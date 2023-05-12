[sql]
select
            100.00 * sum(case
                             when p_type like 'PROMO%'
                                 then l_extendedprice * (1 - l_discount)
                             else 0
            end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
    hive0.tpch.lineitem,
    hive0.tpch.part
where
        l_partkey = p_partkey
  and l_shipdate >= date '1997-02-01'
  and l_shipdate < date '1997-03-01';
[result]
AGGREGATE ([GLOBAL] aggregate [{28: sum=sum(28: sum), 29: sum=sum(29: sum)}] group by [[]] having [null]
    EXCHANGE GATHER
        AGGREGATE ([LOCAL] aggregate [{28: sum=sum(if(80: p_type LIKE PROMO%, 84: l_saleprice, 0)), 29: sum=sum(27: expr)}] group by [[]] having [null]
            SCAN (mv[lineitem_mv] columns[66: l_shipdate, 80: p_type, 84: l_saleprice] predicate[66: l_shipdate >= 1997-02-01 AND 66: l_shipdate < 1997-03-01])
[end]
