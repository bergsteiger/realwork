unit K370384889;
 {* [Requestlink:370384889] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K370384889.pas"
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
 TK370384889 = class(TArchiInsiderTest)
  {* [Requestlink:370384889] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK370384889
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK370384889.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OEMTextTests';
end;//TK370384889.GetFolder

function TK370384889.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FCF0C2800FE';
end;//TK370384889.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK370384889.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
