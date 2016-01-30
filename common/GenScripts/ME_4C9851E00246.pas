unit PrimShutDown_sftNone_UserType;
 {* �������������� � �������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas"
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
 {* ��������� ��� ���� ����� sftNone }
 sftNoneName = 'sftNone';
  {* ��������� ������������� ����������������� ���� "�������������� � �������� ����������" }
 sftNone = TvcmUserType(0);
  {* �������������� � �������� ���������� }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� sftNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_sftNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_sftNone.GetInteger: Integer;
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_sftNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
