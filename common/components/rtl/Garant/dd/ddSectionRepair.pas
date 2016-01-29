//..........................................................................................................................................................................................................................................................
unit ddSectionRepair;
{* Расстановка пропущенных разрывов разделов для "широких" таблиц }


//$Id: ddSectionRepair.pas,v 1.144 2015/10/14 08:11:44 dinishev Exp $

// $Log: ddSectionRepair.pas,v $
// Revision 1.144  2015/10/14 08:11:44  dinishev
// Доплили для тестов.
//
// Revision 1.143  2015/10/14 08:03:58  dinishev
// Правим тесты.
//
// Revision 1.142  2015/06/03 12:43:17  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.141  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.140  2014/04/25 15:58:50  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.139  2014/04/10 11:50:12  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.138  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.137  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.136  2014/04/04 17:53:49  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.135  2014/04/03 17:10:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.134  2014/03/27 14:20:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.133  2014/03/24 09:06:16  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.132  2014/03/04 13:17:01  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.131  2013/11/07 10:21:14  dinishev
// Cleanup
//
// Revision 1.130  2013/11/07 10:18:16  dinishev
// {Requestlink:498874352}
//
// Revision 1.129  2013/10/28 10:07:58  lulin
// - готовимся к смене типа значения по-муоолчанию.
//
// Revision 1.128  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.127  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.126  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.125  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.124  2013/10/18 06:30:17  dinishev
// {Requestlink:493868665}. Не плодим расстановщики разделов, если предыдущий подходит.
//
// Revision 1.123  2013/10/17 13:39:47  dinishev
// Reformat.
//
// Revision 1.122  2013/10/17 13:38:03  dinishev
// {Requestlink:493868665}. Почему-то берем правильную ширину страницы, а ориентацию ставим по умолчанию.
//
// Revision 1.121  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.120  2012/10/29 16:57:38  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.119  2012/10/29 13:29:07  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.118  2012/10/26 16:44:28  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.117  2012/02/27 13:08:00  lulin
// {RequestLink:321986755}
//
// Revision 1.116  2011/09/15 16:23:33  lulin
// {RequestLink:278824896}.
//
// Revision 1.115  2011/09/02 15:09:58  lulin
// {RequestLink:280006084}.
//
// Revision 1.114  2011/08/31 19:32:12  lulin
// {RequestLink:280006084}.
//
// Revision 1.113  2011/08/26 11:02:22  dinishev
// Bug fix: не компилировалось в ветке.
//
// Revision 1.112  2011/08/26 10:55:59  dinishev
// Bug fix: не компилировалось в ветке.
//
// Revision 1.111  2011/08/25 15:00:13  lulin
// {RequestLink:279774216}.
//
// Revision 1.110  2011/08/23 18:01:50  lulin
// {RequestLink:279774229}.
//
// Revision 1.109  2010/09/07 11:29:25  narry
// K234363136. Направильно масштабировалась псевдографика и связка псевдографика+таблица
//
// Revision 1.108  2010/08/16 08:39:02  narry
// K232098492 (Не учитывалось отсутствие текста)
//
// Revision 1.107  2010/07/28 13:30:14  narry
// - К228688912. Удаление отладочной информации
//
// Revision 1.106  2010/07/28 08:05:44  narry
// - К228688912
//
// Revision 1.105  2010/07/07 09:09:24  narry
// - К222758098
//
// Revision 1.104  2010/07/01 11:40:25  narry
// - K221251978
//
// Revision 1.103  2010/06/24 10:53:45  narry
// - когда таблица влезала на A4L, разрыв в документ не добавлялся
//
// Revision 1.102  2010/06/23 12:53:20  narry
// - рефакторинг
//
// Revision 1.101  2010/06/23 12:27:03  narry
// - K219124974.
// При расчете ширины страницы учитываем дельту выравнивания
// При повторном проходе сбрасываем текущий масштаб
//
// Revision 1.100  2010/06/17 07:02:07  narry
// - K217678468
//
// Revision 1.99  2010/06/15 10:29:09  narry
// - K217689765
//
// Revision 1.98  2010/06/10 15:12:25  fireton
// - пишем список обработанных документов в файл
//
// Revision 1.97  2010/06/10 14:06:24  narry
// - K217686969
//
// Revision 1.96  2010/06/07 13:04:09  narry
// - К217682848
//
// Revision 1.95  2010/05/28 13:31:06  narry
// - незакрытые скобки
//
// Revision 1.94  2010/05/20 09:03:54  narry
// - K214074330
// - чистка кода
//
// Revision 1.93  2010/05/20 09:01:42  narry
// - K214074330
//
// Revision 1.92  2010/05/19 07:53:20  narry
// - K214073589
//
// Revision 1.91  2010/04/29 06:42:13  narry
// Зануление буферов
//
// Revision 1.90  2010/04/26 07:51:59  voba
// - не компилилось
//
// Revision 1.89  2010/04/23 06:01:27  narry
// - перед подписью вставлялся разрыв раздела
//
// Revision 1.88  2010/04/22 08:43:54  narry
// - не учитывалась таблица из одной строки
//
// Revision 1.87  2010/04/12 15:12:33  lulin
// {RequestLink:203129570}.
// - убираем ненужный тип подитеративной функции.
//
// Revision 1.86  2010/04/06 06:44:11  narry
// - масштабирование таблиц
//
// Revision 1.85  2010/02/18 08:34:47  narry
// - учитываем отступ таблицы
//
// Revision 1.84  2010/02/16 11:50:45  narry
// - убрал лишние разделы
//
// Revision 1.83  2010/02/16 06:08:11  narry
// - борьба с пустыми страницами
//
// Revision 1.82  2010/02/02 12:08:03  narry
// - вычисление максимальной ширины таблицы
//
// Revision 1.81  2010/01/13 11:36:43  narry
// - блоки в ячейке нарушали логику работы
//
// Revision 1.80  2009/07/23 16:24:04  lulin
// - правим тип объекта на более общий.
//
// Revision 1.79  2009/07/08 15:52:03  lulin
// {RequestLink:141264340}. №7.
//
// Revision 1.78  2009/06/01 16:07:45  lulin
// [$148574348].
//
// Revision 1.77  2009/03/05 17:23:54  lulin
// - <K>: 137470629. Для ветки тоже генерируем ссылки на теги.
//
// Revision 1.76  2009/03/04 13:33:06  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.75  2009/02/26 10:21:26  lulin
// - <K>: 137465982. №1
//
// Revision 1.74  2008/12/17 12:33:30  lulin
// - <K>: 132220285.
//
// Revision 1.73  2008/08/25 09:34:23  narry
// - падал при переработке k2_idCommentPara в таблице
//
// Revision 1.72  2008/07/03 14:08:44  oman
// Не собирались
//
// Revision 1.71  2008/06/20 14:49:11  lulin
// - используем префиксы элементов.
//
// Revision 1.70  2008/06/20 14:02:52  lulin
// - используем префиксы элементов.
//
// Revision 1.69  2008/06/17 07:49:13  lulin
// - bug fix: не собирался Немезис.
//
// Revision 1.68  2007/09/18 12:45:50  oman
// - new: Учимся прерывать перемывку текста для превью (cq25478)
//
// Revision 1.67  2007/09/14 13:26:17  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.66.2.1  2007/09/12 19:56:51  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.66  2007/09/12 11:39:46  narry
// - в конце документа добавлялась пустая страница
//
// Revision 1.65  2007/08/09 18:05:21  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.64  2007/08/09 11:19:17  lulin
// - cleanup.
//
// Revision 1.63  2007/07/20 11:06:05  oman
// - fix: Утечка ресурсов (стабы) (cq25820)
//
// Revision 1.62  2007/07/19 13:56:40  oman
// - fix: Потенциальная утечка (cq25820)
//
// Revision 1.61  2007/07/19 06:18:05  oman
// - fix: выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
// (Не собиралась библиотека)
//
// Revision 1.60  2007/07/05 08:28:28  lulin
// - cleanup.
//
// Revision 1.59  2007/07/04 05:59:17  lulin
// - ориентация страницы переехала в более общий модуль.
//
// Revision 1.58  2007/06/27 12:01:26  narry
// - подгонка "магической дельты"
//
// Revision 1.57  2007/06/13 11:26:46  narry
// - исправление вычисления размера шрифта сегмента
//
// Revision 1.56  2007/05/28 06:33:22  oman
// warning fix
//
// Revision 1.55  2007/04/13 11:36:21  lulin
// - используем родную канву для подсчетов.
//
// Revision 1.54  2007/03/22 12:32:30  narry
// - более корректный обход сегментов
//
// Revision 1.53  2007/03/21 15:11:32  narry
// - лишний разрыв раздела
//
// Revision 1.52  2007/03/21 12:03:13  narry
// - запас в полсимвола при расчете ширины текста
// - установка размера шрифта сегментам (пока такого же как у абзаца)
//
// Revision 1.51  2007/03/16 14:47:27  lulin
// - cleanup.
//
// Revision 1.50  2007/01/16 13:22:01  narry
// - черновой вариант алгоритма уменьшения развмера шрифта
//
// Revision 1.49  2007/01/10 14:34:31  narry
// - борьба с лишним сегментом от подписи
//
// Revision 1.48  2006/10/12 11:29:55  narry
// - стиль ev_saContents не учитывался как моноширинный
//
// Revision 1.47  2006/10/10 10:04:34  lulin
// - cleanup.
//
// Revision 1.46  2006/10/09 14:05:57  narry
// - неправильно выставлялась ориентация страницы
//
// Revision 1.45  2006/10/03 11:50:01  narry
// - округление размера страницы до А4
//
// Revision 1.44  2006/09/20 17:13:28  narry
// - не выставлялись параметры страницы для документов, начинающихся с таблицы
//
// Revision 1.43  2006/09/18 12:15:57  narry
// - не сбрасывались праметры раздела
//
// Revision 1.42  2006/09/15 06:50:57  narry
// - починка обмена сообщениями между сервером и клиентом
//
// Revision 1.41  2006/09/11 14:49:09  narry
// no message
//
// Revision 1.40  2006/09/11 12:24:33  narry
// - не выставлялся флаг альбомной ориентации
//
// Revision 1.39  2006/06/28 09:27:27  narry
// - исправление: "съедались" аттрибуты документа
//
// Revision 1.38.4.1  2006/06/28 09:26:18  narry
// - исправление: "съедались" аттрибуты документа
//
// Revision 1.38  2006/05/29 10:20:23  narry
// - исправление: для документа, состоящего только из картинки, не записывались параметры страницы
//
// Revision 1.37  2006/05/26 12:27:21  demon
// - исправление: не записывались параметры страницы
//
// Revision 1.36  2006/05/26 11:32:41  narry
// - исправление: помимо NormalOEM учитывается и AnsiDos
//
// Revision 1.35  2005/12/29 11:46:50  narry
// - ошибка: для документов, начинающихся с блока, не устанавливались параметры страницы
//
// Revision 1.34  2005/12/28 15:20:32  cyberz
// - ошибка: документу устанавливалась неправильная ширина страницы
//
// Revision 1.33  2005/12/22 13:37:19  demon
// - ошибка: разнообразные проблемы
//
// Revision 1.32  2005/12/22 08:26:28  narry
// - ошибка: запись параметров страницы не для документа
//
// Revision 1.31  2005/12/21 13:50:31  narry
// - чистка кода
//
// Revision 1.30  2005/12/20 10:28:40  demon
// - ошибка: неправильно передавались параметры страницы
//
// Revision 1.29  2005/12/20 09:52:12  narry
// - ошибка: не записывались поля страницы
//
// Revision 1.28  2005/12/16 13:07:30  narry
// - ошибка: далеко не всегда корректный расчет максимальной ширины текста
//
// Revision 1.27  2005/12/13 11:42:22  narry
// - ошибка: лишний разрыв страницы
//
// Revision 1.26  2005/06/23 13:42:54  lulin
// - буфер документа переехал в папку K2.
//
// Revision 1.25  2005/06/23 13:27:36  lulin
// - cleanup.
//
// Revision 1.24  2005/06/10 07:59:31  narry
// - bug fix: незакрытые скобки
//
// Revision 1.23  2005/05/26 17:44:39  lulin
// - базовая канва вывода переехала из Эвереста в L3.
//
// Revision 1.22  2005/05/26 13:19:34  lulin
// - new unit: _l3ScreenIC.
//
// Revision 1.21  2005/05/26 11:41:51  fireton
// - bug fix: не учитывались параметры страницы, передаваемые в документ
//
// Revision 1.20  2005/05/26 11:20:22  narry
// - bug fix: не учитывались параметры страницы, передаваемые в документ
//
// Revision 1.19  2005/05/24 14:50:07  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.18  2005/05/10 09:52:47  narry
// - bug fix: лишние разрывы страниц
//
// Revision 1.17  2005/04/28 15:04:04  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.16.4.1  2005/04/22 06:33:56  lulin
// - bug fix: не компилировалось.
//
// Revision 1.16  2005/03/28 11:32:18  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.15  2005/03/24 18:39:24  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.14  2005/03/21 10:04:55  lulin
// - new interface: _Ik2Type.
//
// Revision 1.13  2005/03/18 16:11:27  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.12  2005/02/18 15:04:39  lulin
// - перевел на _Ik2Tag.
//
// Revision 1.11  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.10  2005/02/01 13:17:27  lulin
// - bug fix: при расстановке секций в документе с блоками в документ попадал "мусор".
//
// Revision 1.9  2004/12/22 14:00:06  lulin
// - bug fix: при экспорте терялись Sub'ы.
//
// Revision 1.8  2004/12/03 15:16:34  narry
// - bug fix: добавление лишнего раздела, если существующий меньшего размера
//
// Revision 1.7  2004/11/30 16:53:20  lulin
// - bug fix: оставались неосвобожденные объекты (CQ OIT5-11019).
//
// Revision 1.6  2004/11/26 10:08:53  narry
// - bug fix: не закрывались теги во вспомогательном буфере
//
// Revision 1.5  2004/11/26 07:32:24  lulin
// - не сравниваем ID типов напрямую.
//
// Revision 1.4  2004/11/12 16:34:24  lulin
// - optimization: не получаем инструменты каждый раз.
//
// Revision 1.3  2004/10/27 12:41:28  narry
// - Update
//
// Revision 1.2  2004/10/20 13:43:43  narry
// - bug fix: существующие разрывы разделов группировались в одном месте, сбрасывалась накопленная максимальная ширина
//
// Revision 1.1  2004/10/19 10:44:56  narry
// Фильтр, восстанавливающий пропущенные разрывы разделов.
//

