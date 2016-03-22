//..........................................................................................................................................................................................................................................................
unit ddRTFKeywords;

// $Id: ddRTFKeywords.pas,v 1.110 2016/03/17 09:02:40 dinishev Exp $ 

// $Log: ddRTFKeywords.pas,v $
// Revision 1.110  2016/03/17 09:02:40  dinishev
// Поддержка новых тегов.
//
// Revision 1.109  2016/02/18 09:04:06  dinishev
// {Requestlink:617082437}. "Многострочные" колонки. Разбиение внутри колонок.
//
// Revision 1.108  2016/02/10 14:35:06  dinishev
// {Requestlink:617082437}
//
// Revision 1.107  2016/01/29 07:40:44  dinishev
// Не читаем праватные поля из RTF.
//
// Revision 1.106  2015/10/22 14:53:44  dinishev
// Отступы табуляции теперь доступны и в полной версии.
//
// Revision 1.105  2015/10/22 10:17:19  dinishev
// Reformat
//
// Revision 1.104  2015/10/22 10:15:36  dinishev
// Reformat
//
// Revision 1.103  2015/10/08 08:35:15  dinishev
// {Requestlink:588548123}. Все уже придумано до нас, нужно только научиться это использовать.
//
// Revision 1.102  2015/09/08 07:30:18  dinishev
// {Requestlink:606634250}. Читаем картинки из \sv
//
// Revision 1.101  2015/08/27 14:55:54  dinishev
// {Requestlink:606138650}
//
// Revision 1.100  2015/08/27 14:53:09  dinishev
// {Requestlink:606138650}
//
// Revision 1.99  2015/08/21 13:23:19  dinishev
// {Requestlink:605843892}
//
// Revision 1.98  2015/08/17 08:15:50  dinishev
// {Requestlink:602009846}
//
// Revision 1.97  2015/08/07 10:33:45  dinishev
// {Requestlink:603416415}
//
// Revision 1.96  2015/08/05 15:33:09  dinishev
// {Requestlink:603416415}
//
// Revision 1.95  2015/07/07 15:01:19  dinishev
// {Requestlink:601462517}
//
// Revision 1.94  2015/03/25 10:54:03  dinishev
// {Requestlink:592251812}
//
// Revision 1.93  2015/03/24 09:10:44  dinishev
// Задел на будущее.
//
// Revision 1.92  2015/02/18 08:10:55  dinishev
// Bug fix: очередной виток борьбы с пустыми сегментами.
//
// Revision 1.91  2014/11/11 11:44:49  dinishev
// {Requestlink:571646843}. Пытаемся игнрорировать лишний текст.
//
// Revision 1.90  2014/11/10 14:18:53  dinishev
// {Requestlink:571646843}. Пытаемся игнрорировать лишний текст.
//
// Revision 1.89  2014/06/05 09:48:25  dinishev
// {Requestlink:540414514}
//
// Revision 1.88  2014/05/21 12:14:30  dinishev
// {Requestlink:535902713}
//
// Revision 1.87  2014/04/14 12:05:58  dinishev
// {Requestlink:528446913}
//
// Revision 1.86  2014/04/03 10:35:36  dinishev
// {Requestlink:526715670}. Учимся читать формат картинки из RTF.
//
// Revision 1.85  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. Перенес TddCellProperty на модель.
//
// Revision 1.84  2013/08/27 10:35:04  dinishev
// {Requestlink:479402808}
//
// Revision 1.83  2013/08/27 07:34:40  dinishev
// Выкидываем неиспользуемые закомментированные слова.
//
// Revision 1.82  2013/07/10 08:58:33  dinishev
// {Requestlink:449678171}
//
// Revision 1.81  2013/05/16 11:42:27  dinishev
// {Requestlink:453164226}. Поддержка чтения \lastrow \irown и игнорирование группы с \nonesttables
//
// Revision 1.80  2013/05/08 12:33:00  dinishev
// {Requestlink:453164226}
//
// Revision 1.79  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.78  2013/04/03 09:34:33  narry
// Не проходили тесты
//
// Revision 1.77  2013/02/06 09:41:56  narry
// Поддержка команды \brdrtbl
//
// Revision 1.76  2013/02/05 10:17:02  narry
// Для LiteVersion игнорируются разрывы разделов
//
// Revision 1.75  2013/01/31 12:14:56  narry
// Обновление
//
// Revision 1.74  2013/01/31 07:07:13  narry
// Обновление
//
// Revision 1.73  2013/01/30 11:51:57  narry
// исправление непрошедших тестов Арчи
//
// Revision 1.72  2013/01/29 06:58:55  narry
// Не работал режим LiteVersion
//
// Revision 1.71  2013/01/24 12:59:15  narry
// Заменять автонумерацию на фиксированную (407745210)
//
// Revision 1.70  2013/01/24 06:55:32  narry
// Поддержка нумерованных абзацев (пока не работает)
//
// Revision 1.69  2013/01/22 12:19:52  narry
// Рефакторинг RTFReader
//
// Revision 1.67  2012/11/09 08:52:29  narry
// Скрытый текст в исходных файлах (407750788)
//
// Revision 1.66  2012/06/27 11:58:11  narry
// Читали мусор из \shprslt
//
// Revision 1.65  2012/06/27 11:37:28  narry
// Читали мусор из \shprslt
//
// Revision 1.64  2012/06/26 13:56:16  narry
// Распознавание текста из фреймов
//
// Revision 1.63  2012/03/21 12:37:04  narry
// Изменённый цвет текста некорректно экспортируется в Word (344754072)
//
// Revision 1.62  2011/09/21 12:30:06  narry
// Пропадают куски текста при форматировании (285510478)
//
// Revision 1.61  2011/04/15 12:41:27  narry
// Обрезать картинку (262636436)
//
// Revision 1.60  2011/02/11 08:25:53  narry
// K253666052. Добавить флаг EnablePictures
//
// Revision 1.59  2011/02/09 11:34:21  narry
// К253657673. Чтение картинок из RTF
//
// Revision 1.58  2010/09/17 12:17:03  narry
// k235051738. Пустые абзацы из-под картинок
//
// Revision 1.57  2010/02/27 10:52:10  lulin
// {RequestLink:193822954}.
// - упрощаем структуры.
//
// Revision 1.56  2009/07/21 15:10:20  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.55  2009/06/24 10:58:27  narry
// - русско-японские RTF от OpenOffice
//
// Revision 1.54  2008/10/13 12:39:27  narry
// - промежуточное обновление
//
// Revision 1.53  2008/05/12 11:43:40  narry
// - поиски пропавшего сегмента
// - рсширение списка констант
//
// Revision 1.52  2008/04/22 10:09:20  narry
// - текст некоторых полей пропадал
//
// Revision 1.51  2008/04/10 10:59:13  narry
// - импорт абзацных отступов для элементов списка
//
// Revision 1.50  2008/04/09 13:51:15  narry
// - рефакторинг
// - замена символов буллета на (*, о, #)
//
// Revision 1.49  2008/03/14 11:36:55  narry
// - борьба с попаданием разрыва страницы внутрь абзаца
//
// Revision 1.48  2008/02/12 19:32:32  lulin
// - избавляемся от универсальности списков.
//
// Revision 1.47  2008/02/06 09:55:25  lulin
// - глобальные объекты сделаны индексированным свойством.
//
// Revision 1.46  2008/02/05 09:58:00  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.45  2008/01/21 11:29:15  narry
// - в RTFLite табуляция заменяется пробелом
//
// Revision 1.44  2007/04/05 09:31:16  narry
// - включение флага allcaps в LiteRTF
//
// Revision 1.43  2006/01/05 15:02:45  narry
// - новое: чтение объединенных по горизонтали ячеек (не совсем корректно)
//
// Revision 1.42  2005/04/28 15:04:04  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.41.4.1  2005/04/26 14:30:49  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.41  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.40  2004/09/28 17:22:07  lulin
// - в первом приближении сделал кеш документов. Пока без вымещения покументов на диск.
//
// Revision 1.39  2004/04/05 11:42:40  narry
// - new: игнорирование текста, удаленного в режиме "Исправления"
//
// Revision 1.38  2004/03/22 11:55:13  narry
// - update: чистка списка ключевых слов RTFLite
//
// Revision 1.37  2004/03/16 10:19:57  narry
// - update: исключение из RTFLite чтения цвета фона ячейки
//
// Revision 1.36  2004/01/16 10:09:12  narry
// - new: игнорирование дубликата картинки
//
// Revision 1.35  2003/05/15 11:45:13  narry
// - add: поддержка табуляций
//
// Revision 1.34  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.33  2003/03/11 12:03:59  law
// - new units: mvcEntitiesRepository, mvcOperationsRepository.
//
// Revision 1.32  2002/08/02 08:32:53  narry
// - update
//
// Revision 1.31  2002/07/30 15:58:16  narry
// - new behavior: поддержка Strikeout
//
// Revision 1.30  2001/11/22 13:58:43  narry
// - update : начало реализации Групп доступа
//
// Revision 1.29  2001/09/25 13:20:45  narry
// - new behavior: чтение буллетов из rtf
//
// Revision 1.28  2001/09/05 10:58:47  narry
// - new behavior: чтение разделов в режиме Lite
//
// Revision 1.27  2001/06/19 12:29:20  narry
// -new behavior: обработка разрывов страниц в lite-версии
//
// Revision 1.26  2001/05/31 15:17:54  narry
// Update - обработка Ctrl-Enter в Lite версии
//
// Revision 1.25  2001/05/10 14:20:21  narry
// Update - обработка параметров раздел
//
// Revision 1.24  2001/04/25 07:18:01  narry
// Update - очередная итерация по записи-чтению стилей Эверест в РТФ
//
// Revision 1.23  2001/04/12 12:58:49  narry
// Update - запись-чтение внутренних стилей в ртф
//
// Revision 1.22  2001/03/20 12:01:25  narry
// Исправлено чтение текствого описания полей
//
// Revision 1.21  2001/03/02 11:55:26  narry
// Fix for loading borders
//
// Revision 1.20  2001/01/25 09:08:06  narry
// Fix - wrong page width, lost character format
// Add - write page break
//
// Revision 1.19  2001/01/16 10:39:23  narry
// Vertical alignment in table cell
//
// Revision 1.18  2001/01/12 12:29:13  narry
// Fix keywords table for LiteRTF
//
// Revision 1.17  2001/01/10 15:24:02  narry
// *** empty log message ***
//
// Revision 1.16  2001/01/10 15:15:48  narry
// Fix dirt text
//
// Revision 1.15  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.14  2000/12/19 13:49:33  narry
// no message
//
// Revision 1.13  2000/12/18 10:53:46  narry
// Fix Lost text and soft hyph
//
// Revision 1.12  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3KeyWrd,

  RTFTypes
  ;
type
  TKWD = (kwdFlag, kwdDest, kwdSymb, kwdTogg, kwdValu);
    {kwdFlag,  - игнориует параметры }
    {kwdDest,  - начинает новую группу назначения, игнорирует параметры }
    {kwdSymb,  - представляет спецсимвол }
    {kwdTogg,  - переключатель. 0 -выключает, отсутствие параметров или > 0 вкл }
    {kwdValu   - требует параметра }

  TSYM = class(Tl3KeyWord)
    private
    { internal fields }
      f_KWD      : Tkwd;       // base action to take
      f_propType : TPropType;  // property type
      f_What     : Tiprop;     // ptoperty subtype
      f_Value    : Longint;    // ptoperty value
    public
     {public methods}
      constructor Create(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer);
      procedure SetParams(apropType: TPropType; aWhat: Tiprop; aValue: Longint);
      property KWD      : Tkwd   //     base action to take
        read f_KWD write f_KWD;
      property propType : TPropType //  property type
        read f_propType write f_propType;
      property What     : Tiprop    //  ptoperty subtype
        read f_What write f_What;
      property Value    : Longint  //   ptoperty value
        read f_Value write f_Value;
  end; {TSYM}

  TddKeywordList = class(Tl3KeyWords)
    private
      procedure AddFlag(const aKeyword: AnsiString; aIndex: Integer; aPropType:
          TPropType; aWhat: TIProp);
      procedure AddValue(const aKeyword: AnsiString; aIndex: Integer; aPropType:
          TPropType; aWhat: TIProp; aValue: Integer = UseParam);
      procedure AddSymbol(const aKeyword: AnsiString; aIndex: Integer; aPropType:
          TPropType; aWhat: TIProp; aValue: Integer = UseParam);
      procedure AddToggle(const aKeyword: AnsiString; aIndex: Integer; aPropType:
          TPropType; aWhat: TIProp; aValue: Integer = UseParam);
    public
      procedure AddDestination(const aKeyword: AnsiString; aIndex, aRds: Integer);
     {public methods }
      procedure AddKeyword(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer);
      procedure AddKeyword2(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer; apropType: TPropType; aWhat: Tiprop; aValue: Longint);
  end; {TKeywordList}


function RTFKeyWords: Tl3KeyWords;

function RTFKeywordsLite: Tl3Keywords;

procedure AddListTableKeywords(aKeywordList: TddKeywordList; Lite: Boolean =
    false);

procedure AddCellKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddCHPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddDOPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddDummyKeys1(aKeywordList: TddKeywordList);

procedure AddDummyKeys2(aKeywordList: TddKeywordList);

procedure AddDummyKeys3(aKeywordList: TddKeywordList);

procedure AddFrameKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddPAPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddRowKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddDestKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddTABKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddFontkeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddStyleKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddPictKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

procedure AddSEPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);

implementation

Uses
  l3Chars,

  ddConst,
  ddTypes,
  ddRTFConst,

  Math;

procedure TddKeywordList.AddDestination(const aKeyword: AnsiString; aIndex, aRds:
    Integer);
begin
 AddKeyword2(aKeyword, kwdDest, aIndex, propNone, 0, aRDS)
end;

procedure TddKeywordList.AddFlag(const aKeyword: AnsiString; aIndex: Integer;
    aPropType: TPropType; aWhat: TIProp);
begin
 AddKeyword2(aKeyword, kwdFlag, aIndex, apropType, aWhat, 0)
end;

procedure TddKeywordList.AddValue(const aKeyword: AnsiString; aIndex: Integer;
    aPropType: TPropType; aWhat: TIProp; aValue: Integer = UseParam);
begin
 AddKeyword2(aKeyword, kwdValu, aIndex, apropType, aWhat, aValue)
end;

procedure TddKeywordList.AddKeyword(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer);
var
 KW: TSYM;
begin
 KW:= TSYM.Create(aKeyword, aKWD, aIndex);
 try
  Add(KW);
 finally
  l3Free(KW);
 end; {try..finally}
end;

procedure TddKeywordList.AddKeyword2(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer;
                         apropType: TPropType; aWhat: Tiprop; aValue: Longint);
var
 KW: TSYM;
begin
 KW:= TSYM.Create(aKeyword, aKWD, aIndex);
 try
  KW.SetParams(apropType, aWhat, aValue);
  Add(KW);
 finally
  l3Free(KW);
 end; {try..finally}
end;

procedure TddKeywordList.AddSymbol(const aKeyword: AnsiString; aIndex: Integer;
    aPropType: TPropType; aWhat: TIProp; aValue: Integer = UseParam);
