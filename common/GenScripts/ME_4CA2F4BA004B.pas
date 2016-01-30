unit K235050248;
 {* [$235050248] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235050248.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , CommentInTableAndScrollTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK235050248 = class(TCommentInTableAndScrollTest)
  {* [$235050248] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235050248
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235050248.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235050248.GetFolder

function TK235050248.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CA2F4BA004B';
end;//TK235050248.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235050248.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
