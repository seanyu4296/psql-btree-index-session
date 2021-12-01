docker run -e POSTGRES_PASSWORD=postgres --name pg1 postgres
docker exec -it pg1 psql