begin
 AddKeyword2(aKeyword, kwdSymb, aIndex, apropType, aWhat, Useparam)
end;

procedure TddKeywordList.AddToggle(const aKeyword: AnsiString; aIndex: Integer;
    aPropType: TPropType; aWhat: TIProp; aValue: Integer = UseParam);
begin
 AddKeyword2(aKeyword, kwdTogg, aIndex, apropType, aWhat, UseParam)
end;

constructor TSYM.Create(const aKeyword: AnsiString; aKWD: TKWD; aIndex: Integer);
begin
 inherited Create(aKeyWord, aIndex);
 KWD:= aKWD;
end;

procedure TSYM.SetParams(apropType: TPropType; aWhat: Tiprop; aValue: Longint);
begin
 propType:= apropType;
 What:= aWhat;
 Value:= aValue;
end;


var g_RTFKeyWords : TddKeyWordList = nil;

procedure RTFKeyWordsFree;
begin
 l3Free(g_RTFKeyWords);
end;

procedure AddDummyKeys1(aKeywordList: TddKeywordList);
begin
 with aKeywordList do
 begin
  AddKeyword2('ab', kwdTogg, togg_ab, propNone, 0, 0);
  AddKeyword2('abslock', kwdFlag, flag_abslock, propNone, 0, 0);
  AddKeyword2('acaps', kwdTogg, togg_acaps, propNone, 0, 0);
  AddKeyword2('acf', kwdValu, valu_acf, propNone, 0, 0);
  AddKeyword2('additive', kwdFlag, flag_additive, propNone, 0, 0);
  AddKeyword2('adjustright', kwdFlag, flag_adjustright, propNone, 0, 0);
  AddKeyword2('adn', kwdValu, valu_adn, propNone, 0, 0);
  AddKeyword2('aenddoc', kwdFlag, flag_aenddoc, propNone, 0, 0);
  AddKeyword2('aendnotes', kwdFlag, flag_aendnotes, propNone, 0, 0);
  AddKeyword2('aexpnd', kwdValu, valu_aexpnd, propNone, 0, 0);
  AddKeyword2('af', kwdValu, valu_af, propNone, 0, 0);
  AddKeyword2('afs', kwdValu, valu_afs, propNone, 0, 0);
  AddKeyword2('aftnbj', kwdFlag, flag_aftnbj, propNone, 0, 0);
 end;
end;

procedure AddDummyKeys2(aKeywordList: TddKeywordList);
begin
 with aKeywordList do
 begin
  AddKeyword2('aftnnalc', kwdFlag, flag_aftnnalc, propNone, 0, 0);
  AddKeyword2('aftnnar', kwdFlag, flag_aftnnar, propNone, 0, 0);
  AddKeyword2('aftnnauc', kwdFlag, flag_aftnnauc, propNone, 0, 0);
  AddKeyword2('aftnnchi', kwdFlag, flag_aftnnchi, propNone, 0, 0);
  AddKeyword2('aftnnchosung', kwdFlag, flag_aftnnchosung, propNone, 0, 0);
  AddKeyword2('aftnncnum', kwdFlag, flag_aftnncnum, propNone, 0, 0);
  AddKeyword2('aftnndbar', kwdFlag, flag_aftnndbar, propNone, 0, 0);
  AddKeyword2('aftnndbnum', kwdFlag, flag_aftnndbnum, propNone, 0, 0);
  AddKeyword2('aftnndbnumd', kwdFlag, flag_aftnndbnumd, propNone, 0, 0);
  AddKeyword2('aftnndbnumk', kwdFlag, flag_aftnndbnumk, propNone, 0, 0);
  AddKeyword2('aftnndbnumt', kwdFlag, flag_aftnndbnumt, propNone, 0, 0);
  AddKeyword2('aftnnganada', kwdFlag, flag_aftnnganada, propNone, 0, 0);
  AddKeyword2('aftnngbnum', kwdFlag, flag_aftnngbnum, propNone, 0, 0);
  AddKeyword2('aftnngbnumd', kwdFlag, flag_aftnngbnumd, propNone, 0, 0);
  AddKeyword2('aftnngbnumk', kwdFlag, flag_aftnngbnumk, propNone, 0, 0);
  AddKeyword2('aftnngbnuml', kwdFlag, flag_aftnngbnuml, propNone, 0, 0);
  AddKeyword2('aftnnrlc', kwdFlag, flag_aftnnrlc, propNone, 0, 0);
  AddKeyword2('aftnnruc', kwdFlag, flag_aftnnruc, propNone, 0, 0);
  AddKeyword2('aftnnzodiac', kwdFlag, flag_aftnnzodiac, propNone, 0, 0);
  AddKeyword2('aftnnzodiacd', kwdFlag, flag_aftnnzodiacd, propNone, 0, 0);
  AddKeyword2('aftnnzodiacl', kwdFlag, flag_aftnnzodiacl, propNone, 0, 0);
  AddKeyword2('aftnrestart', kwdFlag, flag_aftnrestart, propNone, 0, 0);
  AddKeyword2('aftnrstcont', kwdFlag, flag_aftnrstcont, propNone, 0, 0);
 end;
end;

