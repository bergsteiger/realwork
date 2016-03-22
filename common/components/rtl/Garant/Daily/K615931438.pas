unit K615931438;
 {* [Requestlink:615931438]. Падаем, из-за <stab> в ячейках таблицы. Был не начат текстовый параграф, но была попытка поставить сегмент. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K615931438.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK615931438" MUID: (56A85852030C)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK615931438 = class(THTMLtoEVDTest)
  {* [Requestlink:615931438]. Падаем, из-за <stab> в ячейках таблицы. Был не начат текстовый параграф, но была попытка поставить сегмент. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK615931438
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK615931438.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK615931438.GetFolder

function TK615931438.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56A85852030C';
end;//TK615931438.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK615931438.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
