unit K330141531;
 {* [Requestlink:330141531] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K330141531.pas"
// Стереотип: "TestCase"
// Элемент модели: "K330141531" MUID: (4F2679EA023D)
// Имя типа: "TK330141531"

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
 TK330141531 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:330141531] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK330141531
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F2679EA023Dimpl_uses*
 //#UC END# *4F2679EA023Dimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK330141531.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DialogTest';
end;//TK330141531.GetFolder

function TK330141531.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F2679EA023D';
end;//TK330141531.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK330141531.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
