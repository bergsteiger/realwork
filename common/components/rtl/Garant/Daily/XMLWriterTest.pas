unit XMLWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/XMLWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::XML::XMLWriterTest
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
  evdNativeReader,
  WriterTest,
  evdXMLWriter
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TXMLWriterTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure SomeFormatToXML(aReader: Tk2CustomFileReader;
     NeedCheck: Boolean = true);
   procedure EVDtoXML(const aFileName: AnsiString;
     NeedCheck: Boolean = true);
 end;//TXMLWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TXMLWriterTest

procedure TXMLWriterTest.SomeFormatToXML(aReader: Tk2CustomFileReader;
  NeedCheck: Boolean = true);
//#UC START# *503633240255_503632AC03D9_var*
//#UC END# *503633240255_503632AC03D9_var*
var
 l_Writer : TevdXMLWriter;
 l_Filer : Tl3CustomFiler;
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
  NeedCheck: Boolean = true);
//#UC START# *5036334B00AD_503632AC03D9_var*
//#UC END# *5036334B00AD_503632AC03D9_var*
var
 l_Reader : TevdNativeReader;
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
 {-}
begin
 Result := 'XML';
end;//TXMLWriterTest.GetFolder

function TXMLWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '503632AC03D9';
end;//TXMLWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.