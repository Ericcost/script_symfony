#!/bin/bash

#Starter kit

#Functions:

LinuxOS() {
	x-www-browser https://localhost:8000/
}

MacOS() {
	open https://localhost:8000/
}

WindowsOS() {
	start https://localhost:8000/
}

runServer() {
	sudo service mysql start
        gnome-terminal -- npx maildev
        gnome-terminal -- yarn dev-server
       	gnome-terminal -- symfony serve
}

#Run symfony requirements check command
symfony check:requirements

#check the exit code of the previous command
if [ $? -ne 0 ]; then 
	echo "Symfony requirements check failed."
	exit 1
fi

#Create a new Symfony project
echo "What's the name of your symfony project ?"
read projectName

echo "$projectName is creating..."
symfony new $projectName --version="6.1.*" --webapp

cd $projectName
if [ $? -eq 0 ]; then
	echo "$projectName created successfully"
fi

#open it
cd $projectName

#initialize and configure the project 
echo "----------------------------------"
echo "----- Initialize the project -----"
echo "----------------------------------"

echo "Composer installation"
composer install

echo "Webpack encore installation"
composer require symfony/webpack-encore-bundle

echo "Bootstrap installation"
yarn add postcss-loader autoprefixer --dev

echo "yarn installation"
yarn install

echo "sass installation"
yarn add sass-loader@latest sass --dev

echo "poperjs installation"
yarn add @popperjs/core --dev

#Retrieve the sass / js / makefile configuration
echo "Download the scss environment"
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/assets/styles/_global.scss" > assets/styles/_global.scss
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/assets/styles/_variable.scss" > assets/styles/_variable.scss
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/assets/styles/app.scss" > assets/styles/_app.scss

echo "Download the js environment"
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/assets/app.js" > assets/app.js

echo "Download the Makefile"
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/Makefile" > Makefile

echo "Download the .gitignore"
rm .gitignore
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/.gitignore" > .gitignore

echo "Download the doctrine.yaml"
rm config/packageS/doctrine.yaml
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/config/packages/doctrine.yaml" > config/packages/doctrine.yaml

echo "Donwload the webpack.config.js"
rm webpack.config.js
curl -sL "https://raw.githubusercontent.com/Ericcost/Starter_Pack_Symfony/main/webpack.config.js" > webpack.config.js

echo ""
echo "        You must initialize your own MySQL DB        "
echo ""

#Create a .env.local
echo "Creation of the .env.local file..."
touch .env.local

echo "Creation of the .env.test.local file..."
touch .env.test.local

echo ""
echo "          Your credentials are needed in the .env.local and .env.test.local            "
echo ""
echo ""
echo "        You have to add your MySQL configuration within the doctrine.yaml file         "
echo "         Write your DATABASE_URL and your DATABASE_PASSWORD in the .env.local          "
echo ""
echo "         DATABASE_URL='mysql://username:password@localhost:3306/database_name'         "
echo "                             DATABASE_PASSWORD='password'                              "
echo ""

#It launches the current directory where you stand opening a new VSCode window
echo "Let's set up your DB"
echo "VS Code is opening..."
code -n .

#Define the server menu options
yesNoOptions=("Yes" "No")

echo "Do you have initialize your Mysql DB ?"
   select option in "${yesNoOptions[@]}"; do
       case $option in
          "Yes")
                "Let's continue !"
                break
                ;;
           "No")
                echo ""
		echo "        You have to add your MySQL configuration within the doctrine.yaml file         "
		echo "         Write your DATABASE_URL and your DATABASE_PASSWORD in the .env.local          "
		echo ""
		echo "         DATABASE_URL='mysql://username:password@localhost:3306/database_name'         "
		echo "                             DATABASE_PASSWORD='password'                              "
		echo ""
                break
                ;;
            *)
                echo "Invalid option. Please select a valid option."
                ;;
        esac
   done


#Create the db 
echo "DB creation..." 
make db-create
if [ $? -ne 0 ]; then
        echo ""
	echo "        You must initialize your own DB My SQL in order to create your DB        "
	echo ""
fi

echo "HomeController : Creation..."
symfony console make:controller Home

echo "Do you want to run the server ? Select a number"
select option in "${yesNoOptions[@]}"; do
    case $option in
        "Yes")
            echo "Server is starting..."
            runServer
            #Define the OS menu options
            osOptions=("Linux OS" "Mac OS" "Windows OS" "Quit")

            # Wait for user to make a choice run chosen OS
            echo "What's your OS (It will open the localhost:8000 by default) => Select an option : 1, 2, 3 or 4"
                select option in "${osOptions[@]}"; do
                    case $option in
                        "Linux OS")
                           echo "You selected LinuxOS"
                           LinuxOS
                           break
                           ;;
                        "Mac OS")
                           echo "You selected MacOS"
                           MacOS
                           break
                           ;;
                        "Windows OS")
                           echo "You selected Windows OS"
                           WindowsOS
                           break
                           ;;
                        "Quit")
                           echo "Exiting..."
                           break
                           ;;
                        *)
                           echo "Invalid option. Please select a valid option."
                           ;;
                     esac
                done
            break
            ;;
        "No")
            echo "Exiting"
            break
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
done

echo "Enjoy your day !"

exit
