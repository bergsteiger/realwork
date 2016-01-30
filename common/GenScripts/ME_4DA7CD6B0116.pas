unit K259893591;
 {* [$259893591] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K259893591.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WholeSelectionWithMouseTest
 , Types
;

type
 TK259893591 = class(TWholeSelectionWithMouseTest)
  {* [$259893591] }
  protected
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK259893591
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK259893591.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4DA7CD6B0116_var*
//#UC END# *4C08CF700318_4DA7CD6B0116_var*
begin
//#UC START# *4C08CF700318_4DA7CD6B0116_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DA7CD6B0116_impl*
end;//TK259893591.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK259893591.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK259893591.GetFolder

function TK259893591.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DA7CD6B0116';
end;//TK259893591.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK259893591.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
