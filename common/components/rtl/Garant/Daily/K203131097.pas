unit K203131097;
 {* [RequestLink:203131097]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K203131097.pas"
// Стереотип: "TestCase"
// Элемент модели: "K203131097" MUID: (4BC456000241)
// Имя типа: "TK203131097"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK203131097 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:203131097]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK203131097
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BC456000241impl_uses*
 //#UC END# *4BC456000241impl_uses*
;

function TK203131097.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK203131097.GetFolder

function TK203131097.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BC456000241';
end;//TK203131097.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK203131097.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
