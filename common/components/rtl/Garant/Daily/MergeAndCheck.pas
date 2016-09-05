unit MergeAndCheck;
 {* Тест объединения ячеек и сравнения отрисованного }

// Модуль: "w:\common\components\rtl\Garant\Daily\MergeAndCheck.pas"
// Стереотип: "TestCase"
// Элемент модели: "TMergeAndCheck" MUID: (4CC8196F0219)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , DrawTestPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_Parent_ = TDrawTestPrim;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TMergeAndCheck = {abstract} class(_SelectTablePart_)
  {* Тест объединения ячеек и сравнения отрисованного }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoBeforeDrawing(aForm: TPrimTextLoadForm); override;
    {* Произвести какие-нибудь операции перед отрисовкой. }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TMergeAndCheck
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4CC8196F0219impl_uses*
 //#UC END# *4CC8196F0219impl_uses*
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

procedure TMergeAndCheck.DoBeforeDrawing(aForm: TPrimTextLoadForm);
 {* Произвести какие-нибудь операции перед отрисовкой. }
//#UC START# *4CAC45AE011E_4CC8196F0219_var*
//#UC END# *4CAC45AE011E_4CC8196F0219_var*
begin
//#UC START# *4CAC45AE011E_4CC8196F0219_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Table.Cells.Merge;
 aForm.Text.Processor.Undo;
//#UC END# *4CAC45AE011E_4CC8196F0219_impl*
end;//TMergeAndCheck.DoBeforeDrawing

function TMergeAndCheck.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TMergeAndCheck.GetFolder

procedure TMergeAndCheck.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4CC8196F0219_var*
//#UC END# *4CC81D4101AC_4CC8196F0219_var*
begin
//#UC START# *4CC81D4101AC_4CC8196F0219_impl*
 aStartRow := 0;
 aStartCell := 0;
 aFinishRow := 3;
 aFinishCell := 0;
//#UC END# *4CC81D4101AC_4CC8196F0219_impl*
end;//TMergeAndCheck.GetSelectParam

function TMergeAndCheck.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CC8196F0219';
end;//TMergeAndCheck.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
