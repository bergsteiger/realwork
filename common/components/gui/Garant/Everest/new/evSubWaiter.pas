unit evSubWaiter;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evSubWaiter -   }
{ Начат: 03.12.2005 19:09 }
{ $Id: evSubWaiter.pas,v 1.11 2016/04/18 13:52:53 dinishev Exp $ }

// $Log: evSubWaiter.pas,v $
// Revision 1.11  2016/04/18 13:52:53  dinishev
// {Requestlink:621277661}
//
// Revision 1.10  2014/04/08 12:35:11  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/03/04 13:16:53  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.8  2013/10/22 09:21:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2013/10/21 17:31:02  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2013/10/21 15:43:02  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:30:46  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2011/10/25 13:53:47  dinishev
// {Requestlink:294603661}
//
// Revision 1.3  2010/06/24 12:52:58  lulin
// {RequestLink:219125149}.
//
// Revision 1.2  2010/05/28 13:09:37  lulin
// {RequestLink:193823276}.
// - правильно переходим на первый изменённый фрагмент.
//
// Revision 1.1  2009/09/14 11:28:04  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.15  2009/07/14 14:56:28  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.14  2009/07/13 12:31:37  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.13  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.12  2009/04/16 10:47:47  lulin
// [$143396720]. №4. И перетряс взаимное расположение интерфесов.
//
// Revision 1.11  2009/04/09 14:12:37  lulin
// [$140837386]. №15.
//
// Revision 1.10  2009/04/09 11:59:05  lulin
// [$142613459].
//
// Revision 1.9  2009/03/04 13:32:47  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.8  2008/10/15 13:03:23  lulin
// - <K>: 121149970.
//
// Revision 1.7  2008/10/08 11:07:14  lulin
// - избавляемся от ненужных зависимостей между интерфейсами.
//
// Revision 1.6  2008/06/09 11:45:47  lulin
// - <K>: 93264011.
//
// Revision 1.5  2008/04/15 08:23:46  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.4  2008/04/09 17:57:08  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.3  2008/04/09 11:20:22  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.2  2007/12/28 10:03:46  dinishev
// Bug fix: неправильно переходили из списка "Корреспондентов"
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.9  2007/10/03 17:56:35  lulin
// - сделана вставка таблицы и вставка/удаление ее строк.
// - сделан переход на начало/конец документа.
//
// Revision 1.8  2006/07/10 10:39:20  lulin
// - метод, возвращающий родительское выделение получил параметр - уровень родителя для которого интересует выделение.
//
// Revision 1.7  2005/12/21 14:26:57  lulin
// - new behavior: сделана синхронизация редактирования комментариев в различных копиях текста.
//
// Revision 1.6  2005/12/08 17:40:27  lulin
// - bug fix: в 3-й раз починил циклические ссылки между объектами.
// - bug fix: висло при Back по истории - т.к. циклически создавался контейнер документа.
//
// Revision 1.5  2005/12/05 06:04:49  lulin
// - реализация инструментов перенесена в базовую библиотеку.
//
// Revision 1.4  2005/12/05 05:48:53  lulin
// - интерфейс инструментов перенесен в базовую библиотеку.
//
// Revision 1.3  2005/12/03 19:43:55  lulin
// - удален старый механизм перехода на метки. Теперь все делается через Waiter'ов.
//
// Revision 1.2  2005/12/03 18:08:41  lulin
// - выделен более общий интерфейс Waiter'а.
//
// Revision 1.1  2005/12/03 17:49:05  lulin
// - реализован новый механизм перехода на метки - теперь все делается не через событие на форме, а через третий отбъект - Waiter. В результате починилась ошибка с повторным непереходом на метку.
//

{$Include evDefine.inc }

interface

uses
  l3Base,
  l3Tool,

  evInternalInterfaces,

  nevBase,
  nevTools
  ;

