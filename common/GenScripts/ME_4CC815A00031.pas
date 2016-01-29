unit SelectTablePart.imp;

interface

uses
 l3IntfUses
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_ = class
  {* Выделить часть таблицы }
  procedure MakeSelection(aText: TevCustomEditorWindow);
   {* Выделить по заданным параметрам. }
  function GetSelection(const aView: InevView;
   const aTable: InevPara): InevRange;
   {* Получить выделение по заданным "координатам". }
  function NeedSelection: Boolean;
   {* Нужно ли чего-нибудь выделять. }
  function GetTablePara(const aDocument: InevParaList): InevParaList;
   {* Возвращает параграф с таблицей }
  procedure GetSelectParam(out aStartRow: Integer;
   out aStartCell: Integer;
   out aFinishRow: Integer;
   out aFinishCell: Integer);
   {* Получить "координаты" точек выделения. }
  function SelectColumn(var aColID: Integer): Boolean;
   {* Выделить колонку aColID }
  function SelectTableWholly: Boolean;
   {* Вылять таблицу целиком }
 end;//_SelectTablePart_
 
implementation

uses
 l3ImplUses
 , evOp
 , evCursorTools
;

end.