{$Include ddDefine.inc}

interface

uses
  l3Types,
  l3Base,
  l3InternalInterfaces,
  l3Variant,

  k2Interfaces,
  k2TagFilter,
  k2Types,
  k2TagGen,
  k2DocumentBuffer,

  evInternalInterfaces,
  l3LongintList,

  nevBase
  ,
  nevGarbageInterfaces
  ;

type
 TddSectionRepairFilter = class(Tk2TagFilter)
 { Проверяет ширину таблицы и в случае превышения ширины поля текста вставляет
   разрыв раздела }
 private
  f_BreakAdded: Boolean;
  f_Buffer   : Tk2DocumentBuffer;
  f_ParaBuffer   : Tk2DocumentBuffer;
  f_CollectAtoms: Boolean;
  f_CollectedBlocks: Integer;
  f_CollectedObjectsCount: Integer;
  f_CurDoc: Integer;
  f_CustomHeight: Integer;
  f_CustomOrientation: Integer;
  f_CustomWidth: Integer;
  f_DocOrientation: Integer;
  f_DocPageHeight: LongInt;
  f_DocPageWidth: Longint;
  f_DocLeftIndent: Integer;
  f_DocRightIndent: Integer;
  f_HasText: Boolean;
  f_MaxWidth: Integer;
  f_Orientation: LongInt;
  f_PageHeight: LongInt;
  f_PageWidth: Longint;
  f_LeftIndent: Integer;
  f_RightIndent: Integer;
  f_SmallCellCount: Integer;
  f_MaxSmallCount: Integer;
  f_Style: LongInt;
  f_Text: Tl3PrimString;
  f_IC : Il3InfoCanvas;
  f_MinFontSize: Integer;
  f_NeedBreak: Boolean;
  f_PrevRowWidth: Integer;
  f_Tool : InevFontTool;
  f_WorkedDocs: Tl3LongintList;
  procedure AddDoc;
  function AdjustFontSize(out theOrientation: Integer): Boolean;
  function AdjustTableScale(out theOrientation, theScale: Integer): Boolean;
  function BufferCloseStructure: Boolean;
  procedure CalculatePageSize(aMaxWidth: Integer; out theWidth, theHeight,
      theOrientation: Longint);
  procedure CalculateParagraphWidth(aRoot: Tl3Variant);
  procedure CheckBufferRoot;
  procedure CleanupParaBuffer;
  procedure Copy2ParaBuffer;
  function GetActualPageHeight: Integer;
  function GetActualPageOrientation: Integer;
  function GetActualPageWidth: Integer;
  function GetMaxTextWidth(aOrientation: Integer = -1): Integer;
  procedure ResetPageParams;
  procedure RestoreSection;
  procedure SetPageProperties;
  procedure StartDocument;
  procedure WriteCollectedObjects(aEndOfDoc: Boolean);
  procedure WritePageParameters;
  procedure WriteParagraph;
  procedure WriteTable;
  procedure WriteSectionBreak(aOrientation, aWidth, aHeight: Longint);
 protected
  procedure CloseStructure(NeedUndo: Boolean); override;
  procedure Cleanup; override;
  procedure CloseStream(NeedUndo: Boolean); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure SaveListTo(aFileName: AnsiString);
  procedure StartChild(TypeID: Tl3VariantDef); override;
  procedure StartTag(TagID: Long); override;
  property MinFontSize: Integer read f_MinFontSize write f_MinFontSize;
  property WorkedDocs: Tl3LongintList read f_WorkedDocs;
 end;


