unit PrimAdminMain_utEmptyMainWindow_UserType;
 {* ������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\PrimAdminMain_utEmptyMainWindow_UserType.pas"
// ���������: "UserType"
// ������� ������: "utEmptyMainWindow" MUID: (4BD84DBE0387)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utEmptyMainWindowLocalConstants }
 str_utEmptyMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : '������� ����');
  {* ��������� ����������������� ���� "������� ����" }
 str_utEmptyMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : '������� ������ ������������');
  {* ��������� ����������������� ���� "������� ����" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utEmptyMainWindow }
 utEmptyMainWindowName = 'utEmptyMainWindow';
  {* ��������� ������������� ����������������� ���� "������� ����" }
 utEmptyMainWindow = TvcmUserType(0);
  {* ������� ���� }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utEmptyMainWindow = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utEmptyMainWindow }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utEmptyMainWindow
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger

class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utEmptyMainWindowCaption.Init;
 {* ������������� str_utEmptyMainWindowCaption }
 str_utEmptyMainWindowSettingsCaption.Init;
 {* ������������� str_utEmptyMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utEmptyMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
