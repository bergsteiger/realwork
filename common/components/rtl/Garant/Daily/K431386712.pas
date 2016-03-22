unit K431386712;
 {* [Requestlink:431378358] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K431386712.pas"
// Стереотип: "TestCase"
// Элемент модели: "K431386712" MUID: (514850D00368)
// Имя типа: "TK431386712"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK431386712 = class(TEVDtoNSRCPlusWriterTest)
  {* [Requestlink:431378358] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK431386712
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK431386712.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK431386712.GetFolder

function TK431386712.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '514850D00368';
end;//TK431386712.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK431386712.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
