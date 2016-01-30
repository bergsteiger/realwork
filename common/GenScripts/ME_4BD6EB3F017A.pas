unit PrimFoldersTree_utSaveOpen_UserType;
 {* ��� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_utFoldersTree_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utSaveOpen }
 utSaveOpenName = 'utSaveOpen';
  {* ��������� ������������� ����������������� ���� "��� ���������" }
 utSaveOpen = TvcmUserType(utFoldersTree + 1);
  {* ��� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSaveOpen = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utSaveOpen }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utSaveOpen
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utSaveOpen.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utSaveOpen';
end;//Tkw_FormUserType_utSaveOpen.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utSaveOpen.GetInteger: Integer;
begin
 Result := utSaveOpen;
end;//Tkw_FormUserType_utSaveOpen.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSaveOpen.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utSaveOpen }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
