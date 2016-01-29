unit SelectRowAndDeleteTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/SelectRowAndDeleteTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSelectRowAndDeleteTest
//
// Выделить строку и удалить.
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _SelectTablePart_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TSelectRowAndDeleteTest = {abstract} class(_SelectTablePart_)
  {* Выделить строку и удалить. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function NeedSelection: Boolean; override;
     {* Нужно ли чего-нибудь выделять. }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
     {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TSelectRowAndDeleteTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

// start class TSelectRowAndDeleteTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectRowAndDeleteTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4CE3E5F3012B_var*
//#UC END# *4BE13147032C_4CE3E5F3012B_var*
begin
//#UC START# *4BE13147032C_4CE3E5F3012B_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TSelectRowAndDeleteTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSelectRowAndDeleteTest.GetFolder

function TSelectRowAndDeleteTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4CE3E5F3012B_var*
//#UC END# *4CC8189D02DF_4CE3E5F3012B_var*
begin
//#UC START# *4CC8189D02DF_4CE3E5F3012B_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.NeedSelection

procedure TSelectRowAndDeleteTest.GetSelectParam(out aStartRow: Integer;
  out aStartCell: Integer;
  out aFinishRow: Integer;
  out aFinishCell: Integer);
//#UC START# *4CC81D4101AC_4CE3E5F3012B_var*
//#UC END# *4CC81D4101AC_4CE3E5F3012B_var*
begin
//#UC START# *4CC81D4101AC_4CE3E5F3012B_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 0;
 aFinishCell := 1; 
//#UC END# *4CC81D4101AC_4CE3E5F3012B_impl*
end;//TSelectRowAndDeleteTest.GetSelectParam

function TSelectRowAndDeleteTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE3E5F3012B';
end;//TSelectRowAndDeleteTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.