unit kwVcmHistoryGetBackCount;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackCount.pas"
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
 TkwVcmHistoryGetBackCount = {final} class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmHistoryGetBackCount
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

procedure TkwVcmHistoryGetBackCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4C90B002D_var*
//#UC END# *4DAEEDE10285_4FC4C90B002D_var*
begin
//#UC START# *4DAEEDE10285_4FC4C90B002D_impl*
 aCtx.rEngine.PushInt(vcmDispatcher.History.GetBackCount);
//#UC END# *4DAEEDE10285_4FC4C90B002D_impl*
end;//TkwVcmHistoryGetBackCount.DoDoIt

class function TkwVcmHistoryGetBackCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:GetBackCount';
end;//TkwVcmHistoryGetBackCount.GetWordNameForRegister

initialization
 TkwVcmHistoryGetBackCount.RegisterInEngine;
 {* Регистрация vcm_History_GetBackCount }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
