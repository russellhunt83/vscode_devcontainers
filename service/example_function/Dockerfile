FROM public.ecr.aws/lambda/python:3.11

RUN echo "sslverify=0" >> /etc/yum.conf
RUN curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/mssql-release.repo
#to avoid conflicts
RUN yum remove unixODBC-utf16 unixODBC-utf16-devel 
RUN yum update -y -q
RUN ACCEPT_EULA=Y yum install -y msodbcsql18
RUN yum install -y unixODBC tar gzip
COPY ./requirements.txt ${LAMBDA_TASK_ROOT}/requirements.txt
RUN pip install -r ${LAMBDA_TASK_ROOT}/requirements.txt
COPY app/ ${LAMBDA_TASK_ROOT}/app
RUN chmod -R 0777 ${LAMBDA_TASK_ROOT}
ENV PYTHONPATH=${LAMBDA_TASK_ROOT}
CMD ["app.docker_entry_point.lambda_handler"]