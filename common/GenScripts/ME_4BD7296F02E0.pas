unit PrimUnderControl_utUnderControl_UserType;
 {* ��������� �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utUnderControl }
 utUnderControlName = 'utUnderControl';
  {* ��������� ������������� ����������������� ���� "��������� �� ��������" }
 utUnderControl = TvcmUserType(0);
  {* ��������� �� �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utUnderControl = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utUnderControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utUnderControl
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utUnderControl.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utUnderControl';
end;//Tkw_FormUserType_utUnderControl.GetWordNameForRegister

function Tkw_FormUserType_utUnderControl.GetInteger: Integer;
begin
 Result := utUnderControl;
end;//Tkw_FormUserType_utUnderControl.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utUnderControl.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utUnderControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
