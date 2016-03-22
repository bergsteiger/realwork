unit PrimListAnalizer_listAnalize_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListAnalizer_listAnalize_UserType.pas"
// ���������: "UserType"
// ������� ������: "listAnalize" MUID: (4BD71C5800C2)

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
 {* ��������� ��� ���� ����� listAnalize }
 listAnalizeName = 'listAnalize';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 listAnalize = TvcmUserType(0);
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_listAnalize = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� listAnalize }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_listAnalize
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_listAnalize.GetInteger: Integer;
begin
 Result := listAnalize;
end;//Tkw_FormUserType_listAnalize.GetInteger

class function Tkw_FormUserType_listAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::listAnalize';
end;//Tkw_FormUserType_listAnalize.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_listAnalize.RegisterInEngine;
 {* ����������� Tkw_FormUserType_listAnalize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
