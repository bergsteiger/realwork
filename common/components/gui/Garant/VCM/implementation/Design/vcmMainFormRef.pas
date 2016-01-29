unit vcmMainFormRef;
 { Хак для подключения сгенерированных форм }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntityFormRef - }
{ Начат: 29.12.2008 16:18 }
{ $Id: vcmMainFormRef.pas,v 1.1 2008/12/29 13:20:48 lulin Exp $ }

// $Log: vcmMainFormRef.pas,v $
// Revision 1.1  2008/12/29 13:20:48  lulin
// - добавляем возможность рисовать главную форму приложения.
//

{$Include vcmDefine.inc }

interface

uses
  vcmMainForm
  ;

type
  TvcmMainFormRef = class(TvcmMainForm)
  end;//TvcmMainFormRef

implementation

end.

