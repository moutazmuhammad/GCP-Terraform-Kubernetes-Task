FROM python:3.7

EXPOSE 8000

RUN mkdir -p /app

WORKDIR /app

COPY . /app

RUN apt-get update -y

RUN pip install -r requirements.txt

CMD python hello.py
