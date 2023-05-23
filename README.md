FRENCH VERSION

Vous voulez créer un nouveau projet symfony 6 sans devoir tout configurer ? Ce script bash est fait pour vous ! 

Pour cette première version :
Place-toi à la racine du dossier dans lequel tu as récupéré le script. Autorise ton pc à lancer le script en tapant : ```chmod +x script.sh``` dans ton terminal puis tape ```./script.sh``` et laisse-toi guider ! 

Il te faudra set up ta bdd mysql en ajoutant deux infos : 
- DATABASE_URL
- DATABASE_PASSWORD

exemple :
DATABASE_URL='mysql://username:password@localhost:3306/database_name' 
DATABASE_PASSWORD='password'

On doit retrouver ces infos dans deux fichiers nouvellement créés (laisse toi guider on t'a dit ;) ) =>
- .env.test.local
- .env.local

C'est qu'un début, beaucoup de choses sont perfectible et à améliorer mais c'est une bonne base de départ !

ENGLISH VERSION

Do you want to create a new Symfony 6 project without having to configure everything? This bash script is made for you!

For this first version:
Navigate to the root directory where you have retrieved the script. Allow your PC to execute the script by typing: chmod +x script.sh in your terminal, then type ./script.sh and follow the instructions!

You will need to set up your MySQL database by adding two pieces of information:

DATABASE_URL
DATABASE_PASSWORD
Example:
DATABASE_URL='mysql://username:password@localhost:3306/database_name'
DATABASE_PASSWORD='password'

You will find these details in two newly created files (just follow the instructions ;) ) =>

.env.test.local
.env.local
This is just the beginning; many things can be improved and enhanced, but it's a good starting point!
