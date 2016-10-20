unit msmWordByNameListPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmWordByNameListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmWordByNameListPrim" MUID: (57B2D8400355)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwWord;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TmsmWordByNameListPrim = class(_l3UncomparabeObjectRefList_)
  protected
   procedure InitFields; override;
 end;//TmsmWordByNameListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57B2D8400355impl_uses*
 , l3String
 , tfwKeyWordPrim
 //#UC END# *57B2D8400355impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57B2D8400355_var*
//#UC END# *47B2C42A0163_57B2D8400355_var*
begin
//#UC START# *47B2C42A0163_57B2D8400355_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57B2D8400355_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57B2D8400355_var*

 function GetKey(aW : TtfwWord): TtfwKeyWordPrim;
 begin//GetRef
  if (aW = nil) then
   Result := nil
  else
   Result := aW.Key;
 end;//GetRef

//#UC END# *47B99D4503A2_57B2D8400355_var*
begin
//#UC START# *47B99D4503A2_57B2D8400355_impl*
 Result := l3Compare(GetKey(CI.rA^).AsWStr, GetKey(CI.rB^).AsWStr);
//#UC END# *47B99D4503A2_57B2D8400355_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmWordByNameListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

procedure TmsmWordByNameListPrim.InitFields;
//#UC START# *47A042E100E2_57B2D8400355_var*
//#UC END# *47A042E100E2_57B2D8400355_var*
begin
//#UC START# *47A042E100E2_57B2D8400355_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_57B2D8400355_impl*
end;//TmsmWordByNameListPrim.InitFields

end.
