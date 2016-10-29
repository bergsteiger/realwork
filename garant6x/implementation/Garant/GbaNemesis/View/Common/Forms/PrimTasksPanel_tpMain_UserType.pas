unit PrimTasksPanel_tpMain_UserType;
 {* ������ ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas"
// ���������: "UserType"
// ������� ������: "tpMain" MUID: (4BD6D9AE030B)

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
 {* ������������ ������ tpMainLocalConstants }
 str_tpMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'tpMainCaption'; rValue : '������ �����');
  {* ��������� ����������������� ���� "������ �����" }
 {* ��������� ��� ���� ����� tpMain }
 tpMainName = 'tpMain';
  {* ��������� ������������� ����������������� ���� "������ �����" }
 tpMain = TvcmUserType(0);
  {* ������ ����� }
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
 Tkw_FormUserType_tpMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� tpMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_tpMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_tpMain.GetInteger: Integer;
begin
 Result := tpMain;
end;//Tkw_FormUserType_tpMain.GetInteger

class function Tkw_FormUserType_tpMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::tpMain';
end;//Tkw_FormUserType_tpMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_tpMainCaption.Init;
 {* ������������� str_tpMainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_tpMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
