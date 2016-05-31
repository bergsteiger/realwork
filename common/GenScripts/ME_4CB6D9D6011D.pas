unit PrimCreateFilter_cfRename_UserType;
 {* ������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfRename_UserType.pas"
// ���������: "UserType"
// ������� ������: "cfRename" MUID: (4CB6D9D6011D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCreateFilter_cfCreate_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ cfRenameLocalConstants }
 str_cfRenameCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cfRenameCaption'; rValue : '������������� ������');
  {* ��������� ����������������� ���� "������������� ������" }
 {* ��������� ��� ���� ����� cfRename }
 cfRenameName = 'cfRename';
  {* ��������� ������������� ����������������� ���� "������������� ������" }
 cfRename = TvcmUserType(cfCreate + 1);
  {* ������������� ������ }
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
 Tkw_FormUserType_cfRename = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cfRename }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cfRename
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cfRename.GetInteger: Integer;
begin
 Result := cfRename;
end;//Tkw_FormUserType_cfRename.GetInteger

class function Tkw_FormUserType_cfRename.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cfRename';
end;//Tkw_FormUserType_cfRename.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cfRenameCaption.Init;
 {* ������������� str_cfRenameCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfRename.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cfRename }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
