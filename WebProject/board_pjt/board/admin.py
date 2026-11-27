from django.contrib import admin
from .models import Board
from .models import Member

admin.site.register(Member)
# Register your models here.
admin.site.register(Board)