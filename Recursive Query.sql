with base_query as (
    select relative_id1 as relatives, substring(person_id, 1, 3) as family_group
    from family_members where relative_id1 is not null
    union all
    select relative_id2 as relatives, substring(person_id, 1, 3) as family_group
    from family_members where relative_id2 is not null
),
no_relatives as (
    select person_id
    from family_members fam
    where relative_id1 is null and relative_id2 is null
    and person_id not in (select relatives from base_query)
),
related_fam_members as (
    select relatives, family_group, CAST(relatives as VARCHAR(MAX)) as path
    from base_query
    union all
    select fam.person_id, r.family_group, CAST(r.path + ' > ' + fam.person_id as VARCHAR(MAX))
    from related_fam_members r
    join family_members fam on fam.relative_id1 = r.relatives or fam.relative_id2 = r.relatives
    where r.path NOT LIKE '%' + fam.person_id + '%'
)
select 
    concat('F_', row_number() over(order by relatives)) as Family_id, 
    relatives
from (
    select distinct family_group, STRING_AGG(relatives, ', ') as relatives
    from related_fam_members
    group by family_group
    union all
    select '', STRING_AGG(person_id, ', ') from no_relatives
) x;
