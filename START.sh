#!/usr/bin/env sh

cd server
echo "🐍 Launching API..."
docker compose up -d
sleep 20
cd ../client
echo "🚀 Launching Flutter app..."
flutter run -d chrome
