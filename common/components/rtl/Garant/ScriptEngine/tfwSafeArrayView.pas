unit tfwSafeArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwSafeArrayView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwSafeArrayView" MUID: (57C820E80374)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
;

type
 TtfwSafeArrayView = class(TtfwArrayView)
  private
   procedure TransformArray;
  protected
   function GetCount: Integer; override;
   function GetItem(anIndex: Integer): TtfwStackValue; override;
   function GetSafeView: ItfwValueList; override;
   function GetIsView: Boolean; override;
  public
   procedure DoForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
 end;//TtfwSafeArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwArray
 , tfwStoredValuesStack
 //#UC START# *57C820E80374impl_uses*
 , SysUtils
 , tfwScriptEnginePrim
 {$IfDef MSM}
 , Controls
 , Forms
 , msmScriptCaller
 {$Else  MSM}
 , tfwDefaultScriptCaller
 {$EndIf MSM}
 //#UC END# *57C820E80374impl_uses*
;

type
 TtfwSafeArrayViewLambda = class(TtfwWord)
  private
   f_Array: TtfwArray;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(anArray: TtfwArray); reintroduce;
 end;//TtfwSafeArrayViewLambda

constructor TtfwSafeArrayViewLambda.Create(anArray: TtfwArray);
//#UC START# *57C823A00390_57C82359026B_var*
//#UC END# *57C823A00390_57C82359026B_var*
begin
//#UC START# *57C823A00390_57C82359026B_impl*
 anArray.SetRefTo(f_Array);
 inherited Create;
//#UC END# *57C823A00390_57C82359026B_impl*
end;//TtfwSafeArrayViewLambda.Create

procedure TtfwSafeArrayViewLambda.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_57C82359026B_var*
//#UC END# *4DAEEDE10285_57C82359026B_var*
begin
//#UC START# *4DAEEDE10285_57C82359026B_impl*
 f_Array.Add(aCtx.rEngine.Pop);
//#UC END# *4DAEEDE10285_57C82359026B_impl*
end;//TtfwSafeArrayViewLambda.DoDoIt

procedure TtfwSafeArrayViewLambda.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C82359026B_var*
//#UC END# *479731C50290_57C82359026B_var*
begin
//#UC START# *479731C50290_57C82359026B_impl*
 FreeAndNil(f_Array);
 inherited;
//#UC END# *479731C50290_57C82359026B_impl*
end;//TtfwSafeArrayViewLambda.Cleanup

procedure TtfwSafeArrayView.TransformArray;
//#UC START# *57C823BB02D8_57C820E80374_var*
var
 l_A : TtfwArray;
 l_L : TtfwSafeArrayViewLambda;
 l_Ctx : TtfwContext;
 l_E : TtfwScriptEnginePrim;
{$IfDef MSM}
var
 l_Cursor: TCursor;
{$EndIf MSM}
//#UC END# *57C823BB02D8_57C820E80374_var*
begin
//#UC START# *57C823BB02D8_57C820E80374_impl*
 l_A := TtfwArray.Create;
 try
  l_L := TtfwSafeArrayViewLambda.Create(l_A);
  try
   FillChar(l_Ctx, SizeOf(l_Ctx), 0);
   try
    l_E := TtfwScriptEnginePrim.Create;
    try
     l_Ctx.rStoredValuesStack := TtfwStoredValuesStack.Make;
     l_Ctx.rEngine := l_E;
     {$IfDef MSM}
     l_Ctx.rCaller := TmsmScriptCaller.Make;
     {$Else  MSM}
     l_Ctx.rCaller := TtfwDefaultScriptCaller.Make;
     {$EndIf MSM}
     {$IfDef MSM}
     l_Cursor := Screen.Cursor;
     Screen.Cursor := crHourGlass;
     try
      Self.ForEach(l_L, l_Ctx);
     finally
      Screen.Cursor := l_Cursor;
     end;//Screen.Cursor := crHourGlass;
     {$Else  MSM}
     Self.DoForEach(l_L, l_Ctx);
     {$EndIf MSM}
    finally
     FreeAndNil(l_E);
    end;//try..finally
   finally
    Finalize(l_Ctx);
   end;//try..finally
   f_Other := l_A;
  finally
   FreeAndNil(l_L);
  end;//try..finally
 finally
  FreeAndNil(l_A);
 end;//try..finally
