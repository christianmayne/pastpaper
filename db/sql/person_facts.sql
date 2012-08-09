select 
    p. title, p.first_name, p.last_name, p.sex,
    e.name,
    f.date_modifier, f.fact_day, f.fact_month, f.fact_year,
    l.street1, l.street2, l.town, l.county, l.state, l.country
from people p, facts f, event_types e, locations l
where p.id = f.person_id
and f.event_type_id = e.id
and f.location_id = l.id
order by last_name