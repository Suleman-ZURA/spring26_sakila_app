FROM python:3.9-slim

LABEL maintainer="Suleman"
LABEL version="1.0"
LABEL description="Optimized Sakila Flask App"

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD python -c "import socket; s=socket.socket(); s.connect(('127.0.0.1',5000)); s.close()" || exit 1

CMD ["python","app.py"]