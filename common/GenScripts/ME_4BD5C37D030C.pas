unit PrimQueryCard_utqcSendConsultation_UserType;
 {* �������� ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcSendConsultation_UserType.pas"
// ���������: "UserType"
// ������� ������: "utqcSendConsultation" MUID: (4BD5C37D030C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcLegislationReview_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utqcSendConsultation }
 utqcSendConsultationName = 'utqcSendConsultation';
  {* ��������� ������������� ����������������� ���� "�������� ��������� ������" }
 utqcSendConsultation = TvcmUserType(utqcLegislationReview + 1);
  {* �������� ��������� ������ }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utqcSendConsultation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utqcSendConsultation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcSendConsultation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcSendConsultation.GetInteger: Integer;
begin
 Result := utqcSendConsultation;
end;//Tkw_FormUserType_utqcSendConsultation.GetInteger

class function Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utqcSendConsultation';
end;//Tkw_FormUserType_utqcSendConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcSendConsultation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utqcSendConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
