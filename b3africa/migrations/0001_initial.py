# -*- coding: utf-8 -*-
# Generated by Django 1.11.4 on 2018-02-06 11:00
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='APIEndPoint',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('url', models.CharField(max_length=200)),
                ('app_name', models.CharField(max_length=100)),
                ('username', models.CharField(max_length=20)),
                ('passwd', models.CharField(max_length=20)),
                ('site_name', models.CharField(max_length=20)),
                ('version', models.CharField(max_length=10)),
                ('secret_key', models.CharField(blank=True, default='', max_length=20)),
            ],
            options={
                'db_table': 'b3africa_api_endpoints',
            },
        ),
        migrations.CreateModel(
            name='APIMethodOptions',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('var_name', models.CharField(blank=True, max_length=20)),
                ('is_mandatory', models.BooleanField(default=0)),
                ('var_default', models.CharField(blank=True, max_length=20)),
            ],
            options={
                'db_table': 'b3africa_api_options',
            },
        ),
        migrations.CreateModel(
            name='APIMethods',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('top_url', models.CharField(max_length=20)),
                ('method_name', models.CharField(default='', max_length=100)),
                ('api_end_point', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='b3africa.APIEndPoint')),
            ],
            options={
                'db_table': 'b3africa_api_methods',
            },
        ),
        migrations.AddField(
            model_name='apimethodoptions',
            name='api_method',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='b3africa.APIMethods'),
        ),
    ]
