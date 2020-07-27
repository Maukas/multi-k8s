docker build -t maukas/multi-client:latest -t maukas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maukas/multi-server:latest -t maukas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maukas/multi-worker:latest -t maukas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maukas/multi-client:latest
docker push maukas/multi-server:latest
docker push maukas/multi-worker:latest

docker push maukas/multi-client:$SHA
docker push maukas/multi-server:$SHA
docker push maukas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=maukas/multi-client:$SHA
kubectl set image deployments/server-deployment server=maukas/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=maukas/multi-worker:$SHA