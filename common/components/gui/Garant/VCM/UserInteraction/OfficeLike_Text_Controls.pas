unit OfficeLike_Text_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "UserInteraction"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLike_Text_Controls.pas"
// Начат: 23.12.2008 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi Operations::OfficeLike::UserInteraction::Text
//
// Операции с текстом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces {a}
  ;

(* Edit = operations
  {* Правка }
   ['{F11F5205-DECD-4098-9BFF-FB6CFACEEE98}']
   operation Copy; has states;
     {* Копировать }
      AttributesCopy = state
       { Копировать все атрибуты документа в буфер обмена }
      end;//AttributesCopy
   operation Copy;
     {* Копировать }
   operation Cut;
     {* Вырезать }
   operation FindContext;
     {* Поиск }
   operation FindNext;
     {* Найти далее }
   operation Paste;
     {* Вставка }
   operation Undo;
     {* Отмена }
   operation Redo;
     {* Возврат }
   operation SelectAll;
     {* Выделить всё }
   operation Deselect;
     {* Снять выделение }
   operation FindPrev;
 end;//Edit*)

(* Table = operations
   ['{1FF548BA-77F9-43C5-A21E-3DE177AA719E}']
   operation Insert;
   operation InsertRow;
   operation DeleteRow;
   operation InsertColumn;
   operation DeleteColumn;
 end;//Table*)

(* Font = operations
   ['{70A33F9C-A0BE-4E6A-8541-6CA05D812821}']
   operation Bold;
   operation Italic;
   operation Underline;
   operation Strikeout;
 end;//Font*)
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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

// Состояния операций:
var st_user_Edit_Copy_AttributesCopy : TvcmOperationStateIndex = (rID : -1);
  // Правка -> Копировать <-> Копировать все атрибуты документа в буфер обмена
{$IfEnd} //not NoVCM

implementation

end.