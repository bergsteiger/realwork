unit nevViewList;
 {* Список InevView. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevViewList.pas"
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
 _ItemType_ = InevView;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TnevViewList = class(_l3InterfaceRefList_)
  {* Список InevView. }
 end;//TnevViewList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevViewList;

{$Include l3InterfaceRefList.imp.pas}

end.
