unit MergeCellsTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/MergeCellsTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMergeCellsTest
//
// Объединение ячеек в таблице.
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
  TableToolsTest,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TMergeCellsTest = {abstract} class(TTableToolsTest)
  {* Объединение ячеек в таблице. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* Вызвать инструмент для таблицы }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TMergeCellsTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
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

// start class TMergeCellsTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TMergeCellsTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C123E8103B3_var*
//#UC END# *4C345B580083_4C123E8103B3_var*
begin
//#UC START# *4C345B580083_4C123E8103B3_impl*
 aRange.Table.Cells.Merge;
//#UC END# *4C345B580083_4C123E8103B3_impl*
end;//TMergeCellsTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TMergeCellsTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMergeCellsTest.GetFolder

function TMergeCellsTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C123E8103B3';
end;//TMergeCellsTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.