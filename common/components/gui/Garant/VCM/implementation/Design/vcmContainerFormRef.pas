unit vcmContainerFormRef;
 { Хак для подключения сгенерированных форм }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntityFormRef - }
{ Начат: 12.12.2008 12:35 }
{ $Id: vcmContainerFormRef.pas,v 1.1 2008/12/19 10:55:29 lulin Exp $ }

// $Log: vcmContainerFormRef.pas,v $
// Revision 1.1  2008/12/19 10:55:29  lulin
// - перекладываем, чтобы случайно не зацепить.
//
// Revision 1.1  2008/12/19 09:59:17  lulin
// - <K>: 128288713. Хак для того, чтобы наследоваться от сгенерированных форм.
//

{$Include vcmDefine.inc }

interface

uses
  vcmContainerForm
  ;

type
  TvcmContainerFormRef = class(TvcmContainerForm)
  end;//TvcmEntityFormRef

implementation

end.

