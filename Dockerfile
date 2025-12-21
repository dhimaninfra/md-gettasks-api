FROM python:3.11-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Create a non-root user and give ownership to the app directory
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser
ENV HOME=/home/appuser

# FastAPI apps are served with uvicorn
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
