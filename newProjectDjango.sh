#!/bin/bash

echo "creating New Project"
echo "............."
echo "Current path : "
pwd_result=$(pwd)
echo $pwd_result
echo "Do you want to define new spesific path (yes/no)"
read choice
if [[ $choice = "yes" ]]
then
	echo "Please ENTER your spesific path (etc. (home/yourUser/...)) :"
	read pwd_result
	cd $pwd_result
else
	cd $pwd_result
fi

#your project path name
echo "**************************************************************************************"
echo
#virtualenvwrapper must be downloaded
source /usr/local/bin/virtualenvwrapper.sh
boolean_data="yes"
echo "Do you want to create new virtualenvironment(yes/no) :"
echo ""
read bool_data
if [ "$bool_data" == "$boolean_data" ];then

	echo "define new  virtualenv...."
	echo "Please Enter your virtualenv name"
	read venv_name
	echo"**************************************************************************************"
	mkvirtualenv $venv_name -p /usr/bin/python
	workon $venv_name
	#if you have virtualenvwrapper now you are in your virtualenv if dont please activate virtualenv --->source myvenv/bin/activate
	python -m pip install --upgrade pip
	#for spesific django versıon
	#echo "**************************************************************************************"
	#echo "please Enter django version for download"
	#read django_version
	#echo "****************************************************************************************"
	pip --version
	pip install Django
	pip install djangorestframework
	pip install markdown       # Markdown support for the browsable API.
	pip install django-filter  # Filtering support
fi


echo ""
echo "**************************************************************************************"
echo "Please enter your file name :"
read file_name
echo "**************************************************************************************"

mkdir $file_name

cd $file_name
echo "**************************************************************************************"


echo "Please Enter Project Name : "

read project_name

echo "**************************************************************************************"


django-admin startproject $project_name .

python manage.py makemigrations

python manage.py migrate


cd $pwd_result/$file_name

echo "Please Enter App Name :"

read app_name

python manage.py startapp $app_name


echo "dont forget add to settings INSTALLED_APPS :" $app_name ", rest_framework  and app urls.py "
echo "add this also :"
echo "urlpatterns = [

    url(r'^api-auth/', include('rest_framework.urls'))


],

REST_FRAMEWORK = {
    # Use Django's standard `django.contrib.auth` permissions,
    # or allow read-only access for unauthenticated users.
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly'
    ]
}
"
