unit evExtActionsRes;

{ Библиотека "Эверест"      }
{ Автор: Люлин А.В. ©       }
{ Модуль: evExtActionsRes - }
{ Начат: 04.10.2001 11:32   }
{ $Id: evExtActionsRes.pas,v 1.22 2016/10/20 10:15:52 dinishev Exp $ }

// $Log: evExtActionsRes.pas,v $
// Revision 1.22  2016/10/20 10:15:52  dinishev
// {Requestlink:632196336}. Убрал горячие клавиши у кнопок с индексами.
//
// Revision 1.21  2012/11/01 09:41:42  lulin
// - забыл точку с запятой.
//
// Revision 1.20  2012/11/01 07:43:08  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.19  2010/05/26 06:22:19  dinishev
// [$210436129]
//
// Revision 1.18  2010/03/02 09:04:12  dinishev
// Сочетания клавиш для Tools'ов таблиц по просьбе Лапина.
//
// Revision 1.17  2009/11/19 12:05:16  dinishev
// [$171968600]
//
// Revision 1.16  2009/04/08 12:56:39  lulin
// [$142610892]. Вычищаем ненужные контексты.
//
// Revision 1.15  2009/04/08 12:12:34  lulin
// [$142610892]. Пытался собрать Эверест с директивой _Nemesis.
//
// Revision 1.14  2008/08/01 07:07:41  dinishev
// Делаем доступными новые команды для HEAD'а
//
// Revision 1.13  2003/01/21 12:49:47  law
// - new behavior: сделана возможность редактирование списков.
//
// Revision 1.12  2003/01/21 09:52:17  law
// - new standard actions: ev_ccBullet, ev_ccNumber, ev_ccDecIndent, ev_ccIncIndent.
//
// Revision 1.11  2002/10/10 13:21:32  law
// - new action group: ev_giViewMode.
//
// Revision 1.10  2002/09/17 13:03:04  law
// - new standard action: ev_ccWebStyle.
//
// Revision 1.9  2002/07/12 11:05:12  law
// - new actions: ev_ccInsertPageBreak, ev_ccInsertSectionBreak.
//
// Revision 1.8  2002/05/22 11:10:08  law
// no message
//
// Revision 1.7  2002/01/12 14:55:59  law
// - new operation: ev_ccMergeCellsHorz.
//
// Revision 1.6  2002/01/11 16:02:26  law
// - new operation: ev_ccMergeCellsVert.
//
// Revision 1.5  2001/12/28 12:31:07  law
// - new prop: в описание операции добавлено свойство ShortCut.
//
// Revision 1.4  2001/10/10 13:11:21  law
// - new behavior: добавлены GroupIndex по умолчанию.
//
// Revision 1.3  2001/10/04 12:42:36  law
// - new behavior: сделан котнроль за сохранением свойств Category и AutoCheck.
//
// Revision 1.2  2001/10/04 09:52:04  law
// - new behavior: сделана возможность определения парамеров операций по умолчанию.
//
// Revision 1.1  2001/10/04 08:05:53  law
// - new behavior: сделана возмозность определения парамеров операций по умолчанию.
//

{$I evDefine.inc }

interface


implementation

{$IfDef evNeedDisp}

uses
  evStandardActions,
  evExtDisp
  ;

const
  ev_giJustify   = 1;
  ev_giVAlign    = 2;
  ev_giFontIndex = 3;
  ev_giViewMode  = 4;
  ev_giList      = 5;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActionsRes.pas initialization enter'); {$EndIf}

