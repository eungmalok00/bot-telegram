FROM python:3.10-slim
RUN apt-get update && apt-get install -y ffmpeg
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# បង្កើត folder ទុកមុនដើម្បីកុំឱ្យជាប់ permission
RUN mkdir -p uploads outputs && chmod 777 uploads outputs
CMD ["python", "bot.py"]
