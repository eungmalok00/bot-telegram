# ១. ប្រើ Python 3.10-slim ជាមូលដ្ឋាន (ស្រាល និងមានស្ថេរភាព)
FROM python:3.10-slim

# ២. ដំឡើង FFmpeg និងកម្មវិធីចាំបាច់ក្នុង System
# នេះជាផ្នែកដែលធ្វើឱ្យ Whisper ដំណើរការបាន (បំប្លែងវីដេអូជាសំឡេង)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ៣. កំណត់ Folder ការងារក្នុង Server
WORKDIR /app

# ៤. ចម្លង requirements.txt ទៅដំឡើងបណ្ណាល័យ Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ៥. ចម្លងកូដទាំងអស់ពី GitHub ចូលទៅក្នុង Server
COPY . .

# ៦. បង្កើត Folder សម្រាប់ទុក File បណ្តោះអាសន្ន និងផ្ដល់សិទ្ធិ (Permission)
RUN mkdir -p uploads outputs && chmod 777 uploads outputs

# ៧. បើក Port 10000 សម្រាប់ Render
EXPOSE 10000

# ៨. បញ្ជាឱ្យ App ដើរជាមួយ Gunicorn និងកំណត់ Timeout ៦០០ វិនាទី (១០ នាទី)
# ការដាក់ Timeout យូរ ដើម្បីកុំឱ្យវាដាច់ Connection ពេល AI កំពុងដំណើរការ
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "--timeout", "600", "app:app"]
