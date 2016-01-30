unit SelectionCellTest;
 {* Тест на выделение ячейки. }

// Модуль: "w:\common\components\rtl\Garant\Daily\SelectionCellTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
;

type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include CursorMover.imp.pas}
 _ClipboardOperations_Parent_ = _CursorMover_;
 {$Include ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include SelectOperation.imp.pas}
 TSelectionCellTest = {abstract} class(_SelectOperation_)
  {* Тест на выделение ячейки. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TSelectionCellTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3Base
 , l3InternalInterfaces
 , evTypes
;

{$Include CursorMover.imp.pas}

{$Include ClipboardOperations.imp.pas}

{$Include SelectOperation.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TSelectionCellTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4D413AD401BD_var*
//#UC END# *4BE13147032C_4D413AD401BD_var*
begin
//#UC START# *4BE13147032C_4D413AD401BD_impl*
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocParaDown);
 SelectPara(aForm.Text);
 CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4BE13147032C_4D413AD401BD_impl*
end;//TSelectionCellTest.Process
{$IfEnd} // NOT Defined(NoVCM)

function TSelectionCellTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TSelectionCellTest.GetFolder

function TSelectionCellTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D413AD401BD';
end;//TSelectionCellTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
