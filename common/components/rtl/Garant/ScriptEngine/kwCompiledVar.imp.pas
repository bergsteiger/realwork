{$IfNDef kwCompiledVar_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "kwCompiledVar.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::kwCompiledVar
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define kwCompiledVar_imp}
{$If not defined(NoScripts)}
 _kwCompiledVar_ = {abstract mixin} class(_kwCompiledVar_Parent_)
 private
 // private fields
   f_Value : TtfwStackValue;
   f_TypeInfo : TtfwWordInfo;
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden property methods
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetValue(const aCtx: TtfwContext): PtfwStackValue; override;
   function IsVarLike: Boolean; override;
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
     const aCtx: TtfwContext); override;
   function CanClearInRecursiveCalls: Boolean; override;
 end;//_kwCompiledVar_
{$Else}

 _kwCompiledVar_ = _kwCompiledVar_Parent_;

{$IfEnd} //not NoScripts

{$Else kwCompiledVar_imp}

{$If not defined(NoScripts)}

// start class _kwCompiledVar_

procedure _kwCompiledVar_.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D3E2EE0244_var*
//#UC END# *4DAEEDE10285_52D3E2EE0244_var*
begin
//#UC START# *4DAEEDE10285_52D3E2EE0244_impl*
 aCtx.rEngine.Push(f_Value);
//#UC END# *4DAEEDE10285_52D3E2EE0244_impl*
end;//_kwCompiledVar_.DoDoIt

procedure _kwCompiledVar_.Cleanup;
//#UC START# *479731C50290_52D3E2EE0244_var*
//#UC END# *479731C50290_52D3E2EE0244_var*
begin
//#UC START# *479731C50290_52D3E2EE0244_impl*
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
 f_Value := aValue;
//#UC END# *52D00B00031A_52D3E2EE0244_impl*
end;//_kwCompiledVar_.SetValuePrim

function _kwCompiledVar_.GetValue(const aCtx: TtfwContext): PtfwStackValue;
//#UC START# *52D399A00173_52D3E2EE0244_var*
//#UC END# *52D399A00173_52D3E2EE0244_var*
begin
//#UC START# *52D399A00173_52D3E2EE0244_impl*
 Result := @f_Value;
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

{$IfEnd} //not NoScripts

{$EndIf kwCompiledVar_imp}
