unit RTFWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/RTFWriterTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::RTFWriterTest
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
  ddRTFWriter,
  WriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TRTFWriterTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure SomeFormatToRTF(aReader: Tk2CustomFileReader;
     NeedCheck: Boolean = true);
   procedure EVDtoRTF(const aFileName: AnsiString;
     NeedCheck: Boolean = true);
   function UseExternalLinks: Boolean; virtual;
 end;//TRTFWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TRTFWriterTest

procedure TRTFWriterTest.SomeFormatToRTF(aReader: Tk2CustomFileReader;
  NeedCheck: Boolean = true);
//#UC START# *4BACDF18014F_4BACDEF50001_var*
//#UC END# *4BACDF18014F_4BACDEF50001_var*
var
 l_Writer : TevRTFObjectGenerator;
 l_Filer : Tl3CustomFiler;
begin
//#UC START# *4BACDF18014F_4BACDEF50001_impl*
 l_Writer := TevRTFObjectGenerator.Create;
 try
  l_Writer.UseExternalLinks := Self.UseExternalLinks;
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
 if NeedCheck then
  DoWrite(aReader, EtalonSuffix + '.rtf')
 else
  DoWrite(aReader, '');
//#UC END# *4BACDF18014F_4BACDEF50001_impl*
end;//TRTFWriterTest.SomeFormatToRTF

procedure TRTFWriterTest.EVDtoRTF(const aFileName: AnsiString;
  NeedCheck: Boolean = true);
//#UC START# *4BACE0B20173_4BACDEF50001_var*
//#UC END# *4BACE0B20173_4BACDEF50001_var*
var
 l_Reader : TevdNativeReader;
begin
//#UC START# *4BACE0B20173_4BACDEF50001_impl*
 l_Reader := TevdNativeReader.Make(FileFromCurrent(aFileName));
 try
  SomeFormatToRTF(l_Reader, NeedCheck);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4BACE0B20173_4BACDEF50001_impl*
end;//TRTFWriterTest.EVDtoRTF

function TRTFWriterTest.UseExternalLinks: Boolean;
//#UC START# *4CD126A5012A_4BACDEF50001_var*
var
 l_V : Integer;
//#UC END# *4CD126A5012A_4BACDEF50001_var*
begin
//#UC START# *4CD126A5012A_4BACDEF50001_impl*
 if TryStrToInt(KPage, l_V) then
  Result := (l_V > 239371145)
  // - для старых тестов стараемся вести себя по-старому
 else
  Result := true; 
 // http://mdp.garant.ru/pages/viewpage.action?pageId=239371145
//#UC END# *4CD126A5012A_4BACDEF50001_impl*
end;//TRTFWriterTest.UseExternalLinks

function TRTFWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TRTFWriterTest.GetFolder

function TRTFWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BACDEF50001';
end;//TRTFWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.