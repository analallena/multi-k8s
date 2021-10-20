docker build -t analallena/multi-client-k8s:latest -t analallena/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t analallena/multi-worker-k8s:latest -t analallena/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker
docker build -t analallena/muti-server-k8s:latest -t analallena/multi-server-k8s:$SHA -f ./server/Dockerfile ./server

docker push analallena/multi-client-k8s:latest
docker push analallena/multi-server-k8s:latest
docker push analallena/multi-worker-k8s:latest

docker push analallena/multi-client-k8s:$SHA
docker push analallena/multi-server-k8s:$SHA
docker push analallena/multi-worker-k8s:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=analallena/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=analallena/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=analallena/multi-worker-k8s:$SHA

