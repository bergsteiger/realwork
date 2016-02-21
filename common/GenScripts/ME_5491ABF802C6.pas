unit K585129079_NSRC_ANSI;
 {* [RequestLink:585129079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K585129079_NSRC_ANSI.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK585129079_NSRC_ANSI = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:585129079] }
  protected
   function NSRCCodePage: Integer; override;
    {* Кодировка для выливки в NSRC }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK585129079_NSRC_ANSI
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Chars
 , TestFrameWork
;

function TK585129079_NSRC_ANSI.NSRCCodePage: Integer;
 {* Кодировка для выливки в NSRC }
//#UC START# *4BEBCEA00177_5491ABF802C6_var*
//#UC END# *4BEBCEA00177_5491ABF802C6_var*
begin
//#UC START# *4BEBCEA00177_5491ABF802C6_impl*
 Result := CP_ANSI;
//#UC END# *4BEBCEA00177_5491ABF802C6_impl*
end;//TK585129079_NSRC_ANSI.NSRCCodePage

function TK585129079_NSRC_ANSI.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK585129079_NSRC_ANSI.GetFolder

function TK585129079_NSRC_ANSI.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5491ABF802C6';
end;//TK585129079_NSRC_ANSI.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585129079_NSRC_ANSI.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
