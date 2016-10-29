unit PrimInternetAgent_utInternetAgent_UserType;
 {* ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\Forms\PrimInternetAgent_utInternetAgent_UserType.pas"
// ���������: "UserType"
// ������� ������: "utInternetAgent" MUID: (4C6274C701D2)

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
 {* ������������ ������ utInternetAgentLocalConstants }
 str_utInternetAgentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utInternetAgentCaption'; rValue : '������� ������');
  {* ��������� ����������������� ���� "������� ������" }
 {* ��������� ��� ���� ����� utInternetAgent }
 utInternetAgentName = 'utInternetAgent';
  {* ��������� ������������� ����������������� ���� "������� ������" }
 utInternetAgent = TvcmUserType(0);
  {* ������� ������ }
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
 Tkw_FormUserType_utInternetAgent = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utInternetAgent }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utInternetAgent
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utInternetAgent.GetInteger: Integer;
begin
 Result := utInternetAgent;
end;//Tkw_FormUserType_utInternetAgent.GetInteger

class function Tkw_FormUserType_utInternetAgent.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utInternetAgent';
end;//Tkw_FormUserType_utInternetAgent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utInternetAgentCaption.Init;
 {* ������������� str_utInternetAgentCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utInternetAgent.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utInternetAgent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
