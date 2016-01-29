unit RTFReaderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/RTFReaderTest.pas"
// Начат: 20.09.2010 12:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::RTF::RTFReaderTest
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
 TRTFReaderTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure RTFtoEVD(const aFileName: AnsiString);
   function GetEnablePictures: Boolean; virtual;
 end;//TRTFReaderTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  ddRTFReader,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TRTFReaderTest

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

function TRTFReaderTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'RTF';
end;//TRTFReaderTest.GetFolder

function TRTFReaderTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C971BF80183';
end;//TRTFReaderTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.