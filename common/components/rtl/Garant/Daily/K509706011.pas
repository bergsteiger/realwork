unit K509706011;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K509706011.pas"
// �����: 25.12.2013 14:59
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.10::K509706011
//
// {RequestLink:509706011}
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
  EVDtoRTFRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK509706011 = class(TEVDtoRTFRender)
  {* [RequestLink:509706011] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK509706011
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK509706011

function TK509706011.GetFolder: AnsiString;
 {-}
begin
 Result := '7.10';
end;//TK509706011.GetFolder

function TK509706011.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '52BABA7D0004';
end;//TK509706011.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK509706011.Suite);

end.