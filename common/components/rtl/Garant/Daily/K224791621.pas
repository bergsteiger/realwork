unit K224791621;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K224791621.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224791621
//
// [$224791621]
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
  MergeTablesTest,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK224791621 = class(TMergeTablesTest)
  {* [$224791621] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* Вызвать инструмент для таблицы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK224791621
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

// start class TK224791621

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK224791621.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C3AF95C00C5_var*
var
 i             : Integer;
 l_Table       : IedTable;
 l_Row         : IedRow;
 l_RowIterator : IedRowsIterator;
 l_OldRowCount : Integer;
//#UC END# *4C345B580083_4C3AF95C00C5_var*
begin
//#UC START# *4C345B580083_4C3AF95C00C5_impl*
 l_Table := aRange.Table;
 l_OldRowCount := l_Table.RowCount;
 inherited ApplyTools(aRange);
 l_RowIterator := l_Table.RowsIterator;
 l_RowIterator.First;
 for i := 0 to l_OldRowCount + 1 do
  l_Row := l_RowIterator.Next;
 CheckTrue(l_Row.CellsIterator.CellsCount = 3, 'В строках таблицы должно быть по три ячейки!');
//#UC END# *4C345B580083_4C3AF95C00C5_impl*
end;//TK224791621.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TK224791621.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224791621.GetFolder

function TK224791621.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3AF95C00C5';
end;//TK224791621.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224791621.Suite);

end.