//..........................................................................................................................................................................................................................................................
unit evContentTable;
{* Создание оглавления для документа }

// $Id: evContentTable.pas,v 1.35 2014/04/21 12:22:14 lulin Exp $ 

// $Log: evContentTable.pas,v $
// Revision 1.35  2014/04/21 12:22:14  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.34  2014/04/08 14:16:57  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.33  2013/04/24 09:35:36  lulin
// - портируем.
//
// Revision 1.32  2010/02/24 18:22:22  lulin
// - избавляемся от ненужного и вредного параметра, доставшегося в наследство от ошибок молодости.
//
// Revision 1.31  2009/07/23 13:42:15  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.30  2009/07/21 14:36:04  lulin
// - убираем поддержку IUnknown со строк.
//
// Revision 1.29  2009/07/14 14:56:35  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.28  2009/07/13 12:31:42  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.27  2009/06/02 13:48:08  lulin
// [$148574526].
//
// Revision 1.26  2009/06/01 16:07:33  lulin
// [$148574348].
//
// Revision 1.25  2009/04/16 14:27:15  lulin
// [$143396720]. Собираем Архивариус в HEAD.
//
// Revision 1.24  2008/10/01 11:13:31  lulin
// - <K>: 120718563.
//
// Revision 1.23  2008/06/20 14:48:58  lulin
// - используем префиксы элементов.
//
// Revision 1.22  2008/04/15 08:23:51  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.21  2008/04/14 13:46:40  lulin
// - <K>: 89096854.
//
// Revision 1.20  2008/04/10 17:34:26  lulin
// - <K>: 89097983.
//
// Revision 1.19  2008/04/09 17:57:12  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.18  2008/04/09 11:20:26  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.17  2008/03/26 17:17:51  lulin
// - cleanup.
//
// Revision 1.16  2008/03/21 14:09:15  lulin
// - cleanup.
//
// Revision 1.15  2008/02/20 17:22:56  lulin
// - упрощаем строки.
//
// Revision 1.14  2008/02/14 17:30:30  lulin
// - cleanup.
//
// Revision 1.13  2008/02/14 09:40:25  lulin
// - удалён ненужный класс.
//
// Revision 1.12  2008/02/13 20:20:02  lulin
// - <TDN>: 73.
//
// Revision 1.11  2008/02/07 19:12:57  lulin
// - избавляемся от излишне универсальных методов базовых списков.
//
// Revision 1.10  2008/02/06 15:36:54  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.9  2008/02/05 09:57:40  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.8  2008/02/01 15:14:31  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.7  2008/01/31 20:09:53  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.6  2007/12/24 15:25:24  lulin
// - удалены ненужные файлы.
//
// Revision 1.5  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.9  2007/11/28 17:02:39  dinishev
// _CleanUp
//
// Revision 1.1.2.8  2007/11/28 13:22:13  dinishev
// Совместимость с HEAD
//
// Revision 1.1.2.7  2007/06/20 09:25:43  dinishev
// bug fix: не компилировалось
//
// Revision 1.1.2.6  2007/01/19 16:21:10  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.1.2.5  2006/12/21 10:25:54  oman
// - fix: При выделении точки (nevSelection._SelectPoint) сбрасываем
//  выделение, если оно не постоянно и выбираемая точка в него не
//  попадает (cq23931)
//
// Revision 1.1.2.4  2006/11/27 08:43:24  lulin
// - cleanup.
//
// Revision 1.1.2.3  2006/11/23 10:45:25  dinishev
// Bug fix: не компилировался Everest
//
// Revision 1.1.2.2  2006/10/12 15:40:03  lulin
// - bug fix: не компилировался проект Эверест.
//
// Revision 1.1.2.1  2006/02/08 11:50:26  lulin
// - утилитные файлы для Эвереста переехали в ветку.
//
// Revision 1.80.16.1  2006/02/07 15:16:28  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.80  2005/05/16 15:31:16  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.79  2005/05/16 11:42:13  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.78  2005/04/19 15:41:42  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.77  2005/03/28 11:32:17  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.76  2005/03/11 16:26:44  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.75  2005/02/16 13:01:08  narry
// - bug fix: некорректно вычислялись номера статей
//
// Revision 1.74  2004/11/25 07:37:45  lulin
// - new unit: TevCustomEditor.
//
// Revision 1.73  2004/10/26 13:17:24  narry
// - bug fix: AV
//
// Revision 1.72  2004/09/21 12:21:04  lulin
// - Release заменил на Cleanup.
//
// Revision 1.71  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.70  2004/07/28 12:50:54  voba
// - _replace MoveCursor to MoveLeafCursor
//
// Revision 1.69  2004/06/09 11:09:06  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.68  2004/06/01 16:51:22  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.67  2004/05/14 15:33:53  law
// - remove unit: evTypesE.
//
// Revision 1.66  2004/05/06 17:02:36  law
// - cleanup: у ReplaceFunc удален ненужный и непонятный параметр Sender.
//
// Revision 1.65  2004/05/05 12:52:42  law
// - rename method: TevBaseSearcher.Search -> TevBaseSearcher.DoCheckText.
//
// Revision 1.64  2004/04/20 10:02:27  law
// - new methods versions.
//
// Revision 1.63  2004/04/19 16:08:19  law
// - new type: _Tl3PCharLenConst.
//
// Revision 1.62  2004/03/19 09:49:55  narry
// - bug fix: неправильно выравниваются приложения
//
// Revision 1.61  2004/03/15 15:45:57  narry
// - bug fix: лишняя точка после цифры
//
// Revision 1.60  2004/02/10 15:29:03  narry
// - bug fix: составной номер статьи или пункта обрезался при добавлении в оглавление
//
// Revision 1.59  2004/01/16 09:41:45  narry
// - bug fix: бесконечный цикл в процедуре поиска позиции точки в строке
//
// Revision 1.58  2003/11/18 12:12:01  narry
// - bug fix: неправильное форматирование и AV оглавлений с нечеткой нумерацией
//
// Revision 1.57  2003/10/06 10:12:06  narry
// - change: переименование модуля evBseCur в evBaseCursor
//
// Revision 1.56  2003/09/15 14:29:19  narry
// - cleanup
//
// Revision 1.55  2003/08/29 11:56:14  narry
// - bug fix: Названия приложений без точки после номера приложения неправильно форматировались по ширине
//
// Revision 1.54  2003/07/28 12:44:32  narry
// - bug fix: создание оглавления на основе приложений вызывало GPF
//
// Revision 1.53  2003/07/28 09:40:53  narry
// - bug fix: создание оглавления из документа, содержащего пункты, проводило к GPF
//
// Revision 1.52  2003/07/25 14:50:03  narry
// - update: обработка "неправильных" номеров статей (e.g. 12-1, 14.5)
//
// Revision 1.51  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.50  2003/01/29 14:06:45  narry
// - bug fix: Заголовок, состоящий из нескольких предложений приводил к краху "Архивариуса"
//
// Revision 1.49  2003/01/21 13:40:17  narry
// - update: подавление рамки ячейки при нахождении заголовка внутри оной
//
// Revision 1.48  2002/12/06 14:09:08  narry
// - bug fix: Приложения форматировались неверно
//
// Revision 1.47  2002/11/11 11:58:14  law
// - remove prop: TevStyleSearcher.WholeParaOnly.
// - new prop: TevStyleSearcher.SearchPlace.
//
// Revision 1.46  2002/11/10 15:48:40  law
// - use directive: evNotArchi.
//
// Revision 1.45  2002/10/31 14:32:31  narry
// - bug fix: преобразование пустой строки в число
//
// Revision 1.44  2002/10/24 13:54:25  narry
// - bug fix: при совпадении сегмента и ссылки сегмент теряется
//
// Revision 1.43  2002/10/11 13:40:20  narry
// - bug fix: склеивание заголовков
//
// Revision 1.42  2002/10/08 12:30:20  narry
// - bug fix: приложения, имеющие составной номер (1.1) форматировались неправильно
//
// Revision 1.41  2002/10/04 12:41:01  narry
// - bug fix: зацикливание
//
// Revision 1.40  2002/10/03 10:13:33  narry
// - new behavior: поиск названий приложений, оформленных моноширинным шрифтом, поиск приложение, отбитых пробелами слева
//
// Revision 1.39  2002/10/01 12:11:20  narry
// - update : автоматический посчет пунктов и статей, возможность редактирования текста пункта оглавления
//
// Revision 1.38  2002/09/19 13:09:15  narry
// - remove unit: ddHTML.
//
// Revision 1.37  2002/09/17 15:08:43  voba
// - param fix.
//
// Revision 1.36  2002/03/14 13:53:18  narry
// - bug fix & update
//
// Revision 1.35  2002/02/15 07:12:07  narry
// - bug fix: к оглавлению добавлялся лишний "конец абзаца"
//
// Revision 1.34  2002/02/12 14:35:11  narry
// - update: новый шаблон, три подуровня, отступы подуровней два пробела
//
// Revision 1.33  2002/02/08 16:25:36  voba
// - sichronization with everest library
//
// Revision 1.32  2002/02/05 14:56:56  voba
// no message
//
// Revision 1.31  2002/02/01 11:58:11  narry
// - new behavior: удаление символов подчеркивания из пунктов меню
//
// Revision 1.30  2002/01/21 12:00:33  voba
// no message
//
// Revision 1.29  2001/12/03 15:07:57  narry
// - cleanup
//
// Revision 1.28  2001/11/14 15:30:25  narry
// - bug fix: не добавлялся шаблон "Приложение NN"
//
// Revision 1.27  2001/11/14 14:01:12  narry
// - bug fix: замена перебора абзацев на переход по закладке
//
// Revision 1.26  2001/10/31 10:34:44  narry
// - update: замена MoveCursor на MoveLeafCursor
//
// Revision 1.25  2001/10/31 08:04:44  narry
// - update: исправление и добавление текста, вставляемого в оглавление
//
// Revision 1.24  2001/10/05 14:34:21  narry
// - update: не перерисовалось окно редактора под окном настройки оглавления
//
// Revision 1.23  2001/10/05 11:56:36  narry
// - update: замена перемещения на след. абзац перемещением в конец абзаца
//
// Revision 1.22  2001/10/05 11:38:48  narry
// - bug fix: зацикливание поиска стилей
//
// Revision 1.21  2001/09/24 07:32:12  narry
// - update: увеличение глубины поиска метки
//
// Revision 1.20  2001/08/27 10:07:10  narry
// - update: увеличение глубины поиска метки до 10 абзаце
//
// Revision 1.19  2001/06/27 14:49:27  narry
// - bug fix: в некоторых случаях неправильно разбивает на строки
//
// Revision 1.18  2001/06/25 13:57:05  narry
// -bug fix: Ошибка форматирования текст
//
// Revision 1.17  2001/06/22 10:41:21  narry
// -bug fix: неправильное присвоение меток во время автопоиск
//
// Revision 1.16  2001/06/22 10:15:45  narry
// -bug fix: нумерация начиналась с 0
//
// Revision 1.15  2001/06/22 10:11:10  narry
// -new behavior: автоматическая нумерация "Приложение..."
//
// Revision 1.14  2001/06/21 11:30:11  narry
// - new behavior: поиск ближайшей метки в случае отсутствия таковой
//                          на элементе оглавления
//
// Revision 1.13  2001/06/21 07:07:37  narry
// - new behavior: добавлена возможность добавления заданного текста
//                          (Приложение N. ) в начало элемента оглавления
//
// Revision 1.12  2001/06/07 07:50:44  narry
// -bug fix : вместо Моноширинного стиля элементам оглавления
//               присваивался стиль Нормальный ОЕМ.
//
// Revision 1.11  2001/06/06 11:40:11  law
// - comment: добавлены комментарии и тего Id и Log.
//

