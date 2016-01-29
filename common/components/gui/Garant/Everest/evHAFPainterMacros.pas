unit evHAFPainterMacros;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evHAFPainterMacros - }
{ Начат: 28.12.2004 18:22 }
{ $Id: evHAFPainterMacros.pas,v 1.1 2010/09/09 13:34:52 lulin Exp $ }

// $Log: evHAFPainterMacros.pas,v $
// Revision 1.1  2010/09/09 13:34:52  lulin
// {RequestLink:197496539}.
//
// Revision 1.8  2009/01/13 09:23:16  oman
// - new: Новый макрос для колонтитулов (К-121144891)
//
// Revision 1.7  2008/12/29 11:33:33  oman
// - fix: Чистим ненужные константы и операции (К-122675365)
//
// Revision 1.6  2008/02/04 14:02:38  oman
// - new: Предупреждение о редакциях все-таки не макрос (cq20237, 11152)
//
// Revision 1.5  2008/02/04 10:09:01  oman
// - new: Заготовки для макроса "Статус документа" (cq20237, 11152)
//
// Revision 1.4  2007/12/04 12:47:41  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.2.6.3  2007/07/31 16:55:29  lulin
// - cleanup.
//
// Revision 1.2.6.2  2006/11/20 10:16:30  oman
// Merge from B_NEMESIS_6_4
//
// Revision 1.2.6.1.32.1  2006/11/20 09:41:58  oman
// - Новые макросы для печати (cq23193)
//
// Revision 1.2.6.1  2005/05/18 12:42:52  lulin
// - отвел новую ветку.
//
// Revision 1.1.4.3  2005/05/18 12:32:15  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.1.4.2  2005/04/28 09:18:35  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.1.4.1  2005/04/14 07:40:30  lulin
// - объединил с HEAD.
//
// Revision 1.2  2005/04/12 12:40:29  fireton
// - add: добавляем возможность выводить в колонитулах полное название документа
//
// Revision 1.1  2004/12/28 15:36:48  lulin
// - new unit: evHAFPainterMacros.
//

{$Include evDefine.inc }

interface

resourcestring                     
  SAppTitle = '%AppTitle%';
  SDocName = '%DocName%';
  SDocFullName = '%DocFullName%';
  SDocRedactionDate = '%DocRedactionDate%';
  SDocCurrentPage = '%DocCurrentPage%';
  SDocPagesCount = '%DocPagesCount%';
  SCurrentDate = '%CurrentDate%';
  SCurrentTime = '%CurrentTime%';
  SInternalNumber = '%InternalNumber%';
  SDataSize = '%DataSize%';
  SFilePosition = '%FilePosition%';

implementation

end.

