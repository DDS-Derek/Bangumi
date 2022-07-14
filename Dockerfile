FROM python:3.10-alpine

WORKDIR /src

COPY . .

RUN apk add build-base libxml2-dev libxslt-dev && \
    pip install -r requirements.txt

# DO NOT EDIT
# USER NEEDS MOUNT TO THESE DIRECTORY
ENV BANGUMI_DOWNLOAD_FOLDER=/downloads \
    BANGUMI_MEDIA_FOLDER=/media \
    BANGUMI_CONFIG_PATH=/config \
    BANGUMI_CACHE_FOLDER=/cache

# MAIN ENTRY
RUN echo "#!/bin/bash" > ./start.sh && \
    echo "exec python3 ./main.py &" >> ./start.sh && \
    echo "exec uvicorn bangumi:app --host 0.0.0.0 --log-config conf/log.yml" >> ./start.sh

# API PORT
EXPOSE 8000

CMD ["sh", "start.sh"]
