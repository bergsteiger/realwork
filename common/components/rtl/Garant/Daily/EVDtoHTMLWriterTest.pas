unit EVDtoHTMLWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\EVDtoHTMLWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "EVDtoHTMLWriterTest" MUID: (516E72CA0386)
// Имя типа: "TEVDtoHTMLWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , ddHTMLWriter
 , l3Filer
 , k2CustomFileReader
;

type
 TEVDtoHTMLWriterTest = {abstract} class(TWriterTest)
  protected
   procedure EVDtoHTML(const aFileName: AnsiString);
   procedure SomeFormatToHTML(aReader: Tk2CustomFileReader);
   procedure TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator); virtual;
   function GetHTMLWriter: TddHTMLGenerator; virtual;
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
 , evdNativeReader
 , SysUtils
 , TestFrameWork
 //#UC START# *516E72CA0386impl_uses*
 //#UC END# *516E72CA0386impl_uses*
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
 l_Writer := GetHTMLWriter;
 try
  TuningHTMLGenerator(l_Writer);
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

procedure TEVDtoHTMLWriterTest.TuningHTMLGenerator(aHTMLReader: TddHTMLGenerator);
//#UC START# *56D9300D018D_516E72CA0386_var*
//#UC END# *56D9300D018D_516E72CA0386_var*
begin
//#UC START# *56D9300D018D_516E72CA0386_impl*
 
//#UC END# *56D9300D018D_516E72CA0386_impl*
end;//TEVDtoHTMLWriterTest.TuningHTMLGenerator

function TEVDtoHTMLWriterTest.GetHTMLWriter: TddHTMLGenerator;
//#UC START# *57613C5F000C_516E72CA0386_var*
//#UC END# *57613C5F000C_516E72CA0386_var*
begin
//#UC START# *57613C5F000C_516E72CA0386_impl*
 Result := TddHTMLGenerator.Create;
//#UC END# *57613C5F000C_516E72CA0386_impl*
end;//TEVDtoHTMLWriterTest.GetHTMLWriter

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
