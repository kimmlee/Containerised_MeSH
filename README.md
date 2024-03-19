# containerised_mesh

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
        
    3. build dockerfile into docker image (run only once at the first time)
        `docker compose build`

    4. run containers
        `docker compose up -d`
    
    5. Use one of the options to stop containers according to a development purpose 
        5.1 Stop running containers without removing them (no change in an env file.)
            `docker compoose stop`
    
        5.2 Stop and remove containers (there is a change in an env file.)
            `docker compose down`

        5.3 Stops and removes containers and destroy the container image in case you want to rebuild the image
            `docker compose down --rmi all`
   
- Case II: Run Backend only
    1. comment service `client` on docker-compose.yml file between line 24-35

    2. on `server/main.py`
        change 
        `const uri = `serve(app, host='127.0.0.1', port=5000)` 
        
        to
        `const uri = `serve(app, host='0.0.0.0', port=5000)`
    
    3. run the container
        `docker compose build`
        `docker compose up -d server`
    
    3. build dockerfile into docker image (run only once at the first time)
        `docker compose build`

    4. run containers
        `docker compose up -d`
    
    5. Use one of the options to stop containers according to a development purpose 
        5.1 Stop running containers without removing them (no change in an env file.)
            `docker compoose stop`
    
        5.2 Stop and remove containers (there is a change in an env file.)
            `docker compose down`

        5.3 Stops and removes containers and destroy the container image in case you want to rebuild the image
            `docker compose down --rmi all`