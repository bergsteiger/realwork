unit evStandardActions;

{ Библиотека "Эверест"        }
{ Автор: Люлин А.В. ©         }
{ Модуль: evStandardActions - }
{ Начат: 02.12.1999 15:57     }
{ $Id: evStandardActions.pas,v 1.22 2010/05/26 06:19:30 dinishev Exp $ }

// $Log: evStandardActions.pas,v $
// Revision 1.22  2010/05/26 06:19:30  dinishev
// [$210436129]
//
// Revision 1.21  2009/11/19 12:05:13  dinishev
// [$171968600]
//
// Revision 1.20  2008/08/01 07:07:39  dinishev
// Делаем доступными новые команды для HEAD'а
//
// Revision 1.19  2003/05/10 12:40:16  law
// - cleanup: "изменяемые константы" заменены на обычные константы.
//
// Revision 1.18  2003/05/10 12:28:11  law
// - new behavior: сделана возможность изменять выравнивание по вертикали сразу группе ячеек.
//
// Revision 1.17  2003/01/21 09:52:17  law
// - new standard actions: ev_ccBullet, ev_ccNumber, ev_ccDecIndent, ev_ccIncIndent.
//
// Revision 1.16  2002/09/17 13:03:03  law
// - new standard action: ev_ccWebStyle.
//
// Revision 1.15  2002/07/12 11:05:12  law
// - new actions: ev_ccInsertPageBreak, ev_ccInsertSectionBreak.
//
// Revision 1.14  2002/05/16 06:49:11  law
// - new behavior: удаление слова по Ctrl-Del.
//
// Revision 1.13  2002/01/12 14:55:58  law
// - new operation: ev_ccMergeCellsHorz.
//
// Revision 1.12  2002/01/11 16:02:25  law
// - new operation: ev_ccMergeCellsVert.
//
// Revision 1.11  2001/09/21 09:58:54  law
// - cleanup.
//
// Revision 1.10  2001/09/20 14:24:36  law
// - new behavior: сделана возможность открытия/закрытия блоков определенного уровня.
//
// Revision 1.9  2001/06/08 13:19:36  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.8  2001/05/10 14:22:56  law
// - delete: удалена константа ev_ccVisualFormatting.
//
// Revision 1.7  2001/04/10 14:37:06  law
// - new: добавлены две стандартные операции ev_ccSplitTable и ev_ccMergeTables.
//
// Revision 1.6  2001/01/15 18:39:49  law
// - добавлена обработка свойства k2_tiVerticalAligment для ячеек таблиц.
//
// Revision 1.5  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

type
  TevOperation = (ev_ccNone,
                  ev_ccExtended,
                  {стандартные операции редактирования:}
                  ev_ccUndo,
                  ev_ccRedo,
                  ev_ccDelete,
                  ev_ccCut,
                  ev_ccPaste,
                  ev_ccSpecialPaste,
                  ev_ccInsert,
                  ev_ccCopy,
                  ev_ccAdd,
                  {вставка параграфов:}
                  ev_ccInsertTable,
                  ev_ccInsertSBS,
                  ev_ccInsertSBSMark,
                  {операции с таблицами:}
                  ev_ccInsertRow,
                  ev_ccInsertColumn,
                  ev_ccInsertCells,
                  ev_ccDeleteRow,
                  ev_ccDeleteColumn,
                  ev_ccDeleteCells,
                  ev_ccMergeCells,
                  ev_ccMergeCellsHorz,
                  ev_ccMergeCellsVert,
                  ev_ccSplitCells,
                  ev_ccSplitTable,
                  ev_ccMergeTables,
                  ev_ccVAlignTop,
                  ev_ccVAlignCenter,
                  ev_ccVAlignBottom,
                  ev_ccHSplit,
                  ev_ccVSplit,
                  {операции поиска:}
                  ev_ccSearch,
                  ev_ccSearchAgain,
                  ev_ccReplace,
                  ev_ccSpellcheck,
                  {тип выравнивания:}
                  ev_ccJustifyLeft,
                  ev_ccJustifyRight,
                  ev_ccJustifyCenter,
                  ev_ccJustifyWidth,
                  ev_ccJustifyPreformatted,
                  {атрибуты шрифта:}
                  ev_ccBold,
                  ev_ccItalic,
                  ev_ccUnderline,
                  ev_ccStrikeout,
                  ev_ccSubscript,
                  ev_ccSuperscript,
                  ev_ccVisible,
                  {файловые операции:}
                  ev_ccNew,
                  ev_ccOpen,
                  ev_ccGroup,
                  {операции сохранения:}
                  ev_ccSave,
                  ev_ccSaveAs,
                  ev_ccSaveAll,
                  {печать:}
                  ev_ccPrint,
                  ev_ccPrintEx,
                  {параметры отображения:}
                  ev_ccPrintPreview,
                  ev_ccShowSpecial,
                  ev_ccWebStyle,
                  ev_ccZoom,
                  ev_ccPersistent,
                  ev_ccDrawLines,
                  ev_ccShowDocumentParts,
                  ev_ccShowDocumentPart,
                  {контекстная помощь:}
                  ev_ccHelpContents,
                  ev_ccTopicSearch,
                  ev_ccAbout,
                  ev_ccHelpOnHelp,
                  {операции с выделением:}
                  ev_ccSelectAll,
                  ev_ccSelectPara,
                  ev_ccSelectWord,
                  ev_ccHideSelection,
                  ev_ccBordersAndShade,
                  // разрывы
                  ev_ccInsertPageBreak,
                  ev_ccInsertSectionBreak,
                  // списки
                  ev_ccBullet,
                  ev_ccNumber,
                  ev_ccDecIndent,
                  ev_ccIncIndent,
                  ev_ccAlignWithSeparator,
                  ev_ccOldNSRCTable,
                  ev_ccTranslate2Text
                  );
  TevOperationSet = set of TevOperation;

const
  evJustifyCommands = [ev_ccJustifyLeft .. ev_ccJustifyPreformatted] + [ev_ccAlignWithSeparator];
  evListCommands    = [ev_ccBullet .. ev_ccIncIndent];
  evTableCommands   = [ev_ccInsertRow .. ev_ccVSplit] + [ev_ccAlignWithSeparator .. ev_ccTranslate2Text];
  evBlockCommands   = [ev_ccCut, ev_ccCopy,
                       ev_ccHideSelection, ev_ccAdd];
  evFontCommands    = [ev_ccBold .. ev_ccVisible];
  evSelectCommands  = [ev_ccSelectAll .. ev_ccSelectWord];
  evUndoCommands    = [ev_ccUndo, ev_ccRedo];
  evInsertCommands  = [ev_ccInsertTable .. ev_ccInsertSBSMark];
  evViewCommands    = [ev_ccPrintPreview .. ev_ccShowDocumentPart];
  evPrintCommands   = [ev_ccPrint, ev_ccPrintEx];
  evSaveCommands    = [ev_ccSave .. ev_ccSaveAll];
  evSearchCommands  = [ev_ccSearch .. ev_ccSpellcheck];
  evBreakCommands   = [ev_ccInsertPageBreak, ev_ccInsertSectionBreak];
  evVAlignCommands  = [ev_ccVAlignTop .. ev_ccVAlignBottom];

implementation

end.

