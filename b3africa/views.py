from __future__ import absolute_import  # Python 2 only

import posixpath
import json
import re

try:
    from urllib.parse import unquote
except ImportError:
    from urlparse import unquote

from django.http import Http404
from django.conf import settings
from django.contrib.staticfiles import finders
from django.contrib.auth.decorators import login_required
from django.views import static
from django.http import HttpResponse
# from django.http.response import HttpResponse
from django.contrib.auth import logout
from django.shortcuts import render, redirect
from django.middleware import csrf

from vendor.odk_parser import OdkParser
from .b3africa import AziziAMP
from vendor.terminal_output import Terminal

import os
terminal = Terminal()

def serve_static_files(request, path, insecure=False, **kwargs):
    """
    Serve static files below a given point in the directory structure or
    from locations inferred from the staticfiles finders.
    To use, put a URL pattern such as::
        from django.contrib.staticfiles import views
        url(r'^(?P<path>.*)$', views.serve)
    in your URLconf.
    It uses the django.views.static.serve() view to serve the found files.
    """
    if not settings.DEBUG and not insecure:
        raise Http404
    normalized_path = posixpath.normpath(unquote(path)).lstrip('/')
    absolute_path = finders.find(normalized_path)
    if not absolute_path:
        if path.endswith('/') or path == '':
            raise Http404("Directory indexes are not allowed here.")
        raise Http404("'%s' could not be found" % path)
    document_root, path = os.path.split(absolute_path)
    return static.serve(request, path, document_root=document_root, **kwargs)


def show_landing(request):
    csrf_token = get_or_create_csrf_token(request)
    page_settings = {
        'page_title': "%s | Home" % settings.SITE_NAME,
        'csrf_token': csrf_token,
        'site_name': settings.SITE_NAME,
        'section_title': ''
    }
    return render(request, 'azizi_amp.html', page_settings)


def logout_page(request):
    logout(request)
    return show_landing(request)


@login_required(login_url='/login')
def show_dashboard(request):
    csrf_token = get_or_create_csrf_token(request)

    azizi_amp = AziziAMP()
    try:
        stats = azizi_amp.system_stats()
        page_settings = {
            'page_title': "%s | Home" % settings.SITE_NAME,
            'csrf_token': csrf_token,
            'section_title': 'Overview',
            'data': stats,
            'site_name': settings.SITE_NAME,
            'js_data': json.dumps(stats)
        }
        return render(request, 'dash_home.html', page_settings)
    except Exception as e:
        terminal.tprint('Error! %s' % str(e), 'fail')
        show_landing(request)

# @login_required(login_url='/login')
# def show_dashboard(request):
#     csrf_token = get_or_create_csrf_token(request)

#     # check if the settings have been defined(first time visit), if not redirect to the settings page
#     azizi_amp = AziziAMP()
#     try:
#         parser = OdkParser()
#         is_first_login = parser.is_first_login()
#         are_ona_settings_saved = parser.are_ona_settings_saved()
#         if is_first_login is True or are_ona_settings_saved is False:
#             return system_settings(request)

#         stats = azizi_amp.system_stats()
#         page_settings = {
#             'page_title': "%s | Home" % settings.SITE_NAME,
#             'csrf_token': csrf_token,
#             'section_title': 'Overview',
#             'data': stats,
#             'site_name': settings.SITE_NAME,
#             'js_data': json.dumps(stats)
#         }
#         # return render(request, 'dash_home.html', page_settings)
#         return system_settings(request)
#     except Exception as e:
#         print(str(e))
#         terminal.tprint('Error! %s' % str(e), 'fail')
#         show_landing(request)


def save2baobab(request):
    csrf_token = get_or_create_csrf_token(request)
    parser = OdkParser()
    azizi_amp = AziziAMP()

    terminal.tprint(json.dumps(request.body), 'fail')
    form_id = int(json.loads(request.POST['form_id']))

    all_submissions = parser.get_all_submissions(form_id)
    for sample in all_submissions:
        m = re.findall(r"^'(.+)'$", sample['raw_data'])
        sample_d = json.loads(m[0])

        try:
            azizi_amp.push_samples_to_baobab(sample_d)
        except Exception as e:
            terminal.tprint(str(e), 'fail')
            return HttpResponse(json.dumps({'error': True, 'message': str(e)}))

    return HttpResponse(json.dumps({'error': False, 'message': 'Saved Successfully'}))

def get_or_create_csrf_token(request):
    token = request.META.get('CSRF_COOKIE', None)
    if token is None:
        token = csrf._get_new_csrf_string()
        request.META['CSRF_COOKIE'] = token
    request.META['CSRF_COOKIE_USED'] = True
    return token