const
 c_DefaultScale         = 100;
 c_ScaleStep            = 1;
 c_MinPortraitScale     = 90;
 c_MinLandscapeScale    = 60;
 c_MinLandscapeFontSize = 6;
 c_MinPortraitFontSize  = 10;
 cnSmallCellsInTable4DontScale = 20;

implementation

uses
  Classes,
  Math,

  l3Const,
  l3String,
  l3Defaults,
  l3UnitsTools,
  l3ScreenIC,
  l3Interfaces,
  l3Stream,
  l3Filer,

  k2BaseTypes,
  k2Tags, k2Base,

  evdTypes,
  evdDOM,

  evTypes,
  evdStyles,
  evSectionPara,

  Table_Const,
  StyledLeafPara_Const,
  Document_Const,
  SectionBreak_Const,
  TextPara_Const,
  CommentPara_Const,
  SBS_Const,
  TableRow_Const,
  TableCell_Const,
  reqRow_Const,
  L3Math

  ,
  ContentsElement_Const

  ,
  SysUtils,
  l3LongintListPrim

  ,
  nevFontTool
  ;

constructor TddSectionRepairFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
  inherited;
  f_SmallCellCount := 0;
  f_MaxSmallCount := 0;
  f_Buffer:= Tk2DocumentBuffer.Create(anOwner);
  f_ParaBuffer:= Tk2DocumentBuffer.Create(anOwner);
  f_CollectAtoms:= False;
  f_MinFontSize := c_MinPortraitFontSize;
 f_WorkedDocs := Tl3LongintList.MakeSorted;
