# Описание

Приложение для учета персонала больниц.  
Пользователи могут создавать свои больницы и персонал.  
Добавлять сотрудников в свою больницу, делать разные  
манипуляции с ними.

## Запуск

Что бы развернуть свою копию, Вам нужен  
**ruby** и **Ruby on Rails**

Склонировать репозиторий ↓  
`git clone https://github.com/exwarvlad/hospital.git`    
или просто [скачать](https://github.com/exwarvlad/hospital/archive/master.zip)  

Выполнить пару команд в консоли:  

`bundle install --without production`  
`bundle exec rake db:migrate`  
`rails s`  

*И готово :)*  
*Рекомендуется делать это на unix системах*