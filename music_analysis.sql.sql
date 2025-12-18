select *from album
select *from artist
select *from employee
select *from genre
select * from customer
select * from track
select *from invoice;
--1.senior most employee
select *from employee
order by levels desc
limit 1
-- 2.country has most invoices  
select count(*) as d, billing_country        
from invoice
group by billing_country 
order by d desc
--3.top 3 of total invoice
select * from invoice
order by total desc
limit 3
--4.city with best customers reurn both city name and sum of invoice totals
select billing_city,sum(total) as invoice_total from invoice
group by billing_city
order by invoice_total desc
--5.best customer spent more money
select customer.customer_id,customer.first_name,customer.last_name,sum(invoice.total) as total
from customer
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1
--6.return email,first_name,last_name,genre of all rock music,list ordered alphabatically
--email starting with A.
select distinct email,first_name,last_name from customer
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in(
select track_id from track
join genre on track.genre_id=genre.genre_id
where genre.name like 'Rock'
)
order by email
--7.eh query Rock genre ke andar sab se zyada songs likhne wale Top 10 artists dhoondti hai.
select artist.artist_id,artist.name,count(artist.artist_id) as number_of_songs
from track
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id
join genre on genre.genre_id=track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10
--8.Yeh query un songs (tracks) ko dhoondti hai jo average song length se zyada lambi hai
select name,milliseconds from track
where milliseconds > (
select avg(milliseconds) as avg_track_length
from track)
order by milliseconds desc
--9.Albums ke sath artist name
select album.title,artist.name
from album
join artist on artist.artist_id=album.artist_id
--10.Sirf Rock genre ke tracks
select track.name from track
join genre on genre.genre_id = track.genre_id
where genre.name='Rock'
--11.Har genre ke kitne tracks
select genre.name,count(track.track_id) as total_tracks
from track
join genre on genre.genre_id = track.genre_id
group by genre.name
--12.Har artist ke total albums
select artist.name,count(album.album_id) as total_albums
from album
join artist on artist.artist_id=album.artist_id
group by artist.name
--13.Har artist ke total tracks
select artist.name,count(track_id) as total_tracks
from track
join album on album.album_id=track.album_id
join artist on artist.artist_id=album.artist_id
group by artist.name
--14.Sab se mehnga track
select name,unit_price
from track
order by track desc
limit 1
--15.Har customer ka total spend desecnding order mai
select customer.first_name, customer.last_name,
sum(invoice.total) as total_spent
from customer
join invoice on invoice.customer_id = customer.customer_id
group by customer.customer_id
order by total_spent desc
--16.Country wise customers
select country,count(*) as total_customer
from customer
group by country
--17.country wise customers having most customer
select country,count(*) as total_customer
from customer
group by country
order by total_customer desc
limit 1
;








