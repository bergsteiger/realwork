unit HTMLtoEVDWriterTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/HTMLtoEVDWriterTest.pas"
// Начат: 29.09.2011 18:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::HTML::HTMLtoEVDWriterTest
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
 THTMLtoEVDWriterTest = {abstract} class(TWriterTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure HTMLtoEVD(const aFileName: AnsiString);
 end;//THTMLtoEVDWriterTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  ddHTMLReader,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class THTMLtoEVDWriterTest

procedure THTMLtoEVDWriterTest.HTMLtoEVD(const aFileName: AnsiString);
//#UC START# *4E847EEE02DB_4E847D990353_var*
var
 l_Reader : TddHTMLReader;
//#UC END# *4E847EEE02DB_4E847D990353_var*
begin
//#UC START# *4E847EEE02DB_4E847D990353_impl*
 l_Reader := TddHTMLReader.Make(FileFromCurrent(aFileName));
 try
  SomeFormatToEVD(l_Reader);
 finally
  FreeAndNil(l_Reader);
 end;//try..finally
//#UC END# *4E847EEE02DB_4E847D990353_impl*
end;//THTMLtoEVDWriterTest.HTMLtoEVD

function THTMLtoEVDWriterTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'HTML';
end;//THTMLtoEVDWriterTest.GetFolder

function THTMLtoEVDWriterTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E847D990353';
end;//THTMLtoEVDWriterTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.