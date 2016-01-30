unit K585129079_NSRC_EAST_EUROPE;
 {* [RequestLink:585129079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC_EAST_EUROPE.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK585129079_NSRC_EAST_EUROPE = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
  protected
   function NSRCCodePage: Integer; override;
    {* Кодировка для выливки в NSRC }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function PainterCodePage: Integer; override;
 end;//TK585129079_NSRC_EAST_EUROPE
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Chars
 , TestFrameWork
;

function TK585129079_NSRC_EAST_EUROPE.NSRCCodePage: Integer;
 {* Кодировка для выливки в NSRC }
//#UC START# *4BEBCEA00177_5491B03300A0_var*
//#UC END# *4BEBCEA00177_5491B03300A0_var*
begin
//#UC START# *4BEBCEA00177_5491B03300A0_impl*
 Result := CP_EastEurope;
//#UC END# *4BEBCEA00177_5491B03300A0_impl*
end;//TK585129079_NSRC_EAST_EUROPE.NSRCCodePage

function TK585129079_NSRC_EAST_EUROPE.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK585129079_NSRC_EAST_EUROPE.GetFolder

function TK585129079_NSRC_EAST_EUROPE.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5491B03300A0';
end;//TK585129079_NSRC_EAST_EUROPE.GetModelElementGUID

function TK585129079_NSRC_EAST_EUROPE.PainterCodePage: Integer;
//#UC START# *5491B011031B_5491B03300A0_var*
//#UC END# *5491B011031B_5491B03300A0_var*
begin
//#UC START# *5491B011031B_5491B03300A0_impl*
 Result := NSRCCodePage;
//#UC END# *5491B011031B_5491B03300A0_impl*
end;//TK585129079_NSRC_EAST_EUROPE.PainterCodePage

initialization
 TestFramework.RegisterTest(TK585129079_NSRC_EAST_EUROPE.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
