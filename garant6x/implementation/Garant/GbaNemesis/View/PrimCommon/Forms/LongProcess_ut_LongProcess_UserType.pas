unit LongProcess_ut_LongProcess_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/LongProcess_ut_LongProcess_UserType.pas"
// �����: 21.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimCommon::LongProcess::ut_LongProcess
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { ��������� ��� ���� ����� ut_LongProcess }
   ut_LongProcessName = 'ut_LongProcess';
    { ��������� ������������� ����������������� ���� "����������" }
   ut_LongProcess = TvcmUserType(0);
    { ���������� }

implementation

{$If not defined(NoScripts)}
type
   Tkw_FormUserType_ut_LongProcess = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_LongProcess }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_LongProcess
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_ut_LongProcess

class function Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_LongProcess';
end;//Tkw_FormUserType_ut_LongProcess.GetWordNameForRegister

function Tkw_FormUserType_ut_LongProcess.GetInteger: Integer;
 {-}
begin
 Result := ut_LongProcess;
end;//Tkw_FormUserType_ut_LongProcess.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_LongProcess
 Tkw_FormUserType_ut_LongProcess.RegisterInEngine;
{$IfEnd} //not NoScripts

end.