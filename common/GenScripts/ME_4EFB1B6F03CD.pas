unit K325258836;
 {* [Requestlink:325258836] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K325258836.pas"
// Стереотип: "TestCase"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , ArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TK325258836 = class(TArchiInsiderTest)
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
;

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
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
