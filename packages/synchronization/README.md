## Features

The API for joplin server

## For development

- For retrofit
    - run `flutter pub run build_runner build` to generate api service if you change anything

- For joplin server
    - [docker guide](https://medium.com/rahasak/replace-docker-desktop-with-minikube-and-hyperkit-on-macos-783ce4fb39e3)
    - run `docker-compose up -d` in `./server` to start in docker
    - run `docker-compose down` in `./server` to stop in docker
    - View `APP_BASE_URL` in `.env` to access joplin data
    - Default joplin email `admin@localhost` and password `admin`

- Database locations
    - joplin on Mac: `~/.config/joplin-desktop/database.sqlite`
    - joplin server on Docker: host-`docker.local`, port-`5432`, check `server/.env` for db/user/pw
    - mditor on Mac: `~/Library/Containers/io.github.okiele.mditor/Data/Documents`
