unit evOp;
{* Описание кодов операций. }

{ Библиотека ""         }
{ Автор: Люлин А.В.     }
{ Модуль: evOp - описание операций редактирования}
{ Начат: 20.03.97 16:51 }
{ $Id: Evop.pas,v 1.20 2012/11/27 11:50:05 dinishev Exp $ }

// $Log: Evop.pas,v $
// Revision 1.20  2012/11/27 11:50:05  dinishev
// {Requestlink:410628348}
//
// Revision 1.19  2012/03/02 12:27:27  dinishev
// {Requestlink:340175024}
//
// Revision 1.18  2009/04/13 12:32:48  lulin
// [$142613919].
//
// Revision 1.17  2007/12/04 12:46:58  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.15.30.3  2005/07/19 09:37:48  lulin
// - избавился от посылки сообщений.
//
// Revision 1.15.30.2  2005/06/16 14:11:29  lulin
// - cleanup: отдельно стоящие процедуры перенесены на интерфейсы.
//
// Revision 1.15.30.1  2005/05/27 12:05:56  lulin
// - убраны лишние зависимости.
//
// Revision 1.15  2004/02/27 19:22:12  law
// - bug fix: поправлена обработка ShortCut'ов для операций модулей.
// - bug fix: поправдена ДВОЙНАЯ обработка ShortCut'ов в случае редактора.
//
// Revision 1.14  2003/02/26 13:40:31  law
// - new: новый код перемещения курсора ev_ocMakeChildChain.
//
// Revision 1.13  2002/09/10 13:29:20  law
// - comments: xHepGen.
//
// Revision 1.12  2002/07/03 11:10:17  law
// - new const: ev_ocWholeWordRight.
//
// Revision 1.11  2002/06/06 14:48:29  law
// - new behavior: Backspace теперь нормально работает в "резиновых" таблицах.
//
// Revision 1.10  2002/05/17 10:41:07  law
// - new commands: ev_ocDeleteWordLeft, ev_ocDeleteWordRight.
//
// Revision 1.9  2001/06/06 12:43:52  law
// - new behavior: частично сделано разделение ячеек по вертикали.
//
// Revision 1.8  2001/03/23 17:46:17  law
// - добавлена операция ev_ocToggleInsertMode.
//
// Revision 1.7  2001/03/02 16:25:34  law
// - сделана отработка команд ^KB и ^KK.
//
// Revision 1.6  2000/12/15 15:10:33  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  OvcConst, {-command and resource constants from Orpheus} {&&& $$$ &&&}
  
  l3Types,
  l3Operations
  ;

