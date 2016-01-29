unit SelectTablePart.imp;

interface

uses
 l3IntfUses
 , nevTools
 , evCustomEditorWindow
;

type
 _SelectTablePart_ = class
  {* �������� ����� ������� }
  procedure MakeSelection(aText: TevCustomEditorWindow);
   {* �������� �� �������� ����������. }
  function GetSelection(const aView: InevView;
   const aTable: InevPara): InevRange;
   {* �������� ��������� �� �������� "�����������". }
  function NeedSelection: Boolean;
   {* ����� �� ����-������ ��������. }
  function GetTablePara(const aDocument: InevParaList): InevParaList;
   {* ���������� �������� � �������� }
  procedure GetSelectParam(out aStartRow: Integer;
   out aStartCell: Integer;
   out aFinishRow: Integer;
   out aFinishCell: Integer);
   {* �������� "����������" ����� ���������. }
  function SelectColumn(var aColID: Integer): Boolean;
   {* �������� ������� aColID }
  function SelectTableWholly: Boolean;
   {* ������ ������� ������� }
 end;//_SelectTablePart_
 
implementation

uses
 l3ImplUses
 , evOp
 , evCursorTools
;

end.
