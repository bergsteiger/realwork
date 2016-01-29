unit evTextManipulationInterfaces;

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Types
;

type
 IevTextOpProcessor = interface
  {* Процессор текстовых операций }
  procedure CheckTextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* Проверить операцию с текстом }
  procedure TextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* Завершить операцию с текстом }
 end;//IevTextOpProcessor
 
implementation

uses
 l3ImplUses
;

end.