const
  { команды от Orpheus: }
  ev_ocShortCut         = l3_ocShortCut;
    {-}
  ev_ocNone             = ccNone;
    {* - пустая команда}
  ev_ocTab              = ccTab;
    {* - табуляция}
  ev_ocAcceptChar       = ccAccept;
    {-}
  ev_ocActionItem       = ccActionItem;
    {-}
  ev_ocCharLeft         = ccLeft;
    {* - сместиться на символ влево}
  ev_ocCharRight        = ccRight;
    {* - сместиться на символ вправо}
  ev_ocLineUp           = ccUp;
    {* - сместиться на строку вверх}
  ev_ocLineDown         = ccDown;
    {* - сместиться на строку вниз}
  ev_ocLineHome         = ccHome;
    {* - переместиться в начало строки}
  ev_ocLineEnd          = ccEnd;
    {* - переместиться на конец строки}
  ev_ocPageUp           = ccPrevPage;
    {* - страница вверх}
  ev_ocPageDown         = ccNextPage;
    {* - страница вниз}
  ev_ocTopLeft          = ccFirstPage;
    {* - в левый верхний угол документа}
  ev_ocBottomRight      = ccLastPage;
    {* - в правый нижний угол документа}
  ev_ocPageTop          = ccTopOfPage;
    {* - наверх страницы}
  ev_ocPageBottom       = ccBotOfPage;
    {* - вниз страницы}
  ev_ocDeleteChar       = ccDel;
    {* - удалить текущий символ}
  ev_ocBackSpace        = ccBack;
    {* - удалить символ слева от курсора}
  ev_ocBreakPara        = ccNewLine;
    {* - разорвать параграф Loc}
  ev_ocWordLeft         = ccWordLeft;
    {* - переместиться на слово влево}
  ev_ocWordRight        = ccWordRight;
    {* - переместиться на слово вправо Bool(bParam) - на конец слова или на след. слово}
  ev_ocCut              = ccCut;
    {* - скопировать выделение в буфер и удалить}
  ev_ocCopy             = ccCopy;
    {* - скопировать выделение в буфер}
  ev_ocPaste            = ccPaste;
    {* - вставить из буфера}
  ev_ocUndo             = ccUndo;
    {* - отменить операцию}
  ev_ocRedo             = ccRedo;
    {* - вернуть отмененную операцию}
  ev_ocDeleteLine       = ccDelLine;
    {* - удалить строку}
  { команды для установки маркеров: }
  ev_ocSetMarker0       = ccSetMarker0;
  ev_ocSetMarker1       = ccSetMarker1;
  ev_ocSetMarker2       = ccSetMarker2;
  ev_ocSetMarker3       = ccSetMarker3;
  ev_ocSetMarker4       = ccSetMarker4;
  ev_ocSetMarker5       = ccSetMarker5;
  ev_ocSetMarker6       = ccSetMarker6;
  ev_ocSetMarker7       = ccSetMarker7;
  ev_ocSetMarker8       = ccSetMarker8;
  ev_ocSetMarker9       = ccSetMarker9;
  { команды для перехода по маркеру: }
  ev_ocGotoMarker0      = ccGotoMarker0;
  ev_ocGotoMarker1      = ccGotoMarker1;
  ev_ocGotoMarker2      = ccGotoMarker2;
  ev_ocGotoMarker3      = ccGotoMarker3;
  ev_ocGotoMarker4      = ccGotoMarker4;
  ev_ocGotoMarker5      = ccGotoMarker5;
  ev_ocGotoMarker6      = ccGotoMarker6;
  ev_ocGotoMarker7      = ccGotoMarker7;
  ev_ocGotoMarker8      = ccGotoMarker8;
  ev_ocGotoMarker9      = ccGotoMarker9;
  { команды для изменения границ выделенного блока: }
  ev_ocExtLineDown      = ccExtendDown;
  ev_ocExtLineEnd       = ccExtendEnd;
  ev_ocExtLineHome      = ccExtendHome;
  ev_ocExtCharLeft      = ccExtendLeft;
  ev_ocExtPageDown      = ccExtendPgDn;
  ev_ocExtPageUp        = ccExtendPgUp;
  ev_ocExtCharRight     = ccExtendRight;
  ev_ocExtLineUp        = ccExtendUp;
  ev_ocExtPageBottom    = ccExtBotOfPage;
  ev_ocExtTop           = ccExtFirstPage;
  ev_ocExtBottom        = ccExtLastPage;
  ev_ocExtPageTop       = ccExtTopOfPage;
  ev_ocExtWordLeft      = ccExtWordLeft;
  ev_ocExtWordRight     = ccExtWordRight;

  ev_ocStartSelection   = ccStartSelBlock;
   {* - пометить начало выделения. }
  ev_ocFinishSelection  = ccEndSelBlock;
   {* - пометить конец выделения. }
  ev_ocToggleInsertMode = ccIns;
   {* - переключить режим вставки/замены. }
  ev_ocDeleteWordLeft   = ccDelWordLeft;
    {-}
  ev_ocDeleteWordRight  = ccDelWordRight;
    {-}

