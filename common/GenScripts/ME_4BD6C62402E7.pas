unit PrimFolders_utFolders_UserType;
 {* ��� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFolders_utFolders_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utFolders }
 utFoldersName = 'utFolders';
  {* ��������� ������������� ����������������� ���� "��� ���������" }
 utFolders = TvcmUserType(0);
  {* ��� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFolders = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFolders }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFolders
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFolders.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFolders';
end;//Tkw_FormUserType_utFolders.GetWordNameForRegister

function Tkw_FormUserType_utFolders.GetInteger: Integer;
begin
 Result := utFolders;
end;//Tkw_FormUserType_utFolders.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFolders.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFolders }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
