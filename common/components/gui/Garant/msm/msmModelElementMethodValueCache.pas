unit msmModelElementMethodValueCache;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementMethodValueCache.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementMethodValueCache" MUID: (57B2E6B90102)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementMethodValueList
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , SyncObjs
;

type
 _seCriticalSectionHolder_Parent_ = TmsmModelElementMethodValueList;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmModelElementMethodValueCache = class(_seCriticalSectionHolder_{$If NOT Defined(NoScripts)}
 , ItfwWordListener
 {$IfEnd} // NOT Defined(NoScripts)
 )
  protected
   function CanCacheWord(aWord: TtfwWord): Boolean;
   function CheckItem(const anItem: TmsmModelElementMethodValue): TmsmModelElementMethodValue;
   {$If NOT Defined(NoScripts)}
   procedure Notify(aWord: TtfwWord);
   {$IfEnd} // NOT Defined(NoScripts)
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   procedure Add(const anItem: TmsmModelElementMethodValue);
   procedure Insert(anIndex: Integer;
    const anItem: TmsmModelElementMethodValue);
   function FindData(const anItem: TmsmModelElementMethodValue;
    out theIndex: Integer): Boolean;
   procedure DeleteWordCachedValues(aWord: TtfwWord);
   class function Instance: TmsmModelElementMethodValueCache;
    {* Метод получения экземпляра синглетона TmsmModelElementMethodValueCache }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmModelElementMethodValueCache

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwWordDeleteListeners
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 //#UC START# *57B2E6B90102impl_uses*
 , kwCompiledProcedure
 , kwForwardDeclaration
 , kwConstLikeCompiled
 , NewWordDefinitorPack
 , kwTemporaryCompiledCode
 //#UC END# *57B2E6B90102impl_uses*
;

var g_TmsmModelElementMethodValueCache: TmsmModelElementMethodValueCache = nil;
 {* Экземпляр синглетона TmsmModelElementMethodValueCache }

procedure TmsmModelElementMethodValueCacheFree;
 {* Метод освобождения экземпляра синглетона TmsmModelElementMethodValueCache }
begin
 l3Free(g_TmsmModelElementMethodValueCache);
end;//TmsmModelElementMethodValueCacheFree

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmModelElementMethodValueCache.Add(const anItem: TmsmModelElementMethodValue);
//#UC START# *57BC33D10097_57B2E6B90102_var*
var
 l_Item : TmsmModelElementMethodValue;
//#UC END# *57BC33D10097_57B2E6B90102_var*
begin
//#UC START# *57BC33D10097_57B2E6B90102_impl*
 l_Item := CheckItem(anItem);
 if (l_Item.rWord = nil) then
  Exit;
 Assert(CanCacheWord(l_Item.rWord), 'Неверный тип слова для кеширования: ' + l_Item.rWord.ClassName);
 Lock;
 try
  inherited Add(l_Item);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57BC33D10097_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.Add

procedure TmsmModelElementMethodValueCache.Insert(anIndex: Integer;
 const anItem: TmsmModelElementMethodValue);
//#UC START# *57BC33ED02E7_57B2E6B90102_var*
var
 l_Item : TmsmModelElementMethodValue;
//#UC END# *57BC33ED02E7_57B2E6B90102_var*
begin
//#UC START# *57BC33ED02E7_57B2E6B90102_impl*
 l_Item := CheckItem(anItem);
 if (l_Item.rWord = nil) then
  Exit;
 Assert(CanCacheWord(l_Item.rWord), 'Неверный тип слова для кеширования: ' + l_Item.rWord.ClassName);
 Lock;
 try
  inherited Insert(anIndex, l_Item);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57BC33ED02E7_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.Insert

function TmsmModelElementMethodValueCache.CanCacheWord(aWord: TtfwWord): Boolean;
//#UC START# *57BC34160261_57B2E6B90102_var*
//#UC END# *57BC34160261_57B2E6B90102_var*
begin
//#UC START# *57BC34160261_57B2E6B90102_impl*
 Result :=
  (aWord Is TkwCompiledProcedure)
  OR (aWord Is TkwForwardDeclaration)
  OR (aWord Is TkwConstLikeCompiled)
  OR (aWord Is TkwGlobalVar)
 ;
 if Result then
  if (aWord Is TkwTemporaryCompiledCode) then
   Result := false;
//#UC END# *57BC34160261_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.CanCacheWord

