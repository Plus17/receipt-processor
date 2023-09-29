default: run

#### Setup Commands

setup:
	docker-compose run --rm --service-ports rails sh -c "bin/setup setup"

bundle.install:
	docker-compose run --rm -T --no-deps rails sh -c "bundle install"

db.setup:
	docker-compose run --rm --service-ports rails sh -c "rails db:setup"

db.seed:
	docker-compose run --rm --service-ports rails sh -c "rails db:seed"

#### CI/CD Commands

ci:
	docker-compose run --rm rails sh -c "bin/ci"

#### Development Commands

run:
	docker-compose run --rm --service-ports rails sh -c "rails s"

shell:
	docker-compose run --rm rails bash

console:
	docker-compose run --rm rails sh -c "rails c"


.PHONY: ci
