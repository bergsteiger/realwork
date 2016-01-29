unit WikiReaderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/WikiReaderTest.pas"
// Начат: 28.02.2011 21:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::Wiki::WikiReaderTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
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