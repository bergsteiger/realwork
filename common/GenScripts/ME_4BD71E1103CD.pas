unit PrimNewsLine_nltMain_UserType;
 {* �����. ��� ��������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLine_nltMain_UserType.pas"
// ���������: "UserType"
// ������� ������: "nltMain" MUID: (4BD71E1103CD)

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
 {* ��������� ��� ���� ����� nltMain }
 nltMainName = 'nltMain';
  {* ��������� ������������� ����������������� ���� "�����. ��� ��������� �����" }
 nltMain = TvcmUserType(0);
  {* �����. ��� ��������� ����� }
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
 Tkw_FormUserType_nltMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� nltMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_nltMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_nltMain.GetInteger: Integer;
begin
 Result := nltMain;
end;//Tkw_FormUserType_nltMain.GetInteger

class function Tkw_FormUserType_nltMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::nltMain';
end;//Tkw_FormUserType_nltMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_nltMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_nltMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
