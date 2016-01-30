unit CheckTopAnchorTest;
 {* Тест для выбора точки после прокрутки и проверки изменился ли TopAnchor }

// Модуль: "w:\common\components\rtl\Garant\Daily\CheckTopAnchorTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TCheckTopAnchorTest = {abstract} class(TScrollAndSelectPtTest)
  {* Тест для выбора точки после прокрутки и проверки изменился ли TopAnchor }
  private
   f_PrevTopAnchor: InevBasePoint;
    {* Предыдущее значение TopAnchor'а. }
  protected
   procedure Cleanup; override;
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure CheckAfterScroll(const aView: InevInputView); override;
    {* Операции после прокрутки }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TCheckTopAnchorTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TCheckTopAnchorTest.Cleanup;
//#UC START# *4B2F40FD0088_4C3C771A002D_var*
//#UC END# *4B2F40FD0088_4C3C771A002D_var*
begin
//#UC START# *4B2F40FD0088_4C3C771A002D_impl*
 f_PrevTopAnchor := nil;
 inherited;
//#UC END# *4B2F40FD0088_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.Cleanup

{$If NOT Defined(NoVCM)}
procedure TCheckTopAnchorTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4C3C771A002D_var*
//#UC END# *4BE419AF0217_4C3C771A002D_var*
begin
//#UC START# *4BE419AF0217_4C3C771A002D_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.View.TopAnchor.Diff(aForm.Text.View, f_PrevTopAnchor, aForm.Text.View.RootFormatInfo) = 0, 'Сместились вверх при установке курсора!');
//#UC END# *4BE419AF0217_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

procedure TCheckTopAnchorTest.CheckAfterScroll(const aView: InevInputView);
 {* Операции после прокрутки }
//#UC START# *4C3C80AF002D_4C3C771A002D_var*
//#UC END# *4C3C80AF002D_4C3C771A002D_var*
begin
//#UC START# *4C3C80AF002D_4C3C771A002D_impl*
 f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView);
//#UC END# *4C3C80AF002D_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.CheckAfterScroll

function TCheckTopAnchorTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TCheckTopAnchorTest.GetFolder

function TCheckTopAnchorTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C771A002D';
end;//TCheckTopAnchorTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
