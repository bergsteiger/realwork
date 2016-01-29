unit tb97Form;

{ Библиотека "Toolbar 97" }
{ Автор: Люлин А.В. ©     }
{ Модуль: tb97Form -      }
{ Начат: 13.09.2004 15:21 }
{ $Id: tb97Form.pas,v 1.5 2008/01/31 16:15:53 lulin Exp $ }

// $Log: tb97Form.pas,v $
// Revision 1.5  2008/01/31 16:15:53  lulin
// - cleanup.
//
// Revision 1.4  2006/12/10 18:59:05  lulin
// - класс формы переименован в соответствии с библиотекой.
//
// Revision 1.3  2005/07/22 13:03:01  lulin
// - модуль с базовыми формами переехал в библиотеку L3.
//
// Revision 1.2  2004/09/13 14:52:43  lulin
// - bug fix: не компилировалось без L3.
// - bug fix: были перекрыты Destroy, а не Cleanup - из-за этого отьезжали Toolbar'ы.
//
// Revision 1.1  2004/09/13 11:42:42  lulin
// - приближаем Toolbar97 к кошерности.
//

{$I TB97Ver.inc}

interface

uses
  Forms

  ,
  l3Forms
  ;

type
  Ttb97Form = class(Tl3Form)
  end;//Ttb97Form

implementation

end.

