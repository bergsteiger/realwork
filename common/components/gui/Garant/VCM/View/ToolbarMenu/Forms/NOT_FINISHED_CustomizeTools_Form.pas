unit NOT_FINISHED_CustomizeTools_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\NOT_FINISHED_CustomizeTools_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimCustomizeTools_Form
;

type
 TCustomizeToolsForm = {final} class(TPrimCustomizeToolsForm)
 end;//TCustomizeToolsForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If Defined(Nemesis)}
 , eeShortCutEdit
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , CustomizeToolsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_CustomizeToolsLocalConstants }
 str_ut_CustomizeToolsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeToolsCaption'; rValue : 'CustomizeTools');
  {* ��������� ����������������� ���� "CustomizeTools" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeToolsForm);
 {* ����������� CustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_CustomizeToolsCaption.Init;
 {* ������������� str_ut_CustomizeToolsCaption }
{$IfEnd} // NOT Defined(NoVCM)

end.
