unit AttributesUserTypes_fAttributeSynchroView_UserType;
 {* ���������� � ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes_fAttributeSynchroView_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AttributesUserTypes_fDocAttribute_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� fAttributeSynchroView }
 fAttributeSynchroViewName = 'fAttributeSynchroView';
  {* ��������� ������������� ����������������� ���� "���������� � ��������� (���������� ��������)" }
 fAttributeSynchroView = TvcmUserType(fDocAttribute + 1);
  {* ���������� � ��������� (���������� ��������) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fAttributeSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� fAttributeSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_fAttributeSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::fAttributeSynchroView';
end;//Tkw_FormUserType_fAttributeSynchroView.GetWordNameForRegister

function Tkw_FormUserType_fAttributeSynchroView.GetInteger: Integer;
begin
 Result := fAttributeSynchroView;
end;//Tkw_FormUserType_fAttributeSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_fAttributeSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_fAttributeSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
