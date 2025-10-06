@echo off
echo Setting up Rails server...

echo Cleaning up previous installations...
if exist Gemfile.lock del Gemfile.lock
if exist tmp rmdir /s /q tmp

echo Installing gems...
bundle install

echo Creating database...
rails db:create

echo Running migrations...
rails db:migrate

echo Starting server...
rails server -p 3000