{$Include ddDefine.inc }

interface

uses
  l3StringList,
  
  nevTools,
  
  evCustomEditor
  ;

procedure CollectContentTable(DocEditor: TevCustomEditor; aHandle: Longint;
                              const aWriteSubTOC: Boolean = True;
                              const AllDoc: Boolean = True);
{* Накапливает оглавление, выводит окошко со списком и добавляет оглавление в документ.
   Если выделение отсутствует, то оглавление вставляется в позицию курсора,
   если выделение есть, то оглавление добавляется перед выделением }

procedure MakeTOCFromBlock(DocEditor: TevCustomEditor; aHandle: Longint; const AllDoc: Boolean = True);
{* Собирает оглавление, используя блочную структуру }

implementation

Uses
  Classes, Windows, SysUtils, Forms, Controls, Dialogs,
  evOp, evdStyles, evSearch, evExcept,
  evInternalInterfaces, evTypes, 
  l3Types, l3Base, l3String, l3Chars,
  l3Const, l3InterfacesMisc, l3MinMAx, l3StringEx,
  l3Interfaces,
  l3ObjectRefList,

  afwFacade,
  
  k2Interfaces,

  nevNavigation,

  StrUtils,
  ddTOCTypes, ddTuneTOCDialog,

  afwNavigation
  ;

