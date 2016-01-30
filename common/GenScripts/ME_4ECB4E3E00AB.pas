unit K296094705;
 {* [RequestLink:296094705] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K296094705.pas"
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
 TK296094705 = class(TArchiInsiderTest)
  {* [RequestLink:296094705] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK296094705
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK296094705.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK296094705.GetFolder

function TK296094705.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ECB4E3E00AB';
end;//TK296094705.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK296094705.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
