unit EVDtoHTMLWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLWriterTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , l3Filer
 , ddHTMLWriter
 , k2CustomFileReader
;

type
 TEVDtoHTMLWriterTest = {abstract} class(TWriterTest)
  protected
   procedure EVDtoHTML(const aFileName: AnsiString);
   procedure SomeFormatToHTML(aReader: Tk2CustomFileReader);
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoHTMLWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evdNativeReader
 , SysUtils
;

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
var l_Filter: Tl3CustomFiler;
var l_Writer: TddHTMLGenerator;
//#UC START# *516E775B03C9_516E72CA0386_var*
//#UC END# *516E775B03C9_516E72CA0386_var*
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
 {* Папка в которую входит тест }
begin
 Result := 'HTML';
end;//TEVDtoHTMLWriterTest.GetFolder

function TEVDtoHTMLWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '516E72CA0386';
end;//TEVDtoHTMLWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