end;

procedure TddSectionRepairFilter.CalculatePageSize(aMaxWidth: Integer; out
    theWidth, theHeight, theOrientation: Longint);
var
 l_Found: Boolean;
 i: TevdPaperSize;
 l_Page: Integer;
begin
 l_Found := False;

 for i := evd_psA4 downto evd_psA0 do
 begin
  theWidth := l3Cm2Inch(evPageSizes[i].X);
  theHeight := l3Cm2Inch(evPageSizes[i].Y);
  if aMaxWidth <= (theWidth - f_DocLeftIndent - f_DocRightIndent) then
  begin
   l_Found := True;
   theOrientation := Ord(ev_poPortrait);
   break;
  end // aMaxWidth <= (theWidth - f_LeftIndent, f_RightIndent)
  else
  if aMaxWidth <= (theHeight - f_DocLeftIndent - f_DocRightIndent) then
  begin
   l_Found := True;
   theOrientation := Ord(ev_poLandscape);
   break;
  end // aMaxWidth <= (theHeight - f_LeftIndent, f_RightIndent)
 end; // for i
 if l_Found then // Избавление от пустых страниц
  if theOrientation = Ord(ev_poLandscape) then
  begin
   if theHeight mod l3Cm2Inch(evPageSizes[evd_psA4].X) = 0 then
    l_Page := l3Cm2Inch(evPageSizes[evd_psA4].X)
   else
    l_Page := l3Cm2Inch(evPageSizes[evd_psA4].Y);
   if theHeight - aMaxWidth > l_Page then
    Dec(theHeight, l_Page);
  end
  else
  begin
   if theWidth mod l3Cm2Inch(evPageSizes[evd_psA4].X) = 0 then
    l_Page := l3Cm2Inch(evPageSizes[evd_psA4].X)
   else
    l_Page := l3Cm2Inch(evPageSizes[evd_psA4].Y);
   if theWidth - aMaxWidth > l_Page then
    Dec(theWidth, l_Page);
  end;

 if not l_Found then
 begin
  theWidth := aMaxWidth + f_DocLeftIndent + f_DocRightIndent;
  theOrientation := Ord(ev_poPortrait);
 end; // not l_Found
 { TODO -oДудко Дмитрий -cОшибка : Нужно запоминать размер страницы, для выставленного раздела. }
 f_CustomWidth := theWidth;
 f_CustomHeight := theHeight;
 f_CustomOrientation := theOrientation;
end;

procedure TddSectionRepairFilter.CalculateParagraphWidth(aRoot: Tl3Variant);
begin
 if (f_Tool = nil) then
  f_Tool := TnevFontTool.Make;
 if (f_IC = nil) then
  f_IC := l3CRTIC;
 aRoot.AttrW[k2_tiPrintFontSize, nil]:= nil;
 f_IC.Font := f_Tool.GetObjIFont(nil, aRoot, False, nil);
 f_IC.Font.Size:= aRoot.IntA[k2_tiPrintFontSize];
 f_MaxWidth:= Max(f_IC.TextExtent(f_Text.AsWStr).X, f_MaxWidth);
end;

procedure TddSectionRepairFilter.CheckBufferRoot;
begin
  with f_Buffer.Root do
  begin
   f_CollectAtoms := false;
   if IsKindOf(k2_typTable) then
    WriteTable
   else
   if IsKindOf(k2_typStyledLeafPara) then
    WriteParagraph
   else
    Copy2ParaBuffer;
  end; // .. k2_idTextPara ..;
  DecSkipTags;
end;

procedure TddSectionRepairFilter.Cleanup;
begin
 f_Tool := nil;
 f_IC := nil;
 f_SmallCellCount := 0;
 f_MaxSmallCount := 0;
 CleanupParaBuffer;
 FreeAndNil(f_WorkedDocs);
 l3Free(f_ParaBuffer);
 l3Free(f_Buffer);
 l3Free(f_Text);
 inherited;
end;

