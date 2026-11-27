from django.shortcuts import render
import oracledb

# Create your views here.
def index(request):

    return render (request,'index.html')