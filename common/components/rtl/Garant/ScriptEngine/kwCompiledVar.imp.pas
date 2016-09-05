{$IfNDef kwCompiledVar_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "kwCompiledVar" MUID: (52D3E2EE0244)
// Имя типа: "_kwCompiledVar_"

{$Define kwCompiledVar_imp}

{$If NOT Defined(NoScripts)}
 _kwCompiledVar_ = {abstract} class(_kwCompiledVar_Parent_)
  private
   f_Value: TtfwStackValue;
   f_TypeInfo: TtfwWordInfo;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetValue(const aCtx: TtfwContext): TtfwStackValue; override;
   function IsVarLike: Boolean; override;
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
    const aCtx: TtfwContext); override;
   function CanClearInRecursiveCalls: Boolean; override;
 end;//_kwCompiledVar_

{$Else NOT Defined(NoScripts)}

_kwCompiledVar_ = _kwCompiledVar_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else kwCompiledVar_imp}

{$IfNDef kwCompiledVar_imp_impl}

{$Define kwCompiledVar_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _kwCompiledVar_.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D3E2EE0244_var*
//#UC END# *4DAEEDE10285_52D3E2EE0244_var*
begin
//#UC START# *4DAEEDE10285_52D3E2EE0244_impl*
 TtfwThreadVar.Instance.PushValue(Self, @f_Value, aCtx);
//#UC END# *4DAEEDE10285_52D3E2EE0244_impl*
end;//_kwCompiledVar_.DoDoIt

procedure _kwCompiledVar_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52D3E2EE0244_var*
//var
// l_V : PtfwStackValue;
//#UC END# *479731C50290_52D3E2EE0244_var*
begin
//#UC START# *479731C50290_52D3E2EE0244_impl*
 //l_V := TtfwThreadVar.Instance.Check(Self, @f_Value);
 //Finalize(l_V^);
 //l3FillChar(l_V^, SizeOf(l_V^));
 Finalize(f_Value);
 l3FillChar(f_Value, SizeOf(f_Value));
 f_TypeInfo := nil;
 inherited;
//#UC END# *479731C50290_52D3E2EE0244_impl*
end;//_kwCompiledVar_.Cleanup

function _kwCompiledVar_.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_52D3E2EE0244get_var*
//#UC END# *52CFC11603C8_52D3E2EE0244get_var*
begin
//#UC START# *52CFC11603C8_52D3E2EE0244get_impl*
 if (f_TypeInfo = nil) then
  Result := TtfwWordInfoE.Instance
 else
  Result := f_TypeInfo;
//#UC END# *52CFC11603C8_52D3E2EE0244get_impl*
end;//_kwCompiledVar_.pm_GetResultTypeInfo

procedure _kwCompiledVar_.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_52D3E2EE0244_var*
//#UC END# *52D00B00031A_52D3E2EE0244_var*
begin
//#UC START# *52D00B00031A_52D3E2EE0244_impl*
 TtfwThreadVar.Instance.SetValue(Self, @f_Value, aValue);
//#UC END# *52D00B00031A_52D3E2EE0244_impl*
end;//_kwCompiledVar_.SetValuePrim

function _kwCompiledVar_.GetValue(const aCtx: TtfwContext): TtfwStackValue;
//#UC START# *52D399A00173_52D3E2EE0244_var*
//#UC END# *52D399A00173_52D3E2EE0244_var*
begin
//#UC START# *52D399A00173_52D3E2EE0244_impl*
 Result := TtfwThreadVar.Instance.GetValue(Self, @f_Value);
//#UC END# *52D399A00173_52D3E2EE0244_impl*
end;//_kwCompiledVar_.GetValue

function _kwCompiledVar_.IsVarLike: Boolean;
//#UC START# *52D399D40140_52D3E2EE0244_var*
//#UC END# *52D399D40140_52D3E2EE0244_var*
begin
//#UC START# *52D399D40140_52D3E2EE0244_impl*
 Result := true;
//#UC END# *52D399D40140_52D3E2EE0244_impl*
end;//_kwCompiledVar_.IsVarLike

procedure _kwCompiledVar_.SetResultTypeInfo(aValue: TtfwWordInfo;
 const aCtx: TtfwContext);
//#UC START# *52EA6A2C0111_52D3E2EE0244_var*
//#UC END# *52EA6A2C0111_52D3E2EE0244_var*
begin
//#UC START# *52EA6A2C0111_52D3E2EE0244_impl*
 f_TypeInfo := aValue.Clone;
//#UC END# *52EA6A2C0111_52D3E2EE0244_impl*
end;//_kwCompiledVar_.SetResultTypeInfo

function _kwCompiledVar_.CanClearInRecursiveCalls: Boolean;
//#UC START# *559A470F0288_52D3E2EE0244_var*
//#UC END# *559A470F0288_52D3E2EE0244_var*
begin
//#UC START# *559A470F0288_52D3E2EE0244_impl*
 Result := true;
//#UC END# *559A470F0288_52D3E2EE0244_impl*
end;//_kwCompiledVar_.CanClearInRecursiveCalls
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf kwCompiledVar_imp_impl}

{$EndIf kwCompiledVar_imp}

