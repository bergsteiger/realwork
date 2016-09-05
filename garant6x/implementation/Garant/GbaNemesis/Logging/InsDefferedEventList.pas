unit InsDefferedEventList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\InsDefferedEventList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TInsDefferedEventList" MUID: (4B139EC502DF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , LoggingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsDefferedEvent;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TInsDefferedEventList = class(_l3InterfaceRefList_)
 end;//TInsDefferedEventList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4B139EC502DFimpl_uses*
 //#UC END# *4B139EC502DFimpl_uses*
;

type _Instance_R_ = TInsDefferedEventList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
