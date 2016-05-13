unit kwVcmHistoryGetForwardCount;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardCount.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_History_GetForwardCount" MUID: (4FC4CEF40288)
// Имя типа: "TkwVcmHistoryGetForwardCount"

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
 TkwVcmHistoryGetForwardCount = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmHistoryGetForwardCount
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

class function TkwVcmHistoryGetForwardCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:GetForwardCount';
end;//TkwVcmHistoryGetForwardCount.GetWordNameForRegister

procedure TkwVcmHistoryGetForwardCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4CEF40288_var*
//#UC END# *4DAEEDE10285_4FC4CEF40288_var*
begin
//#UC START# *4DAEEDE10285_4FC4CEF40288_impl*
 aCtx.rEngine.PushInt(vcmDispatcher.History.GetForwardCount);
//#UC END# *4DAEEDE10285_4FC4CEF40288_impl*
end;//TkwVcmHistoryGetForwardCount.DoDoIt

initialization
 TkwVcmHistoryGetForwardCount.RegisterInEngine;
 {* Регистрация vcm_History_GetForwardCount }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