const
  FullLineLen   = 73;
  NearestDeep   = 20;
  SubAbsent     = -2;
  TOCOperation  = 100;
  MinLeftIndent = 2;
  SubTOCIndent  = 2;
  tocMaxDotPos  = 50;
  tocMaxWordCount = 2;
  AppendixLen   = 11; // Длина строки 'Приложение '

const
  tocNone        = 0; //  ничего не добавлять
  tocArticlesNN  = 1; //  (ст.ст. NN - NN)
  tocArticlesNNN = 2; //  (ст.ст. NNN - NNN)
  tocPointsNN    = 3; //  (п.п. NN- NN)
  tocPointsNNN   = 4; //  (п.п. NNN - NNN)
  tocAddonN      = 5; //  Приложение N.
  tocAddonNN     = 6; //  Приложение NN.
  tocAddonNNN    = 7; //  Приложение NNN.

const
  dd_atArticlesNN  = '  (ст.ст. NN - NN) ';
  dd_atArticlesNNN = '  (ст.ст. NNN - NNN) ';
  dd_atPointsNN    = '  (п.п. NN - NN) ';
  dd_atPointsNNN   = '  (п.п. NNN - NNN)';

  dd_atArticles = '  (ст.ст. N - M) ';
  dd_atPoints   = '  (п.п. N - M) ';


type
  TddContentTableSearcher = class(TevStyleSearcher)
  private
  protected
   f_SearchPoints: Boolean;
   f_SearchAppendixName: Boolean;
   f_WaitForEmpty: Boolean;
  public
   procedure DoStart; override;
   function DoCheckText(Sender : Tl3Variant;
                        S            : Tl3CustomString;
                        const aSel   : TevPair;
                        out theSel   : TevPair): Bool; override;
  public
   WhatFound: TddContentType;
   property SearchAppendixName: Boolean
    read f_SearchAppendixName;
  end;

  TddContentTableReplacer = class(TevBaseReplacer)
  private
   f_ContentTable: Tl3StringList;
   f_DocEditor   : TevCustomEditor;
   f_RI          : Integer;
   f_TwoLevel    : Boolean;
   f_Searcher    : TddContentTableSearcher;
  protected
    function  ReplaceFunc(const aView : InevView;
                          const Container : InevOp;
                          const aBlock    : InevRange): Bool; override;

    procedure Cleanup; override;
  public
    constructor Create(anOwner: TComponent); override;

    property DocEditor: TevCustomEditor
      read f_DocEditor write f_DocEditor;

    property ContentTable: Tl3StringList
      read f_ContentTable;

    property TwoLevel: Boolean
      read f_TwoLevel write f_TwoLevel;
   property Searcher : TddContentTableSearcher
    read f_Searcher
    write f_Searcher;
  end;

procedure TddContentTableSearcher.DoStart;
begin
 f_SearchPoints:= True;
 f_SearchAppendixName:= False;
 f_WaitForEmpty:= False;
end;

function TddContentTableSearcher.DoCheckText(Sender : Tl3Variant;
                                             S            : Tl3CustomString;
                                             const aSel   : TevPair;
                                             out theSel   : TevPair): Bool;
var
 l_Text: String;
begin
 SearchPlace := ev_spPara;
 WhatFound:= dd_ctNone;
 if (S = nil) then
 begin
  if f_WaitForEmpty then
  begin
   f_WaitForEmpty:= False;
   f_SearchAppendixName:= True;
  end;
 end // f_WaitForEmpty and (S = nil)
 else
 begin
  // Заголовки
  Handle:= ev_saTxtheader1;
  if inherited DoCheckText(Sender, S, aSel, theSel) then
  begin
   Result:= True;
   WhatFound:= dd_ctHeader;
   f_SearchAppendixName:= False;
  end
  else
  // Приложения
  begin
   l_Text:= Trim(l3PCharLen2String(S.AsPCharLen));
   Handle:= ev_saColorSelection;
   SearchPlace := ev_spAll;
   if inherited DoCheckText(Sender, S, aSel, theSel) then
   begin
    if (theSel.rStart = 0) or ((S.Len - Length(l_Text)) = theSel.rStart) then
    begin
     if AnsiStartsText('ПРИЛОЖЕНИЕ', l_Text) then
     begin
      WhatFound:= dd_ctAppendix;
      //f_SearchAppendixName:= True;
      f_WaitForEmpty:= True;
      theSel.rFinish:= aSel.rFinish;
     end
     else
     if AnsiStartsText('СТАТЬЯ', l_Text) then
     begin
      WhatFound:= dd_ctArticle;
      f_SearchPoints:= False;
     end
     else
     if f_SearchAppendixName then
      WhatFound:= dd_ctHeader;
    end // SP = 0
    else
    if f_SearchAppendixName then
     WhatFound:= dd_ctHeader;
   end
   else
   begin
    if f_SearchPoints then
    begin
     Handle:= ev_saTxtNormalANSI;
     if inherited DoCheckText(Sender, S, aSel, theSel) then
     begin
      f_SearchAppendixName:= False;
      if S.First in cc_Digits then
       WhatFound:= dd_ctPoint
     end;
    end; // f_SearchPoints
   end;
  end;
 end;
 Result:= WhatFound <> dd_ctNone;
