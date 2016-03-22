unit LongProcess_ut_LongProcess_UserType;
 {* ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\LongProcess_ut_LongProcess_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_LongProcess" MUID: (F1A5C94EB755)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_LongProcess = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_LongProcess }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_LongProcess
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_LongProcess.GetInteger: Integer;
begin
 Result := ut_LongProcess;
end;//Tkw_FormUserType_ut_LongProcess.GetInteger

class function Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_LongProcess';
end;//Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_LongProcess.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_LongProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
