unit DocumentUserTypes_dftConsultation_UserType;
 {* ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftConsultation_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftConsultation" MUID: (4B040F540027)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftConsultationLocalConstants }
 str_dftConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationCaption'; rValue : '������������');
  {* ��������� ����������������� ���� "������������" }
 str_dftConsultationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationSettingsCaption'; rValue : '��������: ������������');
  {* ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftConsultation }
 dftConsultationName = 'dftConsultation';
  {* ��������� ������������� ����������������� ���� "������������" }
 dftConsultation = TvcmUserType(dftAutoreferatAfterSearch + 1);
  {* ������������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftConsultation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftConsultation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftConsultation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftConsultation.GetInteger: Integer;
begin
 Result := dftConsultation;
end;//Tkw_FormUserType_dftConsultation.GetInteger

class function Tkw_FormUserType_dftConsultation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftConsultation';
end;//Tkw_FormUserType_dftConsultation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftConsultationCaption.Init;
 {* ������������� str_dftConsultationCaption }
 str_dftConsultationSettingsCaption.Init;
 {* ������������� str_dftConsultationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftConsultation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftConsultation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
