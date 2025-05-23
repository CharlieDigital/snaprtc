set -e

gcloud config set account chen.charles.c@gmail.com

docker buildx build \
  --push \
  --platform linux/amd64 \
  -t us-east4-docker.pkg.dev/snaprtc-app/snaprtc-docker/snaprtc-signaling \
  -f Dockerfile .

# Deploy image
gcloud run deploy snaprtc-signaling \
  --image=us-east4-docker.pkg.dev/snaprtc-app/snaprtc-docker/snaprtc-signaling:latest \
  --allow-unauthenticated \
  --min-instances=0 \
  --max-instances=1 \
  --timeout=15m \
  --region=us-east4 \
  --cpu-boost \
  --cpu=1 \
  --memory=512MiB \
  --concurrency=250 \
  --project=snaprtc-app \
  --set-env-vars=DOTNET_SYSTEM_NET_HTTP_SOCKETSHTTPHANDLER_HTTP3SUPPORT=false
