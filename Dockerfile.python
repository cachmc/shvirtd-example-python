FROM python:3.9-slim
WORKDIR /app

COPY main.py ./
COPY requirements.txt ./

RUN pip install -r /app/requirements.txt

CMD ["python", "main.py"]
