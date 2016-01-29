unit evTextInTableCorrector;

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevTextInTableCorrector = class(Tk2TagFilter)
  {* Вычищает всякую "кривизну" из текста в таблицах: стиль "обычный", отрицательные отступы, рамки вокруг текста. }
  function InCell: Boolean;
 end;//TevTextInTableCorrector
 
implementation

uses
 l3ImplUses
 , TableCell_Const
 , TextPara_Const
 , k2Tags
 , evdStyles
 , Document_Const
;

end.