{стандартные операции редактирования:}
evAddOperationDescriptor(ev_ccUndo,         'Отменить', 'Отменить предыдущую операцию', 'Ctrl+Z');
evAddOperationDescriptor(ev_ccRedo,         'Вернуть', 'Вернуть отменненную операцию', 'Shift+Ctrl+Z');
evAddOperationDescriptor(ev_ccDelete,       'Удалить', '', 'Ctrl+Del');
evAddOperationDescriptor(ev_ccCut,          'Вырезать', 'Удалить в буфер обмена', 'Shift+Del');
evAddOperationDescriptor(ev_ccPaste,        'Вставить', 'Вставить из буфера обмена', 'Shift+Ins');
evAddOperationDescriptor(ev_ccSpecialPaste, 'Специальная вставка...', 'Вставить из буфера обмена с выбором формата');
evAddOperationDescriptor(ev_ccInsert,       '', '');
evAddOperationDescriptor(ev_ccCopy,         'Копировать', 'Копировать в буфер обмена', 'Ctrl+Ins');
evAddOperationDescriptor(ev_ccAdd,          'Добавить', 'Добавить в буфер обмена', 'Shift+Ctrl+Ins');
{вставка параграфов:}
evAddOperationDescriptor(ev_ccInsertTable,  'Вставить...', 'Вставить таблицу');
evAddOperationDescriptor(ev_ccInsertSBS,    'Подпись', 'Вставить подпись');
evAddOperationDescriptor(ev_ccInsertSBSMark,'Разделитель', 'Вставить разделитель подписи');
{операции с таблицами:}
evAddOperationDescriptor(ev_ccInsertRow,    'Вставить строку', 'Вставить строку таблицы');
evAddOperationDescriptor(ev_ccInsertColumn, 'Вставить колонку', 'Вставить колонку таблицы');
evAddOperationDescriptor(ev_ccInsertCells,  'Вставить ячейки', 'Вставить ячейки таблицы');
evAddOperationDescriptor(ev_ccDeleteRow,    'Удалить строку', 'Удалить строку таблицы');
evAddOperationDescriptor(ev_ccDeleteColumn, 'Удалить колонку', 'Удалить колонку таблицы');
evAddOperationDescriptor(ev_ccDeleteCells,  'Удалить ячейки', 'Удалить ячейки таблицы');
evAddOperationDescriptor(ev_ccMergeCells,   'Объединить ячейки', 'Объединить ячейки таблицы');
evAddOperationDescriptor(ev_ccMergeCellsHorz, 'Объединить ячейки по горизонтали', 'Объединить ячейки таблицы по горизонтали');
evAddOperationDescriptor(ev_ccMergeCellsVert, 'Объединить ячейки по вертикали', 'Объединить ячейки таблицы по вертикали');
evAddOperationDescriptor(ev_ccSplitCells,   'Разделить ячейки', 'Разделить ячейки таблицы');
evAddOperationDescriptor(ev_ccSplitTable,   'Разделить таблицу', '');
evAddOperationDescriptor(ev_ccMergeTables,  'Объединить таблицы', '');
evAddOperationDescriptor(ev_ccVAlignTop,    'Выравнивание к верху', 'Выровнять содержимое ячейки к верху', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccVAlignCenter, 'Выравнивание по центру', 'Выровнять содержимое ячейки по центру', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccVAlignBottom, 'Выравнивание к низу', 'Выровнять содержимое ячейки к низу', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccHSplit,       'Разделить по горизонтали', 'Разделить ячейку по горизонтали');
evAddOperationDescriptor(ev_ccVSplit,       'Разделить по вертикали', 'Разделить ячейку по вертикали');
evAddOperationDescriptor(ev_ccOldNSRCTable, 'Выливать в псевдографику', 'Выливать в псевдографику');
evAddOperationDescriptor(ev_ccTranslate2Text, 'Преобразовать в текст', 'Преобразовать в текст');
{операции поиска:}
evAddOperationDescriptor(ev_ccSearch,       'Найти...', 'Найти заданный фрагмент', 'Ctrl+F');
evAddOperationDescriptor(ev_ccSearchAgain,  'Повторить поиск', 'Продолжить предыдущий поиск/замену', 'Ctrl+L');
evAddOperationDescriptor(ev_ccReplace,      'Заменить...', 'Найти заданный фрагмент и заменить его на другой', 'Ctrl+R');
evAddOperationDescriptor(ev_ccSpellcheck,   'Проверка орфографии', '', 'F7');
{тип выравнивания:}
evAddOperationDescriptor(ev_ccJustifyLeft,  'Выровнять влево', 'Выровнять параграф влево', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyRight, 'Выровнять вправо', 'Выровнять параграф вправо', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyCenter,'Выровнять по центру', 'Выровнять параграф по центру', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyWidth, 'Выровнять по ширине', 'Выровнять параграф по ширине', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyPreformatted, '"Преформатированный" текст', '', '', true, ev_giJustify);
{атрибуты шрифта:}
evAddOperationDescriptor(ev_ccBold,        'Жирный', 'Жирный текст', 'Ctrl+B', true);
evAddOperationDescriptor(ev_ccItalic,      'Курсив', 'Текст курсивом', 'Ctrl+I', true);
evAddOperationDescriptor(ev_ccUnderline,   'Подчеркнутый', 'Подчеркнутый текст', 'Ctrl+U', true);
evAddOperationDescriptor(ev_ccStrikeout,   'Перечеркнутый', 'Перечеркнутый текст', '', true);
{$IFDEF Archi}
evAddOperationDescriptor(ev_ccSubscript,   'Нижний индекс', '', '', true, ev_giFontIndex);
evAddOperationDescriptor(ev_ccSuperscript, 'Верхний индекс', '', '', true, ev_giFontIndex);
{$ELSE}
evAddOperationDescriptor(ev_ccSubscript,   'Нижний индекс', '', 'Shift+Ctrl+=', true, ev_giFontIndex);
evAddOperationDescriptor(ev_ccSuperscript, 'Верхний индекс', '', 'Ctrl+=', true, ev_giFontIndex);
{$ENDIF}
evAddOperationDescriptor(ev_ccVisible,     'Видимый', 'Видимый текст', '', true);
{файловые операции:}
evAddOperationDescriptor(ev_ccNew,   'Новый', 'Создать новый документ', 'Ctrl+N');
{$IFDEF EverestLite}
evAddOperationDescriptor(ev_ccOpen,  'Открыть...', 'Открыть документ', '');
{$ELSE}
evAddOperationDescriptor(ev_ccOpen,  'Открыть...', 'Открыть документ', 'Ctrl+O');
{$ENDIF EverestLite}
evAddOperationDescriptor(ev_ccGroup, 'Групповые операции', 'Операции с группой документов');
{операции сохранения:}
evAddOperationDescriptor(ev_ccSave,    'Сохранить', 'Сохранить документ', 'Ctrl+S');
evAddOperationDescriptor(ev_ccSaveAs,  'Сохранить как...', 'Сохранить документ под другим именем');
evAddOperationDescriptor(ev_ccSaveAll, 'Сохранить все', 'Сохранить все документы');
{печать:}
evAddOperationDescriptor(ev_ccPrint,   'Печать', '', 'Ctrl+P');
evAddOperationDescriptor(ev_ccPrintEx, 'Печать...', 'Печать с выбором настроек');
{параметры отображения:}
evAddOperationDescriptor(ev_ccPrintPreview,      'По принтеру', 'Форматировать по метрикам принтера', '', true, ev_giViewMode);
evAddOperationDescriptor(ev_ccShowSpecial,       'Спецсимволы', 'Показывать спецсимволы', '', true);
evAddOperationDescriptor(ev_ccZoom,              'Масштаб', '');
evAddOperationDescriptor(ev_ccPersistent,        'Persistent', 'Persistent-выделение', '', true);
evAddOperationDescriptor(ev_ccWebStyle,          'Web-стиль', 'Web-стиль отображения', '', true, ev_giViewMode);
evAddOperationDescriptor(ev_ccDrawLines,         'Рисование', 'Рисование линий', '', true);
evAddOperationDescriptor(ev_ccShowDocumentParts, 'Структура документа', 'Показывать структуру документа', '', true);
evAddOperationDescriptor(ev_ccShowDocumentPart,  'Блок уровня', 'Показать блоки уровня', '', true);
{контекстная помощь:}
evAddOperationDescriptor(ev_ccHelpContents, 'Содержание', 'Содержание справки');
evAddOperationDescriptor(ev_ccTopicSearch,  'Поиск', 'Поиск по индексу');
evAddOperationDescriptor(ev_ccAbout,        'О программе', 'Справка о программе');
evAddOperationDescriptor(ev_ccHelpOnHelp,   'Справка по справке', '');
{операции с выделением:}
evAddOperationDescriptor(ev_ccSelectAll,       'Выделить все', '', 'Ctrl+A');
evAddOperationDescriptor(ev_ccSelectPara,      'Выделить параграф', '');
evAddOperationDescriptor(ev_ccSelectWord,      'Выделить слово', '');
evAddOperationDescriptor(ev_ccHideSelection,   'Снять выделение', '', 'Shift+Ctrl+A');
evAddOperationDescriptor(ev_ccBordersAndShade, 'Границы и заливка...', '');
// разрывы
evAddOperationDescriptor(ev_ccInsertPageBreak, 'Разрыв страницы', '', 'Shift+Enter');
evAddOperationDescriptor(ev_ccInsertSectionBreak, 'Разрыв раздела', '', 'Shift+Ctrl+Enter');
// списки
evAddOperationDescriptor(ev_ccBullet, 'Список', '', '', true, ev_giList);
evAddOperationDescriptor(ev_ccNumber, 'Нумерация', '', '', true, ev_giList);
evAddOperationDescriptor(ev_ccDecIndent, 'Уменьшить отступ', '', '');
evAddOperationDescriptor(ev_ccIncIndent, 'Увеличить отступ', '', '');
evAddOperationDescriptor(ev_ccAlignWithSeparator, 'По разделителю', 'Выравнивание текста в ячейках по разделителю', '', true);
{$EndIf evNeedDisp}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActionsRes.pas initialization leave'); {$EndIf}
end.