end;


constructor TddContentTableReplacer.Create;
begin
  inherited;
  f_ContentTable:= Tl3StringList.Make;
  f_RI:= 0;
  f_TwoLevel:= False;
  f_DocEditor:= nil;
end;

procedure TddContentTableReplacer.Cleanup;
begin
  l3Free(f_ContentTable);
  inherited;
end;


function  TddContentTableReplacer.ReplaceFunc(const aView : InevView;
                                              const Container : InevOp;
                                              const aBlock    : InevRange): Bool;
var
 l_S         : TddContentItem;
 l_St        : Tl3String;
 Start,
 Finish      : InevBasePoint;
 l_Old       : InevBasePoint;
 l_BC        : InevBasePoint;
 l_Sub       : IevSub;
 l_ParPassed : Integer;
 l_PseudoDot : Integer;
 j           : Integer;
 DotFound    : Boolean;
 l_Found     : Boolean;
 l_Number    : Long;
 l_Text      : ShortString;
 l_New       : Boolean;
 l_TmpBlock  : InevRange;

 function CheckLegalID(aID: Longint): Boolean;
 begin
   Result:= (f_ContentTable.Count = 0) or
            (TddContentItem(f_ContentTable.Items[f_ContentTable.Hi]).SubID <> aID);
 end; // function CheckLegalID

var
 l_Stream : IStream; 
begin
 Result:= True;
 l_St:= Tl3String.Create;
 try
  l_TmpBlock := aBlock.BottomChildBlock(aView);
  try
   if not l3IOk(l_St.QueryInterface(IStream, l_Stream)) then
    Assert(false);
   l_TmpBlock.Data.Store(cf_Text, l_Stream, nil);
  finally
   l_TmpBlock := nil;
  end;
  // В связи с тем, что в результате дискуссии с Шуриком "конец абзаца" теперь
  // попадает в выделение, удаляем его из текста
  l_St.TrimEOL;
  // Удаляем переносы строки, двойные пробелы и символы подчеркивания
  DotFound:= False;
  l_PseudoDot:= 0;
  j:= l_St.FindChar(0, cc_SoftEnter);
  if Searcher.WhatFound = dd_ctAppendix then
  begin
   l_St.Delete(j, l_St.Len-j);
  end
  else
  while j <> -1 do
  begin
   if not DotFound and (j <> -1) and (l_St.Ch[j-1] in (cc_Digits + cc_RomeDigits)) then
   begin
    l_St.Ch[j]:= ' ';
    l_PseudoDot:= Pred(j);
    //l_St.Insert(#149{'.'}, j); // нужно добавить "другую" точку, чтобы потом ее грохнуть
    DotFound:= True;
   end // not DotFound and (j <> -1) and (l_St.Ch[j-1] in (cc_Digits + cc_RomeDigits))
   else
    l_St.Ch[j]:= ' ';
   j:= l_St.FindChar(j, cc_SoftEnter);
  end; // while j <> -1

  l_St.DeleteAllChars(cc_Underline);
  l_St.DeleteDoubleSpace;
  l_St.TrimAll;
  if l_St.Empty then
   Exit;

  if Searcher.WhatFound in [dd_ctHeader, dd_ctAppendix] then
  begin
   if (Searcher.WhatFound = dd_ctHeader) and (f_ContentTable.Count > 0) then
   begin
    l_S:= TddContentItem(f_ContentTable.Items[f_ContentTable.Hi]);
    l_New:= (l_S.ItemType <> dd_ctAppendix) or (l_S.Closed);
   end // (Searcher.WhatFound = dd_ctHeader) and (f_ContentTable.Count > 0
   else
    l_New:= True;
   if not l_New then
   begin
    if l_S.Original then
    begin
     l_S.Append('.');
     l_S.Original:= False;
    end; // l_S.Original
    if (l_S.Last <> ' ') then
     l_S.Append(' ');
    l_S.JoinWith(l_St);
    l_S.Closed:= not Searcher.SearchAppendixName;
   end
   else
   begin
    l_S:= TddContentItem.Make(l_St);
    try
     l_S.ItemType:= Searcher.WhatFound;
     if l_PseudoDot < 50 then { !!! }
      l_S.PseudoDot:= l_PseudoDot;
     aBlock.GetBorderPoints(Start, Finish);
     l_BC := Start.MostInner;
     l_S.SubID:= SubAbsent;
     if l3BQueryInterface(l_BC, IevSub, l_Sub) then
     try
      if l_Sub.Exists then
        l_S.SubID:= l_Sub.ID
      else
      begin
       if l3BQueryInterface(l_BC, IevDocumentPart, l_Sub) then
       try
        if l_Sub.Exists then
         l_S.SubID:= l_Sub.ID;
       finally
        l_Sub := nil;
       end;//try..finally
      end;
     finally
      l_Sub := nil;
     end;//try..finally

     if l_S.SubID = SubAbsent then // пытаемся  найти ближайший саб сверху
     begin
      l_ParPassed:= 0;
      l_Old:= DocEditor.Selection.Cursor.ClonePoint(DocEditor.View);
      try
       l_Found:= False;
       repeat
        if DocEditor.MoveLeafCursor(ev_ocParaUp) then
        begin
         Inc(l_ParPassed);
         l_BC:= DocEditor.Selection.Cursor.MostInner;
         if l3BQueryInterface(l_BC, IevSub, l_Sub) then
         try
          if l_Sub.Exists and  CheckLegalID(l_Sub.ID) then
          begin
           l_S.AddID:= l_Sub.ID;
           l_Found:= True;
          end
          else
          begin
           if l3BQueryInterface(l_BC, IevDocumentPart, l_Sub) then
           try
            if l_Sub.Exists and  CheckLegalID(l_Sub.ID) then
            begin
             l_S.AddID:= l_Sub.ID;
             l_Found:= True;
            end;
           finally
            l_Sub := nil;
           end;//try..finally
          end;
         finally
          l_Sub := nil;
         end;//try..finally
         if not l_Found and (l_ParPassed = NearestDeep) then
          l_Found:= True;
        end
        else
         break;
       until l_Found;
       InevSelection(DocEditor.Selection).SelectPoint(l_Old, false);
      finally
       l_Old := nil;
      end; // l_Old
     end; // _S.SubID = SubAbsent
     
     { TODO -oДудко Дмитрий -cРазвитие : Неплохо было бы предусмотреть автоматическое разложение на уровни }
     f_ContentTable.Add(l_S);
    finally
     l3Free(l_S);
    end;//try..finally
   end
  end
  else
  begin
   if f_ContentTable.Count > 0 then
   begin
    l_S:= TddContentItem(f_ContentTable.Items[f_ContentTable.Hi]);
    if l_S.ItemType <> dd_ctAppendix then
    begin
     l_Text:= '';
     if Searcher.WhatFound = dd_ctArticle then
     begin
      j:= 7;
      l_Text:= System.Copy(l_St.AsString, j, Succ(l_St.Len)-j);
     end
     else
     begin
      j:= 0;
      while l_St.Ch[j] in (cc_Digits+['.']) do
      begin
       l_text:= l_Text + l_St.Ch[j];
       Inc(j);
      end;
      if (l_Text <> '') and (l_text[Length(l_Text)] = '.') then
       Delete(l_Text, Length(l_Text), 1);
     end;

     if l_S.StartNo = '' then
     begin
      l_S.StartNo:= Trim(l_Text);
      l_S.ItemType:= Searcher.WhatFound;
     end
     else
      l_S.StopNo:= Trim(l_Text);
    end;
   end;
  end;
 finally
  l3Free(l_St);
 end;
 
