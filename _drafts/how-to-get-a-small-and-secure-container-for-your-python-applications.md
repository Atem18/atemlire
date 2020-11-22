---
title: How to get a small and secure container for your Python applications

---
## Introduction

Hi,

Today we are gonna talk about containers. Whether you are using Docker, Podman, Kubernetes or something else, if you want to put a Python application in a container, you will have create an image and most of the time, people don't really know how to get a small and secure image. Let's fix it.

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

## Explanations

As you can see in the example, we are declaring three "FROM" as opposed to regular one "FROM". It's called [multi-stage](https://docs.docker.com/develop/develop-images/multistage-build/ "multi-stage"). Think of it like pipelines or jobs in your CI/CD tool.
Three stages, each one has a specific utility.

Also, the order of commands matter because you want to use Docker cache as much as possible. So respect those requirements:

* **Put the commands that are changing less often of top of the other to use as much as cache as possible**
* **Don't call RUN command to execute a bash script, unless it's un the CMD or ENTRYPOINT commands**
* **Don't pipe commands that will not change**

Now let's review the stages.

### Develop stage

```Dockerfile
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
COPY requirements.txt /requirements.txt
RUN python -m venv /venv
RUN pip install -r /requirements.txt
CMD ["python", "main.py"]
```

In this stage, the goal is to have the best container for developing your application. It does not have to be minimal in size or secured because it will never be used outside of your device.

```Dockerfile
FROM python:3.8.6 AS develop-stage
```

We use the official Python docker image with all the tools, because we want to have a full Python environement.

```Dockerfile
WORKDIR /app
```

We set the workdir to /app so each next commands are executed in the directory /app

```Dockerfile
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
```

We add the venv/bin directory to the path because we want to be able to call some binaries from our project. This is optional if you don't do it.

The PYTHONPATH env var is optional is your program does not depends on it but it's always good to set it.

```Dockerfile
COPY requirements.txt /requirements.txt
```

We copy the requirements of your project.

```Dockerfile
RUN python -m venv /venv
````

We create a folder where to install all the dependencies.

```Dockerfile
RUN pip install -r /requirements.txt
````

We install the dependencies. PIP will install them in the folder /venv because we did previously set ENV PATH="/venv/bin:$PATH"

```Dockerfile
CMD ["python", "main.py"]
```

Finally we run the app.

If you use docker-compose, you can specify the following to develop using that specific stage.

```yaml
build:
  context: ./app
  target: develop-stage
```

### Build stage

### Production stage