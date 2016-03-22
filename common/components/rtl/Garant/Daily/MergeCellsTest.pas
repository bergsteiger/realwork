unit MergeCellsTest;
 {* Объединение ячеек в таблице. }

// Модуль: "w:\common\components\rtl\Garant\Daily\MergeCellsTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TMergeCellsTest" MUID: (4C123E8103B3)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TMergeCellsTest = {abstract} class(TTableToolsTest)
  {* Объединение ячеек в таблице. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
    {* Вызвать инструмент для таблицы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TMergeCellsTest
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

{$If NOT Defined(NoVCM)}
procedure TMergeCellsTest.ApplyTools(const aRange: IedRange);
 {* Вызвать инструмент для таблицы }
//#UC START# *4C345B580083_4C123E8103B3_var*
//#UC END# *4C345B580083_4C123E8103B3_var*
begin
//#UC START# *4C345B580083_4C123E8103B3_impl*
 aRange.Table.Cells.Merge;
//#UC END# *4C345B580083_4C123E8103B3_impl*
end;//TMergeCellsTest.ApplyTools
{$IfEnd} // NOT Defined(NoVCM)

function TMergeCellsTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TMergeCellsTest.GetFolder

function TMergeCellsTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C123E8103B3';
end;//TMergeCellsTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
