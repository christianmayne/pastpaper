select  
    a.file_file_name, 
    b.first_name, b.last_name, 
    c.kind, c.date_modifier, c.day, c.month, c.year, c.location 
from gedcom_documents a, gedcom_people b, gedcom_facts c
where a.id = b.gedcom_document_id
and b.id = c.gedcom_person_id
order by a.file_file_name, b.last_name, b.first_name