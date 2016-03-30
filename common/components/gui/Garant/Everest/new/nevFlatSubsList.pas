unit nevFlatSubsList;
 {* Плоский контейнер сабов }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFlatSubsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevFlatSubsList" MUID: (4A23947103C0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevContainers
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevSub;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevFlatSubsList = class(_l3InterfaceRefList_, InevFlatSubsList)
  {* Плоский контейнер сабов }
  protected
   function pm_GetCount: Integer;
 end;//TnevFlatSubsList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnevFlatSubsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

function TnevFlatSubsList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4A23947103C0get_var*
//#UC END# *4BB08B8902F2_4A23947103C0get_var*
begin
//#UC START# *4BB08B8902F2_4A23947103C0get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4A23947103C0get_impl*
end;//TnevFlatSubsList.pm_GetCount

end.