type
  TevSubWaiter = class(Tl3Tool, InevWaiter)
    private
    // internal fields
      f_ID         : Integer;
      f_Type       : Integer;
      f_WasSub     : Boolean;
      f_ParaCount  : Integer;
      f_Point      : IevDocumentPoint;
      f_FoundBlock : InevDataObjectPrim2;
    protected
    // internal methods
      function TrySelect(const aContainer: InevDocumentContainer): Boolean;
        {-}
      function TrySelectPara(const aContainer : InevDocumentContainer;
                             const aSel       : InevSelection;
                             aParaID          : Integer): Boolean;
        virtual;
        {-}
      function TrySelectSub(const aContainer : InevDocumentContainer;
                            const aSel       : InevSelection;
                            aSubID           : Integer;
                            aType            : Integer): Boolean;
        virtual;
        {-}
      function TrySelectObj(const aContainer : InevDocumentContainer;
                            aParent    : Tl3Variant;
                            aChild     : Tl3Variant): Boolean;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aControl : InevControl;
                         aSubID         : Integer;
                         aSubType       : Integer);
        reintroduce;
        {-}
      class function Make(const aControl : InevControl;
                          aSubID         : Integer;
                          aSubType       : Integer): InevWaiter;
        reintroduce;
        {-}
  end;//TevSubWaiter

implementation

uses
  SysUtils,

  l3Interfaces,

  k2Tags,
  k2Interfaces,
  
  evdTypes,
  evdInterfaces,

  evOp,
  evParaTools,

  LeafPara_Const,
  Sub_Const,
  DocumentSub_Const,
  Block_Const
  ;

// start class TevSubWaiter

