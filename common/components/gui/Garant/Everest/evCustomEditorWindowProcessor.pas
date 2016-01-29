unit evCustomEditorWindowProcessor;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evEditorWindowProcessor - }
{ Начат: 21.07.2005 08:46 }
{ $Id: evCustomEditorWindowProcessor.pas,v 1.2 2009/04/14 18:11:54 lulin Exp $ }

// $Log: evCustomEditorWindowProcessor.pas,v $
// Revision 1.2  2009/04/14 18:11:54  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.1  2008/05/16 14:01:10  lulin
// - переносим на модель.
//
// Revision 1.2  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.5  2005/12/01 05:27:42  lulin
// - нотификация об изменении атрибута тега разложена по уровням _Processor -> DocumentContainer -> TextSource.
//
// Revision 1.1.2.4  2005/07/25 10:54:36  lulin
// - события нотификации перенесены с контейнера документа и процессора на TextSource.
//
// Revision 1.1.2.3  2005/07/21 13:57:41  lulin
// - убраны лишние свойства с процессора операций.
//
// Revision 1.1.2.2  2005/07/21 09:19:30  lulin
// - с TextSource убраны излишние знания о потрохах контейнера документа.
//
// Revision 1.1.2.1  2005/07/21 05:05:03  lulin
// - распилил модуль с TextSource на несколько.
//

{$Include evDefine.inc }

interface

uses
  evNotifiedProcessor
  ;
  
type
  TevCustomEditorWindowProcessor = class(TevNotifiedProcessor)
   {* Процессор операций для окна редактора (см. TevCustomEditorWindow). }
  end;//TevCustomEditorWindowProcessor

implementation

end.

