insert into book (name,addition_date)
values ('First',sysdate()),
       ('Second',sysdate()),
       ('Third',sysdate());

insert into author(name, surname)
VALUES ('Jan', 'Kowalski'),
       ('Charles', 'Bukowski'),
       ('Charles', 'Dickens');

insert into author_book(book_id, author_id,addition_date)
values (1, 1,sysdate()),
       (1, 2,sysdate()),
       (2,2,sysdate()),
       (3,3,sysdate());


insert into user(name,surname,email,account_creation_date)
values ('name','surname','email@gmail.com',sysdate()),
 ('jan','Nowak','jan@gmail.com',sysdate());

insert into collection(name,creation_date)
values ('collectionName', sysdate()),
 ('secondCollection', sysdate());


insert into collection_book(book_id, collection_id, addition_date)
values (1,1,sysdate());

insert into collection_user(collection_id, user_id) values
(1,1);

