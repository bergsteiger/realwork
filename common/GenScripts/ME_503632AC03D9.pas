unit XMLWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\XMLWriterTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , evdXMLWriter
 , l3Filer
 , k2CustomFileReader
 , evdNativeReader
;

type
 TXMLWriterTest = {abstract} class(TWriterTest)
  protected
   procedure SomeFormatToXML(aReader: Tk2CustomFileReader;
    NeedCheck: Boolean = True);
   procedure EVDtoXML(const aFileName: AnsiString;
    NeedCheck: Boolean = True);
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TXMLWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
;

procedure TXMLWriterTest.SomeFormatToXML(aReader: Tk2CustomFileReader;
 NeedCheck: Boolean = True);
var l_Writer: TevdXMLWriter;
var l_Filer: Tl3CustomFiler;
//#UC START# *503633240255_503632AC03D9_var*
//#UC END# *503633240255_503632AC03D9_var*
begin
//#UC START# *503633240255_503632AC03D9_impl*
 l_Writer := TevdXMLWriter.Create;
 try
  //l_Writer.UseExternalLinks := Self.UseExternalLinks;
  l_Filer := FilerForOutput;
  try
   l_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
  aReader.Generator := l_Writer;
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
 DoWrite(aReader, EtalonSuffix + '.xml');
//#UC END# *503633240255_503632AC03D9_impl*
end;//TXMLWriterTest.SomeFormatToXML

procedure TXMLWriterTest.EVDtoXML(const aFileName: AnsiString;
 NeedCheck: Boolean = True);
var l_Reader: TevdNativeReader;
//#UC START# *5036334B00AD_503632AC03D9_var*
//#UC END# *5036334B00AD_503632AC03D9_var*
begin
//#UC START# *5036334B00AD_503632AC03D9_impl*
 l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  SomeFormatToXML(l_Reader, NeedCheck);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *5036334B00AD_503632AC03D9_impl*
end;//TXMLWriterTest.EVDtoXML

function TXMLWriterTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'XML';
end;//TXMLWriterTest.GetFolder

function TXMLWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '503632AC03D9';
end;//TXMLWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
