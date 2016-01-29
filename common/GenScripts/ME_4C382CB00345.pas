unit TableSelectTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TTableSelectTest = class(TTextEditorVisitor)
  {* Базовый тест для работы с выделением таблицы }
  function GetTablePara(const aDocument: InevParaList): InevParaList;
   {* Возвращает параграф с таблицей }
  function SelectColumn(var aColID: Integer): Boolean;
   {* Выделить колонку aColID }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TTableSelectTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , evOp
 , TestFrameWork
;

end.
