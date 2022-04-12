USE CEG_MyBase;
ALTER Table Покупатели ADD POL nchar(1) default 'м' check (POL in ('м', 'ж')); 