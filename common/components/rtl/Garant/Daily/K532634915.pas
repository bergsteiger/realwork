unit K532634915;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K532634915.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRC 7.7::K532634915
//
// {Requestlink:532634915}
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
  EVDtoNSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK532634915 = class(TEVDtoNSRCWriterTest)
  {* [Requestlink:532634915] }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK532634915
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK532634915

function TK532634915.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_5369D1DB0248_var*
//#UC END# *4B8545CC03D2_5369D1DB0248_var*
begin
//#UC START# *4B8545CC03D2_5369D1DB0248_impl*
 Result := False;
//#UC END# *4B8545CC03D2_5369D1DB0248_impl*
end;//TK532634915.IsNSRCPlus

function TK532634915.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRC 7.7';
end;//TK532634915.GetFolder

function TK532634915.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5369D1DB0248';
end;//TK532634915.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK532634915.Suite);

end.