unit evDrawLineTool;
{* Реализация интерфейса IevDrawLineTool для текстового параграфа. }

{ Библиотека "Эверест"     }
{ Автор: Люлин А.В. ©      }
{ Модуль: evDrawLineTool - }
{ Начат: 22.11.2000 11:45  }
{ $Id: evDrawLineTool.pas,v 1.69 2015/04/03 09:07:00 dinishev Exp $ }

// $Log: evDrawLineTool.pas,v $
// Revision 1.69  2015/04/03 09:07:00  dinishev
// {Requestlink:585429117}. Более правильные правки.
//
// Revision 1.68  2015/04/03 07:57:18  dinishev
// {Requestlink:585429117}
//
// Revision 1.67  2014/10/31 11:26:38  dinishev
// {Requestlink:570532931}
//
// Revision 1.66  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.65  2014/04/22 17:32:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.64  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.63  2014/03/18 17:40:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.62  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.61  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.60  2013/04/04 11:18:51  lulin
// - портируем.
//
// Revision 1.59  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.58  2012/03/22 13:18:22  dinishev
// {Requestlink:349116289}
//
// Revision 1.57  2009/07/23 13:42:10  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.56  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. №25.
//
// Revision 1.55  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.54  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.53  2009/07/11 09:24:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.52  2009/07/10 16:15:41  lulin
// - избавляемся от лишнего дёрганья счётчиков ссылок.
//
// Revision 1.51  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.50  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.49  2009/06/02 16:12:53  lulin
// - выделяем внутренние интерфейсы в отдельные модули.
//
// Revision 1.48  2009/04/15 18:49:30  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.47  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.46  2009/03/04 13:32:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.45  2008/12/18 12:39:01  lulin
// - <K>: 132222370. Поддерживаем работу с кодировкой TatarOEM.
//
// Revision 1.44  2008/06/20 14:48:50  lulin
// - используем префиксы элементов.
//
// Revision 1.43  2008/04/15 08:23:45  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.42  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.41  2008/03/11 11:29:11  lulin
// - <K>: 85721297.
//
// Revision 1.40  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.39  2007/12/04 12:47:01  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.36.6.15  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.36.6.14.2.1  2007/09/12 15:23:00  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.36.6.14  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.36.6.13  2007/06/22 19:18:57  lulin
// - cleanup.
//
// Revision 1.36.6.12  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.36.6.11  2006/11/21 09:55:23  lulin
// - cleanup.
//
// Revision 1.36.6.10  2006/11/03 11:00:04  lulin
// - объединил с веткой 6.4.
//
// Revision 1.36.6.9.2.1  2006/11/02 13:10:33  lulin
// - cleanup.
//
// Revision 1.36.6.9  2006/10/10 12:06:13  lulin
// - cleanup.
//
// Revision 1.36.6.8  2006/01/16 14:28:17  lulin
// - cleanup.
//
// Revision 1.36.6.7  2005/11/09 15:28:23  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.36.6.6  2005/11/07 06:25:22  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.36.6.5  2005/07/18 15:10:26  lulin
// - избавляемся от косвенного приведения одного интерфейса к другому.
//
// Revision 1.36.6.4  2005/06/15 17:23:51  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.36.6.3  2005/06/09 08:09:42  lulin
// - избавляемся от ссылки на нетипизированного Owner'а.
//
// Revision 1.36.6.2  2005/05/31 14:48:01  lulin
// - cleanup: при работе с курсорами используем интерфейсы, а не объекты.
//
// Revision 1.36.6.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.35.2.3  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.35.2.2  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.35.2.1  2005/04/18 16:43:24  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.36  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.36  2005/04/18 17:18:22  lulin
// - используем _Box, а не _Ik2Tag (пока выигрыша в производительности не дало).
//
// Revision 1.35  2005/04/06 12:25:35  lulin
// - bug fix: стрелочки не учитывались как псевдографика.
//
// Revision 1.34  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.33  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.32  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.31  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.30  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.29  2005/03/04 15:49:02  lulin
// - спрятана процедура Tk2Type.New.
//
// Revision 1.28  2003/10/02 16:33:23  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.27  2003/03/14 13:44:32  law
// - bug fix: при рисовании линий не учитывалась кодировка (см. _TestSet\PseudoTable\2.evd ).
//
// Revision 1.26  2002/12/26 16:31:28  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.25  2002/07/23 11:04:40  law
// - rename proc: ev_lpCharSetPresentEx -> l3CharSetPresentEx.
//
// Revision 1.24  2002/07/09 13:57:38  law
// - new unit: evMsgCode.
//
// Revision 1.23  2002/06/24 12:12:40  law
// - new behavior: вставка "стрелок" в "резиновые" таблицы.
//
// Revision 1.22  2002/06/06 13:12:02  law
// - new behavior: в режиме рисования линий операция удаления символов теперь сохраняет ширину ячейки.
//
// Revision 1.21  2002/06/03 16:31:54  law
// - bug fix.
//
// Revision 1.20  2002/06/03 16:20:53  law
// - new behavior: отрабатываем Home и End в "резиновых" таблицах в режиме рисования линий.
//
// Revision 1.19  2002/05/30 15:21:54  law
// - cleanup: удален стиль ev_saWideTable.
//
// Revision 1.18  2002/05/29 12:00:00  law
// - new behavior: утилита рисования линий теперь ориентируется на стиль ev_saWideTable.
//
// Revision 1.17  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.16  2001/12/27 15:03:29  law
// - new constructors: добавлены два конструктора Tl3String._Make.
//
// Revision 1.15  2001/10/24 12:58:21  law
// - new behavior: сделана возможность вставлять символы-"стрелки".
//
// Revision 1.14  2001/04/23 13:43:21  law
// - new behavior: немного изменен алгоритм рисования линий псевдографикой.
//
// Revision 1.13  2001/04/02 12:48:22  law
// - потихонечку переходим от внутренних сообщений к интерфейсам.
//
// Revision 1.12  2001/03/30 11:54:34  law
// - курсор для текстовых параграфов вынесен в модуль evTextParaCursor.
//
// Revision 1.11  2001/03/26 16:01:05  law
// - добавлена еще одна версия процедуры _evInsertPara,
//
// Revision 1.10  2001/03/23 17:50:47  law
// - сделана реализация IevOpInsertString и убрано использование ev_msgInsertString.
//
// Revision 1.9  2001/03/21 17:35:55  law
// - добавлена еще одна процедура _evMoveCursor.
//
// Revision 1.8  2001/01/23 15:12:23  law
// - поправлен предыдущий комментарий.
//
// Revision 1.7  2001/01/23 15:11:05  law
// - bug fix: при рисовании линий, когда упирались в разрыв страницы - был AV.
//
// Revision 1.6  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3CacheableBase,
  l3Interfaces,

  k2Interfaces,

  evInternalInterfaces,

  nevTools
  ;

