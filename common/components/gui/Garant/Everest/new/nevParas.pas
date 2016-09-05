unit nevParas;
 {* Список параграфов. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParas.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevParas" MUID: (47C5271101E3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 _ItemType_ = InevPara;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevParas = class(_l3InterfaceRefList_, InevParas)
  {* Список параграфов. }
  protected
   function pm_GetCount: Integer;
 end;//TnevParas

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47C5271101E3impl_uses*
 //#UC END# *47C5271101E3impl_uses*
;

type _Instance_R_ = TnevParas;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

function TnevParas.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47C5271101E3get_var*
//#UC END# *4BB08B8902F2_47C5271101E3get_var*
begin
//#UC START# *4BB08B8902F2_47C5271101E3get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47C5271101E3get_impl*
end;//TnevParas.pm_GetCount

end.
