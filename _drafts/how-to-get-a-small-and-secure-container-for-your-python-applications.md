---
title: How to get a small and secure container for your Python applications

---
Hi,

Today we are gonna talk about containers.
Whether you are using Docker, Podman, Kubernetes or something else, if you are developping an application in Python, you will have create an image and most of the time, people don't really know how to get a small and secure image.
Let's fix it.

For reference, here is the Dockerfile we will be using:

```Dockerfile
FROM python:3.8.6 AS develop-stage
WORKDIR /app
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
COPY requirements.txt /requirements.txt
RUN python -m venv /venv
RUN pip install -r /requirements.txt
CMD ["python", "main.py"]

FROM python:3.8.6 as build-stage
WORKDIR /app
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir tmp
RUN apt update && apt install patchelf
COPY --from=develop-stage /venv /venv
COPY ./app /app
RUN pyinstaller -F main.py
RUN staticx /app/dist/main /app/dist/main_tmp

FROM scratch
USER 65535
COPY --from=build-stage --chown=65535:65535 /app/tmp /tmp
COPY --from=build-stage --chown=65535:65535 /app/dist/main_tmp /app/main
CMD ["/app/main"]
```

Do note that this is a minimal example, your final one will most probably have more commands.

Let's dive into each "blocks" of commands.
