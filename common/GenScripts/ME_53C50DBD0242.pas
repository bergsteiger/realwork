unit K555392182;
 {* [RequestLink:555392182] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K555392182.pas"
// Стереотип: "TestCase"
// Элемент модели: "K555392182" MUID: (53C50DBD0242)
// Имя типа: "TK555392182"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK555392182 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:555392182] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK555392182
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK555392182.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK555392182.GetFolder

function TK555392182.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53C50DBD0242';
end;//TK555392182.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK555392182.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
