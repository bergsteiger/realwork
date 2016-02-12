unit PrimAttributeSelect_utAttributeSelect_UserType;
 {* ����� �������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

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
 {* ��������� ��� ���� ����� utAttributeSelect }
 utAttributeSelectName = 'utAttributeSelect';
  {* ��������� ������������� ����������������� ���� "����� �������� ��������" }
 utAttributeSelect = TvcmUserType(0);
  {* ����� �������� �������� }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utAttributeSelect }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utAttributeSelect
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister

function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.
