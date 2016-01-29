unit EVDtoHTMLWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoHTMLWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::HTML::EVDtoHTMLWriterTest
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
  l3Filer,
  k2CustomFileReader,
  ddHTMLWriter,
  WriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoHTMLWriterTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure EVDtoHTML(const aFileName: AnsiString);
   procedure SomeFormatToHTML(aReader: Tk2CustomFileReader);
 end;//TEVDtoHTMLWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdNativeReader,
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoHTMLWriterTest

procedure TEVDtoHTMLWriterTest.EVDtoHTML(const aFileName: AnsiString);
//#UC START# *516E73FC02CE_516E72CA0386_var*
var
 l_Reader : TevdNativeReader;
//#UC END# *516E73FC02CE_516E72CA0386_var*
begin
//#UC START# *516E73FC02CE_516E72CA0386_impl*
 l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  SomeFormatToHTML(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *516E73FC02CE_516E72CA0386_impl*
end;//TEVDtoHTMLWriterTest.EVDtoHTML

procedure TEVDtoHTMLWriterTest.SomeFormatToHTML(aReader: Tk2CustomFileReader);
//#UC START# *516E775B03C9_516E72CA0386_var*
//#UC END# *516E775B03C9_516E72CA0386_var*
var
 l_Filter : Tl3CustomFiler;
 l_Writer : TddHTMLGenerator;
begin
//#UC START# *516E775B03C9_516E72CA0386_impl*
 l_Writer := TddHTMLGenerator.Create;
 try
  l_Filter := FilerForOutput;
  try
   l_Writer.Filer := l_Filter;
  finally
   FreeAndNil(l_Filter);
  end;//try..finally
  aReader.Generator := l_Writer;
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
 DoWrite(aReader, EtalonSuffix + '.htm')
//#UC END# *516E775B03C9_516E72CA0386_impl*
end;//TEVDtoHTMLWriterTest.SomeFormatToHTML

function TEVDtoHTMLWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'HTML';
end;//TEVDtoHTMLWriterTest.GetFolder

function TEVDtoHTMLWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '516E72CA0386';
end;//TEVDtoHTMLWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.