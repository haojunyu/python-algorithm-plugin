FROM python:3.6-slim
RUN sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list  \
    && apt update \
    && apt install -y --no-install-recommends wget libgl1-mesa-glx libxrender1  libglib2.0-dev\
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
WORKDIR /app/src
RUN pip install --upgrade pip -i https://mirrors.aliyun.com/pypi/simple \
    && pip install -i  https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt \
    && pip install -i  https://mirrors.aliyun.com/pypi/simple/ torch torchvision \
    && mkdir -p /root/.cache/torch/hub/checkpoints \
    && ln -s /app/model/vgg16-397923af.pth /root/.cache/torch/hub/checkpoints/vgg16-397923af.pth 
CMD ["bash", "../bin/run.sh", "image"]
