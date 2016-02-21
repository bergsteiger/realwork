unit K271189977;
 {* [$271189977] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K271189977.pas"
// Стереотип: "TestCase"

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
 TK271189977 = class(TArchiInsiderTest)
  {* [$271189977] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK271189977
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK271189977.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK271189977.GetFolder

function TK271189977.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E0A09AA03D8';
end;//TK271189977.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK271189977.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
