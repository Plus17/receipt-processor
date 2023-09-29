# application_name

This app receive a receipt data and calculate its points.
## Setup

### Dependencies

1. Install [Docker](https://www.docker.com/products/docker-desktop)
2. Install Make: `sudo apt install make` or `brew install make`

### First run

1. Clone the project repository: `git clone git@github.com:Plus17/receipt-processor.git`
2. Go to project dir: `cd receipt-processor`
3. Execute: `make setup` to install dependencies, setup the database, execute migrations, etc.
4. Execute: `make run` to run the server at http://localhost:3000


## Running The App

1. `make run`

## Tests and CI

1. `make ci` runs all verifications, including tests


## Usage

Make a post request to the endpoint: http://localhost:3000/receipts/process. This returns the receipt id 

```bash
curl --request POST \
  --url http://localhost:3000/receipts/process \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
        "retailer": "Target",
        "purchaseDate": "2022-01-01",
        "purchaseTime": "13:01",
        "items": [
                {
                        "shortDescription": "Mountain Dew 12PK",
                        "price": "6.49"
                },
                {
                        "shortDescription": "Emils Cheese Pizza",
                        "price": "12.25"
                },
                {
                        "shortDescription": "Knorr Creamy Chicken",
                        "price": "1.26"
                },
                {
                        "shortDescription": "Doritos Nacho Cheese",
                        "price": "3.35"
                },
                {
                        "shortDescription": "   Klarbrunn 12-PK 12 FL OZ  ",
                        "price": "12.00"
                }
        ],
        "total": "35.35"
}' | jq --indent 2
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   542    0    45  100   497     95   1054 --:--:-- --:--:-- --:--:--  1160
{
  "id": "8ebee9bc-0ba3-4a2f-9584-426829835d60"
}
```

![proccess receipt](https://github.com/Plus17/receipt-processor/assets/8551125/377aa03a-e883-483c-8563-9c0b9af4e1c8)

The get the receipt points with a GET request to the endpoint: `http://localhost:3000/receipts/:id/points`

```bash
curl --request GET \
  --url http://localhost:3000/receipts/8ebee9bc-0ba3-4a2f-9584-426829835d60/points \
  --header 'Accept: application/json' | jq --indent 2
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    13    0    13    0     0    106      0 --:--:-- --:--:-- --:--:--   114
{
  "points": 28
}
```

![get points](https://github.com/Plus17/receipt-processor/assets/8551125/15e7486e-58b0-42f5-a992-b67fd3f7322c)
