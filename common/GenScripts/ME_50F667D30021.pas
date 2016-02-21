unit PrimProgressIndicator_utProgressIndicator_UserType;
 {* ��� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimProgressIndicator_utProgressIndicator_UserType.pas"
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
 {* ��������� ��� ���� ����� utProgressIndicator }
 utProgressIndicatorName = 'utProgressIndicator';
  {* ��������� ������������� ����������������� ���� "��� ����������" }
 utProgressIndicator = TvcmUserType(0);
  {* ��� ���������� }
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
 Tkw_FormUserType_utProgressIndicator = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utProgressIndicator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utProgressIndicator
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utProgressIndicator';
end;//Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister

function Tkw_FormUserType_utProgressIndicator.GetInteger: Integer;
begin
 Result := utProgressIndicator;
end;//Tkw_FormUserType_utProgressIndicator.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utProgressIndicator.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
