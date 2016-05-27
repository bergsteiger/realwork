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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
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
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_BaseSearchCard
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
 , BaseSearchCard_ut_BaseSearchCard_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , BaseSearchCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_BaseSearchCardLocalConstants }
 str_ut_BaseSearchCardCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_BaseSearchCardCaption'; rValue : '������� �����');
  {* ��������� ����������������� ���� "������� �����" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure Ten_BaseSearchCard.MakeControls;
begin
 inherited;
 with AddUsertype(ut_BaseSearchCardName,
  str_ut_BaseSearchCardCaption,
  str_ut_BaseSearchCardCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_BaseSearchCardName
end;//Ten_BaseSearchCard.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_BaseSearchCardCaption.Init;
 {* ������������� str_ut_BaseSearchCardCaption }
 fm_en_BaseSearchCard.SetFactory(Ten_BaseSearchCard.Make);
 {* ����������� ������� ����� BaseSearchCard }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_BaseSearchCard);
 {* ����������� BaseSearchCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
