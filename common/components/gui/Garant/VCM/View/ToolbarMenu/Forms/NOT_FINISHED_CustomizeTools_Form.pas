unit NOT_FINISHED_CustomizeTools_Form;

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\NOT_FINISHED_CustomizeTools_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "CustomizeTools" MUID: (4C8E42D40131)
// ��� ����: "TCustomizeToolsForm"

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
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , CustomizeToolsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_CustomizeToolsLocalConstants }
 str_ut_CustomizeToolsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeToolsCaption'; rValue : 'CustomizeTools');
  {* ��������� ����������������� ���� "CustomizeTools" }

initialization
 str_ut_CustomizeToolsCaption.Init;
 {* ������������� str_ut_CustomizeToolsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomizeToolsForm);
 {* ����������� CustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
