Quotone allows you to share with the world your favorite quotes from novels, movies, anime, manga, comics, videogames and so on in a completely anonimous way without any type of registration.

Each quote can be voted and shared on Facebook, Twitter and Google+, and you can search for others that deal with the same topic - through the tags - or others from the same work.

APIs will be available soon.

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
