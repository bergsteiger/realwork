unit RTFWriterTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\RTFWriterTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "RTFWriterTest" MUID: (4BACDEF50001)
// Имя типа: "TRTFWriterTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
 , ddRTFWriter
 , l3Filer
 , k2CustomFileReader
 , evdNativeReader
;

type
 TRTFWriterTest = {abstract} class(TWriterTest)
  protected
   procedure SomeFormatToRTF(aReader: Tk2CustomFileReader;
    NeedCheck: Boolean = True);
   procedure EVDtoRTF(const aFileName: AnsiString;
    NeedCheck: Boolean = True);
   function UseExternalLinks: Boolean; virtual;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TRTFWriterTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
;

procedure TRTFWriterTest.SomeFormatToRTF(aReader: Tk2CustomFileReader;
 NeedCheck: Boolean = True);
var l_Writer: TevRTFObjectGenerator;
var l_Filer: Tl3CustomFiler;
//#UC START# *4BACDF18014F_4BACDEF50001_var*
//#UC END# *4BACDF18014F_4BACDEF50001_var*
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
 NeedCheck: Boolean = True);
var l_Reader: TevdNativeReader;
//#UC START# *4BACE0B20173_4BACDEF50001_var*
//#UC END# *4BACE0B20173_4BACDEF50001_var*
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
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TRTFWriterTest.GetFolder

function TRTFWriterTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BACDEF50001';
end;//TRTFWriterTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
