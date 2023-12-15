# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AssemblePoints(models.Model):
    id = models.BigAutoField(primary_key=True)
    adress = models.CharField(blank=True, null=True)
    latitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    longtitude = models.DecimalField(max_digits=9, decimal_places=6, blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'assemble_points'
        db_table_comment = 'Пункт сбора'


class Employees(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(blank=True, null=True)
    surname = models.CharField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'employees'


class GooseDbVersion(models.Model):
    version_id = models.BigIntegerField()
    is_applied = models.BooleanField()
    tstamp = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'goose_db_version'


class OrderedProductsFromWarehouse(models.Model):
    order_id = models.BigIntegerField(blank=True, null=True)
    product_id = models.BigIntegerField(blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    warehouse_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ordered_products_from_warehouse'
# Unable to inspect table 'orders_from_warehouse'
# The error was: could not connect to server "slave_1"
# DETAIL:  could not translate host name "unit_1_lavka" to address: Temporary failure in name resolution


class Products(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(blank=True, null=True)
    calories = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'products'
        db_table_comment = 'Список товаров'


class ProductsInAssemblePoint(models.Model):
    product_id = models.BigIntegerField(blank=True, null=True)
    quantity = models.BigIntegerField(blank=True, null=True)
    assemble_point_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'products_in_assemble_point'
