unit m3DBActions;

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3DBActions -   }
{ Начат: 21.12.2007 11:19 }
{ $Id: m3DBActions.pas,v 1.3 2009/03/23 11:24:02 lulin Exp $ }

// $Log: m3DBActions.pas,v $
// Revision 1.3  2009/03/23 11:24:02  lulin
// - используем кошерный конструктор индекса потока документа.
//
// Revision 1.2  2008/05/08 14:04:19  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.1  2007/12/21 08:26:10  lulin
// - функции для построения оберток вынесены в отдельный модуль.
//

{$Include m3Define.inc}

interface

uses
  m3DBInterfaces
  ;

function  m3L2DocumentAction(Action: Pointer): Tm3DocumentAction;
  {* - делает заглушку для локальной процедуры. }
procedure m3FreeDocumentAction(var Stub: Tm3DocumentAction);
  {* - освобождает заглушку для локальной процедуры. }
function  m3L2FilerAction(Action: Pointer): Tm3FilerAction;
  {* - делает заглушку для локальной процедуры. }
procedure m3FreeFilerAction(var Stub: Tm3FilerAction);
  {* - освобождает заглушку для локальной процедуры. }
function  m3L2DBStreamAction(Action: Pointer): Tm3DBStreamAction;
  {* - делает заглушку для локальной процедуры. }
procedure m3FreeDBStreamAction(var Stub: Tm3DBStreamAction);
  {* - освобождает заглушку для локальной процедуры. }
function  m3L2DBIndexAction(Action: Pointer): Tm3DBIndexAction;
  {* - делает заглушку для локальной процедуры. }
procedure m3FreeDBIndexAction(var Stub: Tm3DBIndexAction);
  {* - освобождает заглушку для локальной процедуры. }

implementation

uses
  l3Base
  ;

function  m3L2DocumentAction(Action: Pointer): Tm3DocumentAction;
  {* - делает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDocumentAction(var Stub: Tm3DocumentAction);
  {* - освобождает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2FilerAction(Action: Pointer): Tm3FilerAction;
  {* - делает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeFilerAction(var Stub: Tm3FilerAction);
  {* - освобождает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2DBStreamAction(Action: Pointer): Tm3DBStreamAction;
  {* - делает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDBStreamAction(var Stub: Tm3DBStreamAction);
  {* - освобождает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  m3L2DBIndexAction(Action: Pointer): Tm3DBIndexAction;
  {* - делает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m3FreeDBIndexAction(var Stub: Tm3DBIndexAction);
  {* - освобождает заглушку для локальной процедуры. }
  register;
asm
          jmp  l3FreeLocalStub
end;{asm}

end.

