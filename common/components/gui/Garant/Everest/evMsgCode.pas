unit evMsgCode;
{* Сообщения Everest'а. Наследие тяжкого безинтерфейсного прошлого.
   Планируется со временем убить. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evMsgCode -     }
{ Начат: 09.07.2002 17:09 }
{ $Id: evMsgCode.pas,v 1.15 2008/09/26 10:10:47 dinishev Exp $ }

// $Log: evMsgCode.pas,v $
// Revision 1.15  2008/09/26 10:10:47  dinishev
// <K>: 77235630 для Head'а
//
// Revision 1.14  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.13  2007/12/04 12:47:03  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.12.14.4  2005/12/05 04:18:16  lulin
// - cleanup.
//
// Revision 1.12.14.3  2005/10/13 06:00:24  lulin
// - cleanup.
//
// Revision 1.12.14.2  2005/07/19 08:25:03  lulin
// - избавился от посылки сообщений для конвертации текста параграфа - перевел конвертацию на общий механизм Search/_Replace.
//
// Revision 1.12.14.1  2005/07/19 06:58:45  lulin
// - cleanup: убрано лишнее сообщение для конвертации текста параграфов.
//
// Revision 1.12  2005/01/27 16:45:27  lulin
// - optimization: меньше переформатируем документ за счет более поздней прогрузки текста.
//
// Revision 1.11  2003/12/01 14:39:59  law
// - new methods: TevCustomEditor.TextBufConvert, TextBufConvertF.
//
// Revision 1.10  2003/10/10 18:47:25  law
// - new behavior: избавился от переформатирования внутри WM_Size.
// - change: задел на отрисовку окна во время переформатирования (см. комментарии TevCustomEditorWindow.Paint - f_ScrollTagWrap). А то сейчас некрасиво выглядит при Maximize при WebStyle.
//
// Revision 1.9  2003/10/10 15:22:41  law
// - new behavior: скрытие/показ комментариев заметно убыстрены.
// - доточена процедура фоновоо форматирования.
// - change: в консольном режиме вставлен отладочный вывод, для тестирования фонового форматирования.
//
// Revision 1.8  2003/09/25 17:00:17  law
// - new behavior: сделано отложенное убивание форм.
//
// Revision 1.7  2003/07/04 19:39:45  law
// - оптимизация переформатирования текста в фоновом режиме (до конца не доделано, но светлые мысли есть).
//
// Revision 1.6  2003/02/06 15:15:03  law
// - cleanup: переходим от сообщений (message) к виртуальным функциям.
//
// Revision 1.5  2003/02/06 14:42:59  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.4  2003/02/06 12:35:22  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.3  2003/02/05 13:53:11  law
// - cleanup: переходим от сообщений (message)  к виртуальным функциям.
//
// Revision 1.2  2003/01/17 15:20:03  law
// - change: перешел от message к interface.
// - new behavior: в результате этого ускорилось объединение таблиц.
//
// Revision 1.1  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//

{$Include evDefine.inc }

interface

const {-сообщения Everest'а}
  ev_msgFirst = $7F00 - 300;
    {* - первое сообщение Everest'а}

  ev_msgFirstOp = ev_msgFirst;
    {-}
  ev_msgSetAtom         = ev_msgFirstOp;
    {* - установить атом. }
  ev_msgAddHyperlink    = ev_msgFirstOp + 1;
    {* - поставить гипертекстовую ссылку. см: evIntf.TevmsgAddHyperlink.}
  ev_msgDeleteHyperlink = ev_msgFirstOp + 2;
    {* - удалить гипертекстовую ссылку. см: evIntf.TevmsgDeleteHyperlink.}
  ev_msgAddSub          = ev_msgFirstOp + 3;
    {* - поставить Sub. см: evIntf.TevmsgAddSub.}
  ev_msgDeleteSub       = ev_msgFirstOp + 4;
    {* - удалить Sub. см: evIntf.TevmsgDeleteSub. }
  ev_msgInsertBlock     = ev_msgFirstOp + 5;
    {* - вставить блок текста. см: evIntf.TevmsgInsertBlock.}
  ev_msgInsertString    = ev_msgFirstOp + 6;
    {* - вставить строку. см: evIntf.TevmsgInsertString.}
  ev_msgDeleteString    = ev_msgFirstOp + 7;
    {* - удалить wParam символов. см: evIntf.TevmsgDeleteString. }
  ev_msgDeleteChar      = ev_msgFirstOp + 8;
    {* - удалить символ. }
  ev_msgJoinParas       = ev_msgFirstOp + 9;
    {* - объединить параграфы. }
  ev_msgBreakPara       = ev_msgFirstOp + 10;
    {* - разорвать параграф. см: evIntf.TevmsgBreakPara. }
  ev_msgInsertPara      = ev_msgFirstOp + 11;
    {* - вставить параграф. }
  ev_msgSearch          = ev_msgFirstOp + 12;
    {* - поиск. см: evIntf.TevmsgSearch. }
  ev_msgMove            = ev_msgFirstOp + 13;
    {* - движение. см: evIntv.TevmsgMove. }
  ev_msgChangeParam     = ev_msgFirstOp + 14;
    {* - изменить значение параметра. }
  ev_msgBackspace       = ev_msgFirstOp + 15;
    {* - удалить предыдущий символ. см: evIntsf.TevmsgBackspace. }
  M_evJoinWith          = ev_msgFirstOp + 16;
    {* - объединить параграфы. см: evMsg.MevJoinWith. }
  M_evSplit             = M_evJoinWith  + 1;
    {* - разорвать параграф. см: evMsg.MevSplit. }
  ev_msgDeletePara      = M_evJoinWith  + 2;
    {* - удалить параграф. }
  ev_msgLastOp = ev_msgDeletePara;
    {* - последняя операция. }
  ev_msgBlock2Para      = ev_msgLastOp + 1;
    {* - преобразовать выделение в параграф. }
  ev_msgNeedPaint       = ev_msgBlock2Para + 1;
    {-}
  ev_msgWasWMSize       = ev_msgNeedPaint + 1;
    {* - последняя занятая константа. }
  ev_msgNeedDoc         = ev_msgWasWMSize + 1;
    {-}
  ev_msgAddMarker      = ev_msgWasWMSize + 2;
    {* - добавить маркер. }
  ev_msgLast            = ev_msgAddMarker;
    {* - последняя занятая константа. }

implementation

end.

