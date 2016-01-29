unit nevTableRow;

interface

uses
 l3IntfUses
 , nevParaList
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTableRow = class(TnevParaList, InevTableRow)
  procedure Make(aTag: Tl3Variant);
  function FindCell(aStart: Integer;
   aWidth: Integer;
   aRight: Boolean): TnevParaIndex;
   {* �������� ����� ������ �� �������� � �� ������. }
 end;//TnevTableRow
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2Base
 , nevFacade
 , evdTypes
 , evConst
 , l3UnitsTools
 , evTableCellUtils
 , k2Const
;

end.
