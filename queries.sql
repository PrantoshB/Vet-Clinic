SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE neutered = true;
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE name != 'Gabumon';

BEGIN;
update animals set species = 'unspecified';
select * from animals;
rollback;
select * from animals;

UPDATE animals set species = 'digimon' where name like '%mon';
select * from animals;
update animals set species = 'pokemon' where species = '';
select * from animals;

BEGIN;
delete from animals;
ROLLBACK;
select * from animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, AVG(escape_attempts) as avg_escapes
FROM animals
GROUP BY neutered
ORDER BY avg_escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) as count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.id;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

SELECT owners.full_name, COUNT(animals.id) as count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY count DESC
LIMIT 1;

select vets.name, animals.name, visits.date_of_visit from vets join visits on vets.id = visits.vet_id join animals on animals.id = visits.animal_id
where vets.name = 'William Tatcher' order by visits.date_of_visit desc limit 1;

SELECT COUNT(DISTINCT a.id) as num_animals
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON vet.id = v.vet_id
WHERE vet.name = 'Stephanie Mendez';

SELECT vt.name, COALESCE(array_to_string(array_agg(s.name), ', '), 'none') AS specialties
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id
GROUP BY vt.id;

SELECT a.*
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON vet.id = v.vet_id
WHERE vet.name = 'Stephanie Mendez'
AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(v.*) as num_visits
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.id
ORDER BY num_visits DESC
LIMIT 1;

SELECT a.name, v.date_of_visit
FROM visits v
INNER JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id IN (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY v.date_of_visit ASC
LIMIT 1;


SELECT a.name AS animal_name, vt.name AS vet_name, v.date_of_visit
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN vets vt ON v.vet_id = vt.id
WHERE v.date_of_visit = (SELECT MAX(date_of_visit) FROM visits);


SELECT COUNT(*) AS num_visits
FROM visits v
INNER JOIN vets vt ON v.vet_id = vt.id
INNER JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.species_id IS NULL;

SELECT s.name
FROM animals a
INNER JOIN visits v ON a.id = v.animal_id
INNER JOIN species s ON a.species_id = s.id
WHERE v.vet_id IN (SELECT id FROM vets WHERE name ILIKE '%maisy smith%')
GROUP BY s.id
ORDER BY COUNT(*) DESC
LIMIT 1;

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;

explain analyze SELECT count(*) FROM visits WHERE animal_id = 4;

explain analyze SELECT * FROM visits WHERE vet_id = 2;
CREATE INDEX visits_vet_id_idx ON visits(vet_id);
explain analyze SELECT * FROM visits WHERE vet_id = 2;
explain analyze SELECT * FROM owners WHERE email = 'owner_18327@mail.com';

CREATE INDEX owners_email_idx ON owners(email);

explain analyze SELECT * FROM owners WHERE email = 'owner_18327@mail.com';