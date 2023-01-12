# Generated by Django 4.1.5 on 2023-01-12 18:08

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ("account_books", "0002_url"),
    ]

    operations = [
        migrations.AddField(
            model_name="url",
            name="created_at",
            field=models.DateTimeField(
                auto_now_add=True, default=django.utils.timezone.now
            ),
            preserve_default=False,
        ),
    ]
