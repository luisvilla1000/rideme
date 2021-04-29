# Ride Me

Ride Me is a small ride-hailing service. This connects drivers with passengers, to provide ride service. The passenger pays for the trip through the Wompi payment services.

## Architecture

- Language: Ruby
- Framework: Sinatra
- ORM: Sequel
- Serializer: jsonapi-serializer (formerly Netflix fast_jsonapi )

## Implementation Status

[x] Conection to Wompi
[x] API endpoints
[x] Schema
[x] Docker ready
[x] Migrations via Rake
[] API Authentication (out of scope)
[] Handling errors (internal services and Wompi services)
[] Validations
[] Unit test
[] Configuration files per enviroment
[] Production ready database
[] Heroku ready

## Usage

### Docker Compose

1. Clone the repository
2. Build the image

```bash
docker compose build
```

3. Run migrations and seeds

```bash
docker compose run api bundle exec rake db:migrate
docker compose run api bundle exec rake db:seed
```

4. Deploy the container

```bash
docker compose up -d
```

5. Check running status:  browse  ```http://ip-address:9292/status```

6. You can use Postman API collection (in /docs folder) to test the services
