unit K347636295;
 {* [Requestlink:347636295] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K347636295.pas"
// Стереотип: "TestCase"

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
 TK347636295 = class(TArchiInsiderTest)
  {* [Requestlink:347636295] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK347636295
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK347636295.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK347636295.GetFolder

function TK347636295.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F6C55ED0287';
end;//TK347636295.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK347636295.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
