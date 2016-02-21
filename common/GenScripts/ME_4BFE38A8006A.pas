unit ScrollAndSelectPtTest;
 {* тесты вида - загрузили, прокрутили и ткнули }

// Модуль: "w:\common\components\rtl\Garant\Daily\ScrollAndSelectPtTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , SelectPtTest
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TScrollAndSelectPtTest = {abstract} class(TSelectPtTest)
  {* тесты вида - загрузили, прокрутили и ткнули }
  protected
   function NeedScrollUp: Boolean; virtual;
   function NeedScrollByLine: Boolean; virtual;
   function GetScrollCount: Integer; virtual;
   procedure CheckAfterScroll(const aView: InevInputView); virtual;
    {* Операции после прокрутки }
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollAndSelectPtTest
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
;

function TScrollAndSelectPtTest.NeedScrollUp: Boolean;
//#UC START# *4E44C98700AE_4BFE38A8006A_var*
//#UC END# *4E44C98700AE_4BFE38A8006A_var*
begin
//#UC START# *4E44C98700AE_4BFE38A8006A_impl*
 Result := False;
//#UC END# *4E44C98700AE_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.NeedScrollUp

function TScrollAndSelectPtTest.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4BFE38A8006A_var*
//#UC END# *4E44C9B00324_4BFE38A8006A_var*
begin
//#UC START# *4E44C9B00324_4BFE38A8006A_impl*
 Result := False;
//#UC END# *4E44C9B00324_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.NeedScrollByLine

function TScrollAndSelectPtTest.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4BFE38A8006A_var*
//#UC END# *4BFE40CD0337_4BFE38A8006A_var*
begin
//#UC START# *4BFE40CD0337_4BFE38A8006A_impl*
 Result := 0;
//#UC END# *4BFE40CD0337_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.GetScrollCount

procedure TScrollAndSelectPtTest.CheckAfterScroll(const aView: InevInputView);
 {* Операции после прокрутки }
//#UC START# *4C3C80AF002D_4BFE38A8006A_var*
//#UC END# *4C3C80AF002D_4BFE38A8006A_var*
begin
//#UC START# *4C3C80AF002D_4BFE38A8006A_impl*
//#UC END# *4C3C80AF002D_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.CheckAfterScroll

{$If NOT Defined(NoVCM)}
procedure TScrollAndSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BFE38A8006A_var*
//#UC END# *4BE419AF0217_4BFE38A8006A_var*
begin
//#UC START# *4BE419AF0217_4BFE38A8006A_impl*
 if NeedScrollByLine then
  ScrollByLine(aForm, GetScrollCount, NeedScrollUp, True)
 else
  ScrollByWeel(aForm, GetScrollCount);
 CheckAfterScroll(aForm.Text.View);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TScrollAndSelectPtTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TScrollAndSelectPtTest.GetFolder

function TScrollAndSelectPtTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BFE38A8006A';
end;//TScrollAndSelectPtTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
