unit WikiReaderTest;

// ������: "w:\common\components\rtl\Garant\Daily\WikiReaderTest.pas"
// ���������: "TestCase"
// ������� ������: "WikiReaderTest" MUID: (4D6BE6320214)
// ��� ����: "TWikiReaderTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
;

type
 TWikiReaderTest = {abstract} class(TWriterTest)
  protected
   procedure WikiToEVD(const aFileName: AnsiString);
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TWikiReaderTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evWikiReader
 , SysUtils
 , TestFrameWork
;

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
 {* ����� � ������� ������ ���� }
begin
 Result := 'Wiki';
end;//TWikiReaderTest.GetFolder

function TWikiReaderTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4D6BE6320214';
end;//TWikiReaderTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
