# README
Running the application locally (Mac or Linux)

* Install Docker with Docker Compose

* Clone the project

* export current host user's id as environment variable
  `export UID=$(id -u)`

* From inside the project root folder run `docker-compose up --build`

* Open separate terminal and run `docker-compose exec app ruby bin/start` to start the CLI application.

