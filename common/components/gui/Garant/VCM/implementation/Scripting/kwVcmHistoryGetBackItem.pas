unit kwVcmHistoryGetBackItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetBackItem.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_History_GetBackItem" MUID: (4FC4C928013F)
// Имя типа: "TkwVcmHistoryGetBackItem"

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
 TkwVcmHistoryGetBackItem = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmHistoryGetBackItem
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

class function TkwVcmHistoryGetBackItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:GetBackItem';
end;//TkwVcmHistoryGetBackItem.GetWordNameForRegister

procedure TkwVcmHistoryGetBackItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4C928013F_var*
//#UC END# *4DAEEDE10285_4FC4C928013F_var*
begin
//#UC START# *4DAEEDE10285_4FC4C928013F_impl*
 aCtx.rEngine.PushString(vcmDispatcher.History.GetBackItem(aCtx.rEngine.PopInt));
//#UC END# *4DAEEDE10285_4FC4C928013F_impl*
end;//TkwVcmHistoryGetBackItem.DoDoIt

initialization
 TkwVcmHistoryGetBackItem.RegisterInEngine;
 {* Регистрация vcm_History_GetBackItem }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