procedure AddDummyKeys3(aKeywordList: TddKeywordList);
begin
 with aKeywordList do
 begin
  AddKeyword2('aftnstart', kwdValu, valu_aftnstart, propNone, 0, 0);
  AddKeyword2('aftntj', kwdFlag, flag_aftntj, propNone, 0, 0);
  AddKeyword2('ai', kwdTogg, togg_ai, propNone, 0, 0);
  AddKeyword2('alang', kwdValu, valu_alang, propNone, 0, 0);
  AddKeyword2('allprot', kwdFlag, flag_allprot, propNone, 0, 0);
  AddKeyword2('alt', kwdFlag, flag_alt, propNone, 0, 0);
  AddKeyword2('animtext', kwdValu, valu_animtext, propNone, 0, 0);
  AddKeyword2('annotprot', kwdFlag, flag_annotprot, propNone, 0, 0);
  AddKeyword2('aoutl', kwdTogg, togg_aoutl, propNone, 0, 0);
  AddKeyword2('ascaps', kwdTogg, togg_ascaps, propNone, 0, 0);
  AddKeyword2('ashad', kwdTogg, togg_ashad, propNone, 0, 0);
  AddKeyword2('astrike', kwdTogg, togg_astrike, propNone, 0, 0);
  AddKeyword2('aul', kwdTogg, togg_aul, propNone, 0, 0);
  AddKeyword2('auld', kwdTogg, togg_auld, propNone, 0, 0);
  AddKeyword2('auldb', kwdTogg, togg_auldb, propNone, 0, 0);
  AddKeyword2('aulnone', kwdTogg, togg_aulnone, propNone, 0, 0);
  AddKeyword2('aulw', kwdTogg, togg_aulw, propNone, 0, 0);
  AddKeyword2('aup', kwdValu, valu_aup, propNone, 0, 0);
  AddKeyword2('bdbfhdr', kwdFlag, flag_bdbfhdr, propNone, 0, 0);
  AddKeyword2('bgbdiag', kwdFlag, flag_bgbdiag, propNone, 0, 0);
  AddKeyword2('bgcross', kwdFlag, flag_bgcross, propNone, 0, 0);
  AddKeyword2('bgdcross', kwdFlag, flag_bgdcross, propNone, 0, 0);
  AddKeyword2('bgdkbdiag', kwdFlag, flag_bgdkbdiag, propNone, 0, 0);
  AddKeyword2('bgdkcross', kwdFlag, flag_bgdkcross, propNone, 0, 0);
  AddKeyword2('bgdkdcross', kwdFlag, flag_bgdkdcross, propNone, 0, 0);
  AddKeyword2('bgdkfdiag', kwdFlag, flag_bgdkfdiag, propNone, 0, 0);
  AddKeyword2('bgdkhoriz', kwdFlag, flag_bgdkhoriz, propNone, 0, 0);
  AddKeyword2('bgdkvert', kwdFlag, flag_bgdkvert, propNone, 0, 0);
  AddKeyword2('bgfdiag', kwdFlag, flag_bgfdiag, propNone, 0, 0);
  AddKeyword2('bghoriz', kwdFlag, flag_bghoriz, propNone, 0, 0);
  AddKeyword2('bgvert', kwdFlag, flag_bgvert, propNone, 0, 0);
  AddKeyword2('binfsxn', kwdValu, valu_binfsxn, propSEP, 0, 0);
  AddKeyword2('binsxn', kwdValu, valu_binsxn, propSEP, 0, 0);
  AddKeyword2('bkmkcolf', kwdValu, valu_bkmkcolf, propNone, 0, 0);
  AddKeyword2('bkmkcoll', kwdValu, valu_bkmkcoll, propNone, 0, 0);
  AddKeyword2('bkmkpub', kwdFlag, flag_bkmkpub, propNone, 0, 0);
  AddKeyword2('bliptag', kwdValu, valu_bliptag, propNone, 0, 0);
  AddKeyword2('blipupi', kwdValu, valu_blipupi, propNone, 0, 0);
  AddKeyword2('brdrart', kwdValu, valu_brdrart, propNone, 0, 0);
  AddKeyword2('brdrbar', kwdFlag, flag_brdrbar, propNone, 0, 0);
  AddKeyword2('brdrbtw', kwdFlag, flag_brdrbtw, propNone, 0, 0);
  AddKeyword2('brdrframe', kwdFlag, flag_brdrframe, propNone, 0, 0);
  AddKeyword2('brkfrm', kwdFlag, flag_brkfrm, propNone, 0, 0);
  AddKeyword2('brsp', kwdValu, valu_brsp, propNone, 0, 0);
  AddKeyword2('bullet', kwdSymb, symb_bullet, propNone, 0, 0);
  AddKeyword2('bxe', kwdFlag, flag_bxe, propNone, 0, 0);
  AddKeyword2('cbpat', kwdValu, valu_cbpat, propNone, 0, 0);
  AddKeyword2('cchs', kwdValu, valu_cchs, propNone, 0, 0);
  AddKeyword2('cfpat', kwdValu, valu_cfpat, propNone, 0, 0);
  AddKeyword2('cgrid', kwdValu, valu_cgrid, propNone, 0, 0);
  AddKeyword2('charscalex', kwdValu, valu_charscalex, propNone, 0, 0);
  AddKeyword2('chatn', kwdSymb, symb_chatn, propNone, 0, 0);
  AddKeyword2('chbgbdiag', kwdFlag, flag_chbgbdiag, propNone, 0, 0);
  AddKeyword2('chbgcross', kwdFlag, flag_chbgcross, propNone, 0, 0);
  AddKeyword2('chbgdcross', kwdFlag, flag_chbgdcross, propNone, 0, 0);
  AddKeyword2('chbgdkbdiag', kwdFlag, flag_chbgdkbdiag, propNone, 0, 0);
  AddKeyword2('chbgdkcross', kwdFlag, flag_chbgdkcross, propNone, 0, 0);
  AddKeyword2('chbgdkdcross', kwdFlag, flag_chbgdkdcross, propNone, 0, 0);
  AddKeyword2('chbgdkfdiag', kwdFlag, flag_chbgdkfdiag, propNone, 0, 0);
  AddKeyword2('chbgdkhoriz', kwdFlag, flag_chbgdkhoriz, propNone, 0, 0);
  AddKeyword2('chbgdkvert', kwdFlag, flag_chbgdkvert, propNone, 0, 0);
  AddKeyword2('chbgfdiag', kwdFlag, flag_chbgfdiag, propNone, 0, 0);
  AddKeyword2('chbghoriz', kwdFlag, flag_chbghoriz, propNone, 0, 0);
  AddKeyword2('chbgvert', kwdFlag, flag_chbgvert, propNone, 0, 0);
  AddKeyword2('chbrdr', kwdFlag, flag_chbrdr, propNone, 0, 0);
  AddKeyword2('chcfpat', kwdValu, valu_chcfpat, propNone, 0, 0);
  AddKeyword2('chdate', kwdSymb, symb_chdate, propNone, 0, 0);
  AddKeyword2('chdpa', kwdSymb, symb_chdpa, propNone, 0, 0);
  AddKeyword2('chdpl', kwdSymb, symb_chdpl, propNone, 0, 0);

  AddKeyword2('chftnsep', kwdSymb, symb_chftnsep, propNone, 0, 0);
  AddKeyword2('chftnsepc', kwdSymb, symb_chftnsepc, propNone, 0, 0);
  AddKeyword2('chpgn', kwdSymb, symb_chpgn, propNone, 0, 0);
  AddKeyword2('chshdng', kwdValu, valu_chshdng, propNone, 0, 0);
  AddKeyword2('chtime', kwdSymb, symb_chtime, propNone, 0, 0);
  AddKeyword2('clbgdkcross', kwdFlag, flag_clbgdkcross, propNone, 0, 0);
  AddKeyword2('clbgdkdcross', kwdFlag, flag_clbgdkdcross, propNone, 0, 0);
  AddKeyword2('clbgdkfdiag', kwdFlag, flag_clbgdkfdiag, propNone, 0, 0);
  AddKeyword2('clbgdkhor', kwdFlag, flag_clbgdkhor, propNone, 0, 0);
  AddKeyword2('clbgdkvert', kwdFlag, flag_clbgdkvert, propNone, 0, 0);
  AddKeyword2('clbgfdiag', kwdFlag, flag_clbgfdiag, propNone, 0, 0);
  AddKeyword2('clbghoriz', kwdFlag, flag_clbghoriz, propNone, 0, 0);
  AddKeyword2('clbgvert', kwdFlag, flag_clbgvert, propNone, 0, 0);

  AddKeyword2('clshdng', kwdValu, valu_clshdng, propNone, 0, 0);
  AddKeyword2('cltxlrtb', kwdFlag, flag_cltxlrtb, propNone, 0, 0);
  AddKeyword2('cltxtbrl', kwdFlag, flag_cltxtbrl, propNone, 0, 0);

  AddKeyword2('colsx', kwdValu, valu_colsx, propNone, 0, 0);

  AddKeyword2('cpg', kwdValu, valu_cpg, propNone, 0, 0);
  AddKeyword2('crauth', kwdValu, valu_crauth, propNone, 0, 0);
  AddKeyword2('crdate', kwdValu, valu_crdate, propNone, 0, 0);

  AddKeyword2('ctrl', kwdFlag, flag_ctrl, propNone, 0, 0);
  AddKeyword2('cvmme', kwdFlag, flag_cvmme, propNone, 0, 0);

  AddKeyword2('date', kwdFlag, flag_date, propNone, 0, 0);
  AddKeyword2('dfrauth', kwdValu, valu_dfrauth, propNone, 0, 0);
  AddKeyword2('dfrdate', kwdValu, valu_dfrdate, propNone, 0, 0);
  AddKeyword2('dfrmtxtx', kwdValu, valu_dfrmtxtx, propNone, 0, 0);
  AddKeyword2('dfrmtxty', kwdValu, valu_dfrmtxty, propNone, 0, 0);
  AddKeyword2('dfrstart', kwdValu, valu_dfrstart, propNone, 0, 0);
  AddKeyword2('dfrstop', kwdValu, valu_dfrstop, propNone, 0, 0);
  AddKeyword2('dfrxst', kwdValu, valu_dfrxst, propNone, 0, 0);
  AddKeyword2('dgmargin', kwdFlag, flag_dgmargin, propNone, 0, 0);
  AddKeyword2('dibitmap', kwdValu, valu_dibitmap, propNone, 0, 0);
  AddKeyword2('dn', kwdValu, valu_dn, propNone, 0, 0);
  AddKeyword2('dntblnsbdb', kwdFlag, flag_dntblnsbdb, propNone, 0, 0);

  AddKeyword2('dobxcolumn', kwdFlag, flag_dobxcolumn, propNone, 0, 0);
  AddKeyword2('dobxmargin', kwdFlag, flag_dobxmargin, propNone, 0, 0);
  AddKeyword2('dobxpage', kwdFlag, flag_dobxpage, propNone, 0, 0);
  AddKeyword2('dobymargin', kwdFlag, flag_dobymargin, propNone, 0, 0);
  AddKeyword2('dobypage', kwdFlag, flag_dobypage, propNone, 0, 0);
  AddKeyword2('dobypara', kwdFlag, flag_dobypara, propNone, 0, 0);

  AddKeyword2('doctemp', kwdFlag, flag_doctemp, propNone, 0, 0);
  AddKeyword2('doctype', kwdValu, valu_doctype, propNone, 0, 0);

  AddKeyword2('dodhgt', kwdValu, valu_dodhgt, propNone, 0, 0);
  AddKeyword2('dolock', kwdFlag, flag_dolock, propNone, 0, 0);
  AddKeyword2('dpaendhol', kwdFlag, flag_dpaendhol, propNone, 0, 0);
  AddKeyword2('dpaendl', kwdValu, valu_dpaendl, propNone, 0, 0);
  AddKeyword2('dpaendsol', kwdFlag, flag_dpaendsol, propNone, 0, 0);
  AddKeyword2('dpaendw', kwdValu, valu_dpaendw, propNone, 0, 0);
  AddKeyword2('dparc', kwdFlag, flag_dparc, propNone, 0, 0);
  AddKeyword2('dparcflipx', kwdFlag, flag_dparcflipx, propNone, 0, 0);
  AddKeyword2('dparcflipy', kwdFlag, flag_dparcflipy, propNone, 0, 0);
  AddKeyword2('dpastarthol', kwdFlag, flag_dpastarthol, propNone, 0, 0);
  AddKeyword2('dpastartl', kwdValu, valu_dpastartl, propNone, 0, 0);
  AddKeyword2('dpastartsol', kwdFlag, flag_dpastartsol, propNone, 0, 0);
  AddKeyword2('dpastartw', kwdValu, valu_dpastartw, propNone, 0, 0);
  AddKeyword2('dpcallout', kwdFlag, flag_dpcallout, propNone, 0, 0);
  AddKeyword2('dpcoa', kwdValu, valu_dpcoa, propNone, 0, 0);
  AddKeyword2('dpcoaccent', kwdFlag, flag_dpcoaccent, propNone, 0, 0);
  AddKeyword2('dpcobestfit', kwdFlag, flag_dpcobestfit, propNone, 0, 0);
  AddKeyword2('dpcoborder', kwdFlag, flag_dpcoborder, propNone, 0, 0);
  AddKeyword2('dpcodabs', kwdValu, valu_dpcodabs, propNone, 0, 0);
  AddKeyword2('dpcodbottom', kwdFlag, flag_dpcodbottom, propNone, 0, 0);
  AddKeyword2('dpcodcenter', kwdFlag, flag_dpcodcenter, propNone, 0, 0);
  AddKeyword2('dpcodescent', kwdValu, valu_dpcodescent, propNone, 0, 0);
  AddKeyword2('dpcodtop', kwdFlag, flag_dpcodtop, propNone, 0, 0);
  AddKeyword2('dpcolength', kwdValu, valu_dpcolength, propNone, 0, 0);
  AddKeyword2('dpcominusx', kwdFlag, flag_dpcominusx, propNone, 0, 0);
  AddKeyword2('dpcominusy', kwdFlag, flag_dpcominusy, propNone, 0, 0);
  AddKeyword2('dpcooffset', kwdValu, valu_dpcooffset, propNone, 0, 0);
  AddKeyword2('dpcosmarta', kwdFlag, flag_dpcosmarta, propNone, 0, 0);
  AddKeyword2('dpcotdouble', kwdFlag, flag_dpcotdouble, propNone, 0, 0);
  AddKeyword2('dpcotright', kwdFlag, flag_dpcotright, propNone, 0, 0);
  AddKeyword2('dpcotsingle', kwdFlag, flag_dpcotsingle, propNone, 0, 0);
  AddKeyword2('dpcottriple', kwdFlag, flag_dpcottriple, propNone, 0, 0);
  AddKeyword2('dpcount', kwdValu, valu_dpcount, propNone, 0, 0);
  AddKeyword2('dpellipse', kwdFlag, flag_dpellipse, propNone, 0, 0);
  AddKeyword2('dpendgroup', kwdFlag, flag_dpendgroup, propNone, 0, 0);
  AddKeyword2('dpfillbgcb', kwdValu, valu_dpfillbgcb, propNone, 0, 0);
  AddKeyword2('dpfillbgcg', kwdValu, valu_dpfillbgcg, propNone, 0, 0);
  AddKeyword2('dpfillbgcr', kwdValu, valu_dpfillbgcr, propNone, 0, 0);
  AddKeyword2('dpfillbggray', kwdValu, valu_dpfillbggray, propNone, 0, 0);
  AddKeyword2('dpfillbgpal', kwdFlag, flag_dpfillbgpal, propNone, 0, 0);
  AddKeyword2('dpfillfgcb', kwdValu, valu_dpfillfgcb, propNone, 0, 0);
  AddKeyword2('dpfillfgcg', kwdValu, valu_dpfillfgcg, propNone, 0, 0);
  AddKeyword2('dpfillfgcr', kwdValu, valu_dpfillfgcr, propNone, 0, 0);
  AddKeyword2('dpfillfggray', kwdValu, valu_dpfillfggray, propNone, 0, 0);
  AddKeyword2('dpfillfgpal', kwdFlag, flag_dpfillfgpal, propNone, 0, 0);
  AddKeyword2('dpfillpat', kwdValu, valu_dpfillpat, propNone, 0, 0);
  AddKeyword2('dpgroup', kwdFlag, flag_dpgroup, propNone, 0, 0);
  AddKeyword2('dpline', kwdFlag, flag_dpline, propNone, 0, 0);
  AddKeyword2('dplinecob', kwdValu, valu_dplinecob, propNone, 0, 0);
  AddKeyword2('dplinecog', kwdValu, valu_dplinecog, propNone, 0, 0);
  AddKeyword2('dplinecor', kwdValu, valu_dplinecor, propNone, 0, 0);
  AddKeyword2('dplinedado', kwdFlag, flag_dplinedado, propNone, 0, 0);
  AddKeyword2('dplinedadodo', kwdFlag, flag_dplinedadodo, propNone, 0, 0);
  AddKeyword2('dplinedash', kwdFlag, flag_dplinedash, propNone, 0, 0);
  AddKeyword2('dplinedot', kwdFlag, flag_dplinedot, propNone, 0, 0);
  AddKeyword2('dplinegray', kwdValu, valu_dplinegray, propNone, 0, 0);
  AddKeyword2('dplinehollow', kwdFlag, flag_dplinehollow, propNone, 0, 0);
  AddKeyword2('dplinepal', kwdFlag, flag_dplinepal, propNone, 0, 0);
  AddKeyword2('dplinesolid', kwdFlag, flag_dplinesolid, propNone, 0, 0);
  AddKeyword2('dplinew', kwdValu, valu_dplinew, propNone, 0, 0);
  AddKeyword2('dppolycount', kwdValu, valu_dppolycount, propNone, 0, 0);
  AddKeyword2('dppolygon', kwdFlag, flag_dppolygon, propNone, 0, 0);
  AddKeyword2('dppolyline', kwdFlag, flag_dppolyline, propNone, 0, 0);
  AddKeyword2('dpptx', kwdValu, valu_dpptx, propNone, 0, 0);
  AddKeyword2('dppty', kwdValu, valu_dppty, propNone, 0, 0);
  AddKeyword2('dprect', kwdFlag, flag_dprect, propNone, 0, 0);
  AddKeyword2('dproundr', kwdFlag, flag_dproundr, propNone, 0, 0);
  AddKeyword2('dpshadow', kwdFlag, flag_dpshadow, propNone, 0, 0);
  AddKeyword2('dpshadx', kwdValu, valu_dpshadx, propNone, 0, 0);
  AddKeyword2('dpshady', kwdValu, valu_dpshady, propNone, 0, 0);
  AddKeyword2('dptxbx', kwdFlag, flag_dptxbx, propNone, 0, 0);
  AddKeyword2('dptxbxmar', kwdValu, valu_dptxbxmar, propNone, 0, 0);

  AddKeyword2('dpx', kwdValu, valu_dpx, propNone, 0, 0);
  AddKeyword2('dpxsize', kwdValu, valu_dpxsize, propNone, 0, 0);
  AddKeyword2('dpy', kwdValu, valu_dpy, propNone, 0, 0);
  AddKeyword2('dpysize', kwdValu, valu_dpysize, propNone, 0, 0);
  AddKeyword2('dropcapli', kwdValu, valu_dropcapli, propNone, 0, 0);
  AddKeyword2('dropcapt', kwdValu, valu_dropcapt, propNone, 0, 0);
  AddKeyword2('fracwidth', kwdFlag, flag_fracwidth, propNone, 0, 0);
  AddKeyword2('frelative', kwdValu, valu_frelative, propNone, 0, 0);
  AddKeyword2('fromtext', kwdFlag, flag_fromtext, propNone, 0, 0);

  AddKeyword2('ftnalt', kwdFlag, flag_ftnalt, propNone, 0, 0);
  AddKeyword2('ftnbj', kwdFlag, flag_ftnbj, propNone, 0, 0);

  AddKeyword2('ftnil', kwdFlag, flag_ftnil, propNone, 0, 0);
  AddKeyword2('ftnnalc', kwdFlag, flag_ftnnalc, propNone, 0, 0);
  AddKeyword2('ftnnar', kwdFlag, flag_ftnnar, propNone, 0, 0);
  AddKeyword2('ftnnauc', kwdFlag, flag_ftnnauc, propNone, 0, 0);
  AddKeyword2('ftnnchi', kwdFlag, flag_ftnnchi, propNone, 0, 0);
  AddKeyword2('ftnnchosung', kwdFlag, flag_ftnnchosung, propNone, 0, 0);
  AddKeyword2('ftnncnum', kwdFlag, flag_ftnncnum, propNone, 0, 0);
  AddKeyword2('ftnndbar', kwdFlag, flag_ftnndbar, propNone, 0, 0);
  AddKeyword2('ftnndbnum', kwdFlag, flag_ftnndbnum, propNone, 0, 0);
  AddKeyword2('ftnndbnumd', kwdFlag, flag_ftnndbnumd, propNone, 0, 0);
  AddKeyword2('ftnndbnumk', kwdFlag, flag_ftnndbnumk, propNone, 0, 0);
  AddKeyword2('ftnndbnumt', kwdFlag, flag_ftnndbnumt, propNone, 0, 0);
  AddKeyword2('ftnnganada', kwdFlag, flag_ftnnganada, propNone, 0, 0);
  AddKeyword2('ftnngbnum', kwdFlag, flag_ftnngbnum, propNone, 0, 0);
  AddKeyword2('ftnngbnumd', kwdFlag, flag_ftnngbnumd, propNone, 0, 0);
  AddKeyword2('ftnngbnumk', kwdFlag, flag_ftnngbnumk, propNone, 0, 0);
  AddKeyword2('ftnngbnuml', kwdFlag, flag_ftnngbnuml, propNone, 0, 0);
  AddKeyword2('ftnnrlc', kwdFlag, flag_ftnnrlc, propNone, 0, 0);
  AddKeyword2('ftnnruc', kwdFlag, flag_ftnnruc, propNone, 0, 0);
  AddKeyword2('ftnnzodiac', kwdFlag, flag_ftnnzodiac, propNone, 0, 0);
  AddKeyword2('ftnnzodiacd', kwdFlag, flag_ftnnzodiacd, propNone, 0, 0);
  AddKeyword2('ftnnzodiacl', kwdFlag, flag_ftnnzodiacl, propNone, 0, 0);
  AddKeyword2('ftnrestart', kwdFlag, flag_ftnrestart, propNone, 0, 0);
  AddKeyword2('ftnrstcont', kwdFlag, flag_ftnrstcont, propNone, 0, 0);
  AddKeyword2('ftnrstpg', kwdFlag, flag_ftnrstpg, propNone, 0, 0);

  AddKeyword2('ftnstart', kwdValu, valu_ftnstart, propNone, 0, 0);
  AddKeyword2('ftntj', kwdFlag, flag_ftntj, propNone, 0, 0);
  AddKeyword2('fttruetype', kwdFlag, flag_fttruetype, propNone, 0, 0);
  AddKeyword2('fvaliddos', kwdFlag, flag_fvaliddos, propNone, 0, 0);
  AddKeyword2('fvalidhpfs', kwdFlag, flag_fvalidhpfs, propNone, 0, 0);
  AddKeyword2('fvalidmac', kwdFlag, flag_fvalidmac, propNone, 0, 0);
  AddKeyword2('fvalidntfs', kwdFlag, flag_fvalidntfs, propNone, 0, 0);
  AddKeyword2('eight', kwdFlag, flag_eight, propNone, 0, 0);
  AddKeyword2('dxfrtext', kwdValu, valu_dxfrtext, propNone, 0, 0);

  AddKeyword2('emspace', kwdSymb, symb_emspace, propNone, 0, 0);

  AddKeyword2('enddoc', kwdFlag, flag_enddoc, propNone, 0, 0);
  AddKeyword2('endnhere', kwdFlag, flag_endnhere, propNone, 0, 0);
  AddKeyword2('endnotes', kwdFlag, flag_endnotes, propNone, 0, 0);
  AddKeyword2('enspace', kwdSymb, symb_enspace, propNone, 0, 0);
  AddKeyword2('expnd', kwdValu, valu_expnd, propNone, 0, 0);
  AddKeyword2('expndtw', kwdValu, valu_expndtw, propNone, 0, 0);
  AddKeyword2('expshrtn', kwdFlag, flag_expshrtn, propNone, 0, 0);

  AddKeyword2('faauto', kwdValu, valu_faauto, propNone, 0, 0);
  AddKeyword2('facingp', kwdFlag, flag_facingp, propNone, 0, 0);

  AddKeyword2('fbias', kwdValu, valu_fbias, propNone, 0, 0);
  AddKeyword2('gcw', kwdValu, valu_gcw, propNone, 0, 0);
  AddKeyword2('fet', kwdValu, valu_fet, propNone, 0, 0);
  AddKeyword2('ffhaslistbox', kwdValu, valu_ffhaslistbox, propNone, 0, 0);

  AddKeyword2('ffhps', kwdValu, valu_ffhps, propNone, 0, 0);

  AddKeyword2('ffmaxlen', kwdValu, valu_ffmaxlen, propNone, 0, 0);

  AddKeyword2('ffownhelp', kwdValu, valu_ffownhelp, propNone, 0, 0);
  AddKeyword2('ffownstat', kwdValu, valu_ffownstat, propNone, 0, 0);
  AddKeyword2('ffprot', kwdValu, valu_ffprot, propNone, 0, 0);
  AddKeyword2('ffrecalc', kwdValu, valu_ffrecalc, propNone, 0, 0);
  AddKeyword2('ffsize', kwdValu, valu_ffsize, propNone, 0, 0);
  AddKeyword2('fftypetxt', kwdValu, valu_fftypetxt, propNone, 0, 0);
  AddKeyword2('fid', kwdValu, valu_fid, propNone, 0, 0);
  AddKeyword2('fldalt', kwdFlag, flag_fldalt, propNone, 0, 0);
  AddKeyword2('flddirty', kwdFlag, flag_flddirty, propNone, 0, 0);
  AddKeyword2('fldedit', kwdFlag, flag_fldedit, propNone, 0, 0);
  AddKeyword2('fldlock', kwdFlag, flag_fldlock, propNone, 0, 0);
  AddKeyword2('fn', kwdValu, valu_fn, propNone, 0, 0);
  AddKeyword2('fnetwork', kwdFlag, flag_fnetwork, propNone, 0, 0);
  AddKeyword2('footery', kwdValu, valu_footery, propNone, 0, 0);
  AddKeyword2('formdisp', kwdFlag, flag_formdisp, propNone, 0, 0);
  AddKeyword2('formprot', kwdFlag, flag_formprot, propNone, 0, 0);
  AddKeyword2('formshade', kwdFlag, flag_formshade, propNone, 0, 0);
  AddKeyword2('fosnum', kwdValu, valu_fosnum, propNone, 0, 0);
  AddKeyword2('gutter', kwdValu, valu_gutter, propNone, 0, 0);
  AddKeyword2('guttersxn', kwdValu, valu_guttersxn, propNone, 0, 0);
  AddKeyword2('headery', kwdValu, valu_headery, propNone, 0, 0);
  AddKeyword2('hlfr', kwdValu, valu_hlfr, propNone, 0, 0);
  AddKeyword2('hlinkbase', kwdValu, valu_hlinkbase, propNone, 0, 0);
  AddKeyword2('hlloc', kwdValu, valu_hlloc, propNone, 0, 0);
  AddKeyword2('hlsrc', kwdValu, valu_hlsrc, propNone, 0, 0);

  AddKeyword2('hyphauto', kwdTogg, togg_hyphauto, propNone, 0, 0);
  AddKeyword2('hyphcaps', kwdTogg, togg_hyphcaps, propNone, 0, 0);
  AddKeyword2('hyphconsec', kwdValu, valu_hyphconsec, propNone, 0, 0);
  AddKeyword2('hyphhotz', kwdValu, valu_hyphhotz, propNone, 0, 0);

  AddKeyword2('id', kwdValu, valu_id, propNone, 0, 0);
  AddKeyword2('impr', kwdTogg, togg_impr, propNone, 0, 0);

  AddKeyword2('ixe', kwdFlag, flag_ixe, propNone, 0, 0);

  AddKeyword2('kerning', kwdValu, valu_kerning, propNone, 0, 0);

  AddKeyword2('landscape', kwdFlag, flag_landscape, propNone, 0, 0);

  AddKeyword2('linebetcol', kwdFlag, flag_linebetcol, propNone, 0, 0);
  AddKeyword2('linecont', kwdFlag, flag_linecont, propNone, 0, 0);
  AddKeyword2('linemod', kwdValu, valu_linemod, propNone, 0, 0);
  AddKeyword2('lineppage', kwdFlag, flag_lineppage, propNone, 0, 0);
  AddKeyword2('linerestart', kwdFlag, flag_linerestart, propNone, 0, 0);
  AddKeyword2('linestart', kwdValu, valu_linestart, propNone, 0, 0);
  AddKeyword2('linestarts', kwdValu, valu_linestarts, propNone, 0, 0);
  AddKeyword2('linex', kwdValu, valu_linex, propNone, 0, 0);
  AddKeyword2('linkself', kwdFlag, flag_linkself, propNone, 0, 0);
  AddKeyword2('linkstyles', kwdFlag, flag_linkstyles, propNone, 0, 0);
  AddKeyword2('linkval', kwdValu, valu_linkval, propNone, 0, 0);
  AddKeyword2('ltrch', kwdFlag, flag_ltrch, propNone, 0, 0);
  AddKeyword2('ltrdoc', kwdFlag, flag_ltrdoc, propNone, 0, 0);
  AddKeyword2('ltrmark', kwdSymb, symb_ltrmark, propNone, 0, 0);
  AddKeyword2('ltrpar', kwdFlag, flag_ltrpar, propNone, 0, 0);
  AddKeyword2('ltrrow', kwdFlag, flag_ltrrow, propNone, 0, 0);
  AddKeyword2('ltrsect', kwdFlag, flag_ltrsect, propNone, 0, 0);
  AddKeyword2('lytexcttp', kwdFlag, flag_lytexcttp, propNone, 0, 0);
  AddKeyword2('lytprtmet', kwdFlag, flag_lytprtmet, propNone, 0, 0);

  AddKeyword2('macpict', kwdFlag, flag_macpict, propNone, 0, 0);
  AddKeyword2('makebackup', kwdFlag, flag_makebackup, propNone, 0, 0);
  AddKeyword2('margmirror', kwdFlag, flag_margmirror, propNone, 0, 0);
  AddKeyword2('msmcap', kwdFlag, flag_msmcap, propNone, 0, 0);
  AddKeyword2('nocolbal', kwdFlag, flag_nocolbal, propNone, 0, 0);
  AddKeyword2('noextrasprl', kwdFlag, flag_noextrasprl, propNone, 0, 0);
  AddKeyword2('nolead', kwdFlag, flag_nolead, propNone, 0, 0);
  AddKeyword2('noline', kwdFlag, flag_noline, propNone, 0, 0);
  AddKeyword2('nosectexpand', kwdFlag, flag_nosectexpand, propNone, 0, 0);
  AddKeyword2('nosnaplinegrid', kwdFlag, flag_nosnaplinegrid, propNone, 0, 0);
  AddKeyword2('nospaceforul', kwdFlag, flag_nospaceforul, propNone, 0, 0);
  AddKeyword2('nosupersub', kwdFlag, flag_nosupersub, propNone, 0, 0);
  AddKeyword2('notabind', kwdFlag, flag_notabind, propNone, 0, 0);
  AddKeyword2('noultrlspc', kwdFlag, flag_noultrlspc, propNone, 0, 0);
  AddKeyword2('nowidctlpar', kwdFlag, flag_nowidctlpar, propNone, 0, 0);
  AddKeyword2('nowrap', kwdFlag, flag_nowrap, propNone, 0, 0);
  AddKeyword2('noxlattoyen', kwdFlag, flag_noxlattoyen, propNone, 0, 0);

  AddKeyword2('objalign', kwdValu, valu_objalign, propNone, 0, 0);
  AddKeyword2('objattph', kwdFlag, flag_objattph, propNone, 0, 0);
  AddKeyword2('objautlink', kwdFlag, flag_objautlink, propNone, 0, 0);

  AddKeyword2('objcropb', kwdValu, valu_objcropb, propNone, 0, 0);
  AddKeyword2('objcropl', kwdValu, valu_objcropl, propNone, 0, 0);
  AddKeyword2('objcropr', kwdValu, valu_objcropr, propNone, 0, 0);
  AddKeyword2('objcropt', kwdValu, valu_objcropt, propNone, 0, 0);

  AddKeyword2('objemb', kwdFlag, flag_objemb, propNone, 0, 0);
  AddKeyword2('objh', kwdValu, valu_objh, propNone, 0, 0);
  AddKeyword2('objhtml', kwdFlag, flag_objhtml, propNone, 0, 0);
  AddKeyword2('objicemb', kwdFlag, flag_objicemb, propNone, 0, 0);
  AddKeyword2('objlink', kwdFlag, flag_objlink, propNone, 0, 0);
  AddKeyword2('objlock', kwdFlag, flag_objlock, propNone, 0, 0);

  AddKeyword2('objocx', kwdFlag, flag_objocx, propNone, 0, 0);
  AddKeyword2('objpub', kwdFlag, flag_objpub, propNone, 0, 0);
  AddKeyword2('objscalex', kwdValu, valu_objscalex, propNone, 0, 0);
  AddKeyword2('objscaley', kwdValu, valu_objscaley, propNone, 0, 0);

  AddKeyword2('objsetsize', kwdFlag, flag_objsetsize, propNone, 0, 0);
  AddKeyword2('objsub', kwdFlag, flag_objsub, propNone, 0, 0);

  AddKeyword2('objtransy', kwdValu, valu_objtransy, propNone, 0, 0);
  AddKeyword2('objupdate', kwdFlag, flag_objupdate, propNone, 0, 0);
  AddKeyword2('objw', kwdValu, valu_objw, propNone, 0, 0);
  AddKeyword2('oldlinewrap', kwdFlag, flag_oldlinewrap, propNone, 0, 0);

  AddKeyword2('otblrul', kwdFlag, flag_otblrul, propNone, 0, 0);
  AddKeyword2('outl', kwdTogg, togg_outl, propNone, 0, 0);
  AddKeyword2('outlinelevel', kwdValu, valu_outlinelevel, propNone, 0, 0);
  AddKeyword2('overlay', kwdFlag, flag_overlay, propNone, 0, 0);
  AddKeyword2('pagebb', kwdFlag, flag_pagebb, propNone, 0, 0);

  AddKeyword2('pgbrdrb', kwdFlag, flag_pgbrdrb, propNone, 0, 0);
  AddKeyword2('pgbrdrfoot', kwdFlag, flag_pgbrdrfoot, propNone, 0, 0);
  AddKeyword2('pgbrdrhead', kwdFlag, flag_pgbrdrhead, propNone, 0, 0);
  AddKeyword2('pgbrdrl', kwdFlag, flag_pgbrdrl, propNone, 0, 0);
  AddKeyword2('pgbrdropt', kwdValu, valu_pgbrdropt, propNone, 0, 0);
  AddKeyword2('pgbrdrr', kwdFlag, flag_pgbrdrr, propNone, 0, 0);
  AddKeyword2('pgbrdrsnap', kwdFlag, flag_pgbrdrsnap, propNone, 0, 0);
  AddKeyword2('pgbrdrt', kwdFlag, flag_pgbrdrt, propNone, 0, 0);
  AddKeyword2('pgnchosung', kwdFlag, flag_pgnchosung, propNone, 0, 0);
  AddKeyword2('pgncnum', kwdFlag, flag_pgncnum, propNone, 0, 0);
  AddKeyword2('pgncont', kwdFlag, flag_pgncont, propNone, 0, 0);
  AddKeyword2('pgndbnumk', kwdFlag, flag_pgndbnumk, propNone, 0, 0);
  AddKeyword2('pgndbnumt', kwdFlag, flag_pgndbnumt, propNone, 0, 0);
  AddKeyword2('pgndec', kwdFlag, flag_pgndec, propNone, 0, 0);
  AddKeyword2('pgnganada', kwdFlag, flag_pgnganada, propNone, 0, 0);
  AddKeyword2('pgngbnum', kwdFlag, flag_pgngbnum, propNone, 0, 0);
  AddKeyword2('pgngbnumd', kwdFlag, flag_pgngbnumd, propNone, 0, 0);
  AddKeyword2('pgngbnumk', kwdFlag, flag_pgngbnumk, propNone, 0, 0);
  AddKeyword2('pgngbnuml', kwdFlag, flag_pgngbnuml, propNone, 0, 0);
  AddKeyword2('pgnhn', kwdValu, valu_pgnhn, propNone, 0, 0);
  AddKeyword2('pgnhnsc', kwdFlag, flag_pgnhnsc, propNone, 0, 0);
  AddKeyword2('pgnhnsh', kwdFlag, flag_pgnhnsh, propNone, 0, 0);
  AddKeyword2('pgnhnsm', kwdFlag, flag_pgnhnsm, propNone, 0, 0);
  AddKeyword2('pgnhnsn', kwdFlag, flag_pgnhnsn, propNone, 0, 0);
  AddKeyword2('pgnhnsp', kwdFlag, flag_pgnhnsp, propNone, 0, 0);
  AddKeyword2('pgnlcltr', kwdFlag, flag_pgnlcltr, propNone, 0, 0);
  AddKeyword2('pgnlcrm', kwdFlag, flag_pgnlcrm, propNone, 0, 0);
  AddKeyword2('pgnrestart', kwdFlag, flag_pgnrestart, propNone, 0, 0);
  AddKeyword2('pgnstart', kwdValu, valu_pgnstart, propNone, 0, 0);
  AddKeyword2('pgnstarts', kwdValu, valu_pgnstarts, propNone, 0, 0);
  AddKeyword2('pgnucltr', kwdFlag, flag_pgnucltr, propNone, 0, 0);
  AddKeyword2('pgnucrm', kwdFlag, flag_pgnucrm, propNone, 0, 0);
  AddKeyword2('pgnx', kwdValu, valu_pgnx, propNone, 0, 0);
  AddKeyword2('pgny', kwdValu, valu_pgny, propNone, 0, 0);
  AddKeyword2('pgnzodiac', kwdFlag, flag_pgnzodiac, propNone, 0, 0);
  AddKeyword2('pgnzodiacd', kwdFlag, flag_pgnzodiacd, propNone, 0, 0);
  AddKeyword2('pgnzodiacl', kwdFlag, flag_pgnzodiacl, propNone, 0, 0);
  AddKeyword2('phcol', kwdFlag, flag_phcol, propNone, 0, 0);
  AddKeyword2('phmrg', kwdFlag, flag_phmrg, propNone, 0, 0);
  AddKeyword2('phpg', kwdFlag, flag_phpg, propNone, 0, 0);
  AddKeyword2('picbmp', kwdFlag, flag_picbmp, propNone, 0, 0);
  AddKeyword2('picbpp', kwdValu, valu_picbpp, propNone, 0, 0);
  AddKeyword2('pich', kwdValu, valu_pich, propNone, 0, 0);
  AddKeyword2('picscaled', kwdFlag, flag_picscaled, propNone, 0, 0);
  AddKeyword2('picw', kwdValu, valu_picw, propNone, 0, 0);
  AddKeyword2('pmmetafile', kwdValu, valu_pmmetafile, propNone, 0, 0);
  AddKeyword2('pnacross', kwdFlag, flag_pnacross, propNone, 0, 0);
  AddKeyword2('pnaiueo', kwdFlag, flag_pnaiueo, propNone, 0, 0);
  AddKeyword2('pnaiueod', kwdFlag, flag_pnaiueod, propNone, 0, 0);
  AddKeyword2('pnb', kwdTogg, togg_pnb, propNone, 0, 0);
  AddKeyword2('pncaps', kwdTogg, togg_pncaps, propNone, 0, 0);
  AddKeyword2('pncard', kwdFlag, flag_pncard, propNone, 0, 0);
  AddKeyword2('pncf', kwdValu, valu_pncf, propNone, 0, 0);
  AddKeyword2('pnchosung', kwdFlag, flag_pnchosung, propNone, 0, 0);
  AddKeyword2('pndbnumd', kwdFlag, flag_pndbnumd, propNone, 0, 0);
  AddKeyword2('pndbnumk', kwdFlag, flag_pndbnumk, propNone, 0, 0);
  AddKeyword2('pndbnuml', kwdFlag, flag_pndbnuml, propNone, 0, 0);
  AddKeyword2('pndbnumt', kwdFlag, flag_pndbnumt, propNone, 0, 0);
  AddKeyword2('pndec', kwdFlag, flag_pndec, propNone, 0, 0);
  AddKeyword2('pnf', kwdValu, valu_pnf, propNone, 0, 0);
  AddKeyword2('pnfs', kwdValu, valu_pnfs, propNone, 0, 0);
  AddKeyword2('pnganada', kwdFlag, flag_pnganada, propNone, 0, 0);
  AddKeyword2('pngbnum', kwdFlag, flag_pngbnum, propNone, 0, 0);
  AddKeyword2('pngbnumd', kwdFlag, flag_pngbnumd, propNone, 0, 0);
  AddKeyword2('pngbnumk', kwdFlag, flag_pngbnumk, propNone, 0, 0);
  AddKeyword2('pngbnuml', kwdFlag, flag_pngbnuml, propNone, 0, 0);
  AddKeyword2('pnhang', kwdFlag, flag_pnhang, propNone, 0, 0);
  AddKeyword2('pni', kwdTogg, togg_pni, propNone, 0, 0);
  AddKeyword2('pnindent', kwdValu, valu_pnindent, propNone, 0, 0);
  AddKeyword2('pnlcltr', kwdFlag, flag_pnlcltr, propNone, 0, 0);
  AddKeyword2('pnlcrm', kwdFlag, flag_pnlcrm, propNone, 0, 0);
  AddKeyword2('pnlvl', kwdValu, valu_pnlvl, propNone, 0, 0);
  AddKeyword2('pnlvlblt', kwdFlag, flag_pnlvlblt, propNone, 0, 0);
  AddKeyword2('pnlvlbody', kwdFlag, flag_pnlvlbody, propNone, 0, 0);
  AddKeyword2('pnlvlcont', kwdFlag, flag_pnlvlcont, propNone, 0, 0);
  AddKeyword2('pnnumonce', kwdFlag, flag_pnnumonce, propNone, 0, 0);
  AddKeyword2('pnord', kwdFlag, flag_pnord, propNone, 0, 0);
  AddKeyword2('pnordt', kwdFlag, flag_pnordt, propNone, 0, 0);
  AddKeyword2('pnprev', kwdFlag, flag_pnprev, propNone, 0, 0);
  AddKeyword2('pnqc', kwdFlag, flag_pnqc, propNone, 0, 0);
  AddKeyword2('pnql', kwdFlag, flag_pnql, propNone, 0, 0);
  AddKeyword2('pnqr', kwdFlag, flag_pnqr, propNone, 0, 0);
  AddKeyword2('pnrauth', kwdValu, valu_pnrauth, propNone, 0, 0);
  AddKeyword2('pnrdate', kwdValu, valu_pnrdate, propNone, 0, 0);
  AddKeyword2('pnrestart', kwdFlag, flag_pnrestart, propNone, 0, 0);
  AddKeyword2('pnrnfc', kwdValu, valu_pnrnfc, propNone, 0, 0);
  AddKeyword2('pnrnot', kwdFlag, flag_pnrnot, propNone, 0, 0);
  AddKeyword2('pnrpnbr', kwdValu, valu_pnrpnbr, propNone, 0, 0);
  AddKeyword2('pnrrgb', kwdValu, valu_pnrrgb, propNone, 0, 0);
  AddKeyword2('pnrstart', kwdValu, valu_pnrstart, propNone, 0, 0);
  AddKeyword2('pnrstop', kwdValu, valu_pnrstop, propNone, 0, 0);
  AddKeyword2('pnrxst', kwdValu, valu_pnrxst, propNone, 0, 0);
  AddKeyword2('pnscaps', kwdTogg, togg_pnscaps, propNone, 0, 0);

  AddKeyword2('pnsp', kwdValu, valu_pnsp, propNone, 0, 0);
  AddKeyword2('pnstart', kwdValu, valu_pnstart, propNone, 0, 0);
  AddKeyword2('pnstrike', kwdTogg, togg_pnstrike, propNone, 0, 0);

  AddKeyword2('pnucltr', kwdFlag, flag_pnucltr, propNone, 0, 0);
  AddKeyword2('pnucrm', kwdFlag, flag_pnucrm, propNone, 0, 0);
  AddKeyword2('pnul', kwdTogg, togg_pnul, propNone, 0, 0);
  AddKeyword2('pnuld', kwdFlag, flag_pnuld, propNone, 0, 0);
  AddKeyword2('pnuldb', kwdFlag, flag_pnuldb, propNone, 0, 0);
  AddKeyword2('pnulnone', kwdFlag, flag_pnulnone, propNone, 0, 0);
  AddKeyword2('pnulw', kwdFlag, flag_pnulw, propNone, 0, 0);
  AddKeyword2('pnzodiac', kwdFlag, flag_pnzodiac, propNone, 0, 0);
  AddKeyword2('pnzodiacd', kwdFlag, flag_pnzodiacd, propNone, 0, 0);
  AddKeyword2('pnzodiacl', kwdFlag, flag_pnzodiacl, propNone, 0, 0);
  AddKeyword2('posnegx', kwdValu, valu_posnegx, propNone, 0, 0);
  AddKeyword2('posnegy', kwdValu, valu_posnegy, propNone, 0, 0);
  AddKeyword2('posxc', kwdFlag, flag_posxc, propNone, 0, 0);
  AddKeyword2('posxi', kwdFlag, flag_posxi, propNone, 0, 0);
  AddKeyword2('posxl', kwdFlag, flag_posxl, propNone, 0, 0);
  AddKeyword2('posxo', kwdFlag, flag_posxo, propNone, 0, 0);
  AddKeyword2('posxr', kwdFlag, flag_posxr, propNone, 0, 0);
  AddKeyword2('posyb', kwdFlag, flag_posyb, propNone, 0, 0);
  AddKeyword2('posyc', kwdFlag, flag_posyc, propNone, 0, 0);
  AddKeyword2('posyil', kwdFlag, flag_posyil, propNone, 0, 0);
  AddKeyword2('posyin', kwdFlag, flag_posyin, propNone, 0, 0);
  AddKeyword2('posyout', kwdFlag, flag_posyout, propNone, 0, 0);
  AddKeyword2('posyt', kwdFlag, flag_posyt, propNone, 0, 0);
  AddKeyword2('prcolbl', kwdFlag, flag_prcolbl, propNone, 0, 0);
  AddKeyword2('printdata', kwdFlag, flag_printdata, propNone, 0, 0);

  AddKeyword2('propname', kwdValu, valu_propname, propNone, 0, 0);
  AddKeyword2('proptype', kwdValu, valu_proptype, propNone, 0, 0);
  AddKeyword2('psover', kwdFlag, flag_psover, propNone, 0, 0);
  AddKeyword2('psz', kwdValu, valu_psz, propNone, 0, 0);
  AddKeyword2('pubauto', kwdFlag, flag_pubauto, propNone, 0, 0);
  AddKeyword2('pvmrg', kwdFlag, flag_pvmrg, propNone, 0, 0);
  AddKeyword2('pvpara', kwdFlag, flag_pvpara, propNone, 0, 0);
  AddKeyword2('pvpg', kwdFlag, flag_pvpg, propNone, 0, 0);
  AddKeyword2('revauth', kwdValu, valu_revauth, propNone, 0, 0);
  AddKeyword2('revauthdel', kwdValu, valu_revauthdel, propNone, 0, 0);
  AddKeyword2('revbar', kwdValu, valu_revbar, propNone, 0, 0);
  AddKeyword2('revdttm', kwdValu, valu_revdttm, propNone, 0, 0);
  AddKeyword2('revdttmdel', kwdValu, valu_revdttmdel, propNone, 0, 0);
  AddKeyword2('revised', kwdTogg, togg_revised, propNone, 0, 0);
  AddKeyword2('revisions', kwdFlag, flag_revisions, propNone, 0, 0);
  AddKeyword2('revprop', kwdValu, valu_revprop, propNone, 0, 0);
  AddKeyword2('revprot', kwdFlag, flag_revprot, propNone, 0, 0);

  AddKeyword2('rsltbmp', kwdFlag, flag_rsltbmp, propNone, 0, 0);
  AddKeyword2('rsltmerge', kwdFlag, flag_rsltmerge, propNone, 0, 0);
  AddKeyword2('rsltpict', kwdFlag, flag_rsltpict, propNone, 0, 0);
  AddKeyword2('rsltrtf', kwdFlag, flag_rsltrtf, propNone, 0, 0);
  AddKeyword2('rslttxt', kwdFlag, flag_rslttxt, propNone, 0, 0);

  AddKeyword2('rtlch', kwdFlag, flag_rtlch, propNone, 0, 0);
  AddKeyword2('rtldoc', kwdFlag, flag_rtldoc, propNone, 0, 0);
  AddKeyword2('rtlmark', kwdSymb, symb_rtlmark, propNone, 0, 0);
  AddKeyword2('rtlpar', kwdFlag, flag_rtlpar, propNone, 0, 0);
  AddKeyword2('rtlrow', kwdFlag, flag_rtlrow, propNone, 0, 0);
  AddKeyword2('rtlsect', kwdFlag, flag_rtlsect, propNone, 0, 0);
  AddKeyword2('sautoupd', kwdFlag, flag_sautoupd, propNone, 0, 0);

  AddKeyword2('sbkcol', kwdFlag, flag_sbkcol, propNone, 0, 0);
  AddKeyword2('sbkeven', kwdFlag, flag_sbkeven, propNone, 0, 0);
  AddKeyword2('sbkodd', kwdFlag, flag_sbkodd, propNone, 0, 0);
  AddKeyword2('sbkpage', kwdFlag, flag_sbkpage, propNone, 0, 0);
  AddKeyword2('sbys', kwdFlag, flag_sbys, propNone, 0, 0);
  AddKeyword2('scaps', kwdTogg, togg_scaps, propNone, 0, 0);
  AddKeyword2('sec', kwdValu, valu_sec, propNone, 0, 0);
  AddKeyword2('sectdefaultcl', kwdValu, valu_sectdefaultcl, propNone, 0, 0);
  AddKeyword2('sectexpand', kwdValu, valu_sectexpand, propNone, 0, 0);
  AddKeyword2('sectlinegrid', kwdValu, valu_sectlinegrid, propNone, 0, 0);
  AddKeyword2('sectnum', kwdSymb, symb_sectnum, propNone, 0, 0);
  AddKeyword2('sectspecifycl', kwdValu, valu_sectspecifycl, propNone, 0, 0);
  AddKeyword2('sectspecifyl', kwdValu, valu_sectspecifyl, propNone, 0, 0);
  AddKeyword2('sectunlocked', kwdFlag, flag_sectunlocked, propNone, 0, 0);
  AddKeyword2('shad', kwdTogg, togg_shad, propNone, 0, 0);
  AddKeyword2('shading', kwdValu, valu_shading, propNone, 0, 0);
  AddKeyword2('shidden', kwdFlag, flag_shidden, propNone, 0, 0);
  AddKeyword2('shift', kwdFlag, flag_shift, propNone, 0, 0);
  AddKeyword2('shpbxcolumn', kwdFlag, flag_shpbxcolumn, propNone, 0, 0);
  AddKeyword2('shpbxmargin', kwdFlag, flag_shpbxmargin, propNone, 0, 0);
  AddKeyword2('shpbxpage', kwdFlag, flag_shpbxpage, propNone, 0, 0);
  AddKeyword2('shpbymargin', kwdFlag, flag_shpbymargin, propNone, 0, 0);
  AddKeyword2('shpbypage', kwdFlag, flag_shpbypage, propNone, 0, 0);
  AddKeyword2('shpbypara', kwdFlag, flag_shpbypara, propNone, 0, 0);
  AddKeyword2('shpfblwtxt', kwdValu, valu_shpfblwtxt, propNone, 0, 0);
  AddKeyword2('shpfhdr', kwdValu, valu_shpfhdr, propNone, 0, 0);
  AddKeyword2('shpgrp', kwdValu, valu_shpgrp, propNone, 0, 0);
  AddKeyword2('shplid', kwdValu, valu_shplid, propNone, 0, 0);
  AddKeyword2('shplockanchor', kwdFlag, flag_shplockanchor, propNone, 0, 0);

  AddKeyword2('shpwr', kwdValu, valu_shpwr, propNone, 0, 0);
  AddKeyword2('shpwrk', kwdValu, valu_shpwrk, propNone, 0, 0);
  AddKeyword2('shpz', kwdValu, valu_shpz, propNone, 0, 0);
  AddKeyword2('slmult', kwdValu, valu_slmult, propNone, 0, 0);
  AddKeyword2('softcol', kwdFlag, flag_softcol, propNone, 0, 0);
  AddKeyword2('softlheight', kwdValu, valu_softlheight, propNone, 0, 0);
  AddKeyword2('softline', kwdFlag, flag_softline, propNone, 0, 0);
  AddKeyword2('softpage', kwdFlag, flag_softpage, propNone, 0, 0);
  AddKeyword2('sprsbsp', kwdFlag, flag_sprsbsp, propNone, 0, 0);
  AddKeyword2('sprslnsp', kwdFlag, flag_sprslnsp, propNone, 0, 0);
  AddKeyword2('sprsspbf', kwdFlag, flag_sprsspbf, propNone, 0, 0);
  AddKeyword2('sprstsm', kwdFlag, flag_sprstsm, propNone, 0, 0);
  AddKeyword2('sprstsp', kwdFlag, flag_sprstsp, propNone, 0, 0);
  AddKeyword2('staticval', kwdValu, valu_staticval, propNone, 0, 0);
  AddKeyword2('stextflow', kwdValu, valu_stextflow, propNone, 0, 0);

  AddKeyword2('strikedl', kwdTogg, togg_strikedl, propNone, 0, 0);

  AddKeyword2('subdocument', kwdValu, valu_subdocument, propNone, 0, 0);
  AddKeyword2('subfontbysize', kwdFlag, flag_subfontbysize, propNone, 0, 0);

  AddKeyword2('swpbdr', kwdFlag, flag_swpbdr, propNone, 0, 0);
  AddKeyword2('tcelld', kwdFlag, flag_tcelld, propNone, 0, 0);
  AddKeyword2('tcf', kwdValu, valu_tcf, propNone, 0, 0);
  AddKeyword2('tcl', kwdValu, valu_tcl, propNone, 0, 0);
  AddKeyword2('tcn', kwdFlag, flag_tcn, propNone, 0, 0);

  AddKeyword2('time', kwdFlag, flag_time, propNone, 0, 0);

  AddKeyword2('titlepg', kwdFlag, flag_titlepg, propNone, 0, 0);
  AddKeyword2('transmf', kwdFlag, flag_transmf, propNone, 0, 0);

  AddKeyword2('truncatefont', kwdFlag, nonetruncatefont, propNone, 0, 0);

  AddKeyword2('uld', kwdFlag, flag_uld, propNone, 0, 0);
  AddKeyword2('uldash', kwdTogg, togg_uldash, propNone, 0, 0);
  AddKeyword2('uldashd', kwdTogg, togg_uldashd, propNone, 0, 0);
  AddKeyword2('uldashdd', kwdTogg, togg_uldashdd, propNone, 0, 0);
  AddKeyword2('uldb', kwdFlag, flag_uldb, propNone, 0, 0);
  AddKeyword2('ulth', kwdTogg, togg_ulth, propNone, 0, 0);
  AddKeyword2('ulw', kwdFlag, flag_ulw, propNone, 0, 0);
  AddKeyword2('ulwave', kwdTogg, togg_ulwave, propNone, 0, 0);

  AddKeyword2('up', kwdValu, valu_up, propNone, 0, 0);
  AddKeyword2('vertalb', kwdFlag, flag_vertalb, propNone, 0, 0);
  AddKeyword2('vertalc', kwdFlag, flag_vertalc, propNone, 0, 0);
  AddKeyword2('vertalj', kwdFlag, flag_vertalj, propNone, 0, 0);
  AddKeyword2('vertalt', kwdFlag, flag_vertalt, propNone, 0, 0);
  AddKeyword2('viewkind', kwdValu, valu_viewkind, propNone, 0, 0);
  AddKeyword2('viewscale', kwdValu, valu_viewscale, propNone, 0, 0);
  AddKeyword2('viewzk', kwdValu, valu_viewzk, propNone, 0, 0);
  AddKeyword2('wbitmap', kwdValu, valu_wbitmap, propNone, 0, 0);
  AddKeyword2('wbmbitspixel', kwdValu, valu_wbmbitspixel, propNone, 0, 0);
  AddKeyword2('wbmplanes', kwdValu, valu_wbmplanes, propNone, 0, 0);
  AddKeyword2('wbmwidthbytes', kwdValu, valu_wbmwidthbytes, propNone, 0, 0);
  AddKeyword2('widctlpar', kwdFlag, flag_widctlpar, propNone, 0, 0);
  AddKeyword2('widowctrl', kwdFlag, flag_widowctrl, propNone, 0, 0);
  AddKeyword2('windowcaption', kwdValu, valu_windowcaption, propNone, 0, 0);
  AddKeyword2('wpeqn', kwdFlag, flag_wpeqn, propNone, 0, 0);
  AddKeyword2('wpjst', kwdFlag, flag_wpjst, propNone, 0, 0);
  AddKeyword2('wpsp', kwdFlag, flag_wpsp, propNone, 0, 0);
  AddKeyword2('wraptrsp', kwdFlag, flag_wraptrsp, propNone, 0, 0);

  AddKeyword2('xef', kwdValu, valu_xef, propNone, 0, 0);
  AddKeyword2('yxe', kwdFlag, flag_yxe, propNone, 0, 0);
  AddKeyword2('zwj', kwdSymb, symb_zwj, propNone, 0, 0);
  AddKeyword2('zwnj', kwdSymb, symb_zwnj, propNone, 0, 0);
 end;
