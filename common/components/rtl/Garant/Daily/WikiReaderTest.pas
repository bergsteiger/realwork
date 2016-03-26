unit WikiReaderTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\WikiReaderTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "WikiReaderTest" MUID: (4D6BE6320214)
// Имя типа: "TWikiReaderTest"

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
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
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
 {* Папка в которую входит тест }
begin
 Result := 'Wiki';
end;//TWikiReaderTest.GetFolder

function TWikiReaderTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6BE6320214';
end;//TWikiReaderTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
