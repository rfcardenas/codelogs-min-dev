
#Varaibles de entorno de script ic
HEROKU_USER=$1
HEROKU_PSW=$2
echo $HEROKU_USER;

#login in heroku codelogs
echo $HEROKU_PSW;
(
  echo "$HEROKU_USER"  # or you can plaintext it, if you're feeling adventurous
  echo "$HEROKU_PSW"
) | heroku login 


