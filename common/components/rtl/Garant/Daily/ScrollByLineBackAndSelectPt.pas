unit ScrollByLineBackAndSelectPt;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/ScrollByLineBackAndSelectPt.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TScrollByLineBackAndSelectPt
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
 TScrollByLineBackAndSelectPt = {abstract} class(TScrollAndSelectPtTest)
 private
 // private fields
   f_PrevAnchor : InevBasePoint;
 protected
 // overridden protected methods
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
   function NeedScrollUp: Boolean; override;
   function NeedScrollByLine: Boolean; override;
 end;//TScrollByLineBackAndSelectPt
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

// start class TScrollByLineBackAndSelectPt

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TScrollByLineBackAndSelectPt.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4E44C60E0060_var*
//#UC END# *4BE419AF0217_4E44C60E0060_var*
begin
//#UC START# *4BE419AF0217_4E44C60E0060_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.View.TopAnchor.Diff(aForm.Text.View, f_PrevAnchor, aForm.Text.View.RootFormatInfo) < 0, 'Не сместились вверх при установке курсора!');
 f_PrevAnchor := nil;
//#UC END# *4BE419AF0217_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.DoVisit
{$IfEnd} //nsTest AND not NoVCM

procedure TScrollByLineBackAndSelectPt.CheckAfterScroll(const aView: InevInputView);
//#UC START# *4C3C80AF002D_4E44C60E0060_var*
//#UC END# *4C3C80AF002D_4E44C60E0060_var*
begin
//#UC START# *4C3C80AF002D_4E44C60E0060_impl*
 f_PrevAnchor := aView.TopAnchor.ClonePoint(aView);
//#UC END# *4C3C80AF002D_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.CheckAfterScroll

function TScrollByLineBackAndSelectPt.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollByLineBackAndSelectPt.GetFolder

function TScrollByLineBackAndSelectPt.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E44C60E0060';
end;//TScrollByLineBackAndSelectPt.GetModelElementGUID

function TScrollByLineBackAndSelectPt.NeedScrollUp: Boolean;
//#UC START# *4E44C98700AE_4E44C60E0060_var*
//#UC END# *4E44C98700AE_4E44C60E0060_var*
begin
//#UC START# *4E44C98700AE_4E44C60E0060_impl*
 Result := True;
//#UC END# *4E44C98700AE_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.NeedScrollUp

function TScrollByLineBackAndSelectPt.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4E44C60E0060_var*
//#UC END# *4E44C9B00324_4E44C60E0060_var*
begin
//#UC START# *4E44C9B00324_4E44C60E0060_impl*
 Result := True;
//#UC END# *4E44C9B00324_4E44C60E0060_impl*
end;//TScrollByLineBackAndSelectPt.NeedScrollByLine

{$IfEnd} //nsTest AND not NoScripts

end.