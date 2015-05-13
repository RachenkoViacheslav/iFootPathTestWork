# iFootPathTestWork

Выполненное тестовое задание от компании Onix System
Нужно создать небольшой клиент, использующий простой API для получения и отображения деталей туристических маршрутов.
Данные получаются с помощью следующего API.

Request type: HTTP POST
http://www.ifootpath.com/API/get_walks.php

Данные должны получатся единоразово и сохраняться локально с помощью любой технологии какой выберешь. 
При запуске грузишь данные с сервера, далее работаешь только с локальной базой. Еще где-то должна быть кнопка которая будет полностью перезагружать данные с сервера.

Первый экран - отображение данных в виде таблички. Каждый элемент списка содержит заголовок, картинку, рейтинг, описание. На этом экране должны быть возможность удаления записей в таблице.
Второй экран - детальное описание, на который попадаем по клику на ячейку в таблице. На этом экране отображаем все данные которые приходят в ответе. На этом экране должна быть возможность правки всех данных и удаления этой записи.

Использованы различные  библиотеки (AFNetWorking, MBProgressView). Перед отправкой запроса, делается проверка на наличие интернет соединения, если его нету, то с помощью alertView сообщаем об этом пользователя
