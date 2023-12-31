drop table if exists BookIssue;
drop table if exists Publisher;
drop table if exists BookReview;
drop table if exists Quote;
drop table if exists UserBook;
drop table if exists "User";
drop table if exists Recommendation;
drop table if exists Book;
drop table if exists Genre;
drop table if exists Author;

create table Author
(
    id      int generated by default as identity PRIMARY KEY,
    name    varchar(50) NOT NULL,
    surname varchar(50),
    country varchar
);

create table Genre
(
    id         int generated by default as identity PRIMARY KEY,
    name       varchar(100) UNIQUE NOT NULL,
    is_fiction bool default true
);

create table Book
(
    id        int generated by default as identity PRIMARY KEY,
    author_id int references Author (id) on delete cascade NOT NULL,
    genre_id  int references Genre (id) on delete set null,
    title     varchar(100) NOT NULL,
    series    varchar(100)
);

create table Recommendation
(
    book_id   int references Book (id) on delete cascade   NOT NULL,
    author_id int references Author (id) on delete cascade NOT NULL,
    primary key (book_id, author_id)
);

create table "User"
(
    id       int generated by default as identity PRIMARY KEY,
    login    varchar(10) NOT NULL UNIQUE,
    password varchar(10) NOT NULL,
    is_admin boolean     NOT NULL default false
);

create table UserBook
(
    book_id     int references Book (id) on delete cascade   NOT NULL,
    user_id     int references "User" (id) on delete cascade NOT NULL,
    primary key (book_id, user_id),

    is_read     bool default false,
    is_demanded bool default false
);

create table Quote
(
    id       int generated by default as identity PRIMARY KEY,
    book_id  int references Book (id) NOT NULL,
    contents varchar                  NOT NULL
);

create table BookReview
(
    id       int generated by default as identity primary key,
    user_id  int references "User" (id)                 NOT NULL,
    book_id  int references Book (id)                   NOT NULL,
    rating   int CHECK ( rating >= 0 and rating <= 100) NOT NULL,
    contents varchar(100)                               NOT NULL
);

create table Publisher
(
    id      int generated by default as identity PRIMARY KEY,
    name    varchar(30) NOT NULL,
    address varchar     NOT NULL,
    phone   varchar
);