type
  TevDrawLineTool = class(Tl3CacheableBase, IevDrawLineTool)
   {* - реализует интерфейс IevDrawLineTool для текстового параграфа. }
    private
    // internal fields
      f_Cursor : InevPoint;
    protected
    //internal methods
      procedure OverwriteChar(const aView : InevView;
                              aChar          : AnsiChar;
                              const aCursor  : InevBasePoint;
                              const anOpPack : InevOp);
        {* - вставляет символ поверх существующего. }
      procedure InsertChar(const aView : InevView;
                           aChar          : AnsiChar;
                           const aCursor  : InevBasePoint;
                           const anOpPack : InevOp);
        {* - вставляет символ. }
      procedure InsertLine(const aView : InevView;
                           aDirection     : TevLineDirection;
                           const aCursor  : InevBasePoint;
                           IsEmpty        : Bool;
                           const anOpPack : InevOp);
        {* - вставляет линию. }
      procedure CheckPos(const aView : InevView;
                         aPos           : Long;
                         const aCursor  : InevBasePoint;
                         const anOpPack : InevOp);
        {* - проверяет позицию курсора. }
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      constructor Create(const aCursor    : InevPoint);
        reintroduce;
        {-}
      class function Make(const aCursor    : InevPoint): IevDrawLineTool;
        reintroduce;
        {-}
      function DrawLine(const aView : InevView;
                        aDirection : TevLineDirection;
                        aStyle     : TevLineStyle;
                        const anOp : InevOp): Bool;
        {* - нарисовать линию в направлении aDirection. }
  end;//TevDrawLineTool

implementation

uses
  SysUtils,

  l3Chars,
  l3CharsEx,
  l3MinMax,
  l3InternalInterfaces,
  l3String,
  l3InterfacedString,

  evConst,

  k2Base,
  k2Tags,

  evOp,
  evMsgCode,
  evdStyles,
  evCursorTools,

  TextPara_Const
  ;

