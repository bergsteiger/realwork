unit EVDtoNSRCPlusWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/EVDtoNSRCPlusWriterTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TEVDtoNSRCPlusWriterTest
//
// ���� ������ � NSRC+
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
 TEVDtoNSRCPlusWriterTest = {abstract} class(TEVDtoNSRCWriterTest)
  {* ���� ������ � NSRC+ }
 protected
 // realized methods
   function IsNSRCPlus: Boolean; override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDtoNSRCPlusWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoNSRCPlusWriterTest

function TEVDtoNSRCPlusWriterTest.IsNSRCPlus: Boolean;
//#UC START# *4B8545CC03D2_4B853E7501DF_var*
//#UC END# *4B8545CC03D2_4B853E7501DF_var*
begin
//#UC START# *4B8545CC03D2_4B853E7501DF_impl*
 Result := true;
//#UC END# *4B8545CC03D2_4B853E7501DF_impl*
end;//TEVDtoNSRCPlusWriterTest.IsNSRCPlus

function TEVDtoNSRCPlusWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TEVDtoNSRCPlusWriterTest.GetFolder

function TEVDtoNSRCPlusWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B853E7501DF';
end;//TEVDtoNSRCPlusWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.