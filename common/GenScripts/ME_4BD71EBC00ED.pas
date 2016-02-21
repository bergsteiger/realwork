unit PrimDiction_utDiction_UserType;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_utDiction_UserType.pas"
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
 {* ��������� ��� ���� ����� utDiction }
 utDictionName = 'utDiction';
  {* ��������� ������������� ����������������� ���� "�������� �������" }
 utDiction = TvcmUserType(0);
  {* �������� ������� }
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
 Tkw_FormUserType_utDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utDiction';
end;//Tkw_FormUserType_utDiction.GetWordNameForRegister

function Tkw_FormUserType_utDiction.GetInteger: Integer;
begin
 Result := utDiction;
end;//Tkw_FormUserType_utDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
