unit PrimFoldersInfo_utFoldersInfoContainer_UserType;
 {* �������� ����� (��������� ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersInfo_utFoldersInfoContainer_UserType.pas"
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
 {* ��������� ��� ���� ����� utFoldersInfoContainer }
 utFoldersInfoContainerName = 'utFoldersInfoContainer';
  {* ��������� ������������� ����������������� ���� "�������� ����� (��������� ������)" }
 utFoldersInfoContainer = TvcmUserType(0);
  {* �������� ����� (��������� ������) }
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
 Tkw_FormUserType_utFoldersInfoContainer = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFoldersInfoContainer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFoldersInfoContainer
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFoldersInfoContainer';
end;//Tkw_FormUserType_utFoldersInfoContainer.GetWordNameForRegister

function Tkw_FormUserType_utFoldersInfoContainer.GetInteger: Integer;
begin
 Result := utFoldersInfoContainer;
end;//Tkw_FormUserType_utFoldersInfoContainer.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersInfoContainer.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFoldersInfoContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