end;

procedure AddDestKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddDestination('annotation',  dest_annotation, ord(rdsAnnotation));
   AddDestination('author',  dest_author, Ord(rdsAuthor));
   AddDestination('background',  dest_background, Ord(rdsSkip));
   AddDestination('bkmkend',  dest_bkmkend, ord(rdsBookmarkEnd));
   AddDestination('bkmkstart',  dest_bkmkstart, ord(rdsBookmarkStart));
   AddDestination('blipuid', valu_blipuid, Ord(rdsSkip));
   AddDestination('colortbl',  dest_colortbl, Ord(rdsColorTable));
   AddDestination('comment',  dest_comment, Ord(rdsSkip));
   AddDestination('company',  dest_company, Ord(rdsCompany));
   AddDestination('creatim',  dest_creatim, Ord(rdsCreaTim));
   AddDestination('datafield',  dest_datafield, Ord(rdsSkip));
   AddDestination('deleted',  togg_deleted,  Ord(rdsSkip)); // было - kwdTogg, togg_deleted, ord(rdsSkip));
   AddDestination('do',  dest_do, Ord(rdsSkip));
   AddDestination('doccomm',  dest_doccomm, Ord(rdsSkip));
   AddDestination('docvar',  dest_docvar, Ord(rdsSkip));
   AddDestination('dptxbxtext',  dest_dptxbxtext, Ord(rdsSkip));
   AddDestination('falt',  dest_falt, Ord(rdsFalt));
   AddDestination('ffdeftext',  dest_ffdeftext, ord(rdsSkip));
   AddDestination('ffentrymcr',  dest_ffentrymcr, ord(rdsSkip));
   AddDestination('ffexitmcr',  dest_ffexitmcr, ord(rdsSkip));
   AddDestination('ffformat',  dest_ffformat, ord(rdsSkip));
   AddDestination('ffhelptext',  dest_ffhelptext, ord(rdsSkip));
   AddDestination('ffl',  dest_ffl, ord(rdsFormFieldItem));
   AddDestination('ffname',  dest_ffname, ord(rdsSkip));
   AddDestination('ffstattext',  dest_ffstattext, ord(rdsSkip));
   AddDestination('field',  dest_field, ord(rdsField));
   AddDestination('file',  dest_file, ord(rdsSkip));
   AddDestination('filetbl',  dest_filetbl, ord(rdsSkip));
   AddDestination('fldinst',  dest_fldinst, ord(rdsFieldInstruction));
   AddDestination('fldrslt',  dest_fldrslt, ord(rdsFieldResult));
   AddDestination('fldtype',  dest_fldtype, ord(rdsSkip));
   AddDestination('fname',  dest_fname, ord(rdsFName));
   AddDestination('fontemb',  dest_fontemb, ord(rdsSkip));
   AddDestination('fontfile',  dest_fontfile, ord(rdsSkip));
   AddDestination('fonttbl',  dest_fonttbl, ord(rdsFontTable));
   AddDestination('footer',  dest_footer, ord(rdsFooter));
   AddDestination('footerf',  dest_footerf, ord(rdsFooter));
   AddDestination('footerl',  dest_footerl, ord(rdsFooter));
   AddDestination('footerr',  dest_footerr, ord(rdsFooter));
   AddDestination('footnote',  dest_footnote, ord(rdsFootnote));
   AddDestination('formfield',  dest_formfield, ord(rdsFormField));
   AddDestination('ftncn',  dest_ftncn, ord(rdsSkip));
   AddDestination('ftnsep',  dest_ftnsep, ord(rdsSkip));
   AddDestination('ftnsepc',  dest_ftnsepc, ord(rdsSkip));
   AddDestination('g',  dest_g, ord(rdsSkip));
   AddDestination('gridtbl',  dest_gridtbl, ord(rdsSkip));
   AddDestination('header',  dest_header, ord(rdsHeader));
   AddDestination('headerf',  dest_headerf, IfThen(Lite, ord(rdsSkip), ord(rdsHeader)));
   AddDestination('headerl',  dest_headerl, IfThen(Lite, ord(rdsSkip), ord(rdsHeader)));
   AddDestination('headerr',  dest_headerr, IfThen(Lite, ord(rdsSkip), ord(rdsHeader)));
   AddDestination('info',  dest_info, Ord(rdsInfo));
   AddDestination('keycode',  dest_keycode, ord(rdsSkip));
   AddDestination('keywords',  dest_keywords, ord(rdsSkip));
   AddDestination('leveltext',  dest_leveltext, ord(rdsLevelText));
   AddDestination('listtext',  dest_listtext, ord(rdsListText));
   AddDestination('list', dest_list, ord(rdsList));
   AddDestination('listlevel', dest_Listlevel, ord(rdsListlevel));
   AddDestination('listname', dest_listname, ord(rdsListName));
   AddDestination('listoverride', dest_listoverride, ord(rdsListOverride));
   AddDestination('lfolevel', dest_lfolevel, ord(rdsLFOlevel));
   AddDestination('listoverridetable', dest_listoverridetable, ord(rdsListOverrideTable));
   Adddestination('listpicture', dest_listpicture, ord(rdsListPicture));
   Adddestination('liststylename', dest_liststylename, ord(rdsListStyleName));
   Adddestination('listtable', dest_listtable, ord(rdsListTable));
   AddDestination('manager',  dest_manager, ord(rdsSkip));
   AddDestination('nextfile',  dest_nextfile, ord(rdsSkip));
   AddDestination('objalias',  dest_objalias, ord(rdsSkip));
   AddDestination('objclass',  dest_objclass, ord(rdsSkip));
   AddDestination('objdata',  dest_objdata, ord(rdsSkip));
   AddDestination('object',  dest_object, Ord(rdsNorm));
   AddDestination('objname',  dest_objname, ord(rdsSkip));
   AddDestination('objsect',  dest_objsect, ord(rdsSkip));
   AddDestination('objtime',  dest_objtime, ord(rdsSkip));
   AddDestination('operator',  dest_operator, ord(rdsOperator));
   AddDestination('panose',  dest_panose, Ord(rdsPanose));
   AddDestination('picprop',  dest_picprop, ord(rdsPictureProp));
   AddDestination('pict',  dest_pict, ord(rdsPicture));
   AddDestination('pn',  dest_pn, ord(rdsParaNumbered));
   AddDestination('pnseclvl',  dest_pnseclvl, ord(rdsSkip));
   AddDestination('pntext',  dest_pntext, ord(rdsOldParaNumbering));
   AddDestination('pntxta',  dest_pntxta, ord(rdsSkip));
   AddDestination('pntxtb',  dest_pntxtb, ord(rdsSkip));
   AddDestination('printim',  dest_printim, ord(rdsSkip));
   AddDestination('private',  dest_private, ord(rdsSkip));
   AddDestination('result',  dest_result, ord(rdsNorm));
   AddDestination('revtbl',  dest_revtbl, ord(rdsSkip));
   AddDestination('revtim',  dest_revtim, Ord(rdsRevTim));
   AddDestination('rtf',  dest_rtf, Ord(rdsNorm));
   AddDestination('rxe',  dest_rxe, ord(rdsSkip));

   AddDestination('shp',  dest_shp, ord(rdsShp));
   AddDestination('shpgrp',  dest_shpgrp, ord(rdsShpGrp));
   AddDestination('shpinst',  dest_shpinst, ord(rdsShpInst));
   AddDestination('shppict',  dest_shppict, ord(rdsNorm));
   AddDestination('shprslt',  dest_shprslt, ord(rdsShpRslt));
   AddDestination('shptxt',  dest_shptxt, ord(rdsShpTxt));

   AddDestination('sp',  dest_sp, ord(rdsSp));
   AddDestination('sv',  dest_sv, ord(rdsSv));
   AddDestination('sn',  dest_sn, ord(rdsSkip));
   AddDestination('stylesheet',  dest_stylesheet, Ord(rdsStyleSheet));
   AddDestination('subject',  dest_subject, ord(rdsSkip));
   AddDestination('tc',  dest_tc, ord(rdsSkip));
   AddDestination('template',  dest_template, ord(rdsSkip));
   AddDestination('title',  dest_title, Ord(rdsTitle));
   AddDestination('txe',  dest_txe, ord(rdsSkip));
   AddDestination('upr',  dest_upr, ord(rdsUpr));
