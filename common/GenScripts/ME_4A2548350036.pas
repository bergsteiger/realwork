unit evTextManipulationInterfaces;

interface

uses
 l3IntfUses
 , l3CustomString
 , l3Types
;

type
 IevTextOpProcessor = interface
  {* ��������� ��������� �������� }
  procedure CheckTextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* ��������� �������� � ������� }
  procedure TextOp(Text: Tl3CustomString;
   Op: Tl3Operation);
   {* ��������� �������� � ������� }
 end;//IevTextOpProcessor
 
implementation

uses
 l3ImplUses
;

end.
