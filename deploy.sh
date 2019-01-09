docker build -t shuheiktgw/multi-client:latest -t shuheiktgw/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shuheiktgw/multi-server:latest -t shuheiktgw/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shuheiktgw/multi-worker:latest -t shuheiktgw/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shuheiktgw/multi-client:latest
docker push shuheiktgw/multi-client:$SHA
docker push shuheiktgw/multi-server:latest
docker push shuheiktgw/multi-server:$SHA
docker push shuheiktgw/multi-worker:latest
docker push shuheiktgw/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shuheiktgw/multi-server:$SHA
kubectl set image deployments/client-deployment client=shuheiktgw/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shuheiktgw/multi-worker:$SHA