procedure TddSectionRepairFilter.AddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
begin
 if not f_CollectAtoms then
 begin
 if CurrentType.IsKindOf(k2_typDocument)
   and ((AtomIndex = k2_tiWidth) or (AtomIndex = k2_tiHeight) or
        (AtomIndex = k2_tiRightIndent) or (AtomIndex = k2_tiLeftIndent))
   then
  begin
   case AtomIndex of
    k2_tiWidth : f_DocPageWidth := Value.AsInteger;
    k2_tiHeight : f_DocPageHeight := Value.AsInteger;
    k2_tiLeftIndent:  f_DocLeftIndent := Value.AsInteger;
    k2_tiRightIndent: f_DocRightIndent := Value.AsInteger;
   end;
   exit
  end;
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_CurDoc:= Value.AsInteger;
  inherited;
  // Накопить информацию о ширине-высоте страницы документа-раздела
  if (TopType[1].IsKindOf(k2_typSectionBreak)) then
   case AtomIndex of
    k2_tiOrientation: f_Orientation := VariantAsInteger(AtomIndex, Value);
    k2_tiHeight: f_PageHeight := Value.AsInteger;
    k2_tiWidth: f_PageWidth := Value.AsInteger;
   end // case AtomIndex
 end
 else
 begin
  f_Buffer.AddAtomEx(AtomIndex, Value);
  if f_Buffer.CurrentType.IsKindOf(k2_typTextPara) then
   case AtomIndex of
    k2_tiText : l3Set(f_Text, Value.AsString); // посчитать ширину абзаца
    k2_tiStyle: f_Style:= Value.AsInteger; // выяснить нужно ли вообще считать  ev_saTxtNormalOEM
   end // case
  else
  if f_Buffer.CurrentType.IsKindOf(k2_typTableCell) then
   if AtomIndex = k2_tiWidth then
   begin
    Inc(f_PrevRowWidth, Value.AsInteger);
    if Value.AsInteger < L3FrameLinesDelta * 4 then
     Inc(f_SmallCellCount);
   end;
 end; // f_IsPara
end;

procedure TddSectionRepairFilter.AddDoc;
begin
 f_WorkedDocs.Add(f_CurDoc);
end;


function TddSectionRepairFilter.AdjustFontSize(out theOrientation: Integer): Boolean;
var
 l_MaxWidth, l_TextWidth: Longint;
 l_Size, l_MinFontSize,
 l_FontSize : Integer;
 l_ParaText : Tl3PCharLen;

 function _CalcWidth(aTag: Tl3Variant; anIndex: Integer): Boolean;
 var
  l_Width, l_SegmentFinish: Integer;
  l_Segments: Tl3Variant;

  function _IterateLayers(aLayer: Tl3Variant; anIndex: Integer): Boolean;
  
   function _CalcSegmentsWidth(aSeg: Tl3Variant; anIndex: Integer): Boolean;
   var
    l_Start, l_Finish: Integer;
    l_Text: Tl3PCharLen;
   begin // _CalcSegmentsWidth
    Result := True;
    l_Start:= aSeg.IntA[k2_tiStart];
    l_Finish:= ifThen(aSeg.Attr[k2_tiFinish].IsValid, aSeg.IntA[k2_tiFinish]);
    if l_Start > l_SegmentFinish then
    begin // вычислить ширину текста между сегментами
     f_IC.Font := f_Tool.GetObjIFont(nil, aTag.AsObject, False, nil);
     f_IC.Font.Size := l_Size;
     l_Text := l3PCharLen(l_ParaText.S[l_SegmentFinish], l_Start - l_SegmentFinish+1);
     Inc(l_Width, f_IC.TextExtent(l_Text).X);
    end; // l_Start > l_SegmentFinis
    f_IC.Font := f_Tool.GetObjIFont(nil, aSeg.AsObject, true {Это Люлин правил} {False}, nil);
    f_IC.Font.Size := l_Size;
    l_Text := l3PCharLen(l_ParaText.S[l_Start], l_Finish - l_Start+1);
    Inc(l_Width, f_IC.TextExtent(l_Text).X);
    l_SegmentFinish := l_Finish;
   end; // _CalcSegmentsWidth
  begin
   Result := True;
   if aLayer.Attr[k2_tiHandle].IsValid and (aLayer.IntA[k2_tiHandle] = Ord(ev_slView)) then
    aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_CalcSegmentsWidth));
  end;

 begin // _CalcWidth
  Result := True;
  if aTag.Attr[k2_tiText].IsValid then
  begin
   l_ParaText := aTag.PCharLenA[k2_tiText];
   if (f_Tool = nil) then
    f_Tool := TnevFontTool.Make;
   if (f_IC = nil) then
    f_IC := l3CRTIC;
   f_IC.Font := f_Tool.GetObjIFont(nil, aTag.AsObject, False, nil);
   l_FontSize := f_IC.Font.Size;
   if l_Size = -1 then
    l_Size:= l_FontSize;
   f_IC.Font.Size:= l_Size;
   if aTag.Attr[k2_tiSegments].IsValid then
   begin
    l_Segments := aTag.Attr[k2_tiSegments];
    l_Width := 0;
    l_SegmentFinish := 0;
    l_Segments.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_IterateLayers))
   end
   else
    l_Width := f_IC.TextExtent(l_ParaText).X;

   l_Width := l_Width + 284;// <- магическое число, полученное серией экспериментов. Зазор, которой Ворд хочет между абзацем и страницей;
   if l_TextWidth < l_Width then
    l_MaxWidth:= Max(l_Width, l_MaxWidth);
  end; // aTag.Attr[k2_tiText].IsValid
 end; // _CalcWidth

 function _ChangeParaFont(aTag: Tl3Variant; anIndex: Integer): Boolean;
 var
  l_Style: Integer;
 begin
  Result := True;
  if aTag.IsKindOf(k2_typTextPara) then
  begin
   if aTag.Attr[k2_tiStyle].IsValid then
   begin
    l_Style:= aTag.IntA[k2_tiStyle];
    if (l_Style = ev_saTxtNormalOEM) or (l_Style = ev_saANSIDOS) then
     aTag.IntA[k2_tiPrintFontSize]:= l_Size;
   end;
  end;
 end; // _ChangeFont

