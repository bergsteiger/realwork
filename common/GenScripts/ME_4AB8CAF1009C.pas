unit DefineSearchDate_Form;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "DefineSearchDate" MUID: (4AB8CAF1009C)
// ��� ����: "Ten_DefineSearchDate"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDefineSearchDate_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_en_DefineSearchDate: TvcmFormDescriptor = (rFormID : (rName : 'en_DefineSearchDate'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_DefineSearchDate }

type
 Ten_DefineSearchDate = class;

 DefineSearchDateFormDef = interface
  {* ������������� ����� DefineSearchDate }
  ['{95B053C2-B5BB-4EE7-9D05-E6333C48DF52}']
 end;//DefineSearchDateFormDef

 Ten_DefineSearchDate = {final} class(TPrimDefineSearchDateForm, DefineSearchDateFormDef)
  {* ���� }
 end;//Ten_DefineSearchDate
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
 , DefineSearchDateKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_DefineSearchDateLocalConstants }
 str_ut_DefineSearchDateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DefineSearchDateCaption'; rValue : '����');
  {* ��������� ����������������� ���� "����" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_DefineSearchDate);
 {* ����������� DefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_DefineSearchDateCaption.Init;
 {* ������������� str_ut_DefineSearchDateCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
