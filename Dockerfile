# Dockerfile

# Используем официальный образ Python slim для легкости
FROM python:3.11-slim

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y gcc musl-dev

# Создаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем только файл зависимостей и устанавливаем их
# Это позволяет кэшировать слой с pip install, если код не менялся
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код приложения
COPY . .

# Запускаем сервер
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]