//   AddDestination('ud',  dest_ud, ord(rdsSkip));
   AddDestination('userprops',  dest_userprops, ord(rdsSkip));
   AddDestination('xe',  dest_xe, ord(rdsSkip));
  AddDestination('aftncn',  dest_aftncn, Ord(rdsSkip));
  AddDestination('aftnsep',  dest_aftnsep, Ord(rdsSkip));
  AddDestination('aftnsepc',  dest_aftnsepc, Ord(rdsSkip));
  AddDestination('atnauthor',  dest_atnauthor, Ord(rdsSkip));
  AddDestination('atnicn',  dest_atnicn, Ord(rdsSkip));
  AddDestination('atnid',  dest_atnid, Ord(rdsSkip));
  AddDestination('atnref',  dest_atnref, Ord(rdsSkip));
  AddDestination('atntime',  dest_atntime, Ord(rdsSkip));
  AddDestination('atrfend',  dest_atrfend, Ord(rdsSkip));
  AddDestination('atrfstart',  dest_atrfstart, Ord(rdsSkip));
  AddDestination('buptim',  dest_buptim, Ord(rdsSkip));
  AddDestination('category',  dest_category, Ord(rdsSkip));
  AddDEstination('mmathPict', dest_mmathPict, Ord(rdsPicture));
 end;
