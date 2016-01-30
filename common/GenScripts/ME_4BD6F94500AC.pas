unit PrimTreeAttributeSelect_astNone_UserType;
 {* �����: ����� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas"
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
 {* ��������� ��� ���� ����� astNone }
 astNoneName = 'astNone';
  {* ��������� ������������� ����������������� ���� "�����: ����� ���������" }
 astNone = TvcmUserType(0);
  {* �����: ����� ��������� }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astNone.GetInteger: Integer;
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
