unit PrimTreeAttributeSelect_astFirstLevel_UserType;
 {* �������� ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astFirstLevel_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astOneLevel_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� astFirstLevel }
 astFirstLevelName = 'astFirstLevel';
  {* ��������� ������������� ����������������� ���� "�������� ������� ������" }
 astFirstLevel = TvcmUserType(astOneLevel + 1);
  {* �������� ������� ������ }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astFirstLevel = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astFirstLevel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astFirstLevel
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astFirstLevel.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astFirstLevel';
end;//Tkw_FormUserType_astFirstLevel.GetWordNameForRegister

function Tkw_FormUserType_astFirstLevel.GetInteger: Integer;
begin
 Result := astFirstLevel;
end;//Tkw_FormUserType_astFirstLevel.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astFirstLevel.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astFirstLevel }
{$IfEnd} // NOT Defined(NoScripts)

end.
