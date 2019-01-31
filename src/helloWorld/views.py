from django.http import HttpResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def Hello(request):
    if request.method == 'GET':
        return HttpResponse('Hello World V2!')
    elif request.method == 'POST':
        name = request.POST.get("name")
        if name:
            return HttpResponse("Hello " + name + " World V2!")
        else:
            return HttpResponse(status=400)
