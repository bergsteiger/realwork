unit kwVcmDispatcherUnlockInOp;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherUnlockInOp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_Dispatcher_UnlockInOp" MUID: (558A60390336)
// Имя типа: "TkwVcmDispatcherUnlockInOp"

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
 TkwVcmDispatcherUnlockInOp = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
 //#UC START# *558A60390336impl_uses*
 //#UC END# *558A60390336impl_uses*
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

class function TkwVcmDispatcherUnlockInOp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:UnlockInOp';
end;//TkwVcmDispatcherUnlockInOp.GetWordNameForRegister

procedure TkwVcmDispatcherUnlockInOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558A60390336_var*
//#UC END# *4DAEEDE10285_558A60390336_var*
begin
//#UC START# *4DAEEDE10285_558A60390336_impl*
 vcmDispatcher.UnlockInOp;
//#UC END# *4DAEEDE10285_558A60390336_impl*
end;//TkwVcmDispatcherUnlockInOp.DoDoIt

initialization
 TkwVcmDispatcherUnlockInOp.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_UnlockInOp }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
