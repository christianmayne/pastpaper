select 
    c.name, 
    a.stock_number, b.name, 
    a.name, a.title, a.views,
    d.photo_file_name, d.photo_content_type, d.photo_file_size
from documents a, document_types b, statuses c, document_photos d 
where a.document_type_id = b.id
and a.status_id = c.id
and d.document_id = b.id