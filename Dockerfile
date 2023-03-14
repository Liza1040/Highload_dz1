FROM python:3.9

COPY httptest /var/www/html
COPY . .

RUN pip install http-parser

EXPOSE 80

CMD python3 main.py