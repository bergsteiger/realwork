unit K403079732;
 {* [Requestlink:403079732] }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\K403079732.pas"
// Стереотип: "TestCase"
// Элемент модели: "K403079732" MUID: (524146DB01BA)
// Имя типа: "TK403079732"

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK403079732 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:403079732] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK403079732
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *524146DB01BAimpl_uses*
 //#UC END# *524146DB01BAimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK403079732.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FileFormatTests';
end;//TK403079732.GetFolder

function TK403079732.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '524146DB01BA';
end;//TK403079732.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK403079732.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
