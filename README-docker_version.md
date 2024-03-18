# ECIR-MeSH-Suggest-Docker

## Description
In containerization we splited container by service frontend (`client`) and backend (`server`).

## How to run
- Case I: Run Frontend and Backend together
    1. on  `client/web-app/src/App.js`
        change 
        `const uri = `'http://127.0.0.1:5000/api/v1/resources/mesh?term=' + term + '&type=' + type;` 
        
        to
        `const uri = `'http://localhost:5000/api/v1/resources/mesh?term=' + term + '&type=' + type;`

    2. on `server/main.py`
        change 
        `const uri = `serve(app, host='127.0.0.1', port=5000)` 
        
        to
        `const uri = `serve(app, host='0.0.0.0', port=5000)`
        
    3. run the container
        `docker compose up -d`

- Case II: Run Backend only
    1. comment service `client` on docker-compose.yml file between line 24-35

    2. on `server/main.py`
        change 
        `const uri = `serve(app, host='127.0.0.1', port=5000)` 
        
        to
        `const uri = `serve(app, host='0.0.0.0', port=5000)`
    
    3. run the container
        `docker compose up -d`