end;

procedure _Collect(var DocEditor: TevCustomEditor; aTOC: Tl3StringList; const AllDoc: Boolean = True);
var
  Searcher    : TevStyleSearcher;
  Replacer    : TddContentTableReplacer;
  l_Cursor    : InevBasePoint;
  l_Pack      : InevOp;
  { Поиск подпунктов и подстатей }
  l_Index, i  : Integer;
  l_S         : TddContentItem;
  S           : String;
  l_Number    : Integer;
 l_Failed: Boolean; 
begin
 Searcher:= TddContentTableSearcher.Create(nil);
 try
  Searcher.Layer  := l3NilLong;
  Searcher.Options:= [ev_soReplace, ev_soReplaceAll];
  if not AllDoc then
   Searcher.Options:= Searcher.Options + [ev_soSelText];
  Replacer:= TddContentTableReplacer.Create(nil);
  try
   Replacer.Options  := Searcher.Options;
   Replacer.DocEditor:= DocEditor;
   Replacer.Searcher := TddContentTableSearcher(Searcher);
   with DocEditor do
   begin
    l_Pack := StartOp(ev_ocUser + TOCOperation);
    try
     if AllDoc then
      l_Cursor := Selection.Cursor.ClonePoint(View)
     else
     begin
      l_Cursor := Selection.Start.ClonePoint(View);
      InevSelection(Selection).SelectPoint(l_Cursor, false);
     end; // not AllDoc
     try
      try
       Find(Searcher, Replacer, Searcher.Options);
       l_Failed:= False;
      except
       on E: EevSearchFailed do
        MessageDlg('Элементы оглавления в документе не найдены', mtInformation, [mbOk], 0);
       on E: Exception do
        l_Failed:= True;
      end;
      if not l_Failed then
       aTOC.Assign(Replacer.ContentTable);
      InevSelection(Selection).SelectPoint(l_Cursor, false);
      // <STUB> не понятно зачем Selection.SelectPoint сам снимает выделение
      // с учетом его постоянности и попадания каретки в выделение
      InevSelection(Selection).UnSelect;
     finally
      l_Cursor := nil;
     end;//try..finally
    finally
     l_Pack := nil;
    end;//try..finally
   end;
  finally
   l3Free(Replacer);
  end;
 finally
  l3Free(Searcher);
 end;
end;

function FindDotPos(aString: TL3String; IsAppendix: Boolean = False): Long;
var
 l_WC: Integer;
 l_Pos: Long;
begin
 //Result:= aString.FindChar(0, #149);
 //if Result = 0 then
  Result:= aString.FindChar(0, '.');
 { Нужно узнать количество слов до первой точки. Если их больше двух, то
   точки в переданной строке нет }
 l_WC:= 0;
 l_Pos:= -1;
 while (l_Pos < Result){ and (l_WC < tocMaxWordCount)} do
 begin
  l_Pos:= aString.FindChar(Succ(l_Pos), ' ');
  if (l_Pos <> -1) and (l_Pos < Result) then
   Inc(l_WC)
  else
  if l_Pos = -1 then
   l_Pos:= Result;
 end;
 if l_WC > tocMaxWordCount then
  Result:= -1;
 if (Result = -1) and IsAppendix then
 begin
  Result:= AppendixLen;
  while (Result < tocMaxDotPos) and not (aString.Ch[Result] in cc_Digits) do
   Inc(Result);
  while (aString.Ch[Result] in cc_Digits) and (Result < tocMaxDotPos) do
   Inc(Result);
 end; // (Result = -1) and IsAppendix
 if Result < tocMaxDotPos then
 begin
  while (aString.Ch[Result+1] in (cc_Digits+['.'])) do
   Inc(Result);
  if not IsAppendix then
   if not ((aString.Ch[Result+1] = ' ') and
          (Result <> -1) and
          (aString.Ch[Result-1] in (cc_Digits + cc_RomeDigits))) then
     Result:= -1;
  Result:= Max(0, Result);
 end
 else
  Result:= 0;
 if (Result = 0) and (aString.Ch[0] in (cc_Digits + cc_RomeDigits)) then
 begin
  while aString.Ch[Result] in (cc_Digits + cc_RomeDigits) do Inc(Result);
  Dec(Result);
 end;
end; // FindDotPos

