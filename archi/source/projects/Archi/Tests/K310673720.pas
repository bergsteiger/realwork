unit K310673720;
 {* [RequestLink:310673720] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K310673720.pas"
// Стереотип: "TestCase"
// Элемент модели: "K310673720" MUID: (4ED7818400C7)
// Имя типа: "TK310673720"

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
 TK310673720 = class({$If NOT Defined(NoScripts)}
 TArchiInsiderTest
 {$IfEnd} // NOT Defined(NoScripts)
 )
  {* [RequestLink:310673720] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK310673720
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoScripts)}
function TK310673720.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'SBSTests';
end;//TK310673720.GetFolder

function TK310673720.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ED7818400C7';
end;//TK310673720.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK310673720.Suite);
{$IfEnd} // NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
