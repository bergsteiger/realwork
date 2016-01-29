unit evEditorWindow;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evCustomEditorWindow - }
{ Начат: 30.09.2008 18:54 }
{ $Id: evEditorWindow.pas,v 1.697 2011/06/22 10:48:28 lulin Exp $ }

// $Log: evEditorWindow.pas,v $
// Revision 1.697  2011/06/22 10:48:28  lulin
// - приближаем исходники к модели.
//
// Revision 1.5  2010/05/25 14:47:24  lulin
// {RequestLink:216072357}.
// - добавлен тест.
//
// Revision 1.4  2010/05/13 14:25:55  lulin
// {RequestLink:210438932}.
// - сделано построчное сроллирование.
// - уменьшен размер тестового файла.
//
// Revision 1.3  2008/10/10 14:19:41  lulin
// - <K>: 121146878.
//
// Revision 1.2  2008/10/01 17:31:01  lulin
// - <K>: 120720356.
//
// Revision 1.1  2008/09/30 16:04:38  lulin
// - <K>: 120718188.
//

{$Include evDefine.inc }

interface

uses
  evCustomEditorWindow,
  evEditorWindowHotSpot
  ;

type
  TevCustomEditorWindow = evCustomEditorWindow.TevCustomEditorWindow;
  RevEditorWindowHotSpot = evCustomEditorWindow.RevEditorWindowHotSpot;
  RevSelection = evCustomEditorWindow.RevSelection;

const
  SB_WheelDown = evCustomEditorWindow.SB_WheelDown;
  SB_WheelUp = evCustomEditorWindow.SB_WheelUp;

implementation

end.

