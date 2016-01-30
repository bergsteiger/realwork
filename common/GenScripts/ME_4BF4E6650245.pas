unit SelectPtTest;
 {* Тест вида - загрузили и ткнули в точку со смещением относительно какого-нибудь параграфа }

// Модуль: "w:\common\components\rtl\Garant\Daily\SelectPtTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , l3Units
 , evCustomEditorWindow
;

type
 _Para2Point_Parent_ = TTextEditorVisitor;
 {$Include Para2Point.imp.pas}
 TSelectPtTest = {abstract} class(_Para2Point_)
  {* Тест вида - загрузили и ткнули в точку со смещением относительно какого-нибудь параграфа }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TSelectPtTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$Include Para2Point.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BF4E6650245_var*
//#UC END# *4BE419AF0217_4BF4E6650245_var*
begin
//#UC START# *4BE419AF0217_4BF4E6650245_impl*
 {$R+}
 aForm.Text.View.Control.Selection.SelectPt(TranslatePara2Point(aForm.Text), True);
 {$R-}
//#UC END# *4BE419AF0217_4BF4E6650245_impl*
end;//TSelectPtTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TSelectPtTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TSelectPtTest.GetFolder

function TSelectPtTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BF4E6650245';
end;//TSelectPtTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
