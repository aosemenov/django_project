from django.contrib import admin
from .models import AssemblePoints, Employees, GooseDbVersion, OrderedProductsFromWarehouse, Products, ProductsInAssemblePoint

admin.site.register(AssemblePoints)
admin.site.register(Employees)
admin.site.register(GooseDbVersion)
admin.site.register(OrderedProductsFromWarehouse)

class ProductsAdmin(admin.ModelAdmin):
    list_display = ['name', 'calories', 'created_at', 'updated_at']

admin.site.register(Products, ProductsAdmin)

admin.site.register(ProductsInAssemblePoint)
