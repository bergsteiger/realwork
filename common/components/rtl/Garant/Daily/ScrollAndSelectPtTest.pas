unit ScrollAndSelectPtTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollAndSelectPtTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollAndSelectPtTest
//
// тесты вида - загрузили, прокрутили и ткнули
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
  SelectPtTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TScrollAndSelectPtTest = {abstract} class(TSelectPtTest)
  {* тесты вида - загрузили, прокрутили и ткнули }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function NeedScrollUp: Boolean; virtual;
   function NeedScrollByLine: Boolean; virtual;
   function GetScrollCount: Integer; virtual;
   procedure CheckAfterScroll(const aView: InevInputView); virtual;
     {* Операции после прокрутки }
 end;//TScrollAndSelectPtTest
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

// start class TScrollAndSelectPtTest

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
//#UC START# *4C3C80AF002D_4BFE38A8006A_var*
//#UC END# *4C3C80AF002D_4BFE38A8006A_var*
begin
//#UC START# *4C3C80AF002D_4BFE38A8006A_impl*
//#UC END# *4C3C80AF002D_4BFE38A8006A_impl*
end;//TScrollAndSelectPtTest.CheckAfterScroll

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollAndSelectPtTest.DoVisit(aForm: TPrimTextLoadForm);
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
{$IfEnd} //nsTest AND not NoVCM

function TScrollAndSelectPtTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollAndSelectPtTest.GetFolder

function TScrollAndSelectPtTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BFE38A8006A';
end;//TScrollAndSelectPtTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.