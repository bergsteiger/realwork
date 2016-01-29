unit kwVcmDispatcherUnlockInOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmDispatcherUnlockInOp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_Dispatcher_UnlockInOp
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}
type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include ..\Scripting\VCMWord.imp.pas}
 TkwVcmDispatcherUnlockInOp = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherUnlockInOp
{$IfEnd} //not NoScripts AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoVCM)}
uses
  vcmForm
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  StdRes,
  vcmBase,
  afwAnswer
  ;
{$IfEnd} //not NoScripts AND not NoVCM

{$If not defined(NoScripts) AND not defined(NoVCM)}

{$Include ..\Scripting\VCMWord.imp.pas}

// start class TkwVcmDispatcherUnlockInOp

procedure TkwVcmDispatcherUnlockInOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558A60390336_var*
//#UC END# *4DAEEDE10285_558A60390336_var*
begin
//#UC START# *4DAEEDE10285_558A60390336_impl*
 vcmDispatcher.UnlockInOp;
//#UC END# *4DAEEDE10285_558A60390336_impl*
end;//TkwVcmDispatcherUnlockInOp.DoDoIt

class function TkwVcmDispatcherUnlockInOp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Dispatcher:UnlockInOp';
end;//TkwVcmDispatcherUnlockInOp.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_Dispatcher_UnlockInOp
 TkwVcmDispatcherUnlockInOp.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.