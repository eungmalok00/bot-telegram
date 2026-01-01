# ប្រើ Python 3.10 ជាមូលដ្ឋាន
FROM python:3.10-slim

# ដំឡើង FFmpeg និងឧបករណ៍ចាំបាច់ក្នុង System
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# កំណត់ Folder ការងារ
WORKDIR /app

# ចម្លងឯកសារ requirements ទៅដំឡើង
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ចម្លងកូដទាំងអស់ចូល
COPY . .

# បញ្ជាឱ្យ Bot ដើរ
CMD ["python", "bot.py"]
