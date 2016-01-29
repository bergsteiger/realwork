unit K585129079_NSRC_KeepExisting;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K585129079_NSRC_KeepExisting.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.11::K585129079_NSRC_KeepExisting
//
// {RequestLink:585129079}
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
  EVDtoBothNSRCWriterTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK585129079_NSRC_KeepExisting = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
 protected
 // overridden protected methods
   function NSRCCodePage: Integer; override;
     {* Кодировка для выливки в NSRC }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function PainterCodePage: Integer; override;
 end;//TK585129079_NSRC_KeepExisting
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Chars,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK585129079_NSRC_KeepExisting

function TK585129079_NSRC_KeepExisting.NSRCCodePage: Integer;
//#UC START# *4BEBCEA00177_5491B41C0353_var*
//#UC END# *4BEBCEA00177_5491B41C0353_var*
begin
//#UC START# *4BEBCEA00177_5491B41C0353_impl*
 Result := CP_KeepExisting;
//#UC END# *4BEBCEA00177_5491B41C0353_impl*
end;//TK585129079_NSRC_KeepExisting.NSRCCodePage

function TK585129079_NSRC_KeepExisting.GetFolder: AnsiString;
 {-}
begin
 Result := '7.11';
end;//TK585129079_NSRC_KeepExisting.GetFolder

function TK585129079_NSRC_KeepExisting.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '5491B41C0353';
end;//TK585129079_NSRC_KeepExisting.GetModelElementGUID

function TK585129079_NSRC_KeepExisting.PainterCodePage: Integer;
//#UC START# *5491B011031B_5491B41C0353_var*
//#UC END# *5491B011031B_5491B41C0353_var*
begin
//#UC START# *5491B011031B_5491B41C0353_impl*
 Result := NSRCCodePage;
//#UC END# *5491B011031B_5491B41C0353_impl*
end;//TK585129079_NSRC_KeepExisting.PainterCodePage

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK585129079_NSRC_KeepExisting.Suite);

end.