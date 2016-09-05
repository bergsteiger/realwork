unit K466751170;
 {* [Requestlink:466751170] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K466751170.pas"
// Стереотип: "TestCase"
// Элемент модели: "K466751170" MUID: (51D16D750188)
// Имя типа: "TK466751170"

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
 TK466751170 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:466751170] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK466751170
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *51D16D750188impl_uses*
 //#UC END# *51D16D750188impl_uses*
;

{$If NOT Defined(NoScripts)}
function TK466751170.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'FilterTests';
end;//TK466751170.GetFolder

function TK466751170.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '51D16D750188';
end;//TK466751170.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK466751170.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
