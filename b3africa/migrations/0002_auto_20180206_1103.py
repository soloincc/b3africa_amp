# -*- coding: utf-8 -*-
# Generated by Django 1.11.4 on 2018-02-06 11:03
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('b3africa', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='apiendpoint',
            name='api_version',
            field=models.CharField(max_length=10, null=True),
        ),
    ]
