unit K325258836;
 {* [Requestlink:325258836] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K325258836.pas"
// Стереотип: "TestCase"
// Элемент модели: "K325258836" MUID: (4EFB1B6F03CD)
// Имя типа: "TK325258836"

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
 TK325258836 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [Requestlink:325258836] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK325258836
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4EFB1B6F03CDimpl_uses*
 //#UC END# *4EFB1B6F03CDimpl_uses*
;

{$If NOT Defined(NoScripts)}
function TK325258836.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK325258836.GetFolder

function TK325258836.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EFB1B6F03CD';
end;//TK325258836.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK325258836.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
