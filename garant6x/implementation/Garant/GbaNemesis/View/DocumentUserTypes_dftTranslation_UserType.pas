unit DocumentUserTypes_dftTranslation_UserType;
 {* ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTranslation_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftTranslation" MUID: (4B040F7C030A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftConsultation_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftTranslationLocalConstants }
 str_dftTranslationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationCaption'; rValue : '�������');
  {* ��������� ����������������� ���� "�������" }
 str_dftTranslationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationSettingsCaption'; rValue : '��������: �������');
  {* ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftTranslation }
 dftTranslationName = 'dftTranslation';
  {* ��������� ������������� ����������������� ���� "�������" }
 dftTranslation = TvcmUserType(dftConsultation + 1);
  {* ������� }
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
 Tkw_FormUserType_dftTranslation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftTranslation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftTranslation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftTranslation.GetInteger: Integer;
begin
 Result := dftTranslation;
end;//Tkw_FormUserType_dftTranslation.GetInteger

class function Tkw_FormUserType_dftTranslation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftTranslation';
end;//Tkw_FormUserType_dftTranslation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftTranslationCaption.Init;
 {* ������������� str_dftTranslationCaption }
 str_dftTranslationSettingsCaption.Init;
 {* ������������� str_dftTranslationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTranslation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftTranslation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
