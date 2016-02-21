unit PrimFoldersElementInfo_utFoldersProperty_UserType;
 {* ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfo_utFoldersProperty_UserType.pas"
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
 {* ��������� ��� ���� ����� utFoldersProperty }
 utFoldersPropertyName = 'utFoldersProperty';
  {* ��������� ������������� ����������������� ���� "������ �������" }
 utFoldersProperty = TvcmUserType(0);
  {* ������ ������� }
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
 Tkw_FormUserType_utFoldersProperty = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFoldersProperty }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFoldersProperty
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFoldersProperty';
end;//Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister

function Tkw_FormUserType_utFoldersProperty.GetInteger: Integer;
begin
 Result := utFoldersProperty;
end;//Tkw_FormUserType_utFoldersProperty.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersProperty.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFoldersProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
