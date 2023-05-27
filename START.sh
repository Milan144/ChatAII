#!/usr/bin/env sh

cd server
echo "🐍 Launching API..."
docker compose up -d
cd client
echo "🚀 Launching Flutter app..."
flutter run -d chrome
