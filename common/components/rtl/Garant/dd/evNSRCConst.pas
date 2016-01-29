unit evNSRCConst;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evNSRCConst -   }
{ Начат: 04.05.2001 13:59 }
{ $Id: evNSRCConst.pas,v 1.1 2015/08/25 15:25:52 lulin Exp $ }

// $Log: evNSRCConst.pas,v $
// Revision 1.1  2015/08/25 15:25:52  lulin
// {RequestLink:605842696}
//
// Revision 1.13  2015/08/19 11:36:52  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.12  2015/08/19 11:30:19  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
//
// Revision 1.11  2015/08/17 15:36:46  lulin
// {RequestLink:604929290}
//
// Revision 1.10  2010/08/11 09:05:17  dinishev
// [$182452385]. Вернул, т.к. в Немезисе и в модели разъехалось - недоглядел. :-(
//
// Revision 1.5  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.8  2010/05/06 14:43:15  lulin
// {RequestLink:210043160}.
//
// Revision 1.7  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.3  2007/09/21 12:58:16  lulin
// - сделана выливка формул в NSRC.
//
// Revision 1.2  2006/10/12 15:17:37  lulin
// - переехали в общую папку.
//
// Revision 1.1.2.1  2006/10/12 15:15:01  lulin
// - переехали в общую папку.
//
// Revision 1.5  2004/06/04 10:20:15  law
// - bug fix: стиль "не вступил в силу" не был добавлен в список стилей для валидации того, что выливаем с NSRC.
//
// Revision 1.4  2003/12/08 13:33:45  law
// - new behavior: выливаем стиль ev_saNotApplied.
//
// Revision 1.3  2002/10/24 14:13:23  law
// - new const: ev_NSRCAll.
// - new type: TevNSRCSymbolStatus.
//
// Revision 1.2  2001/05/04 11:30:06  narry
// - new const: ev_NSRCInvisible.
//
// Revision 1.1  2001/05/04 11:02:12  law
// - new behavior: сделан учет спецсимволов при выливке таблиц в NSRC и txt.
//

{$I evDefine.inc }

interface

const
  ev_NSRCHeader         = #1;
  ev_NSRCOutOfDate      = #6;
  ev_NSRCNotApplied     = #7;
  ev_NSRCHyperlink      = #4;
  ev_NSRCComment        = #3;
  ev_NSRCColorSelection = #1;
  ev_NSRCHyperlinkCont  = #2;
  ev_NSRCInvisible      = #5;
  ev_NSRCFormula        = #19;
  ev_NSRCSoftEnter      = #29;

  ev_NSRCSimple = [ev_NSRCHeader,        ev_NSRCOutOfDate,
                   ev_NSRCComment,       ev_NSRCColorSelection,
                   ev_NSRCHyperlinkCont, ev_NSRCInvisible, ev_NSRCNotApplied];
  ev_NSRCAll = ev_NSRCSimple + [ev_NSRCHyperlink];

type
  TevNSRCSymbolStatus = packed array [ev_NSRCHeader .. ev_NSRCNotApplied] of Boolean;

const
 cDecorBracket = //ev_NSRCFormula
                 ev_NSRCColorSelection;
                 // http://mdp.garant.ru/pages/viewpage.action?pageId=604899511&focusedCommentId=605829699#comment-605829699
 cDecor = 'decor:';
 cDecorEx = cDecorBracket + cDecor;
 
implementation

end.

