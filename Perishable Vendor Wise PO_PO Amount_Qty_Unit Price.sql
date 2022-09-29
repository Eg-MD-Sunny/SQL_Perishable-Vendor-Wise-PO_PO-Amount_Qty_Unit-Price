
select v.id VendorID,v.name Vendor,po.id PurchaseOrderID,
pv.id ProductVariantID,pv.name ProductName,
cast(dbo.tobdt(po.CompletedOn) as date) POPlacedDate,
count(*) Quantity, t.CostPrice UnitCostPrice,
sum(t.costprice) TotalCostPrice

from PurchaseOrder po
join vendor v on po.VendorId=v.id
join thing t on t.PurchaseOrderId=po.id
join productvariant pv on pv.id=t.ProductVariantId

where cast(dbo.tobdt(po.CompletedOn) as smalldatetime)>= concat(CONVERT (DATE,(dateadd(day,-1,dbo.ToBdt(GETDATE())))),' 15:00:00')
and cast(dbo.tobdt(po.CompletedOn) as smalldatetime) < concat(CONVERT (DATE,dbo.ToBdt(GETDATE())),' 15:00:00')
and	CompletedOn is not null
and t.costprice is not null
and v.id in (472,98,264,573,466,488,101,200,594,400,100,544,776,327,635,706,734,747,754,762,757,755,771,778,781,102,785,772,719,790,743,816,876,815,930,959,760,887,860,1114,631,1079,1156)

group by v.id,v.name,po.id,pv.id,pv.name,
cast(dbo.tobdt(po.CompletedOn) as date),
t.CostPrice
order by 6 desc