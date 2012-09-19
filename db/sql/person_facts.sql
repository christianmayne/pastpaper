
select * from facts
left join people on people.id = facts.person_id
left join documents on documents.id = people.document_id
where fact_year = 1962
group by document_id
