unit SplitCellTest;
 {* Тест разделения ячеек }

// Модуль: "w:\common\components\rtl\Garant\Daily\SplitCellTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _CursorMover_Parent_ = TTableToolsTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TSplitCellTest = {abstract} class(_CursorMover_)
  {* Тест разделения ячеек }
  protected
   function GetLineCount: Integer; virtual;
   function GetTabCount: Integer; virtual;
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function NeedSelection: Boolean; override;
    {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TSplitCellTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

function TSplitCellTest.GetLineCount: Integer;
//#UC START# *4D5A6EE600D3_4D5A63ED011A_var*
//#UC END# *4D5A6EE600D3_4D5A63ED011A_var*
begin
//#UC START# *4D5A6EE600D3_4D5A63ED011A_impl*
 Result := 0;
//#UC END# *4D5A6EE600D3_4D5A63ED011A_impl*
end;//TSplitCellTest.GetLineCount

function TSplitCellTest.GetTabCount: Integer;
//#UC START# *4D5A6F4802CB_4D5A63ED011A_var*
//#UC END# *4D5A6F4802CB_4D5A63ED011A_var*
begin
//#UC START# *4D5A6F4802CB_4D5A63ED011A_impl*
 Result := 0;
//#UC END# *4D5A6F4802CB_4D5A63ED011A_impl*
end;//TSplitCellTest.GetTabCount

{$If NOT Defined(NoVCM)}
procedure TSplitCellTest.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4D5A63ED011A_var*
//#UC END# *4C345B580083_4D5A63ED011A_var*
begin
//#UC START# *4C345B580083_4D5A63ED011A_impl*
 aRange.Table.Cell.Split(1, 2);
//#UC END# *4C345B580083_4D5A63ED011A_impl*
end;//TSplitCellTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TSplitCellTest.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4D5A63ED011A_var*
var
 i : Integer;
//#UC END# *4BE419AF0217_4D5A63ED011A_var*
begin
//#UC START# *4BE419AF0217_4D5A63ED011A_impl*
 for i := 0 to GetLineCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 for i := 0 to GetTabCount do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocColumnRight);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4D5A63ED011A_impl*
end;//TSplitCellTest.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TSplitCellTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TSplitCellTest.GetFolder

function TSplitCellTest.NeedSelection: Boolean;
 {* Нужно ли чего-нибудь выделять. }
//#UC START# *4CC8189D02DF_4D5A63ED011A_var*
//#UC END# *4CC8189D02DF_4D5A63ED011A_var*
begin
//#UC START# *4CC8189D02DF_4D5A63ED011A_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4D5A63ED011A_impl*
end;//TSplitCellTest.NeedSelection

function TSplitCellTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D5A63ED011A';
end;//TSplitCellTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
