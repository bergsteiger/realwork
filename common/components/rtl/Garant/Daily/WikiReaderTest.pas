unit WikiReaderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/WikiReaderTest.pas"
// �����: 28.02.2011 21:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Wiki::WikiReaderTest
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
  WriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TWikiReaderTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 protected
 // protected methods
   procedure WikiToEVD(const aFileName: AnsiString);
 end;//TWikiReaderTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evWikiReader,
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TWikiReaderTest

procedure TWikiReaderTest.WikiToEVD(const aFileName: AnsiString);
//#UC START# *4D6BE67102D4_4D6BE6320214_var*
var
 l_Reader : TevWikiReader;
//#UC END# *4D6BE67102D4_4D6BE6320214_var*
begin
//#UC START# *4D6BE67102D4_4D6BE6320214_impl*
 l_Reader := TevWikiReader.Make(FileFromCurrent(aFileName));
 try
  //l_Reader.EnablePictures := Self.GetEnablePictures; 
  SomeFormatToEVD(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4D6BE67102D4_4D6BE6320214_impl*
end;//TWikiReaderTest.WikiToEVD

function TWikiReaderTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Wiki';
end;//TWikiReaderTest.GetFolder

function TWikiReaderTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6BE6320214';
end;//TWikiReaderTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.