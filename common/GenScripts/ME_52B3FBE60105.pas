unit CheckWidthInDeletingColumn.imp;

interface

uses
 l3IntfUses
 , nevBase
 , nevTools
;

type
 _CheckWidthInDeletingColumn_ = class
  function Try2CorrectWidth(const anOpPack: InevOp;
   const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
  procedure SetWidth(aValue: Integer);
  function GetStartOffset: Integer;
 end;//_CheckWidthInDeletingColumn_
 
implementation

uses
 l3ImplUses
 , evTableCellUtils
;

end.
