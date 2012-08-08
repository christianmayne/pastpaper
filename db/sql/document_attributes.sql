select 
    c.name, 
    a.stock_number, b.name, 
    a.name, a.title, a.views,
    e.name,
    d.value, d.on_date, d.attribute_day, d.attribute_month, d.attribute_year, d.attribute_location
from documents a, document_types b, statuses c, attribute_documents d, attribute_types e
where a.document_type_id = b.id
and a.status_id = c.id
and d.document_id = b.id
and d.attribute_type_id = e.id