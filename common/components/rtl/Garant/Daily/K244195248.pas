unit K244195248;
 {* [RequestLInk:244195248] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K244195248.pas"
// Стереотип: "TestCase"
// Элемент модели: "K244195248" MUID: (4CF7B1DA026E)
// Имя типа: "TK244195248"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK244195248 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLInk:244195248] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK244195248
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4CF7B1DA026Eimpl_uses*
 //#UC END# *4CF7B1DA026Eimpl_uses*
;

function TK244195248.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK244195248.GetFolder

function TK244195248.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CF7B1DA026E';
end;//TK244195248.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK244195248.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
