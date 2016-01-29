unit kwBynameControlPush;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$RTLandVCL"
// �����: ����� �.�.
// ������: "kwBynameControlPush.pas"
// �����: 26.01.2012 16:06
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ControlsProcessing::byname_control_push
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  kwControlWord,
  Classes,
  tfwScriptingInterfaces,
  TypInfo,
  Controls
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}
type
 TkwBynameControlPush = {scriptword} class(TkwControlWord)
 protected
 // realized methods
   procedure DoControl(aControl: TControl;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoComponent(aControl: TComponent;
     const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwBynameControlPush
{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  l3Except,
  Windows,
  Forms
  ;
{$IfEnd} //not NoScripts AND not NoVCL

{$If not defined(NoScripts) AND not defined(NoVCL)}

// start class TkwBynameControlPush

procedure TkwBynameControlPush.DoControl(aControl: TControl;
  const aCtx: TtfwContext);
//#UC START# *4DB98B990054_4F2141AD0203_var*
//#UC END# *4DB98B990054_4F2141AD0203_var*
begin
//#UC START# *4DB98B990054_4F2141AD0203_impl*
 aCtx.rEngine.PushObj(aControl);
//#UC END# *4DB98B990054_4F2141AD0203_impl*
end;//TkwBynameControlPush.DoControl

class function TkwBynameControlPush.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'byname:control:push';
end;//TkwBynameControlPush.GetWordNameForRegister

procedure TkwBynameControlPush.DoComponent(aControl: TComponent;
  const aCtx: TtfwContext);
//#UC START# *5357B6FB0024_4F2141AD0203_var*
//#UC END# *5357B6FB0024_4F2141AD0203_var*
begin
//#UC START# *5357B6FB0024_4F2141AD0203_impl*
 aCtx.rEngine.PushObj(aControl);
//#UC END# *5357B6FB0024_4F2141AD0203_impl*
end;//TkwBynameControlPush.DoComponent

function TkwBynameControlPush.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4F2141AD0203_var*
//#UC END# *551544E2001A_4F2141AD0203_var*
begin
//#UC START# *551544E2001A_4F2141AD0203_impl*
 Result := TypeInfo(TComponent);
//#UC END# *551544E2001A_4F2141AD0203_impl*
end;//TkwBynameControlPush.GetResultTypeInfo

{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� byname_control_push
 TkwBynameControlPush.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL

end.