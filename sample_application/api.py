from django.db import transaction
from ninja import NinjaAPI

from app.models import Item

api = NinjaAPI()


@api.post("/test_atomic_requests")
def test_atomic_requests(request):
    Item.objects.create(name="test_atomic_requests")
    raise Exception()


@api.post("/test_transaction_atomic_before")
@transaction.atomic
def test_transaction_atomic_before(request):
    Item.objects.create(name="test_transaction_atomic_before")
    raise Exception()


@transaction.atomic
@api.post("/test_transaction_atomic_after")
def test_transaction_atomic(request):
    Item.objects.create(name="test_transaction_atomic_after")
    raise Exception()
