unit LongProcess_ut_LongProcess_UserType;
 {* ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_ut_LongProcess_UserType.pas"
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
 {* ��������� ��� ���� ����� ut_LongProcess }
 ut_LongProcessName = 'ut_LongProcess';
  {* ��������� ������������� ����������������� ���� "����������" }
 ut_LongProcess = TvcmUserType(0);
  {* ���������� }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_LongProcess = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_LongProcess }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_LongProcess
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_LongProcess';
end;//Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_LongProcess.GetInteger: Integer;
begin
 Result := ut_LongProcess;
end;//Tkw_FormUserType_ut_LongProcess.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_LongProcess.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_LongProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
