unit DocumentWithFlashUserTypes_dwftMain_UserType;
 {* ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftMain_UserType.pas"
// ���������: "UserType"
// ������� ������: "dwftMain" MUID: (4BD6EE980118)

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
 {* ������������ ������ dwftMainLocalConstants }
 str_dwftMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftMainCaption'; rValue : '�����');
  {* ��������� ����������������� ���� "�����" }
 {* ��������� ��� ���� ����� dwftMain }
 dwftMainName = 'dwftMain';
  {* ��������� ������������� ����������������� ���� "�����" }
 dwftMain = TvcmUserType(0);
  {* ����� }
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
 Tkw_FormUserType_dwftMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dwftMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dwftMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dwftMain.GetInteger: Integer;
begin
 Result := dwftMain;
end;//Tkw_FormUserType_dwftMain.GetInteger

class function Tkw_FormUserType_dwftMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dwftMain';
end;//Tkw_FormUserType_dwftMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dwftMainCaption.Init;
 {* ������������� str_dwftMainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dwftMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
