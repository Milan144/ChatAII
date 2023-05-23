# # Install go dependencies
# cd server
# go install
# # Print if the installation was successful
# if [ $? -eq 0 ]; then
#     echo "✅ GO dependencies installed successfully"
# else
#     echo "❌ Installation failed"
# fi

# Install flutter dependencies
cd ../client
flutter pub get
# Print if the installation was successful
if [ $? -eq 0 ]; then
    echo "✅ Flutter dependencies installed successfully"
else
    echo "❌ Installation failed"
fi
