unit K329649989;
 {* [Requestlink:329649989] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K329649989.pas"
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
 TK329649989 = class(TArchiInsiderTest)
  {* [Requestlink:329649989] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK329649989
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK329649989.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK329649989.GetFolder

function TK329649989.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F1ECBA602E3';
end;//TK329649989.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK329649989.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