const
  { собственные команды Эвереста: }
  ev_ocBase             = ccUserFirst + 100;
    {* - база для операций "Эвереста"}
  ev_ocColumnLeft       = ev_ocBase;
    {* - переместить курсор Loc на ячейку влево учитывая TevCaretPos(bParam)}
  ev_ocColumnRight      = ev_ocBase + 1;
    {* - переместить курсор Loc на ячейку вправо учитывая TevCaretPos(bParam)}
  ev_ocDeleteRow        = ev_ocBase + 2;
    {* - удалить текущую строку таблицы}
  ev_ocDeleteColumn     = ev_ocBase + 3;
    {* - удалить текущую колонку таблицы}
  ev_ocParaHome         = ev_ocBase + 4;
    {* - в начало параграфа}
  ev_ocParaEnd          = ev_ocBase + 5;
    {* - в конец параграфа}
  ev_ocLineLeft         = ev_ocBase + 6;
    {* - на строку влево}
  ev_ocLineRight        = ev_ocBase + 7;
    {* - на строку вправо}
  ev_ocParaLeft         = ev_ocBase + 8;
    {* - на параграф влево}
  ev_ocParaUp           = ev_ocBase + 9;
    {* - на параграф вверх}
  ev_ocParaRight        = ev_ocBase + 10;
    {* - на параграф вправо}
  ev_ocParaDown         = ev_ocBase + 11;
    {* - на параграф вниз}
  ev_ocWordStart        = ev_ocBase + 12;
    {* - на начало слова}
  ev_ocWordFinish       = ev_ocBase + 13;
    {* - на конец слова}
  ev_ocExtParaUp        = ev_ocBase + 14;
    {-на параграф вверх}
  ev_ocExtParaDown      = ev_ocBase + 15;
    {-на параграф вниз}
  ev_ocListHome         = ev_ocBase + 16;
    {* - на начало списка параграфов. }
  ev_ocListEnd          = ev_ocBase + 17;
    {* - на конец списка параграфов. }
  ev_ocInsertRow        = ev_ocBase + 18;
    {* - вставить строку таблицы. }
  ev_ocInsertColumn     = ev_ocBase + 19;
    {* - вставить колонку таблицы. }
  ev_ocExtParaEnd       = ev_ocBase + 20;
    {* - в конец параграфа. }
  ev_ocVTop             = ev_ocBase + 21;
    {* - в начало параграфа (по вертикали). }
  ev_ocVBottom          = ev_ocBase + 22;
    {* - в конец параграфа (по вертикали). }
  ev_ocPrevParaBottomRight = ev_ocBase + 23;
    {* - в конец предыдущего параграфа. }
  ev_ocNextParaTopLeft  = ev_ocBase + 24;
    {* - в начало следующего параграфа. }
  ev_ocPrevParaBottomRightInThisBlock = ev_ocBase + 25;
    {* - в конец предыдущего параграфа в это блоке или _ev_cpNull. }
  ev_ocExtParaHome      = ev_ocBase + 26;
    {* - в начало параграфа. }
  ev_ocExtParaLeft      = ev_ocBase + 27;
    {* - на параграф влево. }
  ev_ocExtParaRight     = ev_ocBase + 28;
    {* - на параграф вправо. }
  ev_ocNextPara         = ev_ocBase + 29;
    {* - в начало следующего параграфа. }
  ev_ocPrevCharForDelete = ev_ocBase + 30;
    {* - предыдущий символ для удаления. }
  ev_ocWholeWordRight   = ev_ocBase + 31;
    {* - слово вправо целиком + м. б. пробелы. }
  ev_ocMakeChildChain   = ev_ocBase + 32;
    {* - построить цепочку детей. }
  ev_ocParaDownWithEmptyRow = ev_ocBase + 33;
    {* - на параграф не пропуская пустые строки. }
  ev_ocBottomRightIgnoreMergedCell = ev_ocBase + 34;
    {* - в правый нижний угол документа, игнорируя объединенные ячейки}
  ev_ocUser             = ev_ocBase + 50;
    {-}

implementation

end.

