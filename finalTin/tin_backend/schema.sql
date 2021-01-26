
create table user
(
    id                    integer primary key auto_increment,
    name                  varchar(50),
    surname               varchar(50),
    email                 varchar(50),
    account_creation_date date
);

create table collection
(
    id            integer primary key auto_increment,
    name          varchar(50),
    creation_date date,
    user_id       integer,
    foreign key (user_id) references user (id)
);
create table book
(
    id            integer primary key auto_increment,
    name          varchar(50),
    addition_date date
);

create table author
(
    id      integer primary key auto_increment,
    name    varchar(50),
    surname varchar(50)
);

create table author_book
(
    book_id   integer,
    author_id integer,
    addition_date date,
    primary key (book_id, author_id),
    foreign key (book_id) references book (id),
    foreign key (author_id) references author (id)
);

create table collection_book
(
    book_id       integer,
    collection_id integer,
    addition_date date,
    primary key (book_id, collection_id),
    foreign key (book_id) references book (id),
    foreign key (collection_id) references collection (id)
);

create table collection_user
(
    collection_id integer,
    user_id       integer,
    primary key (collection_id, user_id),
    foreign key (collection_id) references collection (id),
    foreign key (user_id) references user (id)
);

