
from setuptools import setup, find_packages


setup(
    name='FBF-Forecast-GloFAS',
    version='0.1',
    packages=find_packages(
        exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
    install_requires=[
        'GloFAS-API-Wrapper @ git+https://github.com/lucernae/glofas-api-helper.git@master#egg=GloFAS-API-Wrapper-0.1'
    ],
    dependency_links=[
        ''
    ]
)
