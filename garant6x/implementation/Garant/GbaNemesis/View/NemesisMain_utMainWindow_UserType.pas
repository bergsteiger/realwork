unit NemesisMain_utMainWindow_UserType;
 {* ������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NemesisMain_utMainWindow_UserType.pas"
// ���������: "UserType"
// ������� ������: "utMainWindow" MUID: (4BD84644014A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utMainWindowLocalConstants }
 str_utMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowCaption'; rValue : '������� ����');
  {* ��������� ����������������� ���� "������� ����" }
 str_utMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowSettingsCaption'; rValue : '������� ������ ������������');
  {* ��������� ����������������� ���� "������� ����" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utMainWindow }
 utMainWindowName = 'utMainWindow';
  {* ��������� ������������� ����������������� ���� "������� ����" }
 utMainWindow = TvcmUserType(0);
  {* ������� ���� }
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
 Tkw_FormUserType_utMainWindow = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMainWindow }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMainWindow
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMainWindow.GetInteger: Integer;
begin
 Result := utMainWindow;
end;//Tkw_FormUserType_utMainWindow.GetInteger

class function Tkw_FormUserType_utMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMainWindow';
end;//Tkw_FormUserType_utMainWindow.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utMainWindowCaption.Init;
 {* ������������� str_utMainWindowCaption }
 str_utMainWindowSettingsCaption.Init;
 {* ������������� str_utMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainWindow.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
