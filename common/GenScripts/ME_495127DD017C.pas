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

var st_user_Edit_Copy_AttributesCopy: TvcmOperationStateIndex = (rID : -1);
 {* Правка -> Копировать <-> Копировать все атрибуты документа в буфер обмена }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
