unit K380604713;
 {* [Requestlink:380604713] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K380604713.pas"
// Стереотип: "TestCase"
// Элемент модели: "TK380604713" MUID: (5017CA2F0220)

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
 TK380604713 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:380604713] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK380604713
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *5017CA2F0220impl_uses*
 //#UC END# *5017CA2F0220impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK380604713.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BlockTest';
end;//TK380604713.GetFolder

function TK380604713.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5017CA2F0220';
end;//TK380604713.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK380604713.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
