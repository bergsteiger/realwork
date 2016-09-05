unit ScrollAndLinesTest;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\ScrollAndLinesTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TScrollAndLinesTest" MUID: (4E54DE280369)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LinesTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TScrollAndLinesTest = {abstract} class(TLinesTest)
  private
   procedure DoScroll(aForm: TPrimTextLoadForm);
  protected
   function GetScrollCount: Integer; virtual; abstract;
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollAndLinesTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4E54DE280369impl_uses*
 //#UC END# *4E54DE280369impl_uses*
;

procedure TScrollAndLinesTest.DoScroll(aForm: TPrimTextLoadForm);
//#UC START# *4E54DE74026A_4E54DE280369_var*
//#UC END# *4E54DE74026A_4E54DE280369_var*
begin
//#UC START# *4E54DE74026A_4E54DE280369_impl*
 ScrollByWeel(aForm, GetScrollCount);
//#UC END# *4E54DE74026A_4E54DE280369_impl*
end;//TScrollAndLinesTest.DoScroll

{$If NOT Defined(NoVCM)}
procedure TScrollAndLinesTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4E54DE280369_var*
//#UC END# *4BE419AF0217_4E54DE280369_var*
begin
//#UC START# *4BE419AF0217_4E54DE280369_impl*
 DoScroll(aForm);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4E54DE280369_impl*
end;//TScrollAndLinesTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TScrollAndLinesTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TScrollAndLinesTest.GetFolder

function TScrollAndLinesTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E54DE280369';
end;//TScrollAndLinesTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
