unit K271190109;
 {* [$271190109] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K271190109.pas"
// Стереотип: "TestCase"
// Элемент модели: "K271190109" MUID: (4E0B3017029E)
// Имя типа: "TK271190109"

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
 TK271190109 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [$271190109] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK271190109
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4E0B3017029Eimpl_uses*
 //#UC END# *4E0B3017029Eimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK271190109.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK271190109.GetFolder

function TK271190109.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E0B3017029E';
end;//TK271190109.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK271190109.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
