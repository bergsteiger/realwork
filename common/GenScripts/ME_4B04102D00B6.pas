unit DocumentUserTypes_dftAutoreferat_UserType;
 {* �����. ��� ��������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferat_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedDictEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftAutoreferat }
 dftAutoreferatName = 'dftAutoreferat';
  {* ��������� ������������� ����������������� ���� "�����. ��� ��������� �����" }
 dftAutoreferat = TvcmUserType(dftMedDictEntry + 1);
  {* �����. ��� ��������� ����� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferat = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAutoreferat }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAutoreferat
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAutoreferat';
end;//Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferat.GetInteger: Integer;
begin
 Result := dftAutoreferat;
end;//Tkw_FormUserType_dftAutoreferat.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferat.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAutoreferat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
