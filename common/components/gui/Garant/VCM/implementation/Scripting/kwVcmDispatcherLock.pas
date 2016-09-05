unit kwVcmDispatcherLock;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLock.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_Dispatcher_Lock" MUID: (4F69B99001E0)
// Имя типа: "TkwVcmDispatcherLock"

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
 TkwVcmDispatcherLock = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmDispatcherLock
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
 //#UC START# *4F69B99001E0impl_uses*
 //#UC END# *4F69B99001E0impl_uses*
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

class function TkwVcmDispatcherLock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:Lock';
end;//TkwVcmDispatcherLock.GetWordNameForRegister

procedure TkwVcmDispatcherLock.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69B99001E0_var*
//#UC END# *4DAEEDE10285_4F69B99001E0_var*
begin
//#UC START# *4DAEEDE10285_4F69B99001E0_impl*
 vcmDispatcher.FormDispatcher.Lock;
//#UC END# *4DAEEDE10285_4F69B99001E0_impl*
end;//TkwVcmDispatcherLock.DoDoIt

initialization
 TkwVcmDispatcherLock.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_Lock }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
