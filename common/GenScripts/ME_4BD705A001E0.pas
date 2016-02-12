unit PrimRightEdition_utRightEdition_UserType;
 {* ������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas"
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
 {* ��������� ��� ���� ����� utRightEdition }
 utRightEditionName = 'utRightEdition';
  {* ��������� ������������� ����������������� ���� "������� ��������" }
 utRightEdition = TvcmUserType(0);
  {* ������� �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utRightEdition }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utRightEdition
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utRightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utRightEdition';
end;//Tkw_FormUserType_utRightEdition.GetWordNameForRegister

function Tkw_FormUserType_utRightEdition.GetInteger: Integer;
begin
 Result := utRightEdition;
end;//Tkw_FormUserType_utRightEdition.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utRightEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
