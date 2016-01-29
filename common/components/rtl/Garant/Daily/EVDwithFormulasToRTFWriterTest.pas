unit EVDwithFormulasToRTFWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/EVDwithFormulasToRTFWriterTest.pas"
// �����: 01.10.2010 21:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::EVDwithFormulasToRTFWriterTest
//
// ���� �������������� EVD � ��������� � RTF
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
 TEVDwithFormulasToRTFWriterTest = {abstract} class(TEVDtoRTFWriterTest)
  {* ���� �������������� EVD � ��������� � RTF }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsComputerName: Boolean; override;
    {$IfEnd} //nsTest AND not NotTunedDUnit
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TEVDwithFormulasToRTFWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDwithFormulasToRTFWriterTest

function TEVDwithFormulasToRTFWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TEVDwithFormulasToRTFWriterTest.GetFolder

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4CA616760108_var*
//#UC END# *4CA45DAA01BA_4CA616760108_var*
begin
//#UC START# *4CA45DAA01BA_4CA616760108_impl*
 Result := true;
//#UC END# *4CA45DAA01BA_4CA616760108_impl*
end;//TEVDwithFormulasToRTFWriterTest.EtalonNeedsComputerName
{$IfEnd} //nsTest AND not NotTunedDUnit

function TEVDwithFormulasToRTFWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA616760108';
end;//TEVDwithFormulasToRTFWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.