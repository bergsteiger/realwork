unit ScrollerParamsTestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/ScrollerParamsTestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TScrollerParamsTestPrim
//
// Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextViaEditorProcessorWithExternalSave,
  l3Filer
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TScrollerParamsTestPrim = {abstract} class(TTextViaEditorProcessorWithExternalSave)
  {* Тесты для провкрки параметров скроллера при прокрутке и переходе по сабам документа. }
 protected
 // realized methods
   procedure DoSave(aForm: TPrimTextLoadForm;
     aFiler: Tl3CustomFiler); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
    {$If defined(nsTest) AND not defined(NoVCM)}
   function EtalonFileExtension: AnsiString; override;
     {* Расширение эталонного файла }
    {$IfEnd} //nsTest AND not NoVCM
    {$If defined(nsTest) AND not defined(NoVCM)}
   function HeaderBegin: AnsiChar; override;
    {$IfEnd} //nsTest AND not NoVCM
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollerParamsTestPrim
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TScrollerParamsTestPrim

procedure TScrollerParamsTestPrim.DoSave(aForm: TPrimTextLoadForm;
  aFiler: Tl3CustomFiler);
//#UC START# *4D0771F102B6_4D720B6900FC_var*
//#UC END# *4D0771F102B6_4D720B6900FC_var*
begin
//#UC START# *4D0771F102B6_4D720B6900FC_impl*
 with aForm.Text do
 begin
  with View.Scroller[True] do
  begin
   aFiler.WriteLn('Min = ' + IntToStr(Min));
   aFiler.WriteLn('Max = ' + IntToStr(Max));
   aFiler.WriteLn('Pos = ' + IntToStr(Pos));
   //aFiler.WriteLn('Page = ' + IntToStr(Page));
  end;//with TextSource.DocumentContainer
 end;//with aForm.Text
//#UC END# *4D0771F102B6_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.DoSave

function TScrollerParamsTestPrim.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TScrollerParamsTestPrim.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
function TScrollerParamsTestPrim.EtalonFileExtension: AnsiString;
//#UC START# *4D0769150130_4D720B6900FC_var*
//#UC END# *4D0769150130_4D720B6900FC_var*
begin
//#UC START# *4D0769150130_4D720B6900FC_impl*
 Result := 'scroll';
//#UC END# *4D0769150130_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.EtalonFileExtension
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TScrollerParamsTestPrim.HeaderBegin: AnsiChar;
//#UC START# *4D07693F0262_4D720B6900FC_var*
//#UC END# *4D07693F0262_4D720B6900FC_var*
begin
//#UC START# *4D07693F0262_4D720B6900FC_impl*
 Result := #0;
//#UC END# *4D07693F0262_4D720B6900FC_impl*
end;//TScrollerParamsTestPrim.HeaderBegin
{$IfEnd} //nsTest AND not NoVCM

function TScrollerParamsTestPrim.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D720B6900FC';
end;//TScrollerParamsTestPrim.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.