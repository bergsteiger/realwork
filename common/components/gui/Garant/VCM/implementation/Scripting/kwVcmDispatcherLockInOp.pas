unit kwVcmDispatcherLockInOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Scripting"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Scripting/kwVcmDispatcherLockInOp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> Shared Delphi::VCM$Scripting::VCMWords::vcm_Dispatcher_LockInOp
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
 TkwVcmDispatcherLockInOp = {final scriptword} class(_VCMWord_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherLockInOp
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

// start class TkwVcmDispatcherLockInOp

procedure TkwVcmDispatcherLockInOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558A5FF8002C_var*
//#UC END# *4DAEEDE10285_558A5FF8002C_var*
begin
//#UC START# *4DAEEDE10285_558A5FF8002C_impl*
 vcmDispatcher.LockInOp;
//#UC END# *4DAEEDE10285_558A5FF8002C_impl*
end;//TkwVcmDispatcherLockInOp.DoDoIt

class function TkwVcmDispatcherLockInOp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:Dispatcher:LockInOp';
end;//TkwVcmDispatcherLockInOp.GetWordNameForRegister

{$IfEnd} //not NoScripts AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация vcm_Dispatcher_LockInOp
 TkwVcmDispatcherLockInOp.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM

end.