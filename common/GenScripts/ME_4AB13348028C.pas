unit DocNumberQuery_Form;
 {* ������� �������� �� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocNumberQueryOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_DocNumberQueryForm: TvcmFormDescriptor = (rFormID : (rName : 'DocNumberQueryForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TDocNumberQueryForm }

type
 DocNumberQueryFormDef = interface
  {* ������������� ����� DocNumberQuery }
  ['{A522FA71-1132-495B-A68D-0533C12052F1}']
 end;//DocNumberQueryFormDef

 TDocNumberQueryForm = {final} class(TPrimDocNumberQueryOptionsForm, DocNumberQueryFormDef)
  {* ������� �������� �� ������ }
 end;//TDocNumberQueryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , DocNumberQueryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_DocNumberQueryLocalConstants }
 str_ut_DocNumberQueryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DocNumberQueryCaption'; rValue : '������� �������� �� ������');
  {* ��������� ����������������� ���� "������� �������� �� ������" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDocNumberQueryForm);
 {* ����������� DocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_DocNumberQueryCaption.Init;
 {* ������������� str_ut_DocNumberQueryCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