begin // AdjustFontSize
 Result := False;
 // Приступаем к расчету
 l_Size:= 0;
 l_MinFontSize:= c_MinPortraitFontSize;
 l_TextWidth:= GetMaxTextWidth(Ord(ev_poPortrait)); // Подгонка под то, что есть
 repeat
  Dec(l_Size);
  l_MaxWidth:= 0;
  f_ParaBuffer.Root.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_CalcWidth));
 until (l_MaxWidth <= l_TextWidth) or (l_Size < l_MinFontSize);
 Result := (l_Size = -1) or (l_Size >= l_MinFontSize);
 theOrientation:= Ord(ev_poPortrait);
 if not Result then // Если не получилось, нужно попробовать под альбом, если текущая портретная
 begin
  l_Size:= 0;
  l_TextWidth:= GetMaxTextWidth(Ord(ev_poLandscape)); // Подгонка под альбомную ориентацию
  l_MinFontSize:= c_MinLandscapeFontSize;
  repeat
   Dec(l_Size);
   l_MaxWidth:= 0;
   f_ParaBuffer.Root.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_CalcWidth));
  until (l_MaxWidth <= l_TextWidth) or (l_Size < l_MinFontSize);
  Result := l_Size >= l_MinFontSize;
  if Result then
   theOrientation:= Ord(ev_poLandscape);
 end; // not Result
 if (l_Size > -1) and Result then
 begin
  AddDoc;
  f_ParaBuffer.Root.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@_ChangeParaFont));
 end; // result
end; // AdjustFontSize

function TddSectionRepairFilter.AdjustTableScale(out theOrientation, theScale: Integer): Boolean;
var
 l_Scale: Integer;

 function lp_Adjust(aMinScale, aOrientation: Integer; out theScale: Integer): Boolean;
 var
  l_Width: Integer;
  l_CurScale: Integer;
 begin
  Result:= False;
  if f_MaxSmallCount >= cnSmallCellsInTable4DontScale then Exit;
  theScale:= c_DefaultScale;
  l_CurScale:= c_DefaultScale;
  while l_CurScale > aMinScale do
  begin
   l_Width := l3MulDiv(f_MaxWidth, l_CurScale, 100);
   if l_Width <= GetMaxTextWidth(aOrientation) then
   begin
    Result := True;
    theScale := l_CurScale;
    Break;
   end;
   Dec(l_CurScale, c_ScaleStep);
  end;
 end; // lp_Adjust

begin
 Result := False;
 theScale := c_DefaultScale;
 theOrientation := GetActualPageOrientation;
 f_Buffer.Root.AttrW[k2_tiZoom, nil] := nil;
 if l3MulDiv(f_MaxWidth, c_MinPortraitScale, 100) < GetMaxTextWidth then
  Result := lp_Adjust(c_MinPortraitScale, theOrientation, l_Scale)
 else
 begin
  theOrientation := Ord(ev_poLandscape);
  Result := lp_Adjust(c_MinLandscapeScale, theOrientation, l_Scale);
 end;
 if Result then
 begin
  f_Buffer.Root.IntA[k2_tiZoom] := l_Scale;
  AddDoc;
  theScale := l_Scale;
 end;
end;

function TddSectionRepairFilter.BufferCloseStructure: Boolean;
begin
 Result := False;
 if (CurrentType.IsKindOf(k2_typContentsElement, [k2_typCommentPara]) and (f_CollectedBlocks > 0)) or
     not CurrentType.IsKindOf(k2_typContentsElement, [k2_typCommentPara]) then
  with f_Buffer do
  begin
   if CurrentType.IsKindOf(k2_typContentsElement, [k2_typCommentPara]) then
    Dec(f_CollectedBlocks);
   Finish;
   if (Root <> nil) and Root.IsValid then
   begin
    Result:= True;
    inherited CloseStructure(False);
    CheckBufferRoot;
    Root:= nil;
    l3Free(f_Text);
    Finish;
   end; // (Root <> nil) and Root.Tag.IsValid
  end//with f_Buffer;
end;

procedure TddSectionRepairFilter.CleanupParaBuffer;
begin
 if f_ParaBuffer.StreamOpened then
  f_ParaBuffer.Rollback;
 if f_Buffer.StreamOpened then
  f_Buffer.Rollback;
end;

procedure TddSectionRepairFilter.CloseStream(NeedUndo: Boolean);
begin
 CleanupParaBuffer;
 inherited;
end;

procedure TddSectionRepairFilter.CloseStructure(NeedUndo: Boolean);
begin
 if NeedUndo then
  inherited
 else
 begin
  if CurrentType.IsKindOf(k2_typTableRow) and (f_NeedBreak)  then
   f_MaxWidth:= Max(f_MaxWidth, f_PrevRowWidth);

  if not f_CollectAtoms then
  begin
   if f_CollectedObjectsCount > 0 then
   begin
    if (CurrentType.IsKindOf(k2_typDocument) or
        CurrentType.IsKindOf(k2_typContentsElement, [k2_typCommentPara])) then
     WriteCollectedObjects(CurrentType.IsKindOf(k2_typDocument));
   end; // f_CollectedCount > 0
   if CurrentType.IsKindOf(k2_typSectionBreak) then
   begin
    DecSkipTags;
    ResetPageParams;
   end;
   inherited;
  end // not f_CollectAtoms
  else
  begin
   if not BufferCloseStructure then
    inherited;
  end;
 end;
end;

procedure TddSectionRepairFilter.Copy2ParaBuffer;
var
 l_Gen: Tk2TagGenerator;
begin
 l_Gen:= f_ParaBuffer.GetGenerator;
 l_Gen.StartChild(f_Buffer.Root.TagType);
 try
  f_Buffer.Root.WriteTag(l_Gen);
  f_Buffer.Root:= nil;
 finally
  l_Gen.Finish;
 end;
 Inc(f_CollectedObjectsCount);
end;

function TddSectionRepairFilter.GetActualPageHeight: Integer;
begin
 Result := ifThen(f_BreakAdded, f_CustomHeight, f_DocPageHeight);
end;

function TddSectionRepairFilter.GetActualPageOrientation: Integer;
begin
 Result := IfThen(f_BreakAdded, f_CustomOrientation, f_Orientation);
end;

function TddSectionRepairFilter.GetActualPageWidth: Integer;
begin
 Result := ifThen(f_BreakAdded, f_CustomWidth, f_DocPageWidth);
end;

procedure TddSectionRepairFilter.StartChild(TypeID: Tl3VariantDef);
var
 l_Type : Tk2Type;