procedure WriteContentTable(DocEditor: TevCustomEditor; aHandle: Longint; aRI: Integer; aContent: Tl3StringList);
{ Выливает накопленное оглавление в указанное место }
var
  l_Pack      : InevOp;
  l_S, l_S2   : TddContentItem;
  l_TI        : TddContentItem;
  l_JPoint,                 // Позиция точки первого уровня
  l_2JPoint,                //               второго
  l_3JPoint,                //               третьего
  l_JPointAppendix: Integer;//               Приложения
  TOCItemIndex,
  j, i        : Integer;
  l_Hyperlink : IevHyperlink;
  L_toc       : Tl3StringList;
  l_Cursor    : InevBasePoint;
  l_Max       : Longint;
  l_TemplateLen: Longint;

  procedure SplitText(aSt: TddContentItem; RI: Long; var ItemIndex: Integer);
  var
    CharPos, l_i: Long;
    l_NewS, TI : TddContentItem;
    S          : string;
    LineLen    : Integer; // Длина строки для разгона по ширине
    LDelta     : Integer; // Отступ слева
    AddSpace   : Integer; // промежуток между точкой и символом
    Index      : Integer;
    l_DotPos   : Integer;
    l_First    : Boolean;
    l_Last     : Boolean;
    l_Char     : Integer;
    l_AppDelta : Integer;
    l_PadLen   : Integer;
  begin { SplitText }
   TI:= aSt;
   lDelta:= MinLeftIndent;
   if TI.ItemType = dd_ctAppendix then
    RI:= tocNone;
   case RI of
    tocArticlesNN : l_TemplateLen:= Length(dd_atArticles)-2;  // один пробел справа + длина добавки (ст.ст. NN - NN)
    tocArticlesNNN: l_TemplateLen:= Length(dd_atArticles)-4;  // один пробел справа + длина добавки (ст.ст. NNN - NNN)
    tocPointsNN   : l_TemplateLen:= Length(dd_atPoints)-2;  // один пробел справа + длина добавки (п.п. NN - NN)
    tocPointsNNN  : l_TemplateLen:= Length(dd_atPoints)-4;  // один пробел справа + длина добавки (п.п. NNN - NNN)
   else
     l_TemplateLen:= 1;   // один пробел справа
   end;

   LineLen:= FullLineLen - l_TemplateLen;

   Dec(LineLen, LDelta);
   l_First:= True;
   l_Last:= False;

   while not l_Last and not TI.Empty do
   begin

    if l_First then
    begin
     l_DotPos:= FindDotPos(TI, TI.ItemType = dd_ctAppendix);

     if (l_DotPos = 0) then
      if (TI.ItemType = dd_ctAppendix) then
       l_DotPos:= 12
      else
       l_DotPos:= TI.PseudoDot;

     if l_DotPos > 0 then
      if TI.ItemType = dd_ctAppendix then
      begin
       if l_JPointAppendix > 0 then
        AddSpace:= l_JPointAppendix - l_DotPos;
       if TI.Ch[l_DotPos] = '.' then
        l_AppDelta:= 4
       else
        l_AppDelta:= 3;
      end
      else
       case TI.Level of
        1: AddSpace:= l_JPoint - l_DotPos;
        2: AddSpace:= l_2JPoint - l_DotPos;
        3: AddSpace:= l_3JPoint - l_DotPos;
       end
     else
       AddSpace:= 0;

       if (RI > 0) then
       begin
        if TI.StartNo = '' then
        begin
         // Первый StartNo > 0 - начало,
         l_i:= Succ(ItemIndex);
         if l_i < l_TOC.Count then
         begin
          l_NewS:= TddContentItem(l_TOC.Items[l_i]);
          while ((l_i < l_TOC.Count) and (TI.Level < l_NewS.Level)) do
          begin
           if l_NewS.StartNo <> '' then
           begin
            if TI.StartNo = '' then
             TI.StartNo:= l_NewS.StartNo;
            if l_NewS.StopNo = '' then
             TI.StopNo:= l_NewS.StartNo
            else
             TI.StopNo:= l_NewS.StopNo;
            inc(l_i);
            if l_i < l_TOC.Count then
             l_NewS:= TddContentItem(l_TOC.Items[l_i]);
           end // TddContentItem(l_TOC.Items[l_i]).StartNo <> -1
           else
            break;
          end; // while l_i < l_TOC.Count
         end; // l_i < l_TOC.Count
        end; // TI.StartNo < 0
        // перед тем, как добавить получившуюся строку, нужно ее выравнять
        // либо выравнивать непосредственно после подстановки
        if (TI.StartNo <> '') and (TI.StopNo <> '') then
        begin
         case RI of
          tocArticlesNN :
           begin
            S:= AnsiReplaceStr('  (ст.ст. N - M) ', 'N', l3LeftPad(TI.StartNo, 2));
            S:= AnsiReplaceStr(S, 'M', l3LeftPad(TI.StopNo, 2));
           end;
          tocArticlesNNN :
           begin
            if Length(TI.StopNo) > 3 then
             l_PadLen:= Min(Length(TI.StartNo),  3)
            else
             l_PadLen:= 3;
            S:= AnsiReplaceStr('  (ст.ст. N - M) ', 'N', l3LeftPad(TI.StartNo, l_PadLen));
            S:= AnsiReplaceStr(S, 'M', l3LeftPad(TI.StopNo, l_PadLen));
           end;
          tocPointsNN   :
           begin
            S:= AnsiReplaceStr('  (п.п. N - M) ', 'N', l3LeftPad(TI.StartNo, 2));
            S:= AnsiReplaceStr(S, 'M', l3LeftPad(TI.StopNo, 2));
           end;
          tocPointsNNN  :
           begin
            if Length(TI.StopNo) > 3 then
             l_PadLen:= Min(Length(TI.StartNo),  3)
            else
             l_PadLen:= 3;
            S:= AnsiReplaceStr('  (п.п. N - M) ', 'N', l3LeftPad(TI.StartNo, l_PadLen));
            S:= AnsiReplaceStr(S, 'M', l3LeftPad(TI.StopNo, l_PadLen));
           end;
         end

        end
         else
         if (TI.StartNo <> '') and (TI.StopNo = '') then
         case RI of
           tocArticlesNN : S:= AnsiReplaceStr('          (ст. N) ', 'N', l3LeftPad(TI.StartNo, 2));
           tocArticlesNNN: S:= AnsiReplaceStr('           (ст. N) ', 'N', l3LeftPad(TI.StartNo, 3));
           tocPointsNN   : S:= AnsiReplaceStr('         (п. N) ', 'N', l3LeftPad(TI.StartNo, 2));
           tocPointsNNN  : S:= AnsiReplaceStr('          (п. N) ', 'N', l3LeftPad(TI.StartNo, 3));
         end
         else
         case RI of
           tocArticlesNN : S:= dd_atArticlesNN;
           tocArticlesNNN: S:= dd_atArticlesNNN;
           tocPointsNN   : S:= dd_atPointsNN;
           tocPointsNNN  : S:= dd_atPointsNNN;
         end;
         // Форматируем строку - скобки и дефис друг над другом
        if Length(S) > l_TemplateLen then
         Dec(LineLen, Length(S) - l_TemplateLen);
       end;
     Dec(LineLen, AddSpace);
     // Вот здесь нужно вычислять длину строки, по которой нужно выравнивать текст

     if TI.Level > 1 then
     begin
       Inc(lDelta, (TI.Level-1)*SubTOCIndent);
       Dec(LineLen, (TI.Level-1)*SubTOCIndent);
     end;
    end; { if l_First }

    CharPos:= LineLen;

    if TI.Len > CharPos then
    begin
      while not (TI.Ch[CharPos] in [' ', '-']) and (CharPos > 0) do
         Dec(CharPos);

      l_NewS:= TddContentItem.Create;
      try
       l_NewS.Assign(TI);
       l_NewS.PSeudoDot:= 0;
        l_NewS.Delete(0, CharPos+1);
        if TI.SubID > 0 then
          l_NewS.SubID:= -1;
        Index:= l_TOC.IndexOf(TI)+1;
        l_TOC.Insert(Index, l_NewS);
        Inc(ItemIndex);
      finally
        l3Free(l_NewS);
      end; { try..finally }
      if TI.Ch[CharPos] = '-' then
        TI.Delete(CharPos+1, TI.Len-CharPos)
      else
        TI.Delete(CharPos, TI.Len-CharPos);
    end
    else
    begin
      CharPos:= TI.Len;
      l_Last:= True;
    end;

    if not l_Last then // Разгоняем по ширине
    begin
      if l_DotPos > 0 then
      begin
        for l_Char:= 0 to l_DotPos+1 do
          if TI.Ch[l_Char] = ' ' then
             TI.Ch[l_Char]:= cc_SoftSpace;
          l3FixWidth(TI, LineLen);
        if l_Char > 0 then
          for l_Char:= 0 to l_DotPos+1 do
            if TI.Ch[l_Char] = cc_SoftSpace then
               TI.Ch[l_Char]:= ' ';
      end
      else
        l3FixWidth(TI, LineLen);
    end; // not l_Last
    TI.RPad2(LineLen, ' ');

    if l_First  then
    begin
      if (RI > 0) then
        TI.Append(l3PCharLen(S));
      if (l_DotPos > 0) then
          TI.Insert(' ', l_DotPos+1, AddSpace);
    end; // if l_First
    TI.LPad(' ', cp_ANSI, lDelta);

    TI.RPad2(FullLineLen, ' ');

    if not l_Last then
    begin
      TI:= TddContentItem(l_TOC.Items[Index]);
      if l_First then
      begin
        if l_DotPos > 0 then
        begin
         if TI.ItemType = dd_ctAppendix then
         begin
          Dec(LineLen, l_JPointAppendix+l_AppDelta-LDelta-AddSpace); // - AddSpace
          lDelta:= l_JPointAppendix+l_AppDelta;
         end
         else
         case TI.Level of
          1:
            begin
             Dec(LineLen, l_JPoint+4-LDelta-AddSpace); // - AddSpace
             lDelta:= l_JPoint+4;
            end;
          2:
            begin
             Dec(LineLen, l_2JPoint+MinLeftIndent);
             Inc(lDelta, l_2JPoint+MinLeftIndent);
            end;
          3:
            begin
             Dec(LineLen, l_3JPoint+MinLeftIndent);
             Inc(lDelta, l_3JPoint+MinLeftIndent);
            end;
         end;
        end;
      end;
      l_DotPos:= 0;
      l_First:= False;
    end;
   end; { while }
  end; { SplitText }

