unit evFormulaCursor;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evFormulaCursor - }
{ Начат: 16.12.2002 15:02 }
{ $Id: evFormulaCursor.pas,v 1.14 2009/07/10 15:04:43 lulin Exp $ }

// $Log: evFormulaCursor.pas,v $
// Revision 1.14  2009/07/10 15:04:43  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.13  2009/06/18 18:35:07  lulin
// {RequestLink:142613457}.
//
// Revision 1.12  2009/04/13 16:13:52  lulin
// [$142613919]. Все виртуальные методы переносим на модель.
//
// Revision 1.11  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.10  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.8.8.8  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.8.8.7.18.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.8.8.7  2006/06/08 13:37:49  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.8.8.6  2006/01/13 11:56:03  lulin
// - bug fix: в более корректный момент сбрасываем дюймовые координаты курсора.
//
// Revision 1.8.8.5  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.8.8.4  2005/09/23 16:03:55  lulin
// - выделен модуль с общими интерфейсами.
//
// Revision 1.8.8.3  2005/07/27 14:47:52  lulin
// - вместо безликих констант, для результата перемещения курсора введен перечислимый тип.
//
// Revision 1.8.8.2  2005/07/19 12:03:19  lulin
// - cleanup: удалены ненужные модули и методы.
//
// Revision 1.8.8.1  2005/07/19 11:33:07  lulin
// - окончательно избавился, от функциональности, работающей через посылку сообщений.
//
// Revision 1.8  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.7  2004/11/13 16:11:47  lulin
// - bug fix: в результате переделок отвалилась обработка движения курсора для формул.
//
// Revision 1.6  2004/11/13 15:46:01  lulin
// - new behavior: рисуем рамку вокруг параграфа с формулой.
//
// Revision 1.5  2004/11/13 15:29:08  lulin
// - new behavior: запрещено удалять контролы.
//
// Revision 1.4  2004/11/13 15:23:31  lulin
// - cleanup: перевел параграф с формулами на использование флага ReadOnly.
//
// Revision 1.3  2002/12/17 08:17:27  law
// - bug fix.
//
// Revision 1.2  2002/12/16 18:05:18  law
// - new behavior: в режиме Collapsed у формул отрезаны возможности редактирования.
//
// Revision 1.1  2002/12/16 12:21:46  law
// - new unit: evFormulaCursor.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Interfaces,

  evInternalInterfaces,
  evMsgCode,
  evTextParaCursor,

  nevBase,
  nevTools
  ;

type
  TevFormulaCursor = class(TevTextParaCursor)
    protected
    // internal methods
      function  DoMovePrim(const aView : InevView;
                           aCode      : Long;
                           const anOp : InevOp;
                           aCount     : Integer): TnevMoveResult;
        override;
        {-}
      function  Collapsed: Bool;
        {-}
    public
    // public methods
      function  GetReadOnly: Bool;
        override;
        {-}
      function  GetNeedWindowsCaret: Boolean;
        override;
        {-}
      function  GetCanBeDeleted: Bool;
        override;
        {-}
  end;//TevFormulaCursor

implementation

uses
  k2Base,
  k2Tags,

  evCursorConst
  ;

// start class TevFormulaCursor

function TevFormulaCursor.DoMovePrim(const aView : InevView;
                                     aCode      : Long;
                                     const anOp : InevOp;
                                     aCount     : Integer): TnevMoveResult;
  //override;
  {-}
begin
 if Collapsed then
 // - сами не обрабатываем движение курсора, если не в режиме редактирования
  Result := ev_dcNotDone
 else
  Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
end;

function TevFormulaCursor.Collapsed: Bool;
  {-}
begin
 with GetRedirect.Attr[k2_tiCollapsed] do
  Result := not IsValid OR AsBool
end;

function TevFormulaCursor.GetReadOnly: Bool;
  //override;
  {-}
begin
 Result := Collapsed;
end;

function TevFormulaCursor.GetNeedWindowsCaret: Boolean;
  //override;
  {-}
begin
 Result := not ReadOnly;
end;

function TevFormulaCursor.GetCanBeDeleted: Bool;
  //override;
  {-}
begin
 Result := true;
 // - удалять нас можно и в отрендерреном состоянии
end;

end.

