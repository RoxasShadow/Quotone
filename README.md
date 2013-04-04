The place where you can share anonymously your favorite quotes from anime, manga, videogames, books, etc.

Running at http://www.quotone.unsigned.it

```
sudo gem install thin
sudo gem install bundler
git clone https://github.com/RoxasShadow/Quotone
cd Quotone
# Configure config/db.yml with your MySQL login data (however, you can use another DBMS just changing some rows in mygamelist.rb)
sudo apt-get install libsqlite3-dev # change it according to your package manager
bundle install
thin -R config.ru -p 4567 start
# Go to http://localhost:4567
```
