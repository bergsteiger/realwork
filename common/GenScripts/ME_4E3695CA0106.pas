unit ListAnalizeUserTypes_Analize_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes_Analize_UserType.pas"
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
 {* ��������� ��� ���� ����� Analize }
 AnalizeName = 'Analize';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 Analize = TvcmUserType(0);
  {* ������ ������ }
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
 Tkw_FormUserType_Analize = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Analize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_Analize
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_Analize.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Analize';
end;//Tkw_FormUserType_Analize.GetWordNameForRegister

function Tkw_FormUserType_Analize.GetInteger: Integer;
begin
 Result := Analize;
end;//Tkw_FormUserType_Analize.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Analize.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Analize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
