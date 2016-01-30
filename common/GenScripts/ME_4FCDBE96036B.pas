unit K362130404;
 {* [Requestlink:362130404] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K362130404.pas"
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
 TK362130404 = class(TArchiInsiderTest)
  {* [Requestlink:362130404] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK362130404
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK362130404.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'OEMTextTests';
end;//TK362130404.GetFolder

function TK362130404.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4FCDBE96036B';
end;//TK362130404.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK362130404.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
