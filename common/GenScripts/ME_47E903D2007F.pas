unit nevTableCellList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TnevTableCellList = class(_l3InterfaceRefList_)
  {* Список InevTableCell. }
 end;//TnevTableCellList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
