# Docker for rails developers:

1. We ran our first ever Docker command, a helloworld Ruby script, without needing Ruby installed on our machine.
```
$ docker run ruby:2.6 ruby -e "puts :hello"
```
2. We saw how to list our running containers with docker ps and all containers (including stopped ones) with docker ps -a.
3. We deleted our old containers with docker rm <container id> and saw how to create throwaway containers using the docker run’s --rm option.
4. We generated a new Rails project using a container by:
    - Starting an interactive Bash shell running inside a container
    ```
    $ docker run -i -t --rm -v ${PWD}:/usr/src/app ruby:2.6 bash
    ```
    - Installing the Rails gem inside the container
    ```
    root@0c286e8bda42:/usr/src/app# gem install rails
    ```
    - Using the freshly installed Rails gem to generate our project
    ```
    root@0c286e8bda42:/usr/src/app# rails new myapp --skip-test --skip-bundle
    ```
5. We saw our first, rough-and-ready Dockerfile designed to allow us to run our app with a Rails server:
```
> FROM ruby:2.6
> RUN apt-get update -yqq
> RUN apt-get install -yqq --no-install-recommends nodejs
> COPY . /usr/src/app/
> WORKDIR /usr/src/app
> RUN bundle install
```
6. We built our custom image from this Dockerfile with:
```
docker build .
```
7. We listed the images on our system by issuing:
```
docker images
```
8. We started up a Rails server to run our app with:
```
docker run -p 3000:3000 a1df0eddba18 bin/rails s -b 0.0.0.0
```
9. And we saw it running in a browser on http://localhost:3000.
10. We saw how to name and version our images by giving them tags, either after they’re built:
```
$ docker tag a1df0eddba18 railsapp
```
or at build time (here setting two tags):
```
$ docker build -t railsapp -t railsapp:1.0 .
```
11. We added a default command to our image using the CMD instruction:
```
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
```
12. We sped up our image builds by using a .dockerignore to prevent unnecessary files from being sent to the Docker daemon as part of our build context.
13. We ensured that we always use up-to-date package repository information when altering the packages we install by combining apt-get update and apt- get install into a single RUN instruction:
```
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    nodejs
```
14. We prevented file changes from causing our gems to be rebuilt by copying our Gemfiles earlier in our Dockerfile so they could be cached separately:
```
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
```
15. Finally, we indicated who was responsible for our image by setting a maintainer with the LABEL instruction:
```
LABEL maintainer="rob@DockerForRailsDevelopers.com"
```

1. We introduced the docker-compose.yml and its format.
2. We created our own docker-compose.yml for our Rails app, including a locally mounted volume to allow live editing of local files.
3. We saw how to spin up our entire app and start the Rails server by using the command:
    $ docker-compose up
4. We learned various commands for managing our app with Compose:
• List running containers
        $ docker-compose ps
• Manage container life cycle
        $ docker-compose [start|stop|kill|restart|pause|unpause|rm] \
                         <service name>
• View the logs
        $ docker-compose logs [-f] <service name>
• Run a one-off command in a new, throwaway container
        $ docker-compose run --rm <service name> <some command>
• Run a one-off command in an existing container
        $ docker-compose exec <service name> <some command>
• Rebuild an image
        $ docker-compose build <service name>
