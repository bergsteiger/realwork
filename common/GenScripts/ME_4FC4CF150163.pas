unit kwVcmHistoryGetForwardItem;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmHistoryGetForwardItem.pas"
// ���������: "ScriptKeyword"
// ������� ������: "vcm_History_GetForwardItem" MUID: (4FC4CF150163)
// ��� ����: "TkwVcmHistoryGetForwardItem"

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
 TkwVcmHistoryGetForwardItem = {final} class(_VCMWord_)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwVcmHistoryGetForwardItem
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

class function TkwVcmHistoryGetForwardItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:History:GetForwardItem';
end;//TkwVcmHistoryGetForwardItem.GetWordNameForRegister

procedure TkwVcmHistoryGetForwardItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC4CF150163_var*
//#UC END# *4DAEEDE10285_4FC4CF150163_var*
begin
//#UC START# *4DAEEDE10285_4FC4CF150163_impl*
 aCtx.rEngine.PushString(vcmDispatcher.History.GetForwardItem(aCtx.rEngine.PopInt));
//#UC END# *4DAEEDE10285_4FC4CF150163_impl*
end;//TkwVcmHistoryGetForwardItem.DoDoIt

initialization
 TkwVcmHistoryGetForwardItem.RegisterInEngine;
 {* ����������� vcm_History_GetForwardItem }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
