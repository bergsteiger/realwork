unit K431378358;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K431378358.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.8::K431378358
//
// {Requestlink:431378358}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest)}
uses
  EVDtoBothNSRCWriterTest
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TK431378358 = class(TEVDtoBothNSRCWriterTest)
  {* [Requestlink:431378358] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK431378358
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TK431378358

function TK431378358.GetFolder: AnsiString;
 {-}
begin
 Result := '7.8';
end;//TK431378358.GetFolder

function TK431378358.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5125BE8D0328';
end;//TK431378358.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TK431378358.Suite);

end.