begin
 afw.ProcessMessages;

  with DocEditor do
  begin
    l_TOC := Tl3StringList.Make;
    try
     // Нужно переформатировать текст абзаца
     l_JPoint:= 0; l_2JPoint:= 0; l_3JPoint:= 0; l_JPointAppendix:= 0;
     if (aRI  =-1) or (aRI = 0) then
       aRI:= 0;

     for TOCItemIndex:= 0 to aContent.Hi do
     begin
       l_S:= TddContentItem(aContent.Items[TOCItemIndex]);
       l_S2:= TddContentItem.Create;
       try
         l_S2.Assign(l_S);
         l_TOC.Add(l_S2);
       finally
         l3Free(l_s2);
       end;
       j:= FindDotPos(l_S, l_S.ItemType = dd_ctAppendix);
       if j <> -1 then
        if l_S.ItemType = dd_ctAppendix then
         l_JPointAppendix:= Max(j, l_JPointAppendix)
        else
        begin
         if j = 0 then
          j := l_S.PseudoDot;
         case l_S.Level of
          1 : l_JPoint:= Max(j, l_JPoint);
          2 : l_2JPoint:= Max(j, l_2JPoint);
          3 : l_3JPoint:= Max(j, l_3JPoint);
         end; // case l_S.Level
        end;
     end; // For TOCItemIndex
     // Выясняем настоящую ширину дополнения
     l_Max:= 0;
     for i:= 0 to aContent.Hi do
     begin
      l_TI:= TddContentItem(aContent.Items[i]);
      l_Max:= Max(l_Max, Length(l_TI.StopNo));
     end;
     Dec(l_Max); // Так как в маске уже заложен один символ

     // Выравниваем по точке и форматируем
     TOCItemIndex:= 0;
     while TOCItemIndex <= l_TOC.Hi do
     begin
       l_S:= TddContentItem(l_TOC.Items[TOCItemINdex]);
       SplitText(l_S, aRI, TOCItemIndex);
       inc(TOCItemIndex);
     end;     
     
     l_Cursor := Selection.Cursor.ClonePoint(View);
      try
       for TOCItemIndex:= 0 to l_TOC.Hi do
         l_S:= TddContentItem(l_TOC.Items[TOCItemIndex]);

       for TOCItemIndex:= 0 to l_TOC.Hi do
       begin                      
         // Нужно переформатировать текст абзаца
         l_S := TddContentItem(l_TOC.Items[TOCItemIndex]);
         InsertBuf(l_S.AsPCharLen);
         TextPara.Style.ID := ev_saANSIDOS;
         TextPara.Formatting.Visible := False;
         Select(ev_stPara);
         try
           if l_S.SubID > -1 then
           begin    

             Selection.QueryInterface(IevHyperlink, l_Hyperlink);
             if not l_Hyperlink.Exists then
             begin
               l_Hyperlink.Insert;
               l_Hyperlink.Address := TevAddress_C(aHandle, l_S.SubID);
             end;
           end
           else
            if l_S.SubID = -1 then
             // Помечаем как продолжение ссылки
             TextPara.Style.ID:= ev_saHyperlinkCont;
         finally
           InevSelection(Selection).Unselect;
         end;
         InsertBuf(cc_EOLStr);
       end; { For TOCItemINdex }
       InevSelection(Selection).SelectPoint(l_Cursor, false);
     finally
       l_Cursor := nil;
     end; { try..finally l_Cursor }
    finally
      l3Free(l_TOC);
    end;
  end;
