unit msmChangedElementsPrim;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangedElementsPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmChangedElementsPrim" MUID: (57E103E402B8)

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
 , SyncObjs
;

type
 _ItemType_ = TtfwWord;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmChangedElementsPrim = class(_seCriticalSectionHolder_)
  protected
   procedure InitFields; override;
  public
   procedure Add(anItem: TtfwWord);
 end;//TmsmChangedElementsPrim

implementation

uses
 l3ImplUses
 , l3PointerUtils
 , msmModelElementMethodCaller
 {$If NOT Defined(NoScripts)}
 , msmChangedElementsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57E103E402B8impl_uses*
 //#UC END# *57E103E402B8impl_uses*
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57E103E402B8_var*
//#UC END# *47B2C42A0163_57E103E402B8_var*
begin
//#UC START# *47B2C42A0163_57E103E402B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57E103E402B8_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57E103E402B8_var*

 function GetRef(aW : TtfwWord): Pointer;
 begin//GetRef
  if (aW = nil) then
   Result := nil
  else
   Result := aW.GetRefForCompare;
 end;//GetRef

//#UC END# *47B99D4503A2_57E103E402B8_var*
begin
//#UC START# *47B99D4503A2_57E103E402B8_impl*
 Result := l3ComparePointers(GetRef(CI.rA^), GetRef(CI.rB^));
//#UC END# *47B99D4503A2_57E103E402B8_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmChangedElementsPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmChangedElementsPrim.Add(anItem: TtfwWord);
//#UC START# *57E1046B03CD_57E103E402B8_var*
//#UC END# *57E1046B03CD_57E103E402B8_var*
begin
//#UC START# *57E1046B03CD_57E103E402B8_impl*
 Lock;
 try
  inherited Add(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E1046B03CD_57E103E402B8_impl*
end;//TmsmChangedElementsPrim.Add

procedure TmsmChangedElementsPrim.InitFields;
//#UC START# *47A042E100E2_57E103E402B8_var*
//#UC END# *47A042E100E2_57E103E402B8_var*
begin
//#UC START# *47A042E100E2_57E103E402B8_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupIgnore;
//#UC END# *47A042E100E2_57E103E402B8_impl*
end;//TmsmChangedElementsPrim.InitFields

end.
