unit K362130309;
 {* [RequestLink:362130309] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K362130309.pas"
// Стереотип: "TestCase"
// Элемент модели: "K362130309" MUID: (4FA0E0470281)
// Имя типа: "TK362130309"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoEVDWriterTest
;

type
 TK362130309 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:362130309] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK362130309
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362130309.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK362130309.GetFolder

function TK362130309.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA0E0470281';
end;//TK362130309.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362130309.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
