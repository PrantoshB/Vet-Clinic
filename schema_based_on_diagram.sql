create table patients (
    id serial primary key,
    name varchar(255) not null,
    date_of_birth date not null,
)

create table medical_histories (
    id serial primary key,
    admitted_at timestamp not null,
    status varchar(255) not null,
    patient_id int not null references patients(id),
)

create table treatments (
    id int not null references medical_histories(id) primary key,
    type varchar(255) not null,
    name varchar(255) not null,
)

create table invoice_items (
    id serial primary key,
    unit_price numeric(10,2) not null,
    quantity int not null,
    total_price numeric(10,2) not null,
    invoice_id int not null references invoices(id),
    treatment_id int not null references treatments(id),
)

create table invoices (
    id serial primary key,
    total_amount numeric(10,2) not null,
    generated_at timestamp not null,
    payed_at timestamp,
    medical_history_id int not null references medical_histories(id),
)


