unit K211878770;
 {* [RequestLink:211878770] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K211878770.pas"
// Стереотип: "TestCase"
// Элемент модели: "K211878770" MUID: (4BEBC83C00A2)
// Имя типа: "TK211878770"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878770 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:211878770] }
  protected
   function NSRCCodePage: Integer; override;
    {* Кодировка для выливки в NSRC }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK211878770
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Chars
 , TestFrameWork
;

function TK211878770.NSRCCodePage: Integer;
 {* Кодировка для выливки в NSRC }
//#UC START# *4BEBCEA00177_4BEBC83C00A2_var*
//#UC END# *4BEBCEA00177_4BEBC83C00A2_var*
begin
//#UC START# *4BEBCEA00177_4BEBC83C00A2_impl*
 Result := CP_OEM;
//#UC END# *4BEBCEA00177_4BEBC83C00A2_impl*
end;//TK211878770.NSRCCodePage

function TK211878770.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK211878770.GetFolder

function TK211878770.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBC83C00A2';
end;//TK211878770.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878770.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
