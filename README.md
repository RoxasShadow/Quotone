Quotone allows you to share with the world your favorite quotes from novels, movies, anime, manga, comics, videogames and so on in a completely anonymous way without any type of registration.

Each quote has a viewer counter, can be voted and shared on Facebook, Twitter and Google+, and you can search for others that deal with the same topic through the search or the tags.

Read-only and multi-format APIs are available.

Running at http://quotone.unsigned.it.

```
gem install bundler
git clone https://github.com/RoxasShadow/Quotone
cd Quotone
# Configure config/config.yml for admin and database login (you can use another DBMS too, take a look at http://datamapper.org/getting-started.html)
bundle install
thin -R config.ru -p 4567 start
# Go to http://localhost:4567
```
