unit tfwThreadVar;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVar.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwThreadVar" MUID: (57C41DB202EB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwThreadVarPrim
 , tfwTypeInfo
 , tfwScriptingInterfaces
 , SyncObjs
;

type
 _seCriticalSectionHolder_Parent_ = TtfwThreadVarPrim;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TtfwThreadVar = class(_seCriticalSectionHolder_)
  protected
   procedure InitFields; override;
  public
   function GetValue(aWord: TtfwWord;
    aPlace: PtfwStackValue): TtfwStackValue;
   procedure SetValue(aWord: TtfwWord;
    aPlace: PtfwStackValue;
    const aValue: TtfwStackValue);
   procedure PushValue(aWord: TtfwWord;
    aPlace: PtfwStackValue;
    const aCtx: TtfwContext);
   class function Instance: TtfwThreadVar;
    {* Метод получения экземпляра синглетона TtfwThreadVar }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwThreadVar
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57C41DB202EBimpl_uses*
 , Windows
 //#UC END# *57C41DB202EBimpl_uses*
;

var g_TtfwThreadVar: TtfwThreadVar = nil;
 {* Экземпляр синглетона TtfwThreadVar }

procedure TtfwThreadVarFree;
 {* Метод освобождения экземпляра синглетона TtfwThreadVar }
begin
 l3Free(g_TtfwThreadVar);
end;//TtfwThreadVarFree

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

function TtfwThreadVar.GetValue(aWord: TtfwWord;
 aPlace: PtfwStackValue): TtfwStackValue;
//#UC START# *57C41E0E0089_57C41DB202EB_var*
{$IfDef seThreadSafe}
var
 l_T : Cardinal;
 l_R : TtfwThreadVarRec;
 l_Index : Integer;
{$EndIf seThreadSafe}
//#UC END# *57C41E0E0089_57C41DB202EB_var*
begin
//#UC START# *57C41E0E0089_57C41DB202EB_impl*
 {$IfDef seThreadSafe}
 l_T := GetCurrentThreadID;
 if not aWord.IsGlobalVar then
 begin
  if (MainThreadID <> l_T) then
  begin
   l_R := TtfwThreadVarRec_C(aWord, l_T);
   Self.Lock;
   try
    if not Self.FindData(l_R, l_Index) then
     l_Index := Add(l_R);
    Result := Self.ItemSlot(l_Index).rValue;
    Exit;
   finally
    Self.Unlock;
   end;//try..finally
  end;//MainThreadID <> l_T
 end;//not aWord.IsGlobalVar..
 {$EndIf seThreadSafe}
 Result := aPlace^;
//#UC END# *57C41E0E0089_57C41DB202EB_impl*
end;//TtfwThreadVar.GetValue

procedure TtfwThreadVar.SetValue(aWord: TtfwWord;
 aPlace: PtfwStackValue;
 const aValue: TtfwStackValue);
//#UC START# *57C7D06B03A9_57C41DB202EB_var*
var
 l_T : Cardinal;
 l_R : TtfwThreadVarRec;
 l_Index : Integer;
//#UC END# *57C7D06B03A9_57C41DB202EB_var*
begin
//#UC START# *57C7D06B03A9_57C41DB202EB_impl*
 {$IfDef seThreadSafe}
 l_T := GetCurrentThreadID;
 if not aWord.IsGlobalVar then
 begin
  if (MainThreadID <> l_T) then
  begin
   l_R := TtfwThreadVarRec_C(aWord, l_T);
   Self.Lock;
   try
    if not Self.FindData(l_R, l_Index) then
     l_Index := Add(l_R);
    Self.ItemSlot(l_Index).rValue := aValue;
    Exit;
   finally
    Self.Unlock;
   end;//try..finally
  end;//MainThreadID <> l_T
 end;//not aWord.IsGlobalVar..
 {$EndIf seThreadSafe}
 aPlace^ := aValue;
//#UC END# *57C7D06B03A9_57C41DB202EB_impl*
end;//TtfwThreadVar.SetValue

procedure TtfwThreadVar.PushValue(aWord: TtfwWord;
 aPlace: PtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *57C7D318039E_57C41DB202EB_var*
var
 l_T : Cardinal;
 l_R : TtfwThreadVarRec;
 l_Index : Integer;
//#UC END# *57C7D318039E_57C41DB202EB_var*
begin
//#UC START# *57C7D318039E_57C41DB202EB_impl*
 {$IfDef seThreadSafe}
 l_T := GetCurrentThreadID;
 if not aWord.IsGlobalVar then
 begin
  if (MainThreadID <> l_T) then
  begin
   l_R := TtfwThreadVarRec_C(aWord, l_T);
   Self.Lock;
   try
    if not Self.FindData(l_R, l_Index) then
     l_Index := Add(l_R);
    aCtx.rEngine.Push(Self.ItemSlot(l_Index).rValue);
    Exit;
   finally
    Self.Unlock;
   end;//try..finally
  end;//MainThreadID <> l_T
 end;//not aWord.IsGlobalVar..
 {$EndIf seThreadSafe}
 aCtx.rEngine.Push(aPlace^);
//#UC END# *57C7D318039E_57C41DB202EB_impl*
end;//TtfwThreadVar.PushValue

class function TtfwThreadVar.Instance: TtfwThreadVar;
 {* Метод получения экземпляра синглетона TtfwThreadVar }
begin
 if (g_TtfwThreadVar = nil) then
 begin
  l3System.AddExitProc(TtfwThreadVarFree);
  g_TtfwThreadVar := Create;
 end;
 Result := g_TtfwThreadVar;
end;//TtfwThreadVar.Instance

class function TtfwThreadVar.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwThreadVar <> nil;
end;//TtfwThreadVar.Exists

procedure TtfwThreadVar.InitFields;
//#UC START# *47A042E100E2_57C41DB202EB_var*
//#UC END# *47A042E100E2_57C41DB202EB_var*
begin
//#UC START# *47A042E100E2_57C41DB202EB_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_57C41DB202EB_impl*
end;//TtfwThreadVar.InitFields
{$IfEnd} // NOT Defined(NoScripts)

end.
