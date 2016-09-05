unit K271754425;
 {* [$271754425] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K271754425.pas"
// Стереотип: "TestCase"
// Элемент модели: "K271754425" MUID: (4E0DA31F0385)
// Имя типа: "TK271754425"

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
 TK271754425 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [$271754425] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK271754425
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E0DA31F0385impl_uses*
 //#UC END# *4E0DA31F0385impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK271754425.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK271754425.GetFolder

function TK271754425.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E0DA31F0385';
end;//TK271754425.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK271754425.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