end;


procedure CollectContentTable(DocEditor: TevCustomEditor; aHandle: Longint; const aWriteSubTOC: Boolean = True; const AllDoc: Boolean = True);
{ Накапливает двухуровневое оглавление в переданном списке.
  Оглавление второго уровня выливается в документ (или не выливается) }
var
  l_Pack      : InevOp;
  i           : Integer;
  l_S, l_S2   : TddContentItem;
  l_TOC       : Tl3StringList;
  l_SubTOC    : Tl3StringList;
  l_WrSubTOC  : Boolean;
begin
  with DocEditor do
  begin
    //l_Pack := StartOp(ev_ocUser+100);
    //try
     l_TOC:= Tl3StringList.Make;
     try
      _Collect(DocEditor, l_TOC, AllDoc);
      if l_TOC.Count > 0 then
      with TddTuneTOCDlg.Create(Application) do
      try
        TOC:= l_TOC;
        cbInsertSubTOC.Checked:= aWriteSubTOC;
        if Execute then
        begin
         l_Pack := StartOp(ev_ocUser+100);
         try 
          l_TOC.Assign(TOC);
          { Вываливаем полное оглавление }
          if cbAddBefore.Checked and
             (comboAddSpec.ItemIndex in [tocAddonN, tocAddonNN, tocAddonNNN]) then // Добавляем выбранное слово перед текстом
            for i := 0 to l_TOC.Hi do
            begin
              l_S := TddContentItem(l_TOC.Items[i]);
              if comboAddSpec.ItemIndex = tocAddonN then
                l_S.Insert(l3PCharLen(PChar(Format('Приложение %d. ', [i+1]))), 0)
              else
              if comboAddSpec.ItemIndex = tocAddonNN then
                l_S.Insert(l3PCharLen(PChar(Format('Приложение %2d. ', [i+1]))), 0)
              else
               l_S.Insert(l3PCharLen(PChar(Format('Приложение %3d. ', [i+1]))), 0);
            end;
          if cbFindNearest.Checked then
            for i := 0 to l_TOC.Hi do
            begin
              l_S := TddContentItem(l_TOC.Items[i]);
              if l_S.SubID = SubAbsent then
                l_S.SubID:= l_S.AddID;
            end;
          if AllDoc then
          begin
            MoveLeafCursor(ev_ocParaEnd);
            InsertBuf(cc_EOLStr);
          end
          else
          begin
            MoveLeafCursor(ev_ocParaUp, true);
            MoveLeafCursor(ev_ocParaEnd);
            InsertBuf(cc_EOLStr);
          end;

         DocEditor.Cursor:= crHourGlass;
         try
          WriteContentTable(DocEditor, aHandle, comboAddSpec.ItemIndex, l_TOC);

          if cbInsertSubTOC.Checked then
          begin
            { Начинаем вываливать кусочки оглавления }
            i := 0;
            while i <> l_TOC.Hi do
            begin
              l_S := TddContentItem(l_TOC.Items[i]);
              if (l_S.Level > 1) and (i > 0) then
              begin
                // перейти на саб
                l_S2:= TddContentItem(l_TOC.Items[i-1]);
                TextSource.DocumentContainer.SubList.Sub[l_S2.SubID].Select(Selection);
                MoveLeafCursor(ev_ocParaDown, True);
                MoveLeafCursor(ev_ocParaEnd);
                InsertBuf(cc_EOLStr);
                // Выделить подменю
                l_SubTOC:= Tl3StringList.Make;
                try
                  while (l_S.Level > 1) do
                  begin
                    l_S.Level:= 1;
                    l_SubTOC.Add(l_S);
                    if (i <> l_TOC.Hi) then
                    begin
                      Inc(i);
                      l_S:= TddContentItem(l_TOC.Items[i]);
                    end
                    else
                      break;
                  end;
                  WriteContentTable(DocEditor, aHandle, comboAddSpec.ItemIndex, l_SubTOC);
                finally
                  l3Free(l_SubTOC);
                end;
              end
              else
                Inc(i);
            end; // while i
          end; // if WriteSubTOC
         finally
           DocEditor.Cursor:= crDefault;
         end;
        finally
          l_Pack:= nil;
        end;
        end;
      finally
        Free;
      end;
     finally
      l3Free(l_TOC);
     end;
  end; // with DocEditor
end;


procedure MakeTOCFromBlock(DocEditor: TevCustomEditor; aHandle: Longint; const AllDoc: Boolean = True);
{ Собирает оглавление, используя блочную структуру }
begin
end;

end.



