unit DocumentUserTypes_dftMedicFirm_UserType;
 {* �������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirm_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftMedicFirm" MUID: (4B041062003C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrug_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftMedicFirmLocalConstants }
 str_dftMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmCaption'; rValue : '�������� �����');
  {* ��������� ����������������� ���� "�������� �����" }
 {* ��������� ��� ���� ����� dftMedicFirm }
 dftMedicFirmName = 'dftMedicFirm';
  {* ��������� ������������� ����������������� ���� "�������� �����" }
 dftMedicFirm = TvcmUserType(dftDrug + 1);
  {* �������� ����� }
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
 Tkw_FormUserType_dftMedicFirm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftMedicFirm }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftMedicFirm
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftMedicFirm.GetInteger: Integer;
begin
 Result := dftMedicFirm;
end;//Tkw_FormUserType_dftMedicFirm.GetInteger

class function Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftMedicFirm';
end;//Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftMedicFirmCaption.Init;
 {* ������������� str_dftMedicFirmCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
