create table primes (primenum bigint)

declare @counter bigint 
set @counter = 2 
while @counter < 1000 begin if not exists (select top 1 primenum from primes where @counter % primenum = 0) 
insert into primes 
select @counter 
set @counter = @counter +1 end 
select string_agg(primenum,'&') from primes