create table BookIssue
(
    id           int generated by default as identity PRIMARY KEY,
    book_id      int references Book (id)      NOT NULL,
    publisher_id int references Publisher (id) NOT NULL,

    year         int                           NOT NULL,
    quantity     int                           NOT NULL,
    price        double precision
);

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Author ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
insert into Author(name, surname, country)
values ('Фёдор', 'Достоевский', 'Россия');
insert into Author(name, surname, country)
values ('Лев', 'Толстой', 'Россия');
insert into Author(name, surname, country)
values ('Михаил', 'Булгаков', 'СССР');
insert into Author(name, surname, country)
values ('Михаил', 'Шолохов', 'СССР');
insert into Author(name, surname, country)
values ('Стивен', 'Кинг', 'США');
insert into Author(name, surname, country)
values ('Айзек', 'Азимов', 'США');
insert into Author(name, surname, country)
values ('Нассим Николас', 'Талеб', 'США');
insert into Author(name, surname, country)
values ('Агата', 'Кристи', 'Великобритания');
insert into Author(name, surname, country)
values ('Артур Конан', 'Дойл', 'Великобритания');
insert into Author(name, surname, country)
values ('Станислав', 'Лем', 'Польша');
insert into Author(name, surname, country)
values ('Генрик', 'Сенкевич', 'Польша');
insert into Author(name, surname, country)
values ('Болеслав', 'Прус', 'Польша');
insert into Author(name, surname, country)
values ('Александр', 'Дюма', 'Франция');
insert into Author(name, surname, country)
values ('Мишель', 'Фуко', 'Франция');
insert into Author(name, surname, country)
values ('Марсель', 'Пруст', 'Франция');
insert into Author(name, surname, country)
values ('Исаак', 'Бабель', 'СССР');
insert into Author(name, surname, country)
values ('Дэн', 'Браун', 'США');
insert into Author(name, surname, country)
values ('Иван', 'Тургенев', 'Россия');
insert into Author(name, surname, country)
values ('Освальд', 'Шпенглер', 'Германия');
insert into Author(name, surname, country)
values ('Стивен', 'Кови', 'США');

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Genre ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
insert into Genre(name)
values ('Фантастика');
insert into Genre(name)
values ('Исторический роман');
insert into Genre(name)
values ('Психологический роман');
insert into Genre(name)
values ('Фэнтэзи');
insert into Genre(name)
values ('Детектив');
insert into Genre(name, is_fiction)
values ('Философия', false);
insert into Genre(name, is_fiction)
values ('Экономика', false);
insert into Genre(name)
values ('Ужасы');
insert into Genre(name)
values ('Приключения');
insert into Genre(name, is_fiction)
values ('История', false);
insert into Genre(name, is_fiction)
values ('Математика', false);
insert into Genre(name, is_fiction)
values ('Программирование', false);
insert into Genre(name, is_fiction)
values ('Саморазвитие', false);
insert into Genre(name, is_fiction)
values ('Биография', false);

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Book ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO Book (author_id, title, series)
VALUES (1, 'Преступление и наказание', 'Романы Достоевского');
INSERT INTO Book (author_id, title, series)
VALUES (1, 'Братья Карамазовы', 'Романы Достоевского');
INSERT INTO Book (author_id, title, series)
VALUES (2, 'Война и мир', 'Романы Толстого');
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (2, 'Анна Каренина', 'Романы Толстого', 3);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (3, 'Мастер и Маргарита', NULL, 4);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (4, 'Тихий Дон', NULL, 2);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (5, 'Оно', 'Цикл "Оно"', 8);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (6, 'Я, робот', NULL, 1);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (7, 'Чёрный лебедь', NULL, 7);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (8, 'Убийство в Восточном экспрессе', 'Эркюль Пуаро', 5);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (9, 'Приключения Шерлока Холмса', 'Шерлок Холмс', 5);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (10, 'Солярис', NULL, 1);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (11, 'Камо грядеши', NULL, 2);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (12, 'Фараон', NULL, 2);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (13, 'Граф Монте-Кристо', NULL, 2);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (14, 'Надзирать и наказывать', NULL, 6);
INSERT INTO Book (author_id, title, series, genre_id)
VALUES (15, 'В поисках утраченного времени', 'В поисках утраченного времени', 3);

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Recommendation ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO Recommendation (book_id, author_id)
VALUES (1, 2);
INSERT INTO Recommendation (book_id, author_id)
VALUES (4, 5);
INSERT INTO Recommendation (book_id, author_id)
VALUES (1, 4);
INSERT INTO Recommendation (book_id, author_id)
VALUES (3, 7);

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ User ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO "User" (login, password, is_admin)
values ('victor', 'victor', true);
INSERT INTO "User" (login, password)
values ('pliska', 'pliska');

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ UserBook ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO UserBook (book_id, user_id)
values (3, 1);
INSERT INTO UserBook (book_id, user_id)
values (1, 1);
INSERT INTO UserBook (book_id, user_id)
values (2, 1);
INSERT INTO "User" (login, password)
values (5, 2);
INSERT INTO "User" (login, password)
values (1, 2);
INSERT INTO "User" (login, password)
values (3, 2);

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Quote ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO Quote (book_id, contents)
VALUES (1, 'Человек он умный, но чтоб умно поступать — одного ума мало.');
INSERT INTO Quote (book_id, contents)
VALUES (2,
        'Дети в школах народ безжалостный: порознь ангелы божии, а вместе, особенно в школах, весьма часто безжалостны.');
INSERT INTO Quote (book_id, contents)
VALUES (5, 'Самый страшный гнев, гнев бессилия.');
INSERT INTO Quote (book_id, contents)
VALUES (5, 'Зачем же гнаться по следам того, что уже давно окончено?');
INSERT INTO Quote (book_id, contents)
VALUES (5, 'Иногда лучший способ погубить человека — это предоставить ему самому выбрать судьбу.');

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ BookReview ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO BookReview (user_id, book_id, rating, contents)
VALUES (1, 2, 50, 'норм');
INSERT INTO BookReview (user_id, book_id, rating, contents)
VALUES (1, 4, 30, 'так се');
INSERT INTO BookReview (user_id, book_id, rating, contents)
VALUES (2, 2, 70, 'супер');

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ Publisher ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO Publisher (name, address, phone)
VALUES ('Эксмо', 'wwwwww', '+12345678');
INSERT INTO Publisher (name, address, phone)
VALUES ('АСТ', 'eeeeee', '+12345678');
INSERT INTO Publisher (name, address, phone)
VALUES ('Вече', 'ttttttttt', '+12345678');

-- ЗАПОЛНЕНИЕ ТАБЛИЦЫ BookIssue ТЕСТОВЫМИ ЗНАЧЕНИЯМИ
INSERT INTO BookIssue (book_id, publisher_id, year, quantity, price)
VALUES (1, 1, 2020, 5000, 400);
INSERT INTO BookIssue (book_id, publisher_id, year, quantity, price)
VALUES (1, 2, 2016, 5000, 400);
INSERT INTO BookIssue (book_id, publisher_id, year, quantity, price)
VALUES (2, 1, 2022, 5000, 400);
INSERT INTO BookIssue (book_id, publisher_id, year, quantity, price)
VALUES (2, 3, 2023, 5000, 400);
INSERT INTO BookIssue (book_id, publisher_id, year, quantity, price)
VALUES (6, 2, 2003, 5000, 400);