begin
 l_Type := Tk2Type(TypeID);
 if l_Type.IsKindOf(k2_typDocument) then
  StartDocument;
 { Что может быть:
    1. накапливаются атрибуты текущего объекта
    2. накапливаются вложенные объекты вместе с их атрибутами
    3. Все пропускается (?)
 }
 if not f_CollectAtoms then
 begin
  if l_Type.IsKindOf(k2_typStyledLeafPara) or (l_Type.IsKindOf(k2_typTable)) then
  begin
   if l_Type.IsKindOf(k2_typStyledLeafPara) and (f_CollectedObjectsCount = 0) then
   begin
    if not f_ParaBuffer.StreamOpened then
    begin
     f_ParaBuffer.Start;
     f_ParaBuffer.StartChild(k2_typDocument);
     f_MaxWidth:= 0;
    end; // not f_ParaBuffer.StreamOpened
   end //l_Type.IsKindOf(k2_typTextPara) and f_CollectedCount = 0
   else
   if (f_CollectedObjectsCount > 0) and l_Type.IsKindOf(k2_typTable) then
     WriteCollectedObjects(False);
   if l_Type.IsKindOf(k2_typTable) then
   begin
    f_NeedBreak:= not l_Type.IsKindOf(k2_typSBS);
    f_PrevRowWidth:= -108; // !!!
    f_MaxWidth:= 0;
    f_SmallCellCount := 0;
    f_MaxSmallCount := 0;
   end;
   f_CollectAtoms:= True;
   f_Style:= ev_saTxtNormalANSI;
   f_Buffer.Start;
   IncSkipTags;
  end // l_Type.IsKindOf(k2_typTextPara) or l_Type.IsKindOf(k2_typTable)
  else
  if l_type.IsKindOf(k2_typContentsElement, [k2_typCommentPara, k2_typDocument]) and not f_HasText then
  begin
   WritePageParameters
  end;
  if (f_CollectedObjectsCount > 0) and not f_CollectAtoms then
   WriteCollectedObjects(False);
 end; // not f_CollectAtoms
 if (f_CollectedObjectsCount > 0) and l_Type.IsKindOf(k2_typSectionBreak) then
  WriteCollectedObjects(False);
 if not f_CollectAtoms then
 begin
  if l_Type.IsKindOf(k2_typSectionBreak) then
  begin
   ResetPageParams;
   IncSkipTags;
  end
 end
 else
 begin
  if l_Type.IsKindOf(k2_typTableRow) then
  begin
   if f_NeedBreak then
    f_NeedBreak:= not l_Type.IsKindOf(k2_typReqRow);
   f_PrevRowWidth:= -108;
   f_MaxSmallCount := Max(f_MaxSmallCount, f_SmallCellCount);
   f_SmallCellCount := 0;
  end;
  f_Buffer.StartChild(TypeID);
  if l_type.IsKindOf(k2_typContentsElement) then
   inc(f_CollectedBlocks);
 end;
 if (f_CollectedObjectsCount > 0) and not f_CollectAtoms then
  WriteCollectedObjects(False);
 inherited;
end;

function TddSectionRepairFilter.GetMaxTextWidth(aOrientation: Integer = -1): Integer;
var
 l_Width, l_Height, l_Orientation: Integer;
begin
 l_Width:= GetActualPageWidth;
 l_Height:= GetActualPageHeight;
 if aOrientation > -1 then
  l_Orientation := aOrientation
 else
  l_Orientation := GetActualPageOrientation;

 if l_Orientation = Ord(ev_poPortrait) then
  Result := l_Width - f_DocLeftIndent - f_DocRightIndent
 else
  Result := l_Height - f_DocLeftIndent - f_DocRightIndent;
 Inc(Result, l3AlingDelta);
end;

procedure TddSectionRepairFilter.ResetPageParams;
begin
  f_Orientation := f_DocOrientation;
  f_PageHeight:= f_DocPageHeight;
  f_PageWidth:= f_DocPageWidth;
  f_LeftIndent:= f_DocLeftIndent;
  f_RightIndent:= f_DocRightIndent;
end;

procedure TddSectionRepairFilter.RestoreSection;
begin
 WriteSectionBreak(f_DocOrientation, f_DocPageWidth, f_DocPageHeight);
 f_BreakAdded:= False
end;

procedure TddSectionRepairFilter.SaveListTo(aFileName: AnsiString);
var
 I : Integer;
 l_Stream: TStream;
 l_Filer : Tl3DOSFiler;
begin
 if not f_WorkedDocs.Empty then
 begin
  l_Stream:= Tl3FileStream.Create(aFileName, l3_fmWrite);
  try
   l_Filer := Tl3DOSFiler.Create;
   try
    l_Filer.Stream := l_Stream;
    l_Filer.WriteLn('#');
    for i:= 0 to f_WorkedDocs.Hi do
     l_Filer.WriteLn(Format('%d', [f_WorkedDocs[I]]));
   finally
    FreeAndNil(l_Filer);
   end;
  finally
   FreeAndNil(l_Stream);
  end;
 end;
end;

procedure TddSectionRepairFilter.SetPageProperties;
var
 l_Default: Longint;
begin
  with k2_typDocument do
  begin
   l_Default := Tk2Prop(Prop[k2_tiWidth]).DefaultValue;
   if (l_Default <> l3NilLong) then
   begin
    f_DocPageWidth := l_Default;
    l_Default := Tk2Prop(Prop[k2_tiLeftIndent]).DefaultValue;
    if (l_Default = l3NilLong) then
{$IFDEF nsTest}
     f_DocLeftIndent := def_inchPaperLeft
{$ENDIF nsTest}
    else
     f_DocLeftIndent := l_Default;
    l_Default := Tk2Prop(Prop[k2_tiRightIndent]).DefaultValue;
    if (l_Default = l3NilLong) then
{$IFDEF nsTest}
     f_DocRightIndent := def_inchPaperRight
{$ENDIF nsTest}
    else
     f_DocRightIndent:= l_Default;
    f_DocPageHeight:= l3Cm2Inch(evPageSizes[evd_psA4].Y);
    f_DocOrientation := Ord(ev_poPortrait);
    ResetPageParams;
   end; // (l_Default <> l3NilLong);
  end;
end;

procedure TddSectionRepairFilter.StartDocument;
begin
  SetPageProperties;
  f_CollectAtoms:= False;
  f_CollectedObjectsCount := 0;
  f_BreakAdded := False;
  f_CollectedBlocks := 0;
  f_HasText := False;
  f_Buffer.Root:= nil;
  f_ParaBuffer.Root:= nil;
