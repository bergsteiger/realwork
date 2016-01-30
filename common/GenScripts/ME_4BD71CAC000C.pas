unit ContentsUserTypes_utContents_UserType;
 {* ��������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes_utContents_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utContents }
 utContentsName = 'utContents';
  {* ��������� ������������� ����������������� ���� "��������� ���������" }
 utContents = TvcmUserType(0);
  {* ��������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utContents = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utContents }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utContents
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utContents.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utContents';
end;//Tkw_FormUserType_utContents.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utContents.GetInteger: Integer;
begin
 Result := utContents;
end;//Tkw_FormUserType_utContents.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utContents.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
