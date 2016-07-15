unit OfficeLike_Text_Controls;
 {* Операции с текстом }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Text_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Text" MUID: (495127DD017C)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Edit = 'Edit';
 en_capEdit = 'Правка';
 op_Copy = 'Copy';
 op_capCopy = 'Копировать';
 op_Cut = 'Cut';
 op_capCut = 'Вырезать';
 op_FindContext = 'FindContext';
 op_capFindContext = 'Поиск';
 op_FindNext = 'FindNext';
 op_capFindNext = 'Найти далее';
 op_Paste = 'Paste';
 op_capPaste = 'Вставка';
 op_Undo = 'Undo';
 op_capUndo = 'Отмена';
 op_Redo = 'Redo';
 op_capRedo = 'Возврат';
 op_SelectAll = 'SelectAll';
 op_capSelectAll = 'Выделить всё';
 op_Deselect = 'Deselect';
 op_capDeselect = 'Снять выделение';
 op_FindPrev = 'FindPrev';
 op_capFindPrev = '';
 en_Table = 'Table';
 en_capTable = '';
 op_Insert = 'Insert';
 op_capInsert = '';
 op_InsertRow = 'InsertRow';
 op_capInsertRow = '';
 op_DeleteRow = 'DeleteRow';
 op_capDeleteRow = '';
 op_InsertColumn = 'InsertColumn';
 op_capInsertColumn = '';
 op_DeleteColumn = 'DeleteColumn';
 op_capDeleteColumn = '';
 en_Font = 'Font';
 en_capFont = '';
 op_Bold = 'Bold';
 op_capBold = '';
 op_Italic = 'Italic';
 op_capItalic = '';
 op_Underline = 'Underline';
 op_capUnderline = '';
 op_Strikeout = 'Strikeout';
 op_capStrikeout = '';

var opcode_Edit_Copy: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Edit_Copy_AttributesCopy: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Копировать <-> Копировать все атрибуты документа в буфер обмена }
var opcode_Edit_Cut: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_FindContext: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_FindNext: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_Paste: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_Undo: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_Redo: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_SelectAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_Deselect: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edit_FindPrev: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Table_Insert: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Table_InsertRow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Table_DeleteRow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Table_InsertColumn: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Table_DeleteColumn: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Font_Bold: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Font_Italic: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Font_Underline: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Font_Strikeout: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmOperationsForRegister
 , vcmOperationStatesForRegister
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Copy, en_capEdit, op_capCopy, False, False, opcode_Edit_Copy)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('AttributesCopy', st_user_Edit_Copy_AttributesCopy))^ do
  begin
   rCaption := 'Копировать все атрибуты документа в буфер обмена';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Copy, en_capEdit, op_capCopy, False, False, opcode_Edit_Copy)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Cut, en_capEdit, op_capCut, False, False, opcode_Edit_Cut)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_FindContext, en_capEdit, op_capFindContext, False, False, opcode_Edit_FindContext)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_FindNext, en_capEdit, op_capFindNext, False, False, opcode_Edit_FindNext)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Paste, en_capEdit, op_capPaste, False, False, opcode_Edit_Paste)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Undo, en_capEdit, op_capUndo, False, False, opcode_Edit_Undo)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Redo, en_capEdit, op_capRedo, False, False, opcode_Edit_Redo)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_SelectAll, en_capEdit, op_capSelectAll, False, False, opcode_Edit_SelectAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_Deselect, en_capEdit, op_capDeselect, False, False, opcode_Edit_Deselect)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edit, op_FindPrev, en_capEdit, op_capFindPrev, False, False, opcode_Edit_FindPrev)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Table, op_Insert, en_capTable, op_capInsert, False, False, opcode_Table_Insert)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Table, op_InsertRow, en_capTable, op_capInsertRow, False, False, opcode_Table_InsertRow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Table, op_DeleteRow, en_capTable, op_capDeleteRow, False, False, opcode_Table_DeleteRow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Table, op_InsertColumn, en_capTable, op_capInsertColumn, False, False, opcode_Table_InsertColumn)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Table, op_DeleteColumn, en_capTable, op_capDeleteColumn, False, False, opcode_Table_DeleteColumn)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Font, op_Bold, en_capFont, op_capBold, False, False, opcode_Font_Bold)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Font, op_Italic, en_capFont, op_capItalic, False, False, opcode_Font_Italic)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Font, op_Underline, en_capFont, op_capUnderline, False, False, opcode_Font_Underline)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Font, op_Strikeout, en_capFont, op_capStrikeout, False, False, opcode_Font_Strikeout)) do
 begin
 end;

{$IfEnd} // NOT Defined(NoVCM)

end.
