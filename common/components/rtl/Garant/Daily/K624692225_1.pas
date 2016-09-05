unit K624692225_1;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=624692225&focusedCommentId=624709697#comment-624709697 }

// Модуль: "w:\common\components\rtl\Garant\Daily\K624692225_1.pas"
// Стереотип: "TestCase"
// Элемент модели: "K624692225_1" MUID: (576904C80038)
// Имя типа: "TK624692225_1"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK624692225_1 = class(THTMLtoEVDFull)
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=624692225&focusedCommentId=624709697#comment-624709697 }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK624692225_1
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *576904C80038impl_uses*
 //#UC END# *576904C80038impl_uses*
;

function TK624692225_1.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK624692225_1.GetFolder

function TK624692225_1.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '576904C80038';
end;//TK624692225_1.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK624692225_1.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
