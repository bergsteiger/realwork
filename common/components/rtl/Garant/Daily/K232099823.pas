unit K232099823;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K232099823.pas"
// �����: 16.08.2010 12:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K232099823
//
// {RequestLink:232099823}
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
  EVDtoNSRCPlusWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK232099823 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:232099823] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK232099823
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK232099823

function TK232099823.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK232099823.GetFolder

function TK232099823.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C68FC100016';
end;//TK232099823.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK232099823.Suite);

end.