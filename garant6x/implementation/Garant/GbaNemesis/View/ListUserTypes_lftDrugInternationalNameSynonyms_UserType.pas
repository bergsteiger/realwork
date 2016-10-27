unit ListUserTypes_lftDrugInternationalNameSynonyms_UserType;
 {* �������� �� �������������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonyms_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftDrugInternationalNameSynonyms" MUID: (4BD58B5D0377)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugList_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ lftDrugInternationalNameSynonymsLocalConstants }
 str_lftDrugInternationalNameSynonymsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftDrugInternationalNameSynonymsCaption'; rValue : '�������� �� �������������� ��������');
  {* ��������� ����������������� ���� "�������� �� �������������� ��������" }
 {* ��������� ��� ���� ����� lftDrugInternationalNameSynonyms }
 lftDrugInternationalNameSynonymsName = 'lftDrugInternationalNameSynonyms';
  {* ��������� ������������� ����������������� ���� "�������� �� �������������� ��������" }
 lftDrugInternationalNameSynonyms = TvcmUserType(lftDrugList + 1);
  {* �������� �� �������������� �������� }
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
 Tkw_FormUserType_lftDrugInternationalNameSynonyms = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftDrugInternationalNameSynonyms }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger: Integer;
begin
 Result := lftDrugInternationalNameSynonyms;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetInteger

class function Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftDrugInternationalNameSynonyms';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonyms.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftDrugInternationalNameSynonymsCaption.Init;
 {* ������������� str_lftDrugInternationalNameSynonymsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonyms.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftDrugInternationalNameSynonyms }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
