select * from wh.yh_fundamentals;

select *
from wh.bc_portfolio p,
     wh.bc_opt_bearcall o
where p."Symbol" = o."Symbol"
  and o.extracted_on in (select max(extracted_on) from wh.bc_opt_bearcall);

select *  from wh.bc_portfolio p
where p."totChgPct" > 10
and p.source like '%TRACKING%' and p."Time" in (select max(bc_portfolio."Time") from wh.bc_portfolio);


select max(bc_portfolio."Time") from wh.bc_portfolio

--test
