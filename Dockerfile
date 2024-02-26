FROM python:3.11-alpine
WORKDIR /
COPY ./parser.py ./parser.py
RUN pip install --no-cache-dir BeautifulSoup4 requests psycopg2-binary && rm -rf /var/cache 
