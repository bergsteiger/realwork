unit evFacadeCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// ������: "w:/common/components/gui/Garant/EverestCommon/evFacadeCursor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadeCursor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  evCustomEditor,
  evCustomEditorWindow,
  evCommonTypes
  ;

function EvGetMostInnerPos(anEditor: TevCustomEditorWindow): Integer;
   {* ���������� ������� ������ ����������� ������� }
function EvGetMostInnerEntryPos(anEditor: TevCustomEditorWindow): Integer;
   {* ���������� ������� ������ ����������� ������� ��� ������ ��������� }
function EvCursorInSel(anEditor: TevCustomEditorWindow): Boolean;
   {* �������� ��������� �� ������ � ��������� }
function EvMostInnerCursor(anEditor: TevCustomEditor): TnevBaseCursor;
   {* ���������� ������ ������ ������� ������ }
function EvCloneCursor(anEditor: TevCustomEditor): TnevCursor;
   {* ����������� ������ }
procedure EvFreeCursor(var aCursor: TnevCursor);
   {* ����������� ������/��������� ������� }
procedure EvSelectPoint(anEditor: TevCustomEditor;
  const aCursor: TnevCursor);
function EvGetChildCursor(anEditor: TevCustomEditor;
  const aCursor: TnevBaseCursor): TnevBaseCursor;
   {* ���������� �������� ������ }

implementation

uses
  nevTools
  ;

// unit methods

function EvGetMostInnerPos(anEditor: TevCustomEditorWindow): Integer;
//#UC START# *48EEED050239_48EEE8A503AB_var*
//#UC END# *48EEED050239_48EEE8A503AB_var*
begin
//#UC START# *48EEED050239_48EEE8A503AB_impl*
 Result := anEditor.Selection.Cursor.MostInner.Position;
//#UC END# *48EEED050239_48EEE8A503AB_impl*
end;//EvGetMostInnerPos

function EvGetMostInnerEntryPos(anEditor: TevCustomEditorWindow): Integer;
//#UC START# *48EEED27002F_48EEE8A503AB_var*
//#UC END# *48EEED27002F_48EEE8A503AB_var*
begin
//#UC START# *48EEED27002F_48EEE8A503AB_impl*
 if anEditor.HasSelection then
  Result := anEditor.Selection.Start.MostInner.Position
 else
  Result := anEditor.Selection.Cursor.MostInner.Position;
//#UC END# *48EEED27002F_48EEE8A503AB_impl*
end;//EvGetMostInnerEntryPos

function EvCursorInSel(anEditor: TevCustomEditorWindow): Boolean;
//#UC START# *48EEED52016E_48EEE8A503AB_var*
//#UC END# *48EEED52016E_48EEE8A503AB_var*
begin
//#UC START# *48EEED52016E_48EEE8A503AB_impl*
 Result := InevSelection(anEditor.Selection).Contains(anEditor.Selection.Cursor);
//#UC END# *48EEED52016E_48EEE8A503AB_impl*
end;//EvCursorInSel

function EvMostInnerCursor(anEditor: TevCustomEditor): TnevBaseCursor;
//#UC START# *48EEED730106_48EEE8A503AB_var*
//#UC END# *48EEED730106_48EEE8A503AB_var*
begin
//#UC START# *48EEED730106_48EEE8A503AB_impl*
  Result := anEditor.Selection.Cursor.MostInner;
//#UC END# *48EEED730106_48EEE8A503AB_impl*
end;//EvMostInnerCursor

function EvCloneCursor(anEditor: TevCustomEditor): TnevCursor;
//#UC START# *48EEEDA301B2_48EEE8A503AB_var*
//#UC END# *48EEEDA301B2_48EEE8A503AB_var*
begin
//#UC START# *48EEEDA301B2_48EEE8A503AB_impl*
 Result := anEditor.Selection.Cursor.ClonePoint(anEditor.View);
//#UC END# *48EEEDA301B2_48EEE8A503AB_impl*
end;//EvCloneCursor

procedure EvFreeCursor(var aCursor: TnevCursor);
//#UC START# *48EEEDBC02F0_48EEE8A503AB_var*
//#UC END# *48EEEDBC02F0_48EEE8A503AB_var*
begin
//#UC START# *48EEEDBC02F0_48EEE8A503AB_impl*
 aCursor := nil;
//#UC END# *48EEEDBC02F0_48EEE8A503AB_impl*
end;//EvFreeCursor

procedure EvSelectPoint(anEditor: TevCustomEditor;
  const aCursor: TnevCursor);
//#UC START# *48EEEDD200CA_48EEE8A503AB_var*
//#UC END# *48EEEDD200CA_48EEE8A503AB_var*
begin
//#UC START# *48EEEDD200CA_48EEE8A503AB_impl*
 InevSelection(anEditor.Selection).SelectPoint(aCursor, False);
//#UC END# *48EEEDD200CA_48EEE8A503AB_impl*
end;//EvSelectPoint

function EvGetChildCursor(anEditor: TevCustomEditor;
  const aCursor: TnevBaseCursor): TnevBaseCursor;
//#UC START# *48EEEDE302E0_48EEE8A503AB_var*
//#UC END# *48EEEDE302E0_48EEE8A503AB_var*
begin
//#UC START# *48EEEDE302E0_48EEE8A503AB_impl*
 if aCursor.HasInner then
  Result := aCursor.Inner
 else
  Result := nil;
//#UC END# *48EEEDE302E0_48EEE8A503AB_impl*
end;//EvGetChildCursor

end.