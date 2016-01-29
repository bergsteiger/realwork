unit K226001945;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K226001945.pas"
// �����: 25.08.2010 17:11
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K226001945
//
// {RequestLink:226001945}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoRTFWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK226001945 = class(TEVDtoRTFWriterTest)
  {* [RequestLink:226001945] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonCanHaveDiff: Boolean; override;
     {* ������ ����� ����� ��������� ������� ��� ����������� ����������. �������� ��� � [RequestLink:234362304] }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK226001945
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK226001945

function TK226001945.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK226001945.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TK226001945.EtalonCanHaveDiff: Boolean;
//#UC START# *4CAEE13D00E1_4C75166400F1_var*
//#UC END# *4CAEE13D00E1_4C75166400F1_var*
begin
//#UC START# *4CAEE13D00E1_4C75166400F1_impl*
 Result := true;
//#UC END# *4CAEE13D00E1_4C75166400F1_impl*
end;//TK226001945.EtalonCanHaveDiff
{$IfEnd} //nsTest AND not NotTunedDUnit

function TK226001945.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C75166400F1';
end;//TK226001945.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK226001945.Suite);

end.