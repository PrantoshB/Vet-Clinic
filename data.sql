insert into animals(name,date_of_birth,weight_kg,neutered, escape_attempts) 
values 

  ('Charmander', '2020-02-08', -11, false, 0),
  ('Plantmon', '2021-11-15', -5.7, true, 2),
  ('Squirtle', '1993-04-02', -12.13, false, 3),
  ('Angemon', '2005-06-12', -45, true, 1),
  ('Boarmon', '2005-06-07', 20.4, true, 7),
  ('Blossom', '1998-10-13', 17, true, 3),
  ('Ditto', '2022-05-14', 22, true, 4);

insert into owners(full_name, age)
values
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

insert into species(name)
values
  ('Pokemon'),
  ('Digimon');

update animals set species_id = case 
  when name like '%mon' then (select id from species where name = 'Digimon')
  else (select id from species where name = 'Pokemon')
end;

update animals set owner_id = case
  when name = 'Agumon' then (select id from owners where full_name = 'Sam Smith')
  when name = 'Pikachu' or name = 'Gabumon'  then (select id from owners where full_name = 'Jesnnifer Orwell')
  when name = 'Plantmon' then (select id from owners where full_name = 'Bob')
  when name = 'Charmander' or name = 'Squirtle' or name = 'Blossom' then (select id from owners where full_name = 'Melody Pond')
  when name = 'Angemon' or name = 'Boarmon' then (select id from owners where full_name = 'Dean Winchester')
  end;