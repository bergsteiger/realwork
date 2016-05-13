unit kwVcmDispatcherLockInOp;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherLockInOp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_Dispatcher_LockInOp" MUID: (558A5FF8002C)
// Имя типа: "TkwVcmDispatcherLockInOp"

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
 TkwVcmDispatcherLockInOp = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmDispatcherLockInOp
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

class function TkwVcmDispatcherLockInOp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:LockInOp';
end;//TkwVcmDispatcherLockInOp.GetWordNameForRegister

procedure TkwVcmDispatcherLockInOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_558A5FF8002C_var*
//#UC END# *4DAEEDE10285_558A5FF8002C_var*
begin
//#UC START# *4DAEEDE10285_558A5FF8002C_impl*
 vcmDispatcher.LockInOp;
//#UC END# *4DAEEDE10285_558A5FF8002C_impl*
end;//TkwVcmDispatcherLockInOp.DoDoIt

initialization
 TkwVcmDispatcherLockInOp.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_LockInOp }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