//#UC END# *57C823BB02D8_57C820E80374_impl*
end;//TtfwSafeArrayView.TransformArray

procedure TtfwSafeArrayView.DoForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666E80335_57C820E80374_var*
var
 l_L : ItfwValueList;
//#UC END# *52E666E80335_57C820E80374_var*
begin
//#UC START# *52E666E80335_57C820E80374_impl*
 l_L := f_Other;
 try
  inherited DoForEach(aLambda, aCtx);
 finally
  l_L := nil;
 end;//try..finally
//#UC END# *52E666E80335_57C820E80374_impl*
end;//TtfwSafeArrayView.DoForEach

procedure TtfwSafeArrayView.DoForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666F6036E_57C820E80374_var*
var
 l_L : ItfwValueList;
//#UC END# *52E666F6036E_57C820E80374_var*
begin
//#UC START# *52E666F6036E_57C820E80374_impl*
 l_L := f_Other;
 try
  inherited DoForEachBack(aLambda, aCtx);
 finally
  l_L := nil;
 end;//try..finally
//#UC END# *52E666F6036E_57C820E80374_impl*
end;//TtfwSafeArrayView.DoForEachBack

function TtfwSafeArrayView.GetCount: Integer;
//#UC START# *57C811A30375_57C820E80374_var*
//#UC END# *57C811A30375_57C820E80374_var*
begin
//#UC START# *57C811A30375_57C820E80374_impl*
 try
  Result := f_Other.Count;
 except
  on EtfwNotImplemented do
  begin
   TransformArray;
   Result := f_Other.Count;
  end;//on EtfwNotImplemented
 end;//try..except
//#UC END# *57C811A30375_57C820E80374_impl*
end;//TtfwSafeArrayView.GetCount

function TtfwSafeArrayView.GetItem(anIndex: Integer): TtfwStackValue;
//#UC START# *57C8146602DB_57C820E80374_var*
//#UC END# *57C8146602DB_57C820E80374_var*
begin
//#UC START# *57C8146602DB_57C820E80374_impl*
 try
  Result := f_Other.Items[anIndex];
 except
  on EtfwNotImplemented do
  begin
   TransformArray;
   Result := f_Other.Items[anIndex];
  end;//on EtfwNotImplemented
 end;//try..except
//#UC END# *57C8146602DB_57C820E80374_impl*
end;//TtfwSafeArrayView.GetItem

function TtfwSafeArrayView.GetSafeView: ItfwValueList;
//#UC START# *57C821A402BB_57C820E80374_var*
//#UC END# *57C821A402BB_57C820E80374_var*
begin
//#UC START# *57C821A402BB_57C820E80374_impl*
 Result := Self;
//#UC END# *57C821A402BB_57C820E80374_impl*
end;//TtfwSafeArrayView.GetSafeView

function TtfwSafeArrayView.GetIsView: Boolean;
//#UC START# *57C9E8AC03C6_57C820E80374_var*
//#UC END# *57C9E8AC03C6_57C820E80374_var*
begin
//#UC START# *57C9E8AC03C6_57C820E80374_impl*
 if (f_Other = nil) then
  Result := false
 else
  Result := f_Other.IsView; 
//#UC END# *57C9E8AC03C6_57C820E80374_impl*
end;//TtfwSafeArrayView.GetIsView

initialization
 TtfwSafeArrayViewLambda.RegisterClass;
 {* Регистрация TtfwSafeArrayViewLambda }
{$IfEnd} // NOT Defined(NoScripts)

end.
