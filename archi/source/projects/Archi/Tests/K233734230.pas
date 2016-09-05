unit K233734230;
 {* [Requestlink:233734230] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K233734230.pas"
// Стереотип: "TestCase"
// Элемент модели: "K233734230" MUID: (4F5F329B005B)
// Имя типа: "TK233734230"

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
 TK233734230 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:233734230] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK233734230
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F5F329B005Bimpl_uses*
 //#UC END# *4F5F329B005Bimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK233734230.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SelectionTests';
end;//TK233734230.GetFolder

function TK233734230.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F5F329B005B';
end;//TK233734230.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK233734230.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
