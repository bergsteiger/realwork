unit CheckTopAnchorTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/CheckTopAnchorTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TCheckTopAnchorTest
//
// Тест для выбора точки после прокрутки и проверки изменился ли TopAnchor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools,
  ScrollAndSelectPtTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TCheckTopAnchorTest = {abstract} class(TScrollAndSelectPtTest)
  {* Тест для выбора точки после прокрутки и проверки изменился ли TopAnchor }
 private
 // private fields
   f_PrevTopAnchor : InevBasePoint;
    {* Предыдущее значение TopAnchor'а.}
 protected
 // overridden protected methods
   procedure Cleanup; override;
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   procedure CheckAfterScroll(const aView: InevInputView); override;
     {* Операции после прокрутки }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TCheckTopAnchorTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TCheckTopAnchorTest

procedure TCheckTopAnchorTest.Cleanup;
//#UC START# *4B2F40FD0088_4C3C771A002D_var*
//#UC END# *4B2F40FD0088_4C3C771A002D_var*
begin
//#UC START# *4B2F40FD0088_4C3C771A002D_impl*
 f_PrevTopAnchor := nil;
 inherited;
//#UC END# *4B2F40FD0088_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.Cleanup

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TCheckTopAnchorTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C3C771A002D_var*
//#UC END# *4BE419AF0217_4C3C771A002D_var*
begin
//#UC START# *4BE419AF0217_4C3C771A002D_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.View.TopAnchor.Diff(aForm.Text.View, f_PrevTopAnchor, aForm.Text.View.RootFormatInfo) = 0, 'Сместились вверх при установке курсора!');
//#UC END# *4BE419AF0217_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

procedure TCheckTopAnchorTest.CheckAfterScroll(const aView: InevInputView);
//#UC START# *4C3C80AF002D_4C3C771A002D_var*
//#UC END# *4C3C80AF002D_4C3C771A002D_var*
begin
//#UC START# *4C3C80AF002D_4C3C771A002D_impl*
 f_PrevTopAnchor := aView.TopAnchor.ClonePoint(aView);
//#UC END# *4C3C80AF002D_4C3C771A002D_impl*
end;//TCheckTopAnchorTest.CheckAfterScroll

function TCheckTopAnchorTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TCheckTopAnchorTest.GetFolder

function TCheckTopAnchorTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C771A002D';
end;//TCheckTopAnchorTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.