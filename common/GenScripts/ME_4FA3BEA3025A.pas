unit K333553224;
 {* [Requestlink:333553224] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K333553224.pas"
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
 TK333553224 = class(TArchiInsiderTest)
  {* [Requestlink:333553224] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK333553224
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK333553224.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Drawing Tests';
end;//TK333553224.GetFolder

function TK333553224.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FA3BEA3025A';
end;//TK333553224.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK333553224.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
