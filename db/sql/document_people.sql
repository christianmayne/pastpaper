select 
    c.name, 
    a.stock_number, b.name, 
    a.name, a.title, a.views,
    d.
from documents a, document_types b, statuses c, document_photos d 
where a.document_type_id = b.id
and a.status_id = c.id
and d.document_id = b.id