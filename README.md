# Traefik Demonstration

The goal of this repository is to share some examples of how to use Traefik.  
You have access to the [presentation](demo-traefik.pdf) I gave. However, there ain't much to read in it. If you want some written explanations I'd recommend you to read the [official documentation](https://docs.traefik.io/).

There are three demonstrations in this repository, each one with its own docker-compose file. To make it easier to start and stop the demonstrations, there is a [Makefile](Makefile) with some targets to help you.  
I also provided a docker-compose file for Traefik itself, you have to use it in order to run the demonstrations.

Regarding the services used throughout the demonstrations, I used the [whoami](https://hub.docker.com/r/traefik/whoami) image. It's a simple HTTP service that prints the IP address of the container it's running in as well as some other information related to the machine.

## Requirements

- [Docker](https://docs.docker.com/install/)

## Configuration

The Traefik configuration is stored in the [traefik.yml](traefik.yml) file.  
You will find many options that are commented because they would require some additional configuration. I encourage you to read the [official documentation](https://docs.traefik.io/) to learn more about them.

I won't explain the options here since the goal of this repository is to show a few things that Traefik can do, not to explain how to configure it.

## Demonstrations

It is mandatory to start Traefik before starting any of the demonstrations. To do so, run the following command:

```bash
make traefik
```

Then, access or curl [http://localhost:8080](http://localhost:8080). You should see the Traefik dashboard.

If you want to stop Traefik, run the following command:

```bash
make traefik-down
```

If you want to have to start all the demos at once, run the following command. You will be able to access : 
- [http://localhost/single](http://localhost/single)
- [http://replicas.localhost](http://replicas.localhost)
- [http://localhost/middleware](http://localhost/middleware)

```bash
make all
```

### 1. Single Service

This demonstration shows how to use Traefik to expose a single service. We bind this service to `localhost/single` to show that Traefik is able to manage routing to a route on a domain.

To start the demonstration, run the following command:

```bash
make single
```

Then, access or curl [http://localhost/single](http://localhost/single). You should see something like this:

```bash
Hostname: b9c0a7918774
IP: 127.0.0.1
IP: 172.18.0.3
RemoteAddr: 172.18.0.2:56534
GET /single HTTP/1.1
Host: localhost
User-Agent: curl/7.81.0
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.18.0.1
X-Forwarded-Host: localhost
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: d5298376a34f
X-Real-Ip: 172.18.0.1
```

To stop the demonstration, run the following command:

```bash
make single-down
```

### 2. Replicated Service

This time we have a replicated service, we have three instances of the same service running. We bind this service to `replicas.localhost` to show that Traefik is able to manage routing to a sub-domain.

To start the demonstration, run the following command:

```bash
make replicas
```

Then, access or curl [http://replicas.localhost](http://replicas.localhost). You should see something like in the previous demonstration.

However, if you refresh the page, you should see that the IP address changes. This is because Traefik is using a round-robin algorithm to route the requests to the different instances of the service.

To stop the demonstration, run the following command:

```bash
make replicas-down
```

### 3. Using a Middleware

This demonstration shows how to use a middleware to add a custom response header to the service. We bind this service to `localhost/middleware`.

To start the demonstration, run the following command:

```bash
make middleware
```

Then, access or curl [http://localhost/middleware](http://localhost/middleware). You should see something like this:

If you to see the custom header, execute the following command:

```bash
curl -I http://localhost/middleware
```

You should see something like this:

```bash
HTTP/1.1 200 OK
Content-Length: 327
Content-Type: text/plain; charset=utf-8
Date: Thu, 15 Jun 2023 08:33:10 GMT
I_am_custom: raphaelanjou
```

To stop the demonstration, run the following command:

```bash
make middleware-down
```

### Conclusion

If you paid close attention, you may have noticed that Traefik automatically found the services we started. It is one the main advantages of Traefik, it is able to automatically discover services and route requests to them.

In a few demonstrations, we managed to see how to : 
- Expose a single service
- Replicate a service
- Add a middleware to a service
- Route requests to a sub-domain
- Route requests to a route on a domain

## Author

- [Raphaël ANJOU](https://github.com/orange-anjou)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.