function TmsmModelElementMethodValueCache.CheckItem(const anItem: TmsmModelElementMethodValue): TmsmModelElementMethodValue;
//#UC START# *57BC3A8400E3_57B2E6B90102_var*
//#UC END# *57BC3A8400E3_57B2E6B90102_var*
begin
//#UC START# *57BC3A8400E3_57B2E6B90102_impl*
 Result := anItem;
 Result.rWord := Result.rWord.GetRefForCompare;
//#UC END# *57BC3A8400E3_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.CheckItem

function TmsmModelElementMethodValueCache.FindData(const anItem: TmsmModelElementMethodValue;
 out theIndex: Integer): Boolean;
//#UC START# *57BC3FB202AF_57B2E6B90102_var*
//#UC END# *57BC3FB202AF_57B2E6B90102_var*
begin
//#UC START# *57BC3FB202AF_57B2E6B90102_impl*
 Lock;
 try
  Result := inherited FindData(CheckItem(anItem), theIndex);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57BC3FB202AF_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.FindData

procedure TmsmModelElementMethodValueCache.DeleteWordCachedValues(aWord: TtfwWord);
//#UC START# *57D25F960241_57B2E6B90102_var*
var
 l_Index : Integer;
 l_NeedClear : Boolean;
//#UC END# *57D25F960241_57B2E6B90102_var*
begin
//#UC START# *57D25F960241_57B2E6B90102_impl*
 l_NeedClear := true;
 l_NeedClear := CanCacheWord(aWord);
 if l_NeedClear then
 begin
  l_Index := 0;
  FindData(TmsmModelElementMethodValue_C(aWord, nil), l_Index);
  {if (l_Index > 0) then
   Dec(l_Index);}
  while (l_Index < Count) do
  begin
   if ItemSlot(l_Index).rWord = aWord then
   begin
    while (ItemSlot(l_Index).rWord = aWord) do
     Delete(l_Index);
    Exit;
   end//ItemSlot(l_Index).rWord = aWord
   else
    Inc(l_Index);
   break;
  end;//while (l_Index < Count)
 end;//l_NeedClear
//#UC END# *57D25F960241_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.DeleteWordCachedValues

{$If NOT Defined(NoScripts)}
procedure TmsmModelElementMethodValueCache.Notify(aWord: TtfwWord);
//#UC START# *57BAFEC801C8_57B2E6B90102_var*
//#UC END# *57BAFEC801C8_57B2E6B90102_var*
begin
//#UC START# *57BAFEC801C8_57B2E6B90102_impl*
 DeleteWordCachedValues(aWord);
//#UC END# *57BAFEC801C8_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.Notify
{$IfEnd} // NOT Defined(NoScripts)

class function TmsmModelElementMethodValueCache.Instance: TmsmModelElementMethodValueCache;
 {* Метод получения экземпляра синглетона TmsmModelElementMethodValueCache }
begin
 if (g_TmsmModelElementMethodValueCache = nil) then
 begin
  l3System.AddExitProc(TmsmModelElementMethodValueCacheFree);
  g_TmsmModelElementMethodValueCache := Create;
 end;
 Result := g_TmsmModelElementMethodValueCache;
end;//TmsmModelElementMethodValueCache.Instance

class function TmsmModelElementMethodValueCache.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmModelElementMethodValueCache <> nil;
end;//TmsmModelElementMethodValueCache.Exists

procedure TmsmModelElementMethodValueCache.InitFields;
//#UC START# *47A042E100E2_57B2E6B90102_var*
//#UC END# *47A042E100E2_57B2E6B90102_var*
begin
//#UC START# *47A042E100E2_57B2E6B90102_impl*
 inherited;
 TtfwWordDeleteListeners.Instance.Subscribe(Self);
//#UC END# *47A042E100E2_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.InitFields

procedure TmsmModelElementMethodValueCache.BeforeRelease;
//#UC START# *49BFC98902FF_57B2E6B90102_var*
//#UC END# *49BFC98902FF_57B2E6B90102_var*
begin
//#UC START# *49BFC98902FF_57B2E6B90102_impl*
 inherited;
 if TtfwWordDeleteListeners.Exists then
  TtfwWordDeleteListeners.Instance.Unsubscribe(Self);
//#UC END# *49BFC98902FF_57B2E6B90102_impl*
end;//TmsmModelElementMethodValueCache.BeforeRelease

end.
