{$IfNDef tfwStackChecking_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "tfwStackChecking.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::tfwStackChecking
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define tfwStackChecking_imp}
{$If not defined(NoScripts)}
 _tfwStackChecking_ = {mixin} class(_tfwStackChecking_Parent_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   function StackCheckingMessage: AnsiString; virtual;
 end;//_tfwStackChecking_
{$Else}

 _tfwStackChecking_ = _tfwStackChecking_Parent_;

{$IfEnd} //not NoScripts

{$Else tfwStackChecking_imp}

{$If not defined(NoScripts)}

// start class _tfwStackChecking_

function _tfwStackChecking_.StackCheckingMessage: AnsiString;
//#UC START# *528F7301033E_528F7DDA02BF_var*
//#UC END# *528F7301033E_528F7DDA02BF_var*
begin
//#UC START# *528F7301033E_528F7DDA02BF_impl*
 Result := '��������� �� ����� ���������� �������� ����� ����';
//#UC END# *528F7301033E_528F7DDA02BF_impl*
end;//_tfwStackChecking_.StackCheckingMessage

procedure _tfwStackChecking_.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_528F7DDA02BF_var*
var
 l_StackCount : Integer;
 l_ParamCount : Integer;
//#UC END# *4DAEEDE10285_528F7DDA02BF_var*
begin
//#UC START# *4DAEEDE10285_528F7DDA02BF_impl*
 l_StackCount := aCtx.rEngine.ValuesCount;
 l_ParamCount := Self.GetAllParamsCount(aCtx);
 inherited;
 l_StackCount := aCtx.rEngine.ValuesCount - (l_StackCount - l_ParamCount);
 if (l_StackCount > 0) then
 begin
  while (l_StackCount > 0) do
  // - ������ �����, ����� �� �� �������� ���������
  begin
   aCtx.rEngine.Drop;
   Dec(l_StackCount);
  end;//while (l_StackCount > 0)
  RunnerError(StackCheckingMessage, aCtx);
 end//l_StackCount > 0
 else
 if (l_StackCount < 0) then
 begin
  RunnerAssertFmt(false, '�� ����� ������� ������ ��������: %d, ��� ������� ����������: %d', [l_ParamCount-l_StackCount, l_ParamCount], aCtx);
 end;//l_StackCount < 0
//#UC END# *4DAEEDE10285_528F7DDA02BF_impl*
end;//_tfwStackChecking_.DoDoIt

{$IfEnd} //not NoScripts

{$EndIf tfwStackChecking_imp}
