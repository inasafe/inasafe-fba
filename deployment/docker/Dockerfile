FROM nginx

RUN apt -y update; apt -y install make zip python3 python3-pip wget curl

ADD . /opt/inasafe-fba

RUN pip3 install -r /opt/inasafe-fba/deployment/docker/requirements.txt
# Build artifacts from inside the image
RUN /opt/inasafe-fba/deployment/docker/scripts/artifacts-build.sh

ENTRYPOINT ["/opt/inasafe-fba/deployment/docker/scripts/entrypoint.sh"]
CMD ["nginx","-g","daemon off;"]
