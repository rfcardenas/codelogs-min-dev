# for reading Heredoc into var
# (from http://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash/8088167#8088167)
assign_heredoc(){ IFS='\n' read -r -d '' ${1} || true; }

assign_heredoc INSTALL_SCRIPT <<'SCRIPT'
  HEROKU_CLIENT_URL="http://assets.heroku.com.s3.amazonaws.com/heroku-client/heroku-client.tgz"
  # download and extract the client tarball
  rm -rf /usr/local/heroku
  mkdir -p /usr/local/heroku
  cd /usr/local/heroku
  if [[ -z "$(which wget)" ]]; then
    curl -s $HEROKU_CLIENT_URL | tar xz
  else
    wget -qO- $HEROKU_CLIENT_URL | tar xz
  fi
  mv heroku-client/* .
  rmdir heroku-client
SCRIPT

if [ -w /usr/local ]; then
  # we have permission to write to /usr/local (e.g. we're a homebrew user)
  # run as currrent user
  sh -c "$INSTALL_SCRIPT"
else
  # sudo is required
  echo "This script requires superuser access to install software."
  echo "You will be prompted for your password by sudo."

  # clear any previous sudo permission
  sudo -k

  # run inside sudo
  sudo sh -c "$INSTALL_SCRIPT"
fi

# remind the user to add to $PATH
if [[ ":$PATH:" != *":/usr/local/heroku/bin:"* ]]; then
  echo "Add the Heroku CLI to your PATH using:"
  echo "$ echo 'PATH=\"/usr/local/heroku/bin:\$PATH\"' >> ~/.profile"
fi

echo "Installation complete"
