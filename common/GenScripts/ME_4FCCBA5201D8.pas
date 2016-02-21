unit K367198557;
 {* [$367198557] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K367198557.pas"
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
 TK367198557 = class(TArchiInsiderTest)
  {* [$367198557] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK367198557
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK367198557.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK367198557.GetFolder

function TK367198557.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FCCBA5201D8';
end;//TK367198557.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK367198557.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
