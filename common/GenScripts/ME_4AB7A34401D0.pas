unit BaseSearchCard_Form;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "BaseSearchCard" MUID: (4AB7A34401D0)
// ��� ����: "Ten_BaseSearchCard"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimBaseSearchCard_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_en_BaseSearchCard: TvcmFormDescriptor = (rFormID : (rName : 'en_BaseSearchCard'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_BaseSearchCard }

type
 Ten_BaseSearchCard = class;

 BaseSearchCardFormDef = interface
  {* ������������� ����� BaseSearchCard }
  ['{8B9F39A3-2E36-4686-82DA-8C441DE365A3}']
 end;//BaseSearchCardFormDef

 Ten_BaseSearchCard = {final} class(TPrimBaseSearchCardForm, BaseSearchCardFormDef)
  {* ������� ����� }
 end;//Ten_BaseSearchCard
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
 , BaseSearchCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , BaseSearchCard_ut_BaseSearchCard_UserType
;

const
 {* ������������ ������ ut_BaseSearchCardLocalConstants }
 str_ut_BaseSearchCardCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_BaseSearchCardCaption'; rValue : '������� �����');
  {* ��������� ����������������� ���� "������� �����" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_BaseSearchCard);
 {* ����������� BaseSearchCard }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_BaseSearchCard.SetFactory(Ten_BaseSearchCard.Make);
 {* ����������� ������� ����� BaseSearchCard }
 str_ut_BaseSearchCardCaption.Init;
 {* ������������� str_ut_BaseSearchCardCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
