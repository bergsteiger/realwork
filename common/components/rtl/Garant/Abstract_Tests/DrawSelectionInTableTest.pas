unit DrawSelectionInTableTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/DrawSelectionInTableTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TDrawSelectionInTableTest
//
// Тест для проверки правильности отрисовки выделения в таблице
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextEditorVisitor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(evNeedPainters)}
  ,
  evDelayedPaintersSpy
  {$IfEnd} //evNeedPainters
  ,
  nevTools,
  evCustomEditorWindow,
  Types
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _SelectTablePart_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TDrawSelectionInTableTest = {abstract} class(_SelectTablePart_ {$If defined(evNeedPainters)}, IevDelayedPainterLogger{$IfEnd} //evNeedPainters
 )
  {* Тест для проверки правильности отрисовки выделения в таблице }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
    {$If defined(evNeedPainters)}
   function OpenSelectionLog: AnsiString;
    {$IfEnd} //evNeedPainters
    {$If defined(evNeedPainters)}
   procedure CloseSelectionLog(const aLogName: AnsiString);
    {$IfEnd} //evNeedPainters
 protected
 // overridden protected methods
    {$If defined(nsTest) AND not defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
     {* Стандартный файл для вывода, для текщего теста }
    {$IfEnd} //nsTest AND not NotTunedDUnit
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function NeedSelection: Boolean; override;
     {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TDrawSelectionInTableTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
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

// start class TDrawSelectionInTableTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TDrawSelectionInTableTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4D6F501303E4_var*
//#UC END# *4BE419AF0217_4D6F501303E4_var*
begin
//#UC START# *4BE419AF0217_4D6F501303E4_impl*
 MakeSelection(aForm.Text);
 ScrollByWeel(aForm, 10, False);
 TevDelayedPaintersSpy.Instance.SetLogger(Self);
 try
  aForm.Text.Repaint;
 finally
  TevDelayedPaintersSpy.Instance.RemoveLogger(Self);
 end;
//#UC END# *4BE419AF0217_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

{$If defined(evNeedPainters)}
function TDrawSelectionInTableTest.OpenSelectionLog: AnsiString;
//#UC START# *4D6F66820158_4D6F501303E4_var*
//#UC END# *4D6F66820158_4D6F501303E4_var*
begin
//#UC START# *4D6F66820158_4D6F501303E4_impl*
 Result := FileForOutput;
//#UC END# *4D6F66820158_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.OpenSelectionLog
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
procedure TDrawSelectionInTableTest.CloseSelectionLog(const aLogName: AnsiString);
//#UC START# *4D6F669C0185_4D6F501303E4_var*
//#UC END# *4D6F669C0185_4D6F501303E4_var*
begin
//#UC START# *4D6F669C0185_4D6F501303E4_impl*
 CheckOutputWithInput(ChangeFileExt(ExtractFileName(aLogName), EtalonSuffix + '.selection'));
//#UC END# *4D6F669C0185_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.CloseSelectionLog
{$IfEnd} //evNeedPainters

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
function TDrawSelectionInTableTest.FileForOutput: AnsiString;
//#UC START# *4B4F588B0241_4D6F501303E4_var*
//#UC END# *4B4F588B0241_4D6F501303E4_var*
begin
//#UC START# *4B4F588B0241_4D6F501303E4_impl*
 Result := OutputPath + KPage + '.selection'
//#UC END# *4B4F588B0241_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.FileForOutput
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NoVCM)}
function TDrawSelectionInTableTest.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4D6F501303E4_var*
//#UC END# *4C07AC6F036D_4D6F501303E4_var*
begin
//#UC START# *4C07AC6F036D_4D6F501303E4_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TDrawSelectionInTableTest.FormExtent: TPoint;
//#UC START# *4C08CF700318_4D6F501303E4_var*
//#UC END# *4C08CF700318_4D6F501303E4_var*
begin
//#UC START# *4C08CF700318_4D6F501303E4_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TDrawSelectionInTableTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TDrawSelectionInTableTest.GetFolder

function TDrawSelectionInTableTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4D6F501303E4_var*
//#UC END# *4CC8189D02DF_4D6F501303E4_var*
begin
//#UC START# *4CC8189D02DF_4D6F501303E4_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4D6F501303E4_impl*
end;//TDrawSelectionInTableTest.NeedSelection

function TDrawSelectionInTableTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D6F501303E4';
end;//TDrawSelectionInTableTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.