---
title: How to create a small and secure container for your Python applications

---
## Introduction

Hi,

Today we are gonna talk about containers. Whether you are using Docker, Podman, Kubernetes or something else, if you want to put a Python application in a container, you will have to create an image and most of the time, people don't really know how to get a small and secure image. Let's fix it.

TL;DR: For reference, here is the Dockerfile we will be using:

```Dockerfile
FROM python:3.8.6 AS develop-stage
WORKDIR /app
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
COPY requirements.txt /requirements.txt
RUN python -m venv /venv
RUN pip install -r /requirements.txt
CMD ["python", "main.py"]

FROM develop-stage as build-stage
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

We use the official Python docker image with all the tools, because we want to have a full Python environement to develop.

```Dockerfile
WORKDIR /app
```

We set the workdir to /app so each next commands are executed in the directory /app

```Dockerfile
ENV PATH="/venv/bin:$PATH"
ENV PYTHONPATH=/app
```

We add the venv/bin directory to the path because we want to be able to call some binaries from our project. This is optional if you don't do it.

The PYTHONPATH env var is optional if your program does not depends on it but it's always good to set it.

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

```Dockerfile
FROM develop-stage as build-stage
RUN mkdir tmp
RUN apt update && apt install patchelf
COPY --from=develop-stage /venv /venv
COPY ./app /app
RUN pyinstaller -F main.py
RUN staticx /app/dist/main /app/dist/main_tmp
````

In this stage, the goal is to generate the binary of your application. It does not have to be minimal in size or secured because it will never be used outside of your device.

```Dockerfile
FROM develop-stage as build-stage
````

We are using the same container as the develop-stage to save time and space.

````
RUN mkdir tmp
````

We create a tmp folder that we will use later. It's for Pyinstaller because it needs to uncompress some files into /tmp and the final image "scratch" has no utility to create that /tmp folder.

```Dockerfile
RUN apt update && apt install patchelf
```

We install patchelf as it's a dependency of staticx, the tool we will use to generate our final binary with the system libs embeded.

```Dockerfile
COPY --from=develop-stage /venv /venv
```

We copy the Python dependencies so we can call Pyinstaller and it can find all your program dependencies.

```Dockerfile
COPY ./app /app
```

We copy your program source source.

```Dockerfile
RUN pyinstaller -F main.py
```

Now, we generate a static binary out of your main entry program. Don't forget to add pyinstaller to your requirements.txt.

```Dockerfile
RUN staticx /app/dist/main /app/dist/main_tmp
```

Finally, we link the system libs against your app and generate a file out of it. Don't forget to add statixc to your requirements.txt.


You can now either stop and distribute the file main_tmp to your clients or keep reading and distribute a container with only your application inside.

### Production stage

```Dockerfile
FROM scratch
USER 65535
COPY --from=build-stage --chown=65535:65535 /app/tmp /tmp
COPY --from=build-stage --chown=65535:65535 /app/dist/main_tmp /app/main
CMD ["/app/main"]
```

In this stage, the goal is to generate the final container for your application. We need it to be minimal in size and secured, that's why we will be using scratch as base image.

```Dockerfile
FROM scratch
````

As said previously, we use scratch as it's an empty image so there is no exploit possible outside of your application.

```Dockerfile
USER 65535
```

We set the user to a non-root user. Please do note that your application cannot bind to a port lower than 1024 because it does not run as root.

```Dockerfile
COPY --from=build-stage --chown=65535:65535 /app/tmp /tmp
```

As said previously, Pyinstaller needs a /tmp directory so we copy it from the previous stage.

```Dockerfile
COPY --from=build-stage --chown=65535:65535 /app/dist/main_tmp /app/main
```

We copy our final binary to the main directory.

```Dockerfile
CMD ["/app/main"]
```

Finally, we set the final command of the container.


## Conclusion

I hope you liked the article and that it will help you to deliver Python apps to many people and in a secure way ! :)

Feel free to comment if you have any questions/suggestions.

Have a good day,
Kevin.