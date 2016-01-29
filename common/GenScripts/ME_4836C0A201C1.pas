unit evCustomNSRCWriter;

interface

uses
 l3IntfUses
 , evCustomTextPainter
;

type
 TevCustomNSRCWriter = class(TevCustomTextPainter)
  {* Фильтр для записи текста в формате NSRC. }
  procedure CheckDigitalSeparatorAlignment;
   {* Корректировка стиля на наличие выравнивания по разделителю. }
 end;//TevCustomNSRCWriter
 
implementation

uses
 l3ImplUses
 , evNSRWrt
;

end.
