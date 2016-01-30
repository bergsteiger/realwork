unit ContentsUserTypes_utDrugContents_UserType;
 {* ��������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utDrugContents_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ContentsUserTypes_utContents_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utDrugContents }
 utDrugContentsName = 'utDrugContents';
  {* ��������� ������������� ����������������� ���� "��������� ���������" }
 utDrugContents = TvcmUserType(utContents + 1);
  {* ��������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDrugContents = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utDrugContents }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utDrugContents
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utDrugContents.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utDrugContents';
end;//Tkw_FormUserType_utDrugContents.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utDrugContents.GetInteger: Integer;
begin
 Result := utDrugContents;
end;//Tkw_FormUserType_utDrugContents.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDrugContents.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utDrugContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
