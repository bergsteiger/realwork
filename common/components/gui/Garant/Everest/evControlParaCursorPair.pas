unit evControlParaCursorPair;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evControlParaCursorPair - }
{ Начат: 30.08.2005 18:48 }
{ $Id: evControlParaCursorPair.pas,v 1.4 2014/07/29 12:54:56 lulin Exp $ }

// $Log: evControlParaCursorPair.pas,v $
// Revision 1.4  2014/07/29 12:54:56  lulin
// - рисуем фабрики интерфейсов.
//
// Revision 1.3  2008/04/11 12:26:07  lulin
// - <K>: 89100752.
//
// Revision 1.2  2007/12/04 12:46:59  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.2  2006/11/03 11:00:03  lulin
// - объединил с веткой 6.4.
//
// Revision 1.1.2.1.22.1  2006/10/19 13:42:24  oman
// - fix: При даблклике в пустом поле КЗ пропадала каретка
//
// Revision 1.1.2.1  2005/08/30 15:03:05  lulin
// - new behavior: в контроле выделяем только текст, но не сам контрол.
//

{$Include evDefine.inc }

interface

uses
  evTextCursorPair,

  nevTools
  ;

type
  TevControlParaCursorPair = class(TevTextCursorPair)
    protected
    // internal methods
      {$IfDef Nemesis}
      function  IsSolid(const aView : InevView): Boolean;
        override;
        {-}
      function EmptyIsNotConsideredCollapsed: Boolean;
        override;
        {* - трактовать пустое выделение в пустом параграфе как непустое }
      {$EndIf Nemesis}
  end;//TevControlParaCursorPair

implementation

// start class TevControlParaCursorPair

{$IfDef Nemesis}
function TevControlParaCursorPair.EmptyIsNotConsideredCollapsed: Boolean;
begin
 Result := False;
end;

function TevControlParaCursorPair.IsSolid(const aView : InevView): Boolean;
  //override;
  {-}
begin
 Result := false;
end;
{$EndIf Nemesis}

end.

