unit evSelectConst;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evSelectConst - }
{ Начат: 19.05.2005 19:59 }
{ $Id: evSelectConst.pas,v 1.3 2007/12/04 12:47:04 lulin Exp $ }

// $Log: evSelectConst.pas,v $
// Revision 1.3  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.1  2005/05/19 16:01:11  lulin
// - new unit: evSelectConst.
//

{$Include evDefine.inc }

interface

uses
  evTypes,
  evOp
  ;

const
  evSelectBrackets : array [TevSelectTarget] of record
   Open, Close : Integer
  end = ((Open: -1; Close: ev_ocCharRight),
         (Open: ev_ocWordStart; Close: ev_ocWordFinish),
         (Open: ev_ocLineHome;  Close: ev_ocLineEnd),
         (Open: ev_ocParaHome;  Close: ev_ocParaEnd),
         (Open: ev_ocTopLeft;   Close: ev_ocBottomRight));
   {* - массив кодов операций перемещения курсора для соответствующих участков
        документа из типа TevSelectTarget. }

implementation

end.

