unit kwVcmDispatcherBeginOp;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherBeginOp.pas"
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
 TkwVcmDispatcherBeginOp = {final} class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmDispatcherBeginOp
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

procedure TkwVcmDispatcherBeginOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69BC1C02CC_var*
//#UC END# *4DAEEDE10285_4F69BC1C02CC_var*
begin
//#UC START# *4DAEEDE10285_4F69BC1C02CC_impl*
 vcmDispatcher.BeginOp;
//#UC END# *4DAEEDE10285_4F69BC1C02CC_impl*
end;//TkwVcmDispatcherBeginOp.DoDoIt

class function TkwVcmDispatcherBeginOp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:BeginOp';
end;//TkwVcmDispatcherBeginOp.GetWordNameForRegister

initialization
 TkwVcmDispatcherBeginOp.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_BeginOp }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
