---
title: How to create, host and monitor a personnal website, the DevOps way
date: '2018-09-16T21:19:51.000+00:00'
subtitle: I will teach you how to hide complexity but keeping control of a self host
  website...

---
# Introduction

Want to create a website ? Are you lazy ? Do you know a bit about DevOps ?

Well, you are in the right place.

Today, we will learn about Jekyll, Forestry, Docker, Travis CI and Datadog.

Please be advice that it's not a step by step tutorial, as you can read the dockerfile and docker-compose, but notes of the technologies that I used to create my personal website.

Be ready, it starts now !

# Jekyll

> **Jekyll** is a simple, blog-aware, static site generator for personal, project, or organization sites.
>
> Instead of using databases, Jekyll takes the content, renders Markdown or Textile and Liquid templates, and produces a complete, static website ready to be served by Apache HTTP Server, Nginx or another web server. Jekyll is the engine behind GitHub Pages, a GitHub feature that allows users to host websites based on their GitHub repositories for no additional cost.
>
> Jekyll is flexible and can be used in combination with front-end frameworks such as Bootstrap, Semantic UI and many others.
>
> Jekyll sites can be connected to cloud-based CMS software such as CloudCannon, Forestry, Netlify or Siteleaf, enabling content editors to modify site content without having to know how to code.

> Source : [https://en.wikipedia.org/wiki/Jekyll_(software)](https://en.wikipedia.org/wiki/Jekyll_(software) "https://en.wikipedia.org/wiki/Jekyll_(software)")

On your local computer, install Jekyll:

    gem install bundler jekyll

Then, create a new Jekyll website and replace **my-awesome-site** by the name of your website :

    jekyll new my-awesome-site

And finally, launch your new website:

    cd my-awesome-site
    bundle exec jekyll serve

From now on, you can create pages, blog articles, collections and so on.

I will not explain all the steps to do so because they do it better than me : [https://jekyllrb.com/docs/](https://jekyllrb.com/docs/ "https://jekyllrb.com/docs/")

And if you want an example of a running Jekyll website, well you have that website and the source code is here : [https://github.com/Atem18/kmdotnet](https://github.com/Atem18/kmdotnet "https://github.com/Atem18/kmdotnet")

More info: [https://jekyllrb.com/](https://jekyllrb.com/ "https://jekyllrb.com/")

## Forestry

As written in the introduction of Jekyll, Forestry is a CMS that allows you to write content for your Jekyll website with a WYSIWYG interface.

Same as Jekyll, take the tutorial : [https://forestry.io/docs/quickstart/tour/](https://forestry.io/docs/quickstart/tour/ "https://forestry.io/docs/quickstart/tour/")

My recommendation is to use Master branch from your GitHub repository if you are alone and a content branch that you merge into master if others people will do the content.

If you do not want content to be published either way, set Draft to ON.

More info: [https://forestry.io](https://forestry.io "https://forestry.io")

# Docker

Docker is a tool to manage containers.

If you don't know (yet) what is a container nor Docker, please take the tutorial : [https://docs.docker.com/get-started/#test-docker-installation](https://docs.docker.com/get-started/#test-docker-installation "https://docs.docker.com/get-started/#test-docker-installation")

For this website, I have chosen to build with multistage in mind so that with one file, you can build the website with all the tools and have a small image to deploy in production. Plus, it does not matter where you build it, you can migrate to any platform at any moment.

Here is an example : [https://github.com/Atem18/kmdotnet/blob/master/Dockerfile](https://github.com/Atem18/kmdotnet/blob/master/Dockerfile "https://github.com/Atem18/kmdotnet/blob/master/Dockerfile")

Basically, I am first building my website in a subset of Jekyll containers and then I copy the static files in an Nginx containers with some flags for Traefik.

More info: [https://www.docker.com/](https://www.docker.com/ "https://www.docker.com/")

# Traefik

Traefik is used as a reverse proxy for our website and to enable HTTPS.

To launch Traefik:

    /usr/bin/docker run --name traefik --network=kmdotnet -p 80:80 -p 443:443 -v /var/run/docker.sock:/var/run/docker.sock -v /etc/traefik/traefik.toml:/traefik.toml -v /etc/traefik/acme.json:/acme.json traefik --docker

To launch your website with Traefik:

    /usr/bin/docker run --name kmdotnet --network=kmdotnet --label "traefik.frontend.rule"="Host:www.kevin-messer.net" atem18/kmdotnet:git_commit

# Datadog

[https://www.datadoghq.com/](https://www.datadoghq.com/ "https://www.datadoghq.com/")

# Conclusion

If you want to learn and practice, clone or fork the repo of this website, build the docker and run it: [https://github.com/Atem18/kmdotnet](https://github.com/Atem18/kmdotnet "https://github.com/Atem18/kmdotnet")

Happy DevOPS !