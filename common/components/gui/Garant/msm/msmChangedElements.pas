unit msmChangedElements;

// Модуль: "w:\common\components\gui\Garant\msm\msmChangedElements.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmChangedElements" MUID: (57E103E402B8)

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
 TmsmChangedElements = class(_seCriticalSectionHolder_)
  protected
   procedure InitFields; override;
  public
   procedure Add(anItem: TtfwWord);
   procedure Save;
   class function Instance: TmsmChangedElements;
    {* Метод получения экземпляра синглетона TmsmChangedElements }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmChangedElements

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
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57E103E402B8impl_uses*
 //#UC END# *57E103E402B8impl_uses*
;

var g_TmsmChangedElements: TmsmChangedElements = nil;
 {* Экземпляр синглетона TmsmChangedElements }

procedure TmsmChangedElementsFree;
 {* Метод освобождения экземпляра синглетона TmsmChangedElements }
begin
 l3Free(g_TmsmChangedElements);
end;//TmsmChangedElementsFree

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
//#UC END# *47B99D4503A2_57E103E402B8_var*
begin
//#UC START# *47B99D4503A2_57E103E402B8_impl*
 Result := l3ComparePointers(CI.rA.GetRefForCompare, CI.rB.GetRefForCompare);
//#UC END# *47B99D4503A2_57E103E402B8_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmChangedElements;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmChangedElements.Add(anItem: TtfwWord);
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
end;//TmsmChangedElements.Add

procedure TmsmChangedElements.Save;
//#UC START# *57E105510123_57E103E402B8_var*
var
 l_List : TtfwWordRefList;
 l_Index : Integer;
//#UC END# *57E105510123_57E103E402B8_var*
begin
//#UC START# *57E105510123_57E103E402B8_impl*
 if Self.Empty then
  Exit;
 Lock;
 try
  l_List := TtfwWordRefList.Create;
  try
   for l_Index := 0 to Pred(Self.Count) do
    l_List.Add(Self.Items[l_Index]);
   TmsmModelElementMethodCaller.Call([TtfwStackValue_C(TtfwWordsIterator.Make(l_List))], 'SaveElements'); 
  finally
   FreeAndNil(l_List);
  end;//try..finally
  Self.Clear;
 finally
  Unlock;
 end;//try..finally
//#UC END# *57E105510123_57E103E402B8_impl*
end;//TmsmChangedElements.Save

class function TmsmChangedElements.Instance: TmsmChangedElements;
 {* Метод получения экземпляра синглетона TmsmChangedElements }
begin
 if (g_TmsmChangedElements = nil) then
 begin
  l3System.AddExitProc(TmsmChangedElementsFree);
  g_TmsmChangedElements := Create;
 end;
 Result := g_TmsmChangedElements;
end;//TmsmChangedElements.Instance

class function TmsmChangedElements.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmChangedElements <> nil;
end;//TmsmChangedElements.Exists

procedure TmsmChangedElements.InitFields;
//#UC START# *47A042E100E2_57E103E402B8_var*
//#UC END# *47A042E100E2_57E103E402B8_var*
begin
//#UC START# *47A042E100E2_57E103E402B8_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupIgnore;
//#UC END# *47A042E100E2_57E103E402B8_impl*
end;//TmsmChangedElements.InitFields

end.