end;

procedure AddShapeKeyword(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('shpleft', kwdValu, valu_shpleft, propShape, ipropLeft, UseParam);
  AddKeyword2('shpright', kwdValu, valu_shpright, propShape, ipropRight, UseParam);
  AddKeyword2('shptop', kwdValu, valu_shptop, propShape, ipropTop, UseParam);
  AddKeyword2('shpbottom', kwdValu, valu_shpbottom, propShape, ipropBottom, UseParam);
  // Не совсем от Shape: но для окончания сортировки:
  AddKeyword2('sectd', kwdFlag, flag_sectd, propShape, ipropSectd, 0);
 end;
end;

procedure AddFrameKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('brdrb', kwdFlag, flag_brdrb, propFrame, ipropBorderWhere, Ord(bwBottom));
  AddKeyword2('brdrcf', kwdValu, valu_brdrcf, propFrame, ipropColorF, UseParam);
  AddKeyword2('brdrdash', kwdFlag, flag_brdrdash, propFrame, ipropLineType, Ord(btDashed));
  AddKeyword2('brdrdashd', kwdFlag, flag_brdrdashd, propFrame, ipropLineType, Ord(btDotDash));
  AddKeyword2('brdrdashdd', kwdFlag, flag_brdrdashdd, propFrame, ipropLineType, Ord(btDotDotDash));
  AddKeyword2('brdrdashdotstr', kwdFlag,flag_brdrdashdotstr, propFrame, ipropLineType, Ord(btStriped));
  AddKeyword2('brdrdashsm', kwdFlag, flag_brdrdashsm, propFrame, ipropLineType, Ord(btDashSmall));
  AddKeyword2('brdrdb', kwdFlag, flag_brdrdb, propFrame, ipropLineType, Ord(btDouble));
  AddKeyword2('brdrdot', kwdFlag, flag_brdrdot, propFrame, ipropLineType, Ord(btDotted));
  AddKeyword2('brdremboss', kwdFlag, flag_brdremboss, propFrame, ipropLineType, Ord(btEmboss));
  AddKeyword2('brdrengrave', kwdFlag, flag_brdrengrave, propFrame, ipropLineType, Ord(btEngrave));
  AddKeyword2('brdrhair', kwdFlag, flag_brdrhair, propFrame, ipropLineType, Ord(btHairline));
  AddKeyword2('brdrl', kwdFlag, flag_brdrl, propFrame, ipropBorderWhere, Ord(bwLeft));
  AddKeyword2('brdrnone', kwdFlag, flag_brdrnone, propFrame, ipropLineType, Ord(btNone));
  AddKeyword2('brdrr', kwdFlag, flag_brdrr, propFrame, ipropBorderWhere, Ord(bwRight));
  AddKeyword2('brdrs', kwdFlag, flag_brdrs, propFrame, ipropLineType, Ord(btSingleThick));
  AddKeyword2('brdrsh', kwdFlag, flag_brdrsh, propFrame, ipropLineType, Ord(btShadowed));
  AddKeyword2('brdrt', kwdFlag, flag_brdrt, propFrame, ipropBorderWhere, Ord(bwTop));
  AddFlag('brdrtbl', flag_brdrtbl, propFrame, ipropBrdrTbl);
  AddFlag('brdrnil', flag_brdrtbl, propFrame, ipropBrdrNil);
  AddKeyword2('brdrth', kwdFlag, flag_brdrth, propFrame, ipropLineType, Ord(btDoubleThick));
  AddKeyword2('brdrthtnlg', kwdFlag, flag_brdrthtnlg, propFrame, ipropLineType, Ord(btThinThickL));
  AddKeyword2('brdrthtnmg', kwdFlag, flag_brdrthtnmg, propFrame, ipropLineType, Ord(btThinThickM));
  AddKeyword2('brdrthtnsg', kwdFlag, flag_brdrthtnsg, propFrame, ipropLineType, Ord(btThinThickS));
  AddKeyword2('brdrtnthlg', kwdFlag, flag_brdrtnthlg, propFrame, ipropLineType, Ord(btThickThinL));
  AddKeyword2('brdrtnthmg', kwdFlag, flag_brdrtnthmg, propFrame, ipropLineType, Ord(btThickThinM));
  AddKeyword2('brdrtnthsg', kwdFlag, flag_brdrtnthsg, propFrame, ipropLineType, Ord(btThickThinS));
  AddKeyword2('brdrtnthtnlg', kwdFlag, flag_brdrtnthtnlg, propFrame, ipropLineType, Ord(btThinThickThinL));
  AddKeyword2('brdrtnthtnmg', kwdFlag, flag_brdrtnthtnmg, propFrame, ipropLineType, Ord(btThinThickThinM));
  AddKeyword2('brdrtnthtnsg', kwdFlag, flag_brdrtnthtnsg, propFrame, ipropLineType, Ord(btThinThickThinS));
  AddKeyword2('brdrtriple', kwdFlag, flag_brdrtriple, propFrame, ipropLineType, Ord(btTriple));
  AddKeyword2('brdrw', kwdValu, valu_brdrw, propFrame, ipropWidth, UseParam);
  AddKeyword2('brdrwavy', kwdFlag, flag_brdrwavy, propFrame, ipropLineType, Ord(btWavy));
  AddKeyword2('brdrwavydb', kwdFlag, flag_brdrwavydb, propFrame, ipropLineType, Ord(btWavyDouble));
 end;
end;

procedure AddSEPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('lndscpsxn', kwdFlag, flag_lndscpsxn, propSep, ipropLandscape, Ord(True));
  AddKeyword2('pghsxn', kwdValu, valu_pghsxn, propSep, ipropHeight, UseParam);
  AddKeyword2('pgwsxn', kwdValu, valu_pgwsxn, propSep, ipropWidth, UseParam);
  if not Lite then
  begin
   AddKeyword2('margbsxn', kwdValu, valu_margbsxn, propSep, ipropBottom, UseParam);
   AddKeyword2('marglsxn', kwdValu, valu_marglsxn, propSEP, ipropLeft, useParam);
   AddKeyword2('margrsxn', kwdValu, valu_margrsxn, propSep, ipropRight, useParam);
   AddKeyword2('margtsxn', kwdValu, valu_margtsxn, propSep, ipropTop, useParam);
   AddKeyword2('sbknone', kwdFlag, flag_sbknone, propSep, ipropSbkNone, 0);
  end; //not Lite
 end;
end;

procedure AddPictKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddFlag('nonshppict', flag_nonshppict, propPict, ipropSkipPicture);
  AddValue('piccropb', valu_piccropb, propPict, ipropPicCropB);
  AddKeyword2('piccropl', kwdValu, valu_piccropl, propPict, ipropPicCropL, UseParam);
  AddKeyword2('piccropr', kwdValu, valu_piccropr, propPict, ipropPicCropR, UseParam);
  AddKeyword2('piccropt', kwdValu, valu_piccropt, propPict, ipropPicCropT, UseParam);
  AddKeyword2('pichgoal', kwdValu, valu_pichgoal, propPict, ipropHeight, UseParam);
  AddKeyword2('picscalex', kwdValu, valu_picscalex, propPict, ipropScaleX, UseParam);
  AddKeyword2('picscaley', kwdValu, valu_picscaley, propPict, ipropScaleY, UseParam);
  AddKeyword2('picscaled', kwdFlag, flag_picscaled, propNone, 0, 0);
  AddKeyword2('picw', kwdValu, valu_picw, propPict, iproppicw, UseParam);
  AddKeyword2('pich', kwdValu, valu_picw, propPict, iproppich, UseParam);
  AddKeyword2('picwgoal', kwdValu, valu_picwgoal, propPict, ipropWidth, UseParam);
  AddFlag('emfblip', flag_emfblip, propPict, ipropPicEMF);
  AddFlag('jpegblip', flag_jpegblip, propPict, ipropPicJPEG);
  AddFlag('pngblip', flag_pngblip, propPict, ipropPicPNG);
  AddKeyword2('bin', kwdValu, valu_bin, propPict, ipropBin, UseParam);
  AddKeyword2('wmetafile', kwdValu, valu_wmetafile, propPict, ipropPicWMF, UseParam);
 end;
end;

procedure AddColorTableKeys(aKeywordList: TddKeywordList; Lite: Boolean =
    false);
begin
 with aKeywordList do
 begin
  AddValue('blue', valu_blue, propColorTable, ipropBlue);
  AddValue('green', valu_green, propColorTable, ipropGreen);
  AddValue('red', valu_red, propColorTable, ipropRed);
 end; // with
end;

procedure AddFieldKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('ffdefres', kwdValu, valu_ffdefres, propFormField, ipropFFDefRes, UseParam);
  AddKeyword2('ffres', kwdValu, valu_ffres, propFormField, ipropFFRes, UseParam);
  AddKeyword2('fftype', kwdValu, valu_fftype, propFormField, ipropFFType, UseParam);
  AddKeyword2('fldpriv', kwdFlag, flag_fldpriv, propField, propfldpriv, 0);
 end;
end;

procedure AddColumnsKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('colno', kwdValu, valu_colno, propColumn, ipropColNum, UseParam);
  AddKeyword2('cols', kwdValu, valu_cols, propColumn, ipropColCount, UseParam);
  AddKeyword2('colw', kwdValu, valu_colw, propColumn, ipropColWidth, UseParam);
  AddKeyword2('colsr', kwdValu, valu_colsr, propColumn, ipropColumnRight, UseParam);
  if not Lite then
   AddKeyword2('column', kwdSymb, symb_column, propDOP, ipropColumn, ord(breakColumn));
 end;
end;

function RTFKeyWords: Tl3KeyWords;
var
 KW : TddKeyWordList;
begin
 if (g_RTFKeyWords = nil) then
 begin
  l3System.AddExitProc(RTFKeyWordsFree);
  g_RTFKeyWords := TddKeyWordList.Create;
  try
   KW := g_RTFKeyWords;
   with KW do
   begin
    AddDestKeys(KW);
    AddListTableKeywords(KW);
    AddDOPKeys(KW);
    AddPAPKeys(KW);
    AddCHPKeys(KW);
    AddFrameKeys(KW);
    AddStyleKeys(KW);
    AddSEPKeys(KW);
    AddPictKeys(KW);
    AddColorTableKeys(KW);
    AddRowKeys(KW);
    AddCellKeys(KW);
    AddFontKeys(KW);
    AddTABKeys(KW);
    AddShapeKeyword(KW);
    AddFieldKeys(KW);
    AddColumnsKeys(KW);

    AddKeyword2('edmins', kwdValu, valu_edmins, propNone, ipropedmins, useParam);
    AddKeyword2('nofchars', kwdValu, valu_nofchars, propNone, 0, UseParam);
    AddKeyword2('nofcharsws', kwdValu, valu_nofcharsws, propNone, ipropnofcharsws, UseParam);
    AddKeyword2('nofpages', kwdValu, valu_nofpages, propNone, ipropnofpages, UseParam);
    AddKeyword2('nofwords', kwdValu, valu_nofwords, propNone, ipropnofwords, UseParam);
    AddKeyword2('vern', kwdValu, valu_vern, propNone, ipropVern, UseParam);
    AddKeyword2(cc_Austerisk ,   kwdSymb, symb_Star,  propNone, 0, Ord(rdsSkipGroup));
    AddKeyword2('nonesttables', kwdSymb, symb_nonenested, propNone, 0, Ord(rdsSkipGroup));
   end;
   Result := KW;
  except
   l3Free(g_RTFKeyWords);
   raise;
  end; {try..finally}
 end else
  Result := g_RTFKeyWords;

end;


var g_RTFKeyWordsLite : TddKeyWordList = nil;

procedure RTFKeyWordsLiteFree;
begin
 l3Free(g_RTFKeyWordsLite);
end;

function RTFKeywordsLite: Tl3Keywords;
var
 KW : TddKeyWordList;
begin
 if (g_RTFKeyWordsLite = nil) then
 begin
  l3System.AddExitProc(RTFKeyWordsLiteFree);
  g_RTFKeyWordsLite := TddKeyWordList.Create;
  try
   KW := g_RTFKeyWordsLite;
   with KW do
   begin
    AddDestKeys(KW, True);
    AddDOPKeys(KW, True);
    AddFontKeys(KW, true);
    AddListTableKeywords(KW, True);
    AddPAPKeys(KW, True);
    AddCHPKeys(KW, True);
    AddPictKeys(KW, True);
    AddTABKeys(KW, True);
    AddROWKeys(KW, True);
    AddCellKeys(KW, True);
    AddStyleKeys(KW, True);
    AddColorTableKeys(KW, True);
    AddSEPKeys(KW, True);
    AddFrameKeys(KW, True);
    AddShapeKeyword(KW, True);
    AddFieldKeys(KW, True);

   AddKeyword2('landscape', kwdFlag, flag_landscape, propNone, 0, 0);
   AddKeyword2(cc_Austerisk ,   kwdSymb, symb_Star,  propNone, 0, Ord(rdsSkipGroup)); // было kwdDest
   AddKeyword2('nonesttables', kwdSymb, symb_nonenested, propNone, 0, Ord(rdsSkipGroup));
  end;
   Result := g_RTFKeyWordsLite;
  except
   l3Free(g_RTFKeyWordsLite);
   raise;
  end; {try..finally}
 end else
  Result := g_RTFKeyWordsLite;

end;

procedure AddListTableKeywords(aKeywordList: TddKeywordList; Lite: Boolean =
    false);
begin
 with aKeywordList do
 begin
  AddFlag('listhybrid', flag_listhybrid, propList, iproplisthybrid);
  AddValue('listid', valu_listid, propList, iproplistid);
  AddValue('listoverridecount', valu_listoverridecount, propList, iproplistoverridecount);
  AddValue('listoverrideformat', valu_listoverrideformat, propList, ipropListOverrideFormat);
  AddFlag('listoverridestartat', valu_listoverridestartat, propList, iproplistoverridestartat);
  AddValue('listrestarthdn', valu_listrestarthdn, propList, iproplistrestarthdn);
  AddValue('listsimple', valu_listsimple, propList, iproplistsimple);
  AddValue('liststyleid', valu_liststyleid, propList, ipropliststyleid);
  AddValue('listtemplateid', valu_listtemplateid, propList, iproplistTemplateID);
  // Элементы списка
  AddValue('levelfollow', valu_levelfollow, propLevel, iproplevelfollow);
  AddValue('levelindent', valu_levelindent, propLevel, iproplevelindent);
  AddValue('leveljc', valu_leveljc, propLevel, ipropLeveljc);
  AddValue('leveljcn', valu_leveljcn, propLevel, ipropleveljcn);
  AddValue('levellegal', valu_levellegal, propLevel, ipropLevelLegal);
  AddValue('levelnfc', valu_levelnfc, propLevel, iproplevelnfc);
  AddValue('levelnfcn', valu_levelnfcn, propLevel, iproplevelnfcn);
  AddValue('levelnorestart',  valu_levelnorestart, propLevel, iproplevelnorestart);
  AddValue('levelold', valu_levelold, propLevel, iproplevelold);
  Addvalue('levelpicture', valu_levelpicture, propLevel, ipropLevelpicture);
  AddFlag('levelpicturenosize', valu_levelpicturenosize, propLevel, ipropLevelpicturenosize);
  AddKeyword2('levelprev', kwdValu, valu_levelprev, propNone, 0, 0);
  AddKeyword2('levelprevspace', kwdValu, valu_levelprevspace, propNone, 0, 0);
  AddKeyword2('levelspace', kwdValu, valu_levelspace, propNone, 0, 0);
  AddValue('levelstartat', valu_levelstartat, propLevel, iproplevelstartat);
  // Для использования в абзаце
 end; // with aKeywordList
end;

procedure AddCHPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  if not Lite then
  begin
   AddKeyword2('b', kwdTogg, togg_b, propChp, ipropBold, UseParam);
   AddKeyword2('cb', kwdValu, valu_cb, propCHP, ipropColorB, UseParam);
   AddKeyword2('cf', kwdValu, valu_cf, propCHP, ipropColorF, UseParam);
   AddKeyword2('fs', kwdValu, valu_fs, propCHP, ipropHeight, UseParam);
   AddKeyword2('highlight', kwdValu, valu_highlight, propCHP, ipropHighlight, UseParam);
   AddKeyword2('i', kwdTogg, togg_i, propCHP, ipropItalic, UseParam);
   AddKeyword2('strike', kwdTogg, togg_strike, propCHP, ipropStrikeout, UseParam);
   AddKeyword2('ul', kwdTogg, togg_ul, propCHP, ipropUnderline, UseParam);
   AddKeyword2('ulnone', kwdFlag, flag_ulnone, propCHP, ipropUnderline, Ord(False));
   AddKeyword2('sub', kwdFlag, flag_sub, propCHP, ipropPos, Ord(cpSubScript));
   AddKeyword2('super', kwdFlag, flag_super, propCHP, ipropPos, Ord(cpSuperScript));
  end; // lite
  AddKeyword2('caps', kwdTogg, togg_caps, propCHP, iproPAnsiCharCaps, ord(ccAllCaps));
  AddKeyword2('chcbpat', kwdValu, valu_chcbpat, propCHP, ipropHighlight, UseParam);
  AddKeyword2('chftn', kwdSymb, symb_chftn, propCHP, 0, symbolFootnote);
  AddKeyword2('embo', kwdTogg, togg_embo, propCHP, ipropContour, ord(ctEmbo));
  AddKeyword2('emdash', kwdSymb, symb_emdash, propCHP, 0, ord('-'));
  AddKeyword2('endash', kwdSymb, symb_endash, propCHP, 0, ord('-'));
  AddKeyword2('f', kwdValu, valu_f, propCHP, ipropNumber, UseParam);
  AddKeyword2('lang', kwdValu, valu_lang, propCHP, ipropLang, 0);
  AddKeyword2('ldblquote', kwdSymb, symb_ldblquote, propCHP, 0, Ord(cc_LTDoubleQuote));
  AddKeyword2('line', kwdSymb, symb_line, propCHP, 0, Ord(cc_SoftEnter));
  AddKeyword2('lquote', kwdSymb, symb_lquote, propCHP, 0, ord(cc_lSingleQuote));
  AddKeyword2('plain', kwdFlag, flag_plain, propCHP, ipropDefault, 0);
  AddKeyword2('rdblquote', kwdSymb, symb_rdblquote, propCHP, 0, ord(cc_RTDoubleQuote));
  AddKeyword2('rquote', kwdSymb, symb_rquote, propCHP, 0, ord(cc_rSingleQuote));
  AddKeyword2('tab', kwdSymb, symb_tab, propCHP, 0, IfThen(Lite, ord(' '), ord(cc_Tab)));
  AddKeyword2('u', kwdValu, valu_u, propCHP, ipropUnicode, UseParam);
  AddKeyword2('v', kwdTogg, togg_v, propCHP, ipropHidden, UseParam);
  AddKeyword2(cc_SingleQuote, kwdValu, valu_Hex, propCHP, 0, UseParam);
  AddKeyword2(cc_Colon, kwdSymb, symb_ToDot, propCHP, 0, Ord(cc_Colon));
  AddKeyword2(cc_Slash, kwdSymb, symb_Slash, propCHP, 0, Ord(cc_Slash));
  AddKeyword2(cc_Underline, kwdSymb, symb_Under, propCHP,  0, Ord('-'));
  AddKeyword2('{', kwdSymb, symb_OpBrak, propCHP, 0, ord('{'));
  AddKeyword2('|', kwdSymb, symb_Vert, propCHP, 0, ord('|'));
  AddKeyword2('}', kwdSymb, symb_ClBrak, propCHP, 0, ord('}'));
  AddKeyword2('~', kwdSymb, symb_Tilda, propCHP, 0, ord(cc_SoftSpace));
 end;
end;

procedure AddPAPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddKeyword2('box', kwdFlag, flag_box, propPAP, ipropBorderWhere, Ord(bwBox));
   AddKeyword2('fi', kwdValu, valu_fi, propPAP, ipropFirst, UseParam);
   AddKeyword2('intbl', kwdFlag, flag_intbl, propPAP, ipropInTable, UseParam);
   AddToggle('hyphpar', togg_hyphpar, propPAP, 0);
   AddKeyword2('li', kwdValu, valu_li, propPAP, ipropLeft, UseParam);
   AddKeyword2('ls', kwdValu, valu_ls, propPAP, ipropLS, 0);
   AddKeyword2('par', kwdSymb, symb_par, propPAP, 0, 0);
   AddKeyword2('pard', kwdFlag, flag_pard, propPAP, ipropDefault, 0);
   AddKeyword2('qc', kwdFlag, flag_qc, propPAP, ipropJust, ord(justC));
   AddKeyword2('qj', kwdFlag, flag_qj, propPAP, ipropJust, ord(justF));
   AddKeyword2('ql', kwdFlag, flag_ql, propPAP, ipropJust, ord(justL));
   AddKeyword2('qr', kwdFlag, flag_qr, propPAP, ipropJust, ord(justR));
   AddKeyword2('ri', kwdValu, valu_ri, propPAP, 0, useParam);
   AddKeyword2('sa', kwdValu, valu_sa, propPAP, ipropBottom, UseParam);
   AddKeyword2('sb', kwdValu, valu_sb, propPAP, ipropTop, UseParam);
   AddKeyword2('posx', kwdValu, valu_posx, propPAP, ipropposx, UseParam);
   AddKeyword2('posy', kwdValu, valu_posy, propPAP, ipropposy, UseParam);
   AddKeyword2('absh', kwdValu, valu_absh, propPAP, ipropabsh, UseParam);
   AddKeyword2('absw', kwdValu, valu_absw, propPAP, ipropabsw, UseParam);
   AddValue('level', valu_level, propPAP, ipropLevel);
   AddValue('ilvl', valu_ilvl, propPAP, ipropilvl);
   AddValue('itap', valu_itap, propPAP, ipropitap);
 end;
end;

procedure AddDOPKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddKeyword2('ansi', kwdFlag, flag_ansi, propDOP, iproPAnsiCharSet, ord(rtfAnsi));
   AddKeyword2('ansicpg', kwdValu, valu_ansicpg, propDOP, ipropCodePage, UseParam);
   AddKeyword2('deff', kwdValu, valu_deff, propDOP, ipropDefFont, UseParam);
   AddKeyword2('defformat', kwdFlag, flag_defformat, propDOP, 0, 0);
   AddKeyword2('deflang', kwdValu, valu_deflang, propDOP, ipropDefLang, UseParam);
   AddKeyword2('deflangfe', kwdValu, valu_deflangfe, propNone, 0, 0);
   AddKeyword2('deftab', kwdValu, valu_deftab, propDOP, ipropDefTab, UseParam);
   AddKeyword2('dy', kwdValu, valu_dy, propDop, ipropDay, UseParam);
   AddKeyword2('hr', kwdValu, valu_hr, propDop, ipropHour, UseParam);
   AddKeyword2('mac', kwdFlag, flag_mac, propDOP, iproPAnsiCharSet, ord(rtfMac));
   AddKeyword2('margb', kwdValu, valu_margb, propDOP, ipropBottom, useParam);
   AddKeyword2('margl', kwdValu, valu_margl, propDOP, ipropLeft, useParam);
   AddKeyword2('margr', kwdValu, valu_margr, propDOP, ipropRight, useParam);
   AddKeyword2('margt', kwdValu, valu_margt, propDOP, ipropTop, useParam);
   AddKeyword2('min', kwdValu, valu_min, propDop, ipropMin, UseParam);
   AddKeyword2('mo', kwdValu, valu_mo, propDop, ipropMonth, UseParam);
   if not Lite then
    AddSymbol('page', symb_page, propDOP, ipropBreak, ord(breakPage));
   AddKeyword2('paperh', kwdValu, valu_paperh, propDOP, ipropHeight, useParam);
   AddKeyword2('paperw', kwdValu, valu_paperw, propDOP, ipropWidth, useParam);
   AddKeyword2('pc', kwdFlag, flag_pc, propDOP, iproPAnsiCharSet, ord(rtfPC));
   AddKeyword2('pca', kwdFlag, flag_pca, propDOP, iproPAnsiCharSet, ord(rtfPCA));
   if not Lite then
    AddKeyword2('sect', kwdSymb, symb_sect, propDOP, 0, ord(breakSection));
   AddKeyword2('uc', kwdValu, valu_uc, propDOP, ipropUC, useParam);
   AddKeyword2('version', kwdValu, valu_version, propDOP, ipropVersion, UseParam);
   AddKeyword2('yr', kwdValu, valu_yr, propDOP, ipropYear, UseParam);
 end;
end;

procedure AddCellKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddSymbol('cell', symb_cell, propCell, 0, 0);
   AddKeyword2('cellx', kwdValu, valu_cellx, propCell, ipropWidth, UseParam);
   AddKeyword2('clwWidth', kwdValu, valu_cellx, propCell, ipropclwWidth, UseParam);
   AddKeyword2('clbgbdiag', kwdFlag, flag_clbgbdiag, propCell, ipropShading, Ord(stDiag));
   AddKeyword2('clbgcross', kwdFlag, flag_clbgcross, propCell, ipropShading, Ord(stCross));
   AddKeyword2('clbgdcross', kwdFlag, flag_clbgdcross, propCell, ipropShading, Ord(stDCross));
   AddKeyword2('clbgdkbdiag', kwdFlag, flag_clbgdkbdiag, propCell, ipropShading, Ord(stDkCross));
   AddKeyword2('clbrdrb', kwdFlag, flag_clbrdrb, propCell, ipropBottom, 0);
   AddKeyword2('clbrdrl', kwdFlag, flag_clbrdrl, propCell, ipropLeft, 0);
   AddKeyword2('clbrdrr', kwdFlag, flag_clbrdrr, propCell, ipropRight, 0);
   AddKeyword2('clbrdrt', kwdFlag, flag_clbrdrt, propCell, ipropTop, 0);
   AddFlag('clmgf', flag_clmgf, propCell, ipropMergedFirst);
   AddFlag('clmrg', flag_clmrg, propCell, ipropMerged);
   AddFlag('clvmgf', flag_clvmgf, propCell, ipropVMergeFirst);
   AddFlag('clvmrg', flag_clvmrg, propCell, ipropVMerged);
   AddKeyword2('clvertalb', kwdFlag, flag_clvertalb, propCell, ipropJust, ord(cellBottom));
   AddKeyword2('clvertalc', kwdFlag, flag_clvertalc, propCell, ipropJust, ord(cellCenter));
   AddKeyword2('clvertalt', kwdFlag, flag_clvertalt, propCell, ipropJust, ord(cellTop));
   AddValue('clcbpat', valu_clcbpat, propCell, ipropColorB);
   AddValue('clcfpat', valu_clcfpat, propCell, ipropColorF);
   AddSymbol('nestcell', symb_nestcell, propNestedCell, 0, 0);
 end;
end;

procedure AddRowKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddKeyword2('row', kwdSymb, symb_row, propRow, 0, 0);
   AddKeyword2('trbrdrb', kwdFlag, flag_trbrdrb, propRow, ipropBorderWhere, Ord(bwBottom));
   AddKeyword2('trbrdrh', kwdFlag, flag_trbrdrh, propRow, ipropBorderWhere, Ord(bwHorizontal));
   AddKeyword2('trbrdrl', kwdFlag, flag_trbrdrl, propRow, ipropBorderWhere, Ord(bwLeft));
   AddKeyword2('trbrdrr', kwdFlag, flag_trbrdrr, propRow, ipropBorderWhere, Ord(bwRight));
   AddKeyword2('trbrdrt', kwdFlag, flag_trbrdrt, propRow, ipropBorderWhere, Ord(bwTop));
   AddKeyword2('trbrdrv', kwdFlag, flag_trbrdrv, propRow, ipropBorderWhere, Ord(bwVertical));
   AddKeyword2('trgaph', kwdValu, valu_trgaph, propRow, ipropFirst, UseParam);
   AddKeyword2('trhdr', kwdFlag, flag_trhdr, propNone, 0, 0);
   AddKeyword2('trkeep', kwdFlag, flag_trkeep, propNone, 0, 0);
   AddKeyword2('trleft', kwdValu, valu_trleft, propRow, ipropLeft, UseParam);
   AddKeyword2('trwWidthA', kwdValu, valu_trwidtha, propRow, iproptrwWidthA, UseParam);
   AddKeyword2('trwWidthB', kwdValu, valu_trwidthb, propRow, iproptrwWidthB, UseParam);
   AddKeyword2('trftsWidthA', kwdValu, valu_trswidtha, propRow, iproptrftsWidthA, UseParam);
   AddKeyword2('trftsWidthB', kwdValu, valu_trswidthb, propRow, iproptrftsWidthB, UseParam);
   AddKeyword2('trowd', kwdFlag, flag_trowd, propRow, ipropDefault, 0);
   AddKeyword2('nesttableprops', kwdFlag, flag_nestrow, propRow, ipropDefault, 1);

   AddKeyword2('trqc', kwdFlag, flag_trqc, propNone, 0, 0);
   AddKeyword2('trql', kwdFlag, flag_trql, propNone, 0, 0);
   AddKeyword2('trqr', kwdFlag, flag_trqr, propNone, 0, 0);
   AddKeyword2('trrh', kwdValu, valu_trrh, propNone, 0, 0);
   AddKeyword2('lastrow', kwdFlag, flag_lastrow, propRow, ipropLast, 0);
   AddKeyword2('nestrow', kwdSymb, symb_nestrow, propNestedRow, 0, 0);
   AddKeyword2('irow', kwdValu, value_irow, propRow, ipropirow, UseParam);
 end;
end;

procedure AddTABKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
   AddKeyword2('tb', kwdValu, valu_tb, propTAB, ipropTabBar, UseParam);
   AddKeyword2('tldot', kwdFlag, flag_tldot, propTAB, ipropTabLead, Ord(tlDots));
   AddKeyword2('tleq', kwdFlag, flag_tleq, propTAB, ipropTabLead, Ord(tlEqualSign));
   AddKeyword2('tlhyph', kwdFlag, flag_tlhyph, propTAB, ipropTabLead, Ord(tlHyphens));
   AddKeyword2('tlth', kwdFlag, flag_tlth, propTAB, ipropTabLead, Ord(tlThickLine));
   AddKeyword2('tlul', kwdFlag, flag_tlul, propTAB, ipropTabLead, Ord(tlUnderline));
   AddKeyword2('tqc', kwdFlag, flag_tqc, propTAB, ipropJust, Ord(tkCentered));
   AddKeyword2('tqdec', kwdFlag, flag_tqdec, propTAB, ipropJust, Ord(tkDecimal));
   AddKeyword2('tqr', kwdFlag, flag_tqr, propTAB, ipropJust, Ord(tkRight));
   AddKeyword2('tx', kwdValu, valu_tx, propTAB, ipropWidth, UseParam);
 end;
end;

procedure AddFontkeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('fbidi', kwdFlag, flag_fbidi, propFont, ipropFontFamily, ord(ffBidi));
  AddKeyword2('fcharset', kwdValu, valu_fcharset, propFont, iproPAnsiCharSet, UseParam);
  AddKeyword2('fdecor', kwdFlag, flag_fdecor, propFont, ipropFontFamily, ord(ffdecor));
  AddKeyword2('fmodern', kwdFlag, flag_fmodern, propFont, ipropFontFamily, ord(ffModern));
  AddKeyword2('fnil', kwdFlag, flag_fnil, propFont, ipropFontFamily, ord(ffNil));
  AddKeyword2('fprq', kwdValu, valu_fprq, propNone, 0, UseParam);
  AddKeyword2('froman', kwdFlag, flag_froman, propFont, ipropFontFamily, ord(ffRoman));
  AddKeyword2('fscript', kwdFlag, flag_fscript, propFont, ipropFontFamily, ord(ffScript));
  AddKeyword2('fswiss', kwdFlag, flag_fswiss, propFont, ipropFontFamily, ord(ffSwiss));
  AddKeyword2('ftech', kwdFlag, flag_ftech, propFont, ipropFontFamily, ord(ffTech));
 end;
end;

procedure AddStyleKeys(aKeywordList: TddKeywordList; Lite: Boolean = false);
begin
 with aKeywordList do
 begin
  AddKeyword2('cs', kwdValu, valu_cs, propStyle, iproPAnsiCharStyle, UseParam);
  AddKeyword2('ds', kwdValu, valu_ds, propStyle, ipropSectStyle, UseParam);
  AddKeyword2('s', kwdValu, valu_s, propStyle, ipropParaStyle, UseParam);
  AddKeyword2('sbasedon', kwdValu, valu_sbasedon, propNone, 0, 0);
  AddKeyword2('snext', kwdValu, valu_snext, propNone, 0, 0);
 end;
end;


end.
