unit kwVcmDispatcherUnlock;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlock.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}
 TkwVcmDispatcherUnlock = {final} class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherUnlock
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

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

procedure TkwVcmDispatcherUnlock.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69B9AD0040_var*
//#UC END# *4DAEEDE10285_4F69B9AD0040_var*
begin
//#UC START# *4DAEEDE10285_4F69B9AD0040_impl*
 vcmDispatcher.FormDispatcher.Unlock;
//#UC END# *4DAEEDE10285_4F69B9AD0040_impl*
end;//TkwVcmDispatcherUnlock.DoDoIt

class function TkwVcmDispatcherUnlock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:Unlock';
end;//TkwVcmDispatcherUnlock.GetWordNameForRegister

initialization
 TkwVcmDispatcherUnlock.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_Unlock }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
