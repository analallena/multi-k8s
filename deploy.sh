docker build -t analallena/multi-client:latest -t analallena/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t analallena/multi-worker:latest -t analallena/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t analallena/muti-server:latest -t analallena/multi-server:$SHA -f ./server/Dockerfile ./server

docker push analallena/multi-client:latest
docker push analallena/multi-server:latest
docker push analallena/multi-worker:latest

docker push analallena/multi-client:$SHA
docker push analallena/multi-server:$SHA
docker push analallena/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=analallena/multi-server:$SHA
kubectl set image deployments/client-deployment client=analallena/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=analallena/multi-worker:$SHA