end;

procedure TddSectionRepairFilter.StartTag(TagID: Long);
begin
  if f_CollectAtoms then
   f_Buffer.StartTag(TagID);
  inherited;
end;

procedure TddSectionRepairFilter.WriteCollectedObjects(aEndOfDoc: Boolean);
var
 l_Width, l_Height: Longint;
 l_Landscape: Longint;
begin
  f_ParaBuffer.Finish;
  if f_MaxWidth > GetMaxTextWidth then
  begin
   l_Width:= GetActualPageWidth;
   l_Height:= GetActualPageHeight;

   if not AdjustFontSize(l_Landscape) then
   begin
    CalculatePageSize(f_MaxWidth, l_Width, l_Height, l_Landscape);
    WriteSectionBreak(l_Landscape, l_Width, l_Height);
    f_BreakAdded:= True;
   end // not AdjustFontSize
   else
   if l_Landscape <> GetActualPageOrientation then
   begin
    WriteSectionBreak(l_Landscape, GetActualPageWidth, GetActualPageHeight);
    f_CustomWidth := f_DocPageWidth;
    f_CustomHeight := f_DocPageHeight;
    f_CustomOrientation := Ord(ev_poLandscape);
    f_BreakAdded:= True;
   end
  end; // f_MaxWidth > MaxTextWidth
  //else
  if not f_HasText then
   WritePageParameters;

  f_ParaBuffer.Root.WriteTag(Generator, [l3_spfChildren]);
  f_ParaBuffer.Root:= nil;
  f_ParaBuffer.Finish;
  f_CollectedObjectsCount := 0;
  f_HasText := True;
end;

procedure TddSectionRepairFilter.WritePageParameters;
begin
 if not f_HasText and CurrentType.IsKindOf(k2_typDocument) then
 begin
  Generator.AddIntegerAtom(k2_tiWidth, f_DocPageWidth);
  Generator.AddIntegerAtom(k2_tiHeight, f_DocPageHeight);
  Generator.AddIntegerAtom(k2_tiLeftIndent,  f_DocLeftIndent);
  Generator.AddIntegerAtom(k2_tiRightIndent, f_DocRightIndent);
 end;
end;

procedure TddSectionRepairFilter.WriteParagraph;
begin
  if (((f_Style = ev_saTxtNormalOEM) or (f_Style = ev_saANSIDOS) or (f_Style = ev_saContents)) and (f_Text <> nil)) or
     (((f_Text = nil) or f_Text.Empty)) then // Накапливаем абзацы
  begin
   if (f_Text <> nil) and not (f_Text.Empty) then
     CalculateParagraphWidth(f_Buffer.Root);
   Copy2ParaBuffer;
  end
  else
  begin
   if f_CollectedObjectsCount > 0 then
    WriteCollectedObjects(False);
   if f_BreakAdded and (f_Text <> nil) then
    RestoreSection
   else
    WritePageParameters;
   Generator.StartChild(f_Buffer.Root.TagType);
   try
    f_Buffer.Root.WriteTag(Generator);
    f_Buffer.Root:= nil;
    f_HasText := True;
   finally
    Generator.Finish;
   end;//try..finally
  end;
end;

procedure TddSectionRepairFilter.WriteTable;
var
 l_BreakAdded: Boolean;
 l_Width, l_Height: Longint;
 l_Orientation: Longint;
 l_Type : Tk2Type;
 l_NeedBreak: Boolean;
 l_Scale: Integer;
begin
 l_BreakAdded:= False;
 if not f_HasText then
  WritepageParameters;
 if f_NeedBreak then
 begin
  f_Buffer.Root.IntA[k2_tiZoom]:= c_DefaultScale;
  if f_MaxWidth > GetMaxTextWidth then
  begin
   if AdjustTableScale(l_Orientation, l_Scale) then
   begin
    if (l_Orientation = Ord(ev_poLandscape)) and (l_Orientation <> GetActualPageOrientation) and (f_MaxWidth <> GetActualPageWidth) then
    begin
     WriteSectionBreak(l_Orientation, GetActualPageWidth, GetActualPageHeight);
     f_BreakAdded := True;
    end;
   end
   else
   if l_Scale = c_DefaultScale then
   begin
    CalculatePageSize(f_MaxWidth, l_Width, l_Height, l_Orientation);
    WriteSectionBreak(l_Orientation, l_Width, l_Height);
    f_BreakAdded:= True;
   end;
  end; // f_MaxWidth > MaxTextWidth
 end; 
 Generator.StartChild(f_Buffer.Root.TagType);
 try
  f_Buffer.Root.WriteTag(Generator);
  f_Buffer.Root:= nil;
  f_HasText := True;
 finally
  Generator.Finish;
 end;//try..finally
end;

procedure TddSectionRepairFilter.WriteSectionBreak(aOrientation, aWidth,
    aHeight: Longint);
begin
 if f_HasText then
 begin
  Generator.StartChild(k2_typSectionBreak);
  try
    Generator.StartTag(k2_tiParas);
    try
     Generator.AddIntegerAtom(k2_tiOrientation, aOrientation);
     Generator.AddIntegerAtom(k2_tiHeight, aHeight);
     Generator.AddIntegerAtom(k2_tiWidth, aWidth);
    finally
     Generator.Finish;
    end; // try..finally
  finally
   Generator.Finish;
  end; // try..finally;
  f_CustomHeight:= aHeight;
  f_CustomWidth:= aWidth;
  f_CustomOrientation:= aOrientation;
 end
 else
 begin
  Generator.AddIntegerAtom(k2_tiWidth, IfThen(aOrientation = Ord(l3_poLandscape), aHeight, aWidth));
  Generator.AddIntegerAtom(k2_tiHeight, IfThen(aOrientation = Ord(l3_poLandscape), aWidth, aHeight));
  Generator.AddIntegerAtom(k2_tiLeftIndent,  f_DocLeftIndent);
  Generator.AddIntegerAtom(k2_tiRightIndent, f_DocRightIndent);
  f_HasText := True;
 end;
 AddDoc;
end;

end.
