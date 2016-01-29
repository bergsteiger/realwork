unit vcmMessages;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmMessages -   }
{ Начат: 03.10.2003 12:48 }
{ $Id: vcmMessages.pas,v 1.4 2009/01/12 15:08:02 oman Exp $ }

// $Log: vcmMessages.pas,v $
// Revision 1.4  2009/01/12 15:08:02  oman
// - fix: Экспериментальная залечка (К-133891591)
//
// Revision 1.3  2005/07/22 13:08:33  lulin
// - отключена зависимость о Everest.
//
// Revision 1.2  2003/10/22 12:33:52  law
// - bug fix: невовремя убивался Toolbar.
//
// Revision 1.1  2003/10/03 09:13:56  law
// - bug fix: очищаем PopupMenu в подходящий момент.
//

{$I vcmDefine.inc }

interface

const
  vcm_msgCloseForm      = $7F00 - 300;
    {-}
  vcm_msgCloseChildForm = vcm_msgCloseForm + 1;
    {-}
  vcm_msgClearPopup     = vcm_msgCloseChildForm + 2;
    {-}
  vcm_msgFreeComponent  = vcm_msgCloseChildForm + 3;
    {-}
  vcm_msgUpdateStatus   = vcm_msgCloseChildForm + 4;

implementation

end.

