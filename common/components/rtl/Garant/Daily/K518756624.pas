unit K518756624;
 {* [RequestLink:518756624] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K518756624.pas"
// Стереотип: "TestCase"
// Элемент модели: "K518756624" MUID: (530C925400E5)
// Имя типа: "TK518756624"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFRender
;

type
 TK518756624 = class(TEVDtoRTFRender)
  {* [RequestLink:518756624] }
  protected
   function NeedEliminateCommentDecorations: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK518756624
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *530C925400E5impl_uses*
 //#UC END# *530C925400E5impl_uses*
;

function TK518756624.NeedEliminateCommentDecorations: Boolean;
//#UC START# *530C91FB00BD_530C925400E5_var*
//#UC END# *530C91FB00BD_530C925400E5_var*
begin
//#UC START# *530C91FB00BD_530C925400E5_impl*
 Result := True;
//#UC END# *530C91FB00BD_530C925400E5_impl*
end;//TK518756624.NeedEliminateCommentDecorations

function TK518756624.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK518756624.GetFolder

function TK518756624.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '530C925400E5';
end;//TK518756624.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK518756624.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
