unit kwWaitCancel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwWaitCancel.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::ModalDialogs::wait_Cancel
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}
type
 _afwImpurity_Parent_ = TtfwRegisterableWord;
 {$Include ..\ScriptEngine\afwImpurity.imp.pas}
 TkwWaitCancel = {final scriptword} class(_afwImpurity_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwWaitCancel
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  l3BatchService,
  Controls
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}

{$Include ..\ScriptEngine\afwImpurity.imp.pas}

// start class TkwWaitCancel

procedure TkwWaitCancel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FFFE217028B_var*
//#UC END# *4DAEEDE10285_4FFFE217028B_var*
begin
//#UC START# *4DAEEDE10285_4FFFE217028B_impl*
 Tl3BatchService.Instance.PushAnswer(mrCancel);
//#UC END# *4DAEEDE10285_4FFFE217028B_impl*
end;//TkwWaitCancel.DoDoIt

class function TkwWaitCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wait:Cancel';
end;//TkwWaitCancel.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� wait_Cancel
 TkwWaitCancel.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.