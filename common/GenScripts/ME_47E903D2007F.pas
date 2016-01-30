unit nevTableCellList;
 {* Список InevTableCell. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTableCellList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevTableCell;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
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

type _Instance_R_ = TnevTableCellList;

{$Include l3InterfaceRefList.imp.pas}

end.
