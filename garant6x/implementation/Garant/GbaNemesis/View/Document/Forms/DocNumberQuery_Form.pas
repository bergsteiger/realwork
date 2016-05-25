unit DocNumberQuery_Form;
 {* ������� �������� �� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\DocNumberQuery_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "DocNumberQuery" MUID: (4AB13348028C)
// ��� ����: "TDocNumberQueryForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocNumberQueryOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_DocNumberQueryForm: TvcmFormDescriptor = (rFormID : (rName : 'DocNumberQueryForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TDocNumberQueryForm }

type
 TDocNumberQueryForm = class;

 DocNumberQueryFormDef = interface
  {* ������������� ����� DocNumberQuery }
  ['{A522FA71-1132-495B-A68D-0533C12052F1}']
 end;//DocNumberQueryFormDef

 TDocNumberQueryForm = {final} class(TPrimDocNumberQueryOptionsForm, DocNumberQueryFormDef)
  {* ������� �������� �� ������ }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TDocNumberQueryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , DocNumberQuery_ut_DocNumberQuery_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DocNumberQueryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_DocNumberQueryLocalConstants }
 str_ut_DocNumberQueryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DocNumberQueryCaption'; rValue : '������� �������� �� ������');
  {* ��������� ����������������� ���� "������� �������� �� ������" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TDocNumberQueryForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_DocNumberQueryName,
  str_ut_DocNumberQueryCaption,
  str_ut_DocNumberQueryCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_DocNumberQueryName
end;//TDocNumberQueryForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_DocNumberQueryCaption.Init;
 {* ������������� str_ut_DocNumberQueryCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDocNumberQueryForm);
 {* ����������� DocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
