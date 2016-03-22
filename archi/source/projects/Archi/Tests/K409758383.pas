unit K409758383;
 {* [Requestlink:409758383] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K409758383.pas"
// Стереотип: "TestCase"
// Элемент модели: "K409758383" MUID: (50B86E6202C7)
// Имя типа: "TK409758383"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK409758383 = class(TArchiInsiderTest)
  {* [Requestlink:409758383] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK409758383
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK409758383.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ColumnResize';
end;//TK409758383.GetFolder

function TK409758383.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50B86E6202C7';
end;//TK409758383.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK409758383.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
