## Stata apiet

- ladda ned reot
- kör 'bundle install'
- kör 'rake db:migrate'
- kör 'rake db:seed'
- kör 'rails s'

Skapa dev nycklar ligger nu på http://localhost:3000
Apiet ligger nu på http://localhost:3000/api/

**Testa apiet**

[Postman url](https://www.getpostman.com/collections/eada35f52017f547bc4f)


### login för dev nycklar delen

användarnamn: 'admin'

lösenord: 'password'

användarnamn: 'kalle'

lösen: '1234567'

Mera info finns i seed.rb filen


## Angular klienten

- ladda ned repot
- gå in 'klient' mappen
- kör 'npm install'
- kör 'node app'

angular sidan ligger nu på: http://localhost:3334

Login på angular sidan

användarnamn: rick

lösenord: 1234567


## ädrat i api under angular
- Jag ville ändra hur sökningen fungerade för att söka via namn och description
- Gjorte några små uppdateringar i hur updateringen av toilet fungerade
- Ändrade i databasen så att tags ochså har ett creator id
- Gjorde så att man kan hämta creator baserat på namn
- Ändrade så att man kunde få ut toilet ihop joinat med positions både enskilt och för alla
