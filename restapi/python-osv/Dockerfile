FROM python:2.7-alpine

WORKDIR /app

ADD ./server.py /app/server.py
ADD ./lib /usr/local/lib

EXPOSE 8080

CMD ["python","server.py"]

