from django.contrib.auth.models import User
from django.db import models


class APIEndPoint(models.Model):
    """
    The Profile class that adds attributes to the default auth user.
    """

    url = models.CharField(max_length=200)
    app_name = models.CharField(max_length=100)
    username = models.CharField(max_length=20)
    passwd = models.CharField(max_length=20)
    site_name = models.CharField(max_length=20)
    api_version = models.CharField(max_length=10, null=True)
    secret_key = models.CharField(max_length=20, blank=True, default='')

    class Meta:
        db_table = 'b3africa_api_endpoints'

    def publish(self):
        self.save()


class APIMethods(models.Model):
    """
    The methods which can be called using the api end points
    """
    top_url = models.CharField(max_length=20)
    method_name = models.CharField(max_length=100, default='')
    api_end_point = models.ForeignKey(APIEndPoint)

    class Meta:
        db_table = 'b3africa_api_methods'

    def publish(self):
        self.save()


class APIObjects(models.Model):
    """
    The methods which can be called using the api end points
    """
    object_name = models.CharField(max_length=100)
    odk_param_name = models.CharField(max_length=50)
    api_end_point = models.ForeignKey(APIEndPoint)

    class Meta:
        db_table = 'b3africa_api_objects'

    def publish(self):
        self.save()


class APIMethodOptions(models.Model):
    """
    The methods which can be called using the api end points
    """
    var_name = models.CharField(max_length=20)
    is_mandatory = models.BooleanField(default=False)
    var_default = models.CharField(max_length=20, null=True)
    api_method = models.ForeignKey(APIMethods)
    api_object = models.ForeignKey(APIObjects)

    class Meta:
        db_table = 'b3africa_api_options'

    def publish(self):
        self.save()


