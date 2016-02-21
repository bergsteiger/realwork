unit K300028777;
 {* [RequestLink:300028777] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K300028777.pas"
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
 TK300028777 = class(TArchiInsiderTest)
  {* [RequestLink:300028777] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK300028777
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK300028777.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ContentsTree';
end;//TK300028777.GetFolder

function TK300028777.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4ECB30E101B4';
end;//TK300028777.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK300028777.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
