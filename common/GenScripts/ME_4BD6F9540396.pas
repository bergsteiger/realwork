unit PrimTreeAttributeSelect_astOneLevel_UserType;
 {* �������� ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astOneLevel_UserType.pas"
// ���������: "UserType"
// ������� ������: "astOneLevel" MUID: (4BD6F9540396)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� astOneLevel }
 astOneLevelName = 'astOneLevel';
  {* ��������� ������������� ����������������� ���� "�������� ������� ������" }
 astOneLevel = TvcmUserType(astNone + 1);
  {* �������� ������� ������ }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astOneLevel = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astOneLevel }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astOneLevel
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astOneLevel.GetInteger: Integer;
begin
 Result := astOneLevel;
end;//Tkw_FormUserType_astOneLevel.GetInteger

class function Tkw_FormUserType_astOneLevel.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astOneLevel';
end;//Tkw_FormUserType_astOneLevel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astOneLevel.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astOneLevel }
{$IfEnd} // NOT Defined(NoScripts)

end.
