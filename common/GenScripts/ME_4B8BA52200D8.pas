unit nevInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки TnevMiscMessages }
 str_nevmmSaveText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSaveText'; rValue : 'Сохранение текста');
  {* 'Сохранение текста' }
 str_nevmmSaveFormattedText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSaveFormattedText'; rValue : 'Сохранение текста в формате "%s"');
  {* 'Сохранение текста в формате "%s"' }
 str_nevmmReference: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmReference'; rValue : 'Справка: %s');
  {* 'Справка: %s' }
 str_nevmmPageCounter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmPageCounter'; rValue : 'Страница %d из %d');
  {* 'Страница %d из %d' }
 str_nevmmDocumentCount: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmDocumentCount'; rValue : 'Документ %d из %d');
  {* 'Документ %d из %d' }
 str_nevmmDocumentCountInt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmDocumentCountInt'; rValue : 'Документ %d из %d, выделено %d');
  {* 'Документ %d из %d, выделено %d' }
 str_nevmmComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmComment'; rValue : ' Мой комментарий ');
  {* ' Мой комментарий ' }
 str_nevmmReplace: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmReplace'; rValue : 'Замена');
  {* 'Замена' }
 str_nevmmFragment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmFragment'; rValue : '%s (фрагмент)');
  {* '%s (фрагмент)' }
 str_nevmmSearch: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSearch'; rValue : 'Поиск');
  {* 'Поиск' }
 str_nevmmLongOperation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmLongOperation'; rValue : 'Выполняется длительная операция...');
  {* 'Выполняется длительная операция...' }
 str_nevmmCommentFolder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmCommentFolder'; rValue : ' Мой комментарий ');
  {* ' Мой комментарий ' }
 str_nevmmAnnotation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmAnnotation'; rValue : 'Аннотация: %s');
  {* 'Аннотация: %s' }
 str_nevmmChronology: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmChronology'; rValue : 'Хронология судебного дела: %s');
  {* 'Хронология судебного дела: %s' }
 str_nevmmTranslation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmTranslation'; rValue : 'Перевод: %s');
  {* 'Перевод: %s' }
 str_nevmmJurorComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmJurorComment'; rValue : ' Комментарий ГАРАНТа ');
  {* ' Комментарий ГАРАНТа ' }
 str_nevmmJurorCommentDecorate: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmJurorCommentDecorate'; rValue : 'Комментарий ГАРАНТа');
  {* 'Комментарий ГАРАНТа' }
 str_nevmmTOC: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmTOC'; rValue : 'Оглавление');
  {* 'Оглавление' }
 str_nevmmPageCounterNew: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmPageCounterNew'; rValue : 'Объем распечатки в листах: %d');
  {* 'Объем распечатки в листах: %d' }
 {* Локализуемые строки TnevTextFormats }
 str_nevtfANSI: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfANSI'; rValue : 'ANSI-текст');
  {* 'ANSI-текст' }
 str_nevtfUnicode: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfUnicode'; rValue : 'Unicode-текст');
  {* 'Unicode-текст' }
 str_nevtfOEM: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfOEM'; rValue : 'OEM-текст');
  {* 'OEM-текст' }
 {$If Defined(evMyEditor)}
 str_nevtfThyEditor: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfThyEditor'; rValue : 'Моего редактора');
  {* 'Моего редактора' }
 {$IfEnd} // Defined(evMyEditor)
 {$If Defined(Nemesis)}
 str_nevtfGarant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfGarant'; rValue : 'Документ ГАРАНТа');
  {* 'Документ ГАРАНТа' }
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 str_nevtfEverestBin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfEverestBin'; rValue : 'Эверест (binary)');
  {* 'Эверест (binary)' }
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 str_nevtfEverest: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfEverest'; rValue : 'Эверест');
  {* 'Эверест' }
 {$IfEnd} // NOT Defined(Nemesis)
 str_nevtfRtf: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfRtf'; rValue : 'RTF');
  {* 'RTF' }
 {* Локализуемые строки TnevPrintMessages }
 str_nevpmTimeLeft: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmTimeLeft'; rValue : ', %d секунд осталось');
  {* ', %d секунд осталось' }
 str_nevpmCounting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmCounting'; rValue : 'Подсчет числа страниц... %d (~%d)');
  {* 'Подсчет числа страниц... %d (~%d)' }
 str_nevpmPreparing: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPreparing'; rValue : 'Подготовка просмотра печати... %d страниц подготовлено');
  {* 'Подготовка просмотра печати... %d страниц подготовлено' }
 str_nevpmPreparingExt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPreparingExt'; rValue : 'Подготовка просмотра печати... %d страниц из %s%d подготовлено');
  {* 'Подготовка просмотра печати... %d страниц из %s%d подготовлено' }
 str_nevpmPrinting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPrinting'; rValue : 'Печать документа');
  {* 'Печать документа' }
 str_nevpmDocumentList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmDocumentList'; rValue : 'Список документов');
  {* 'Список документов' }
 str_nevpmDefaultColontitul: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmDefaultColontitul'; rValue : '%s Страниц: %s Напечатан: %s');
  {* '%s Страниц: %s Напечатан: %s' }
 str_nevpmUndefinedSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmUndefinedSize'; rValue : 'Не определен');
  {* 'Не определен' }
 str_nevpmUndefinedTopic: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmUndefinedTopic'; rValue : 'Не определен');
  {* 'Не определен' }
 str_nevpmProcessText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmProcessText'; rValue : 'Обработка текста');
  {* 'Обработка текста' }
 str_nevpmProcessPreview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmProcessPreview'; rValue : 'Обработка просмотра печати');
  {* 'Обработка просмотра печати' }
 {* Локализуемые строки TnevCommentParaHint }
 str_nevcphExpand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphExpand'; rValue : 'Развернуть комментарий');
  {* 'Развернуть комментарий' }
 str_nevcphCollapse: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphCollapse'; rValue : 'Свернуть комментарий');
  {* 'Свернуть комментарий' }
 str_nevcphSelect: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphSelect'; rValue : 'Выделить комментарий');
  {* 'Выделить комментарий' }
 str_nevcphMove: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphMove'; rValue : 'Переместить комментарий');
  {* 'Переместить комментарий' }
 str_nevcphChangeTopBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphChangeTopBorder'; rValue : 'Изменить верхнюю границу комментария');
  {* 'Изменить верхнюю границу комментария' }
 str_nevcphChangeBottomBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphChangeBottomBorder'; rValue : 'Изменить нижнюю границу комментария');
  {* 'Изменить нижнюю границу комментария' }
 str_nevcphProperties: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphProperties'; rValue : 'Свойства комментария');
  {* 'Свойства комментария' }
 {* Локализуемые строки TnevMemoContextMenu }
 str_nevmcmUndo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmUndo'; rValue : 'Отменить');
  {* 'Отменить' }
 str_nevmcmCut: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmCut'; rValue : 'Вырезать');
  {* 'Вырезать' }
 str_nevmcmCopy: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmCopy'; rValue : 'Копировать');
  {* 'Копировать' }
 str_nevmcmPaste: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmPaste'; rValue : 'Вставить');
  {* 'Вставить' }
 str_nevmcmDelete: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmDelete'; rValue : 'Удалить');
  {* 'Удалить' }
 {* Локализуемые строки TnevDocumentPartHint }
 str_nevdphExpand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphExpand'; rValue : 'Развернуть блок');
  {* 'Развернуть блок' }
 str_nevdphCollapse: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphCollapse'; rValue : 'Свернуть блок');
  {* 'Свернуть блок' }
 str_nevdphSelect: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphSelect'; rValue : 'Выделить блок');
  {* 'Выделить блок' }
 str_nevdphMove: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphMove'; rValue : 'Переместить блок');
  {* 'Переместить блок' }
 str_nevdphChangeTopBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphChangeTopBorder'; rValue : 'Изменить верхнюю границу блока');
  {* 'Изменить верхнюю границу блока' }
 str_nevdphChangeBottomBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphChangeBottomBorder'; rValue : 'Изменить нижнюю границу блока');
  {* 'Изменить нижнюю границу блока' }
 str_nevdphProperties: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphProperties'; rValue : 'Свойства блока');
  {* 'Свойства блока' }
 {* Локализуемые строки TnevMiscHotspotHints }
 str_nevmhhBlockParams: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhBlockParams'; rValue : 'Параметры раздела.');
  {* 'Параметры раздела.' }
 str_nevmhhTableCell: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableCell'; rValue : 'Ячейка таблицы');
  {* 'Ячейка таблицы' }
 str_nevmhhTableSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableSize'; rValue : 'Размер таблицы');
  {* 'Размер таблицы' }
 str_nevmhhColumnSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhColumnSize'; rValue : 'Размер столбца');
  {* 'Размер столбца' }
 str_nevmhhTableColumn: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableColumn'; rValue : 'Колонка таблицы');
  {* 'Колонка таблицы' }
 str_nevmhhTableRow: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableRow'; rValue : 'Строка таблицы');
  {* 'Строка таблицы' }
 str_nevmhhLeftHyperlinkBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhLeftHyperlinkBorder'; rValue : 'Левая граница ссылки');
  {* 'Левая граница ссылки' }
 str_nevmhhRightHyperlinkBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhRightHyperlinkBorder'; rValue : 'Правая граница ссылки');
  {* 'Правая граница ссылки' }
 {* Локализуемые строки TnevMarkerHint }
 str_nevmhLeftIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhLeftIndent'; rValue : 'Левый отступ');
  {* 'Левый отступ' }
 str_nevmhRightIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRightIndent'; rValue : 'Правый отступ');
  {* 'Правый отступ' }
 str_nevmhRedLineIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRedLineIndent'; rValue : 'Отступ красной строки');
  {* 'Отступ красной строки' }
 str_nevmhCellSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhCellSize'; rValue : 'Размер ячейки');
  {* 'Размер ячейки' }
 str_nevmhTableIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhTableIndent'; rValue : 'Отступ таблицы');
  {* 'Отступ таблицы' }
 str_nevmhPaperSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhPaperSize'; rValue : 'Размер бумаги');
  {* 'Размер бумаги' }
 str_nevmhLeftDocMargin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhLeftDocMargin'; rValue : 'Левое поле');
  {* 'Левое поле' }
 str_nevmhRightDocMargin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRightDocMargin'; rValue : 'Правое поле');
  {* 'Правое поле' }
 str_nevmhTabIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhTabIndent'; rValue : 'По разделителю');
  {* 'По разделителю' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_nevmmSaveText.Init;
 {* Инициализация str_nevmmSaveText }
 str_nevmmSaveFormattedText.Init;
 {* Инициализация str_nevmmSaveFormattedText }
 str_nevmmReference.Init;
 {* Инициализация str_nevmmReference }
 str_nevmmPageCounter.Init;
 {* Инициализация str_nevmmPageCounter }
 str_nevmmDocumentCount.Init;
 {* Инициализация str_nevmmDocumentCount }
 str_nevmmDocumentCountInt.Init;
 {* Инициализация str_nevmmDocumentCountInt }
 str_nevmmComment.Init;
 {* Инициализация str_nevmmComment }
 str_nevmmReplace.Init;
 {* Инициализация str_nevmmReplace }
 str_nevmmFragment.Init;
 {* Инициализация str_nevmmFragment }
 str_nevmmSearch.Init;
 {* Инициализация str_nevmmSearch }
 str_nevmmLongOperation.Init;
 {* Инициализация str_nevmmLongOperation }
 str_nevmmCommentFolder.Init;
 {* Инициализация str_nevmmCommentFolder }
 str_nevmmAnnotation.Init;
 {* Инициализация str_nevmmAnnotation }
 str_nevmmChronology.Init;
 {* Инициализация str_nevmmChronology }
 str_nevmmTranslation.Init;
 {* Инициализация str_nevmmTranslation }
 str_nevmmJurorComment.Init;
 {* Инициализация str_nevmmJurorComment }
 str_nevmmJurorCommentDecorate.Init;
 {* Инициализация str_nevmmJurorCommentDecorate }
 str_nevmmTOC.Init;
 {* Инициализация str_nevmmTOC }
 str_nevmmPageCounterNew.Init;
 {* Инициализация str_nevmmPageCounterNew }
 str_nevtfANSI.Init;
 {* Инициализация str_nevtfANSI }
 str_nevtfUnicode.Init;
 {* Инициализация str_nevtfUnicode }
 str_nevtfOEM.Init;
 {* Инициализация str_nevtfOEM }
{$If Defined(evMyEditor)}
 str_nevtfThyEditor.Init;
 {* Инициализация str_nevtfThyEditor }
{$IfEnd} // Defined(evMyEditor)
{$If Defined(Nemesis)}
 str_nevtfGarant.Init;
 {* Инициализация str_nevtfGarant }
{$IfEnd} // Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_nevtfEverestBin.Init;
 {* Инициализация str_nevtfEverestBin }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_nevtfEverest.Init;
 {* Инициализация str_nevtfEverest }
{$IfEnd} // NOT Defined(Nemesis)
 str_nevtfRtf.Init;
 {* Инициализация str_nevtfRtf }
 str_nevpmTimeLeft.Init;
 {* Инициализация str_nevpmTimeLeft }
 str_nevpmCounting.Init;
 {* Инициализация str_nevpmCounting }
 str_nevpmPreparing.Init;
 {* Инициализация str_nevpmPreparing }
 str_nevpmPreparingExt.Init;
 {* Инициализация str_nevpmPreparingExt }
 str_nevpmPrinting.Init;
 {* Инициализация str_nevpmPrinting }
 str_nevpmDocumentList.Init;
 {* Инициализация str_nevpmDocumentList }
 str_nevpmDefaultColontitul.Init;
 {* Инициализация str_nevpmDefaultColontitul }
 str_nevpmUndefinedSize.Init;
 {* Инициализация str_nevpmUndefinedSize }
 str_nevpmUndefinedTopic.Init;
 {* Инициализация str_nevpmUndefinedTopic }
 str_nevpmProcessText.Init;
 {* Инициализация str_nevpmProcessText }
 str_nevpmProcessPreview.Init;
 {* Инициализация str_nevpmProcessPreview }
 str_nevcphExpand.Init;
 {* Инициализация str_nevcphExpand }
 str_nevcphCollapse.Init;
 {* Инициализация str_nevcphCollapse }
 str_nevcphSelect.Init;
 {* Инициализация str_nevcphSelect }
 str_nevcphMove.Init;
 {* Инициализация str_nevcphMove }
 str_nevcphChangeTopBorder.Init;
 {* Инициализация str_nevcphChangeTopBorder }
 str_nevcphChangeBottomBorder.Init;
 {* Инициализация str_nevcphChangeBottomBorder }
 str_nevcphProperties.Init;
 {* Инициализация str_nevcphProperties }
 str_nevmcmUndo.Init;
 {* Инициализация str_nevmcmUndo }
 str_nevmcmCut.Init;
 {* Инициализация str_nevmcmCut }
 str_nevmcmCopy.Init;
 {* Инициализация str_nevmcmCopy }
 str_nevmcmPaste.Init;
 {* Инициализация str_nevmcmPaste }
 str_nevmcmDelete.Init;
 {* Инициализация str_nevmcmDelete }
 str_nevdphExpand.Init;
 {* Инициализация str_nevdphExpand }
 str_nevdphCollapse.Init;
 {* Инициализация str_nevdphCollapse }
 str_nevdphSelect.Init;
 {* Инициализация str_nevdphSelect }
 str_nevdphMove.Init;
 {* Инициализация str_nevdphMove }
 str_nevdphChangeTopBorder.Init;
 {* Инициализация str_nevdphChangeTopBorder }
 str_nevdphChangeBottomBorder.Init;
 {* Инициализация str_nevdphChangeBottomBorder }
 str_nevdphProperties.Init;
 {* Инициализация str_nevdphProperties }
 str_nevmhhBlockParams.Init;
 {* Инициализация str_nevmhhBlockParams }
 str_nevmhhTableCell.Init;
 {* Инициализация str_nevmhhTableCell }
 str_nevmhhTableSize.Init;
 {* Инициализация str_nevmhhTableSize }
 str_nevmhhColumnSize.Init;
 {* Инициализация str_nevmhhColumnSize }
 str_nevmhhTableColumn.Init;
 {* Инициализация str_nevmhhTableColumn }
 str_nevmhhTableRow.Init;
 {* Инициализация str_nevmhhTableRow }
 str_nevmhhLeftHyperlinkBorder.Init;
 {* Инициализация str_nevmhhLeftHyperlinkBorder }
 str_nevmhhRightHyperlinkBorder.Init;
 {* Инициализация str_nevmhhRightHyperlinkBorder }
 str_nevmhLeftIndent.Init;
 {* Инициализация str_nevmhLeftIndent }
 str_nevmhRightIndent.Init;
 {* Инициализация str_nevmhRightIndent }
 str_nevmhRedLineIndent.Init;
 {* Инициализация str_nevmhRedLineIndent }
 str_nevmhCellSize.Init;
 {* Инициализация str_nevmhCellSize }
 str_nevmhTableIndent.Init;
 {* Инициализация str_nevmhTableIndent }
 str_nevmhPaperSize.Init;
 {* Инициализация str_nevmhPaperSize }
 str_nevmhLeftDocMargin.Init;
 {* Инициализация str_nevmhLeftDocMargin }
 str_nevmhRightDocMargin.Init;
 {* Инициализация str_nevmhRightDocMargin }
 str_nevmhTabIndent.Init;
 {* Инициализация str_nevmhTabIndent }

end.
