unit K343640765;
 {* [Requestlink:343640765] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K343640765.pas"
// Стереотип: "TestCase"
// Элемент модели: "K343640765" MUID: (4F560F5A0088)
// Имя типа: "TK343640765"

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
 TK343640765 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:343640765] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK343640765
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F560F5A0088impl_uses*
 //#UC END# *4F560F5A0088impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK343640765.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ScrollTests';
end;//TK343640765.GetFolder

function TK343640765.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F560F5A0088';
end;//TK343640765.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK343640765.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
