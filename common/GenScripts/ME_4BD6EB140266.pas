unit PrimFoldersTree_utFoldersTree_UserType;
 {* ��� ��������� (�������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utFoldersTree_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_utSaveOpen_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utFoldersTree }
 utFoldersTreeName = 'utFoldersTree';
  {* ��������� ������������� ����������������� ���� "��� ��������� (�������)" }
 utFoldersTree = TvcmUserType(0);
  {* ��� ��������� (�������) }
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
 Tkw_FormUserType_utFoldersTree = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFoldersTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utFoldersTree
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFoldersTree';
end;//Tkw_FormUserType_utFoldersTree.GetWordNameForRegister

function Tkw_FormUserType_utFoldersTree.GetInteger: Integer;
begin
 Result := utFoldersTree;
end;//Tkw_FormUserType_utFoldersTree.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersTree.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFoldersTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
