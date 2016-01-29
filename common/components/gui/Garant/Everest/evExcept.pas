unit evExcept;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В.     }
{ Модуль: evExcept - описание исключительных ситуаций}
{ Начат: 03.06.97 17:37 }
{ $Id: evExcept.pas,v 1.17 2015/06/23 10:23:56 dinishev Exp $ }

// $Log: evExcept.pas,v $
// Revision 1.17  2015/06/23 10:23:56  dinishev
// Расширенное сообщение с номерами и названиями блоков.
//
// Revision 1.16  2015/06/22 08:21:28  dinishev
// {Requestlink:602478379}
//
// Revision 1.15  2015/05/21 11:46:03  lulin
// - развязываем зависимости.
//
// Revision 1.14  2015/05/21 11:39:36  lulin
// - развязываем зависимости.
//
// Revision 1.1  2015/05/21 11:37:08  lulin
// - развязываем зависимости.
//
// Revision 1.12  2015/01/23 10:41:26  dinishev
// {Requestlink:570533036}
//
// Revision 1.11  2011/04/04 14:57:09  lulin
// {RequestLink:255980313}.
//
// Revision 1.10  2010/07/23 08:39:04  fireton
// - механизм "перезапуска" цепочки searcher'ов
//
// Revision 1.9  2010/06/30 08:46:25  oman
// - fix: {RequestLink:220595917}
//
// Revision 1.8  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.7.24.4  2007/08/29 15:33:19  lulin
// - cleanup.
//
// Revision 1.7.24.3  2006/12/06 12:24:09  oman
// - fix: Если на печати колонтитулы не оставляют места для
//  основного текста - бросаем исключение - текст исключения (cq23103)
//
// Revision 1.7.24.2  2006/12/04 13:46:40  oman
// - fix: Если на печати колонтитулы не оставляют места для
//  основного текста - бросаем исключение (cq23103)
//
// Revision 1.7.24.1  2006/03/01 10:48:46  lulin
// - cleanup.
//
// Revision 1.7  2004/07/16 12:36:41  law
// - bug fix: неправильно обрабатывали PgUp/PgDn когда курсора не было видно.
//
// Revision 1.6  2001/03/12 12:48:22  law
// - bug fix: exception при инициализации курсоров выделения, а также применение k2_tiJustification к выделению.
//
// Revision 1.5  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include k2Define.inc }

interface

uses
  SysUtils,
  
  k2Except
  ;

type
  EevException = class(Exception);

  EevWarning = class(EevException);
  EevSearchFailed = class(EevWarning);
  EevReadOnly = Ek2ReadOnly;
  EevLimitReached = Ek2LimitReached;
  EevPrintError = class(EevException);
  EevInvalidPrintMargins = class(EevPrintError);
  EevNothingToPrint = class(EevException);
  EevSearcherRestart = class(Exception);
  EevUnstableProcessWhileInsertUserComment = class(EevException);
  EevTooLargeColumnWidth = class(EevException);
  EevDoubleHandleInNestedBlocks = class(EevException);

const
  ev_errTooLargeColumnWidth = 'Недопустимое значение ширины колонки.';
  ev_warSearchFailed = 'Поиск не дал результатов';
  ev_warInvalidMargins = 'Область печати выходит за границы бумажного листа. '+
    'Отредактируйте настройки размера бумаги и колонтитулов и повторите попытку печати.';
  ev_errDoubleHandleInNestedBlocks = 'В документе найдены вложенные блоки с одинаковыми номерами: %d и %d, имена блоков %s и %s';

implementation

end.