// start class TevDrawLineTool

constructor TevDrawLineTool.Create(const aCursor    : InevPoint);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Cursor := aCursor;
end;

class function TevDrawLineTool.Make(const aCursor    : InevPoint): IevDrawLineTool;
  //reintroduce;
  {-}
var
 l_Tool : TevDrawLineTool;
begin
 l_Tool := Create(aCursor);
 try
  Result := l_Tool;
 finally
  l3Free(l_Tool);
 end;//try..finally
end;

procedure TevDrawLineTool.Cleanup;
  //override;
  {-}
begin
 f_Cursor := nil;
 inherited;
end;

procedure TevDrawLineTool.OverwriteChar(const aView : InevView;
                                        aChar          : AnsiChar;
                                        const aCursor  : InevBasePoint;
                                        const anOpPack : InevOp);
  {* - вставляет символ поверх существующего. }
var
 l_Pos : Long;
begin
 with aCursor do
 begin
  l_Pos := Position;
  if Obj.Attr[k2_tiText].IsValid then
   with (Obj.AsObject.cAtom(k2_tiText, anOpPack) As Tl3String) do
   begin
    if (CodePage <> CP_TatarOEM) AND (CodePage <> CP_Unicode) AND (CodePage <> CP_RussianDOS) then
     CodePage := CP_OEM;
    if (Ch[l_Pos] = aChar) then
     Exit;
   end;//with ..(AsObject As Tl3String)
  Text.Modify.InsertString(aView, l3CStr(l3PCharLen(@aChar, 1, CP_OEM)), anOpPack, false, [misfDirect]);
  SetEntryPoint(l_Pos);
 end;//with aCursor
end;

procedure TevDrawLineTool.InsertChar(const aView : InevView;
                                     aChar          : AnsiChar;
                                     const aCursor  : InevBasePoint;
                                     const anOpPack : InevOp);
  {* - вставляет символ. }
begin
 with aCursor do
 begin
  if Obj.Attr[k2_tiText].IsValid then
   with (Obj.AsObject.cAtom(k2_tiText, anOpPack) As Tl3String) do
   begin
    if (CodePage <> CP_TatarOEM) AND (CodePage <> CP_Unicode) AND (CodePage <> CP_RussianDOS) then
     CodePage := CP_OEM;
   end;//with ..(AsObject As Tl3String)
 end;//aCursor
 aCursor.Text.Modify.InsertString(aView, l3CStr(l3PCharLen(@aChar, 1, CP_OEM)), anOpPack, true, [misfDraw]);
end;

procedure TevDrawLineTool.CheckPos(const aView : InevView;
                                   aPos           : Long;
                                   const aCursor  : InevBasePoint;
                                   const anOpPack : InevOp);
  {* - проверяет позицию курсора. }
var
 l_Delta  : Long;
 l_String : Tl3InterfacedString;
begin
 if (aPos > 0) then
 begin
  with aCursor do
  begin
   if not aCursor.Obj.IsKindOf(k2_typTextPara) then Exit;
   with (Obj.AsObject.cAtom(k2_tiText, anOpPack) As Tl3String) do
   begin
    l_Delta := aPos - Len;
    if (l_Delta > 0) then
     SetEntryPoint(Len, anOpPack As IevCursorContext);
   end;//with .. k2_tiText ..
   if (l_Delta > 0) then begin
    l_String := Tl3InterfacedString.Create;
    try
     l_String.Append(cc_HardSpace, l_Delta);
     aCursor.Text.Modify.InsertString(aView, l_String, anOpPack, true, [misfDirect]);
    finally
     l3Free(l_String);
    end;//try..finally
   end;//l_Delta > 0
   SetEntryPoint(aPos, anOpPack As IevCursorContext);
  end;//aCursor
 end;//aPos
end;

procedure TevDrawLineTool.InsertLine(const aView : InevView;
                                     aDirection     : TevLineDirection;
                                     const aCursor  : InevBasePoint;
                                     IsEmpty        : Bool;
                                     const anOpPack : InevOp);
  {* - вставляет линию. }
const
  evInvertLineDirection : array [TevLineDirection] of TevLineDirection =
                          (ev_ldDown, ev_ldUp, ev_ldRight, ev_ldLeft,
                           ev_ldEnd, ev_ldHome);
   {* - Константа для инверсии направления рисования линии. }

var
 l_N   : array [ev_ldUp .. ev_ldRight] of AnsiChar;
 l_Pos : Long;
 l_PID : Long;
