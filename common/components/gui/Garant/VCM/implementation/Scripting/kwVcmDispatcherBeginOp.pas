unit kwVcmDispatcherBeginOp;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmDispatcherBeginOp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_Dispatcher_BeginOp" MUID: (4F69BC1C02CC)
// Имя типа: "TkwVcmDispatcherBeginOp"

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
 TkwVcmDispatcherBeginOp = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
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
 //#UC START# *4F69BC1C02CCimpl_uses*
 //#UC END# *4F69BC1C02CCimpl_uses*
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

class function TkwVcmDispatcherBeginOp.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:Dispatcher:BeginOp';
end;//TkwVcmDispatcherBeginOp.GetWordNameForRegister

procedure TkwVcmDispatcherBeginOp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F69BC1C02CC_var*
//#UC END# *4DAEEDE10285_4F69BC1C02CC_var*
begin
//#UC START# *4DAEEDE10285_4F69BC1C02CC_impl*
 vcmDispatcher.BeginOp;
//#UC END# *4DAEEDE10285_4F69BC1C02CC_impl*
end;//TkwVcmDispatcherBeginOp.DoDoIt

initialization
 TkwVcmDispatcherBeginOp.RegisterInEngine;
 {* Регистрация vcm_Dispatcher_BeginOp }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
