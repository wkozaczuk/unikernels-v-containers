# unikernels-v-containers
Unikernels vs Containers: An In-Depth Benchmarking Study in the context of Microservice Applications

To build docker image:
```
./build-docker.sh
```
To run docker:
```
docker run --cpuset-cpus="0,1" -p 80:8080 uc/abc-rest
```