begin
 with aCursor do
 begin
  with Inner do
  begin
   l_Pos := Position;
   if Obj.Attr[k2_tiText].IsValid then
    with (Obj.AsObject.cAtom(k2_tiText, anOpPack) As Tl3String) do
    begin
     l_N[ev_ldLeft] := Ch[Pred(l_Pos)];
     l_N[ev_ldRight] := Ch[Succ(l_Pos)];
    end;//with .. k2_tiText
  end;//with Inner
  l_PID := Pred(Position);
  l_N[ev_ldUp] := cc_Null;
  l_N[ev_ldDown] := cc_Null;
  with Obj^ do
  begin
   if (l_PID > 0) then
    with AsObject.Child[Pred(l_PID)].Attr[k2_tiText] do
     if IsValid then
      with (AsObject As Tl3String) do
       if IsOEM then
        l_N[ev_ldUp] := Ch[l_Pos];
   if (l_PID < Pred(AsObject.ChildrenCount)) then
    with AsObject.Child[Succ(l_PID)].Attr[k2_tiText] do
     if IsValid then
      with (AsObject As Tl3String) do
       if IsOEM then
        l_N[ev_ldDown] := Ch[l_Pos];
  end;//with Obj^
  if IsEmpty then begin
   l_N[aDirection] := cc_HardSpace;
   l_N[evInvertLineDirection[aDirection]] := cc_HardSpace;
  end else
   l_N[aDirection] := cc_Cross;
  OverwriteChar(aView,
                cc_FrameParts[l_N[ev_ldUp] in cc_UpFrames,
                              l_N[ev_ldDown] in cc_DownFrames,
                              l_N[ev_ldLeft] in cc_LeftFrames,
                              l_N[ev_ldRight] in cc_RightFrames][true].S^,
                Inner, anOpPack);
 end;//with aCursor
end;

function TevDrawLineTool.DrawLine(const aView : InevView;
                                  aDirection : TevLineDirection;
                                  aStyle     : TevLineStyle;
                                  const anOp : InevOp): Bool;
  {* - нарисовать линию в направлении aDirection. }

var
 l_Cursor       : InevBasePoint;
 l_CursorParent : InevBasePoint;
 l_Pos          : Long;

 function InsertNewPara(aAtEnd: Bool): Bool;
 var
  l_NewPara : Tl3Variant;
 begin
  l_NewPara := l_Cursor.Obj.AsObject.TagType.MakeTag.AsObject;
  try
   with l_NewPara do begin
    IntA[k2_tiStyle] := ev_saTxtNormalOEM;
    with (cAtom(k2_tiText).AsObject As Tl3String) do
    begin
     if (CodePage <> CP_TatarOEM) AND (CodePage <> CP_Unicode) AND (CodePage <> CP_RussianDOS) then
      CodePage := CP_OEM;
     Append(cc_HardSpace, l_Pos);
    end;//with (cAtom(k2_tiText)
   end;//with l_NewPara
   Result := evInsertPara(anOp, l_CursorParent, l_NewPara, [ev_ipfAtEnd]);
  finally
   l_NewPara := nil;
  end;//try..finally
 end;

var
 l_Style     : Long;
 l_MoveTo    : Long;
 l_SpacesEnd : Long;
