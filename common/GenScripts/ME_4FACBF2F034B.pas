unit K360481669;
 {* [Requestlink:360481669] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K360481669.pas"
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
 TK360481669 = class(TArchiInsiderTest)
  {* [Requestlink:360481669] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK360481669
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK360481669.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Text2TableTests';
end;//TK360481669.GetFolder

function TK360481669.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FACBF2F034B';
end;//TK360481669.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK360481669.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
