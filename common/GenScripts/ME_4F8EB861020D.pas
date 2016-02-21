unit K358976702;
 {* [Requestlink:358976702] }

// Модуль: "w:\archi\source\projects\Archi\Tests\K358976702.pas"
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
 TK358976702 = class(TArchiInsiderTest)
  {* [Requestlink:358976702] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK358976702
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK358976702.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TK358976702.GetFolder

function TK358976702.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F8EB861020D';
end;//TK358976702.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK358976702.Suite);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