constructor TevSubWaiter.Create(const aControl : InevControl;
                                aSubID         : Integer;
                                aSubType       : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(aControl As Il3ToolOwner);
 f_ID := aSubID;
 f_Type := aSubType;
 f_WasSub := false;
 f_FoundBlock := nil;
end;

class function TevSubWaiter.Make(const aControl : InevControl;
                                 aSubID         : Integer;
                                 aSubType       : Integer): InevWaiter;
  //reintroduce;
  {-}
var
 l_Waiter : TevSubWaiter;
begin
 if (aControl = nil) OR (aSubType = Ord(ev_sbtNone)) then
  Result := nil
 else
 begin
  l_Waiter := Create(aControl, aSubID, aSubType);
  try
   Result := l_Waiter;
  finally
   l3Free(l_Waiter);
  end;//try..finally
 end;//aSubType = ev_sbtNone
end;

procedure TevSubWaiter.Cleanup;
  //override;
  {-}
begin
 f_Point := nil;
 f_FoundBlock := nil;
 inherited;
end;

function TevSubWaiter.TrySelectPara(const aContainer : InevDocumentContainer;
                                    const aSel       : InevSelection;
                                    aParaID          : Integer): Boolean;
  //virtual;
  {-}
var
 l_Para : InevObject;
begin
 Result := aContainer.FindObjByID(aParaID, l_Para);
 if Result then
  aSel.SelectPoint(l_Para.MakePoint, True);
end;

function TevSubWaiter.TrySelect(const aContainer: InevDocumentContainer): Boolean;
  {-}
var
 l_Sel     : InevSelection;
 l_Pt      : InevBasePoint;
 l_Control : InevControl;
 l_Para    : InevObject;
begin
 if (f_Owner = nil) then
 // - все уже нигде не надо позиционироваться
  Result := True
 else
 begin
  l_Control := (IUnknown(f_Owner) As InevControl);
  l_Sel := l_Control.Selection;
  if (l_Sel = nil) then
   Result := False
  else
  begin
   Assert(aContainer <> nil);
   case f_Type of
    Ord(ev_sbtSub) .. Ord(ev_sbtMark) :
     Result := TrySelectSub(aContainer, l_Sel, f_ID, f_Type);
    ev_sbtPara :
     Result := TrySelectPara(aContainer, l_Sel, f_ID);
    ev_sbtDocumentPlace:
    begin
     if (f_ID = Ord(ev_dpEnd)) then
     begin
      if aContainer.Document.Para.QT(InevObject, l_Para) then
      begin
       l_Pt := l_Para.MakePoint;
       Result := l_Pt.Move(l_Control.View, ev_ocBottomRight);
       if Result then
        l_Sel.SelectPoint(l_Pt, False);
      end//aContainer.Document.Para.QT(InevObject, l_Para)
      else
       Result := False;
     end//f_ID = Ord(ev_dpEnd)
     else
     begin
      Assert(False);
      Result := False;
     end;//f_ID = Ord(ev_dpEnd)
    end;//ev_sbtDocumentPlace
    else
    begin
     Assert(False);
     Result := False;
    end;//else
   end;//сase f_Type
  end;//l_Sel = nil
 end;//f_Owner = nil
end;

function TevSubWaiter.TrySelectObj(const aContainer : InevDocumentContainer;
                                   aParent    : Tl3Variant;
                                   aChild     : Tl3Variant): Boolean;
  {-}
var
 l_Sel     : InevSelection;
 l_Para    : InevObject;
 l_OutPara : InevObject;
begin
 if (f_Owner = nil) then
 // - все уже нигде не надо позиционироваться
  Result := True
 else
 begin
  Result := False;
  if f_WasSub then
  begin
   if aChild.IsKindOf(k2_typLeafPara) then
   begin
    Inc(f_ParaCount);
    if (f_ParaCount >= 50) then
    begin
     l_Sel := (IUnknown(f_Owner) As InevControl).Selection;
     if (l_Sel <> nil) then
     begin
      if (f_Point = nil) then
       Result := TrySelect(aContainer)
      else
       Result := f_Point.Select(l_Sel);
      f_WasSub := not Result;
     end;//l_Sel <> nil
    end;//f_ParaCount >= 50
   end;//aChild.IsKindOf(k2_typLeafPara)
  end//f_WasSub
  else
  begin
   case f_Type of
    Ord(ev_sbtSub) .. Ord(ev_sbtMark) :
    begin
     if aChild.IsKindOf(k2_typSub, [k2_typDocumentSub]) then
     begin
      if (aChild.IntA[k2_tiHandle] = f_ID) then
      begin
       if aChild.IsKindOf(k2_typBlock) then
        f_WasSub := (aChild.IntA[k2_tiLayerID] = f_Type)
       else
        f_WasSub := (aParent.IntA[k2_tiHandle] = f_Type);
       if f_WasSub then
        f_ParaCount := 0;
      end;//aChild.IntA[k2_tiHandle] = f_ID
     end;//aChild.IsKindOf(k2_typSub, [k2_typDocumentSub])
    end;//ev_sbtSub
    ev_sbtPara :
    begin
     if aChild.IsKindOf(k2_typLeafPara) AND (aChild.IntA[k2_tiHandle] = f_ID) then
     begin
      if aChild.QT(InevObject, l_Para) then
       try
        f_WasSub := True;
        f_ParaCount := 0;
        f_Point := l_Para.MakePoint As IevDocumentPoint;
       finally
        l_Para := nil;
       end//try..finally
      else
       Assert(false);
     end;//aChild.IsKindOf(k2_typLeafPara) AND ..
    end;//ev_sbtPara
    else
    begin
     Assert(false);
     Result := false;
    end;//else
   end;//case f_Type
  end;//f_WasSub
 end;//f_Owner = nil
end;

function TevSubWaiter.TrySelectSub(const aContainer: InevDocumentContainer;
  const aSel: InevSelection; aSubID, aType: Integer): Boolean;
var
 l_Sub: IevSub;
begin
 l_Sub := aContainer.SubList.SubEx[f_ID, f_Type];
 if (l_Sub = nil) OR not l_Sub.Exists then
  Result := False
 else
  Result := l_Sub.Select(aSel);
end;

end.

