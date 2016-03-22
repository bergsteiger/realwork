unit RTFReaderTest;

// Модуль: "w:\common\components\rtl\Garant\Daily\RTFReaderTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "RTFReaderTest" MUID: (4C971BF80183)
// Имя типа: "TRTFReaderTest"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WriterTest
;

type
 TRTFReaderTest = {abstract} class(TWriterTest)
  protected
   procedure RTFtoEVD(const aFileName: AnsiString);
   function GetEnablePictures: Boolean; virtual;
   function GetEnableReadURL: Boolean; virtual;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TRTFReaderTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , ddRTFReader
;

procedure TRTFReaderTest.RTFtoEVD(const aFileName: AnsiString);
//#UC START# *4C971C6C0182_4C971BF80183_var*
var
 l_Reader : TddRTFReader;
//#UC END# *4C971C6C0182_4C971BF80183_var*
begin
//#UC START# *4C971C6C0182_4C971BF80183_impl*
 l_Reader := TddRTFReader.Make(FileFromCurrent(aFileName));
 try
  l_Reader.EnablePictures := Self.GetEnablePictures;
  l_Reader.ReadURL := GetEnableReadURL;
  SomeFormatToEVD(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4C971C6C0182_4C971BF80183_impl*
end;//TRTFReaderTest.RTFtoEVD

function TRTFReaderTest.GetEnablePictures: Boolean;
//#UC START# *4D5BE2F500AD_4C971BF80183_var*
//#UC END# *4D5BE2F500AD_4C971BF80183_var*
begin
//#UC START# *4D5BE2F500AD_4C971BF80183_impl*
 Result := false;
//#UC END# *4D5BE2F500AD_4C971BF80183_impl*
end;//TRTFReaderTest.GetEnablePictures

function TRTFReaderTest.GetEnableReadURL: Boolean;
//#UC START# *56A9C9CE021D_4C971BF80183_var*
//#UC END# *56A9C9CE021D_4C971BF80183_var*
begin
//#UC START# *56A9C9CE021D_4C971BF80183_impl*
 Result := False;
//#UC END# *56A9C9CE021D_4C971BF80183_impl*
end;//TRTFReaderTest.GetEnableReadURL

function TRTFReaderTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RTF';
end;//TRTFReaderTest.GetFolder

function TRTFReaderTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C971BF80183';
end;//TRTFReaderTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
