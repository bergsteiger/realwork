unit kwVcmDispatcherUnlockInOp;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlockInOp.pas"
// Стереотип: "ScriptKeyword"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include VCMWord.imp.pas}
 TkwVcmDispatcherUnlockInOp = {final} class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherUnlockInOp
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmForm
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , StdRes
 , vcmBase
 , afwAnswer
;

{$Include VCMWord.imp.pas}

procedure TkwVcmDispatcherUnlockInOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558A60390336_var*
//#UC END# *4DAEEDE10285_558A60390336_var*
begin
//#UC START# *4DAEEDE10285_558A60390336_impl*
 vcmDispatcher.UnlockInOp;
//#UC END# *4DAEEDE10285_558A60390336_impl*
end;//TkwVcmDispatcherUnlockInOp.DoDoIt

class function TkwVcmDispatcherUnlockInOp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:UnlockInOp';
end;//TkwVcmDispatcherUnlockInOp.GetWordNameForRegister

initialization
 TkwVcmDispatcherUnlockInOp.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_UnlockInOp }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
