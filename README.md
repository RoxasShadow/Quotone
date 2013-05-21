The place where you can share anonymously your favorite quotes from anime, manga, videogames, books, etc.

Running at http://www.quotone.unsigned.it and compatible with ruby-1.8.7 (just because it is running on my server).

```
sudo gem install thin
sudo gem install bundler
git clone https://github.com/RoxasShadow/Quotone
cd Quotone
# Configure config/config.yml for admin and database login (you can use another DBMS however, give a look on datamapper.org)
bundle install
thin -R config.ru -p 4567 start
# Go to http://localhost:4567
```
