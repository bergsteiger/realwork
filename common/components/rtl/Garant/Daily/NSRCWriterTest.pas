unit NSRCWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/NSRCWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::NSRCTests::TNSRCWriterTest
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
  k2DocumentBuffer,
  k2TagGen,
  k2CustomFileReader,
  evCustomTextFormatter,
  evdNativeReader,
  evdNSRCReader,
  WriterTest,
  tstNSRCGenerator
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TNSRCWriterTest = {abstract} class(TWriterTest, ItstNSRCListener)
 protected
 // realized methods
   procedure ExtractFileEvent(const aFileName: AnsiString);
     {* Событие выливки внешнего файла. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure SomeFormatToNSRC(aReader: Tk2CustomFileReader;
     aPlus: Boolean);
   procedure EVDtoNSRC(const aFileName: AnsiString;
     aPlus: Boolean);
   procedure NSRCtoNSRC(const aFileName: AnsiString;
     aPlus: Boolean);
   function CreateNSRCReader(const aFileName: AnsiString): TevdNSRCReader;
     {* Создаёт NSRCReader }
   procedure NSRCtoMemory(const aFileName: AnsiString);
     {* Читает NSRC в память }
   procedure NSRCtoEVD(const aFileName: AnsiString);
   function PainterCodePage: Integer; virtual;
   function NSRCCodePage: Integer; virtual;
     {* Кодировка для выливки в NSRC }
 end;//TNSRCWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  l3Chars,
  evTextFormatter,
  evSimpleTextPainter,
  evNSRCPlusWriter,
  evEmptyTableEliminator,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TNSRCWriterTest

procedure TNSRCWriterTest.SomeFormatToNSRC(aReader: Tk2CustomFileReader;
  aPlus: Boolean);
//#UC START# *4B59DC7D0325_4B4F68EE006B_var*
const
 cExt : array [Boolean] of AnsiString = ('.nsr', '.plus.nsr');
//#UC END# *4B59DC7D0325_4B4F68EE006B_var*
var
 l_Filer : Tl3CustomFiler;
 l_Painter : TevCustomTextFormatter;
 l_G : Tk2TagGenerator;
 l_TestGen : TtstNSRCGenerator;
begin
//#UC START# *4B59DC7D0325_4B4F68EE006B_impl*
 if aPlus then
  l_Painter := TevSimpleTextPainter.Create
 else
  l_Painter := TevTextFormatter.Create;
 try
  l_TestGen := TtstNSRCGenerator.Create;
  l_TestGen.LinkNSRCListener(Self);
  l_TestGen.ExportDirectory := OutputPath;
(*  if aPlus then
   l_NSRCWriter := TevNSRCPlusWriter.Create
  else
   l_NSRCWriter := TevCustomNSRCWriter.Create;*)
  try
   l_TestGen.CodePage := NSRCCodePage;
   l_Filer := FilerForOutput;
   try
    l_TestGen.Filer := l_Filer;
   finally
    FreeAndNil(l_Filer);
   end;//try..finally
   with l_Painter do
   begin
    CodePage := PainterCodePage;
    SBSDelimeter := '|';
    Generator := l_TestGen;
    FormatOrdinalParas := true;
   end;//with l_Painter
   l_G := l_Painter.Use;
   try
    TevEmptyTableEliminator.SetTo(l_G);
    aReader.Generator := l_G;
   finally
    FreeAndNil(l_G);
   end;//try..finally
  finally
   FreeAndNil(l_Painter);
  end;//try..finally
  DoWrite(aReader, EtalonSuffix + cExt[aPlus], ';');
 finally
  l_TestGen.UnlinkNSRCListener(Self);
  FreeAndNil(l_TestGen);
 end;//try..finally
//#UC END# *4B59DC7D0325_4B4F68EE006B_impl*
end;//TNSRCWriterTest.SomeFormatToNSRC

procedure TNSRCWriterTest.EVDtoNSRC(const aFileName: AnsiString;
  aPlus: Boolean);
//#UC START# *4B59E36902DE_4B4F68EE006B_var*
//#UC END# *4B59E36902DE_4B4F68EE006B_var*
var
 l_Reader : TevdNativeReader;
begin
//#UC START# *4B59E36902DE_4B4F68EE006B_impl*
 l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  SomeFormatToNSRC(l_Reader, aPlus);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4B59E36902DE_4B4F68EE006B_impl*
end;//TNSRCWriterTest.EVDtoNSRC

procedure TNSRCWriterTest.NSRCtoNSRC(const aFileName: AnsiString;
  aPlus: Boolean);
//#UC START# *4B59EBDB038B_4B4F68EE006B_var*
//#UC END# *4B59EBDB038B_4B4F68EE006B_var*
var
 l_Reader : TevdNSRCReader;
begin
//#UC START# *4B59EBDB038B_4B4F68EE006B_impl*
 l_Reader := CreateNSRCReader(aFileName);
 try
  SomeFormatToNSRC(l_Reader, aPlus);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4B59EBDB038B_4B4F68EE006B_impl*
end;//TNSRCWriterTest.NSRCtoNSRC

function TNSRCWriterTest.CreateNSRCReader(const aFileName: AnsiString): TevdNSRCReader;
//#UC START# *4B7D049100D0_4B4F68EE006B_var*
//#UC END# *4B7D049100D0_4B4F68EE006B_var*
begin
//#UC START# *4B7D049100D0_4B4F68EE006B_impl*
 Result := TevdNSRCReader.Make(FileFromCurrent(aFileName));
 try
  Result.StrictFormat := false;
 except
  FreeAndNil(Result);
  raise;
 end;//try..except
//#UC END# *4B7D049100D0_4B4F68EE006B_impl*
end;//TNSRCWriterTest.CreateNSRCReader

procedure TNSRCWriterTest.NSRCtoMemory(const aFileName: AnsiString);
//#UC START# *4B7D050E002F_4B4F68EE006B_var*
//#UC END# *4B7D050E002F_4B4F68EE006B_var*
var
 l_Reader : TevdNSRCReader;
 l_Buffer : Tk2DocumentBuffer;
begin
//#UC START# *4B7D050E002F_4B4F68EE006B_impl*
 l_Reader := CreateNSRCReader(aFileName);
 try
  l_Buffer := Tk2DocumentBuffer.Create;
  try
   l_Reader.Generator := l_Buffer;
   StartTimer;
   try
    l_Reader.Execute;
   finally
    StopTimer;
   end;//try..finally
  finally
   FreeAndNil(l_Buffer);
  end;//try..finally
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4B7D050E002F_4B4F68EE006B_impl*
end;//TNSRCWriterTest.NSRCtoMemory

procedure TNSRCWriterTest.NSRCtoEVD(const aFileName: AnsiString);
//#UC START# *4BED3FAC0228_4B4F68EE006B_var*
//#UC END# *4BED3FAC0228_4B4F68EE006B_var*
var
 l_Reader : TevdNSRCReader;
begin
//#UC START# *4BED3FAC0228_4B4F68EE006B_impl*
 l_Reader := CreateNSRCReader(aFileName);
 try
  SomeFormatToEVD(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4BED3FAC0228_4B4F68EE006B_impl*
end;//TNSRCWriterTest.NSRCtoEVD

function TNSRCWriterTest.PainterCodePage: Integer;
//#UC START# *5491B011031B_4B4F68EE006B_var*
//#UC END# *5491B011031B_4B4F68EE006B_var*
begin
//#UC START# *5491B011031B_4B4F68EE006B_impl*
 Result := CP_OEMLite;
//#UC END# *5491B011031B_4B4F68EE006B_impl*
end;//TNSRCWriterTest.PainterCodePage

function TNSRCWriterTest.NSRCCodePage: Integer;
//#UC START# *4BEBCEA00177_4B4F68EE006B_var*
//#UC END# *4BEBCEA00177_4B4F68EE006B_var*
begin
//#UC START# *4BEBCEA00177_4B4F68EE006B_impl*
 Result := CP_KeepExisting;
//#UC END# *4BEBCEA00177_4B4F68EE006B_impl*
end;//TNSRCWriterTest.NSRCCodePage

procedure TNSRCWriterTest.ExtractFileEvent(const aFileName: AnsiString);
//#UC START# *4D70B2AF0288_4B4F68EE006B_var*
//#UC END# *4D70B2AF0288_4B4F68EE006B_var*
begin
//#UC START# *4D70B2AF0288_4B4F68EE006B_impl*
 Check(FileExists(aFileName));
 DeleteFile(aFileName);
//#UC END# *4D70B2AF0288_4B4F68EE006B_impl*
end;//TNSRCWriterTest.ExtractFileEvent

function TNSRCWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'NSRCTests';
end;//TNSRCWriterTest.GetFolder

function TNSRCWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4B4F68EE006B';
end;//TNSRCWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.