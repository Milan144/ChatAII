# Install flutter dependencies
cd ../client
echo "📱 Installing flutter dependencies..."
flutter pub get
# Print if the installation was successful
if [ $? -eq 0 ]; then
    echo "✅ Flutter dependencies installed successfully"
else
    echo "❌ Installation failed"
fi
