from django.http import HttpRequest
from django.test import SimpleTestCase
from django.urls import reverse

from . import views


class HomePageTests(SimpleTestCase):

    def test_get(self):
        response = self.client.get('/')
        self.assertEquals(response.status_code, 200)

    def test_post_success(self):
        response = self.client.post(reverse('hello'), {'name': 'milad'})
        self.assertEquals(response.status_code, 200)

    def test_post_fail(self):
        response = self.client.post(reverse('hello'))
        self.assertEquals(response.status_code, 400)
