unit evTableRowCursorPair;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTableRowCursorPair - }
{ Начат: 17.12.2002 11:25 }
{ $Id: evTableRowCursorPair.pas,v 1.28 2014/04/30 11:23:52 lulin Exp $ }

// $Log: evTableRowCursorPair.pas,v $
// Revision 1.28  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.27  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.26  2014/01/16 15:11:01  kostitsin
// {requestlink: 156370750} - TevRange
//
// Revision 1.25  2013/01/30 11:32:09  dinishev
// {Requestlink:425273666}
//
// Revision 1.24  2013/01/30 09:28:06  dinishev
// {Requestlink:425273666}. Переносим на модель TevTableCurosrPair, т.к. нужна примесь.
//
// Revision 1.23  2011/02/17 13:19:27  dinishev
// [$253663257]
//
// Revision 1.22  2010/10/14 12:46:11  dinishev
// [$235875463]
//
// Revision 1.21  2010/07/29 11:34:09  lulin
// {RequestLink:228693150}.
// - не удаляем все пустые параграфы при вставке потока. ОДИН всегда оставляем.
//
// Revision 1.20  2010/07/13 10:45:27  dinishev
// [$226001213]
//
// Revision 1.19  2010/07/12 07:56:01  dinishev
// [$223608887]
//
// Revision 1.18  2010/07/12 07:48:29  dinishev
// Cleanup
//
// Revision 1.17  2010/07/12 07:44:25  dinishev
// Cleanup
//
// Revision 1.16  2010/03/24 18:25:44  lulin
// {RequestLink:198672902}.
//
// Revision 1.15  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.14  2009/04/14 18:11:55  lulin
// [$143396720]. Подготовительная работа.
//
// Revision 1.13  2009/04/06 09:45:27  lulin
// [$140837386]. Убираем старорежимную примесь для списков параграфов.
//
// Revision 1.12  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.11  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.8.8.11  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.8.8.10.2.1  2007/09/12 15:23:02  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.8.8.10  2007/07/18 15:07:19  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.8.8.9  2007/06/22 20:18:32  lulin
// - cleanup.
//
// Revision 1.8.8.8  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.8.8.7  2005/11/07 14:08:32  lulin
// - от безликих тегов переходим к параграфам.
//
// Revision 1.8.8.6  2005/07/19 12:03:20  lulin
// - cleanup: удалены ненужные модули и методы.
//
// Revision 1.8.8.5  2005/07/11 06:07:07  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.8.8.4  2005/06/16 14:11:30  lulin
// - cleanup: отдельно стоящие процедуры перенесены на интерфейсы.
//
// Revision 1.8.8.3  2005/06/03 12:08:19  lulin
// - cleanup: убраны ненужные зависимости.
//
// Revision 1.8.8.2  2005/06/02 12:33:08  lulin
// - вчерне заменил прямое создание блока выделения на его получение от фабрики.
//
// Revision 1.8.8.1  2005/05/20 11:27:36  lulin
// - класс TevBlock вынесен в отдельный модуль.
//
// Revision 1.8  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.7  2005/03/15 10:30:18  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.6  2004/12/21 15:38:05  lulin
// - используем интерфейсы вместо объектов.
//
// Revision 1.5  2003/02/14 13:02:59  law
// - cleanup: rename class TevListCursorPair -> _TevParaListCursorPair.
//
// Revision 1.4  2003/01/23 16:18:09  law
// - new behavior: используем TevBlock.Delete вместо WM_Clear.
//
// Revision 1.3  2002/12/26 16:03:15  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.2  2002/12/17 09:49:43  law
// - new unit: evParaListCursorPair.
//
// Revision 1.1  2002/12/17 08:31:19  law
// - new unit: evTableRowCursorPair.
//

{$Include evDefine.inc }

interface

uses
  Messages,

  l3Types,
  l3Interfaces,
  l3Base,

  k2Interfaces,

  evInternalInterfaces,
  evParaListCursorPair,

  nevTools
  ;

type
  TevTableRowCursorPair = class(TevParaListCursorPair)
   {* Выделение для строки таблицы. }
    protected
    // internal methods
      function  DoGetChildSel(const aView : InevView;
                            ChildIndex: Long;
                            aForDrawing: Boolean): InevRange;
        override;
        {-}              
    public
    // public methods
      {$IfDef evNeedEditableCursors}
      function DoDelete(const aView : InevView;
                       const anOpPack : InevOp = nil;
                       aMode          : TevClearMode = ev_cmAll;
                       const aPara    : InevPara = nil): Bool;
        override;
        {-}
      {$EndIf evNeedEditableCursors}
  end;{TevTableRowCursorPair}

implementation

uses
  evdTypes,

  k2Base,
  k2Tags,

  nevFacade
  ;

// start class TevTableRowCursorPair 

{$IfDef evNeedEditableCursors}
function TevTableRowCursorPair.DoDelete(const aView : InevView;
                                      const anOpPack : InevOp = nil;
                                      aMode          : TevClearMode = ev_cmAll;
                                      const aPara    : InevPara = nil): Bool;
  //override;
  {-}

 function _Delete(const aBlock: InevRange; anIndex: Long): Bool;
 begin//_Delete
  Result := true;
  aBlock.Modify.Delete(aView, anOpPack, aMode);
 end;//_Delete

begin
 if not (aMode in [ev_cmKeepOne, ev_cmForceKeepOne]) then
  Result := inherited DoDelete(aView, anOpPack, aMode, aPara)
 else
  DoIterateF(evL2TSA(@_Delete));
 Result := true;
end;
{$EndIf evNeedEditableCursors}

function TevTableRowCursorPair.DoGetChildSel(const aView: InevView;
  ChildIndex: Long;
  aForDrawing: Boolean): InevRange;
var
 l_CellObj   : InevObject;
 l_TableCell : InevTableCell;
 l_Selection : InevRange;
begin
 Result := inherited DoGetChildSel(aView, ChildIndex, aForDrawing);
 if aForDrawing and (Result <> nil) then
 begin
  l_CellObj := Result.Obj^;
  if TevMergeStatus(l_CellObj.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue then
  begin
   l_CellObj.AsObject.QT(InevTableCell, l_TableCell);
   l_TableCell := l_TableCell.GetMergeHead;
   if l_TableCell = nil then Exit;
   l_Selection := ParentRange;
   l_Selection := l_Selection.GetChildSel(aView, l_TableCell.OwnerPara.PID, aForDrawing);
   if l_Selection <> nil then
   begin
    l_Selection := l_Selection.GetChildSel(aView, l_TableCell.PID, aForDrawing);
    if l_Selection = nil then
     Result := nil;
   end // if l_Selection <> nil then
   else
    Result := nil;
  end; // if TevMergeStatus(ChildPara.IntA[k2_itMergeStatus]) = ev_msContinue then
 end; // if aForDrawing and (Result <> nil) then
end;

end.