begin
 Result := false;
 l_Cursor := f_Cursor;
 l_CursorParent := l_Cursor.ParentPoint;
 if (l_CursorParent <> nil) then begin
  Result := true;
   l_Pos := l_Cursor.Position;
   with l_Cursor.Obj^ do
   begin
    l_Style := AsObject.IntA[k2_tiStyle];
    if (l_Style <> ev_saTxtNormalOEM) then
    begin
     if AsObject.Attr[k2_tiText].IsValid then
     begin
      if (aStyle = ev_lsClear) then Exit;
      if (aStyle = ev_lsMove) then begin
       Result := false;
       Exit;
      end;//aStyle = ev_lsMove
      if InsertNewPara(false) AND
         l_CursorParent.Move(aView, ev_ocParaUp, anOp) AND
         (aDirection in [ev_ldDown, ev_ldRight]) then
       l_Cursor := l_CursorParent.Inner
      else
       Exit;
     end//Attr[k2_tiText].IsValid
     else
      AsObject.IntW[k2_tiStyle, anOp] := ev_saTxtNormalOEM;
    end;//l_Style <> ev_saTxtNormalOEM..
   end;//with l_Cursor.Obj
   if (aStyle = ev_lsMove) then begin
    Case aDirection of
     ev_ldHome  : begin
      with l_Cursor.Obj^ do
       with AsObject.Attr[k2_tiText] do
        if IsValid then
         with (AsObject As Tl3CustomString) do begin
          l_MoveTo := l3CharSetPresentExR(St, Min(Len, Max(0, Pred(l_Pos))), cc_Graph_Criteria);
          if (l_MoveTo = -1) then
           Result := false
          else begin
           while (Pred(l_Pos) > l_MoveTo) do
            if l_Cursor.Move(aView, ev_ocCharLeft, anOp) then
             Dec(l_Pos)
            else
             break; 
          end;//l_MoveTo
         end
        else
         Result := false; 
     end;//ev_ldHome
     ev_ldEnd   : begin
      with l_Cursor.Obj^ do
       with AsObject.Attr[k2_tiText] do
        if IsValid then
         with (AsObject As Tl3CustomString) do begin
          l_MoveTo := l3CharSetPresentEx(St + l_Pos, Len - l_Pos, cc_Graph_Criteria);
          if (l_MoveTo = -1) then
           Result := false
          else begin
           l_SpacesEnd := l3CharSetPresentExR(St, Pred(l_Pos + l_MoveTo), cc_AllChars - [cc_HardSpace]);
           if (l_SpacesEnd <> -1) then
            l_MoveTo := l_SpacesEnd - Pred(l_Pos);
           if (l_MoveTo < 0) then begin
            while (l_MoveTo < 0) do
             if l_Cursor.Move(aView, ev_ocCharLeft, anOp) then
              Inc(l_MoveTo)
             else
              break;
           end else begin
            while (l_MoveTo > 0) do
             if l_Cursor.Move(aView, ev_ocCharRight, anOp) then
              Dec(l_MoveTo)
             else
              break;
           end;//l_MoveTo < 0
          end;//l_MoveTo
         end
        else
         Result := false; 
     end;//ev_ldEnd
    end;//Case aDirection
    Exit;
   end else if (aStyle = ev_lsSymbol) then begin
    Case aDirection of
     ev_ldUp    : InsertChar(aView, cc_TriUp, l_Cursor, anOp);
     ev_ldDown  : InsertChar(aView, cc_TriDown, l_Cursor, anOp);
     ev_ldLeft  : InsertChar(aView, cc_TriLeft, l_Cursor, anOp);
     ev_ldRight : InsertChar(aView, cc_TriRight, l_Cursor, anOp);
    end;//Case aDirection
//     evMoveCursor(anOp, l_Cursor, ev_ocCharRight);
    Exit;
   end;//aStyle = ev_lsSymbol
   Case aDirection of
    ev_ldUp :
     with l_CursorParent do
      if (Position <= 1) OR
         not Obj.AsObject.Child[Position - 2].IsKindOf(k2_typTextPara) then begin
       if (aStyle = ev_lsClear) then Exit;
       InsertNewPara(false);
      end;//Position <= 1
    ev_ldDown :
     with l_CursorParent, Obj^ do
      if (Position >= AsObject.ChildrenCount) OR
         not AsObject.Child[Position].IsKindOf(k2_typTextPara) then
      begin
       if (aStyle = ev_lsClear) then Exit;
       InsertNewPara(true);
      end;//Position >= ChildrenCount
   end;//Case aDirection
   // - здесь помещаем вставку символа
   if (aDirection = ev_ldLeft) AND (l_Pos <= 0) then Exit;
   InsertLine(aView, aDirection, l_CursorParent, (aStyle = ev_lsClear), anOp);
   Case aDirection of
    ev_ldLeft : l_Cursor.Move(aView, ev_ocCharLeft, anOp);
    ev_ldRight : l_Cursor.Move(aView, ev_ocCharRight, anOp);
    ev_ldUp :
    begin
     l_CursorParent.Move(aView, ev_ocParaUp, anOp);
     CheckPos(aView, l_Pos, l_CursorParent.Inner, anOp);
    end;//ev_ldUp
    ev_ldDown :
    begin
     l_CursorParent.Move(aView, ev_ocParaDown, anOp);
     CheckPos(aView, l_Pos, l_CursorParent.Inner, anOp);
    end;//ev_ldDown
   end;//Case aDirection
   l_CursorParent.Refresh;
 end;//l_CursorParent
end;

end.

