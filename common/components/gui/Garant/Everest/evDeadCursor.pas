unit evDeadCursor;

{ Библиотека "Эверест"  }
{ Автор: Люлин А.В. ©   }
{ Модуль: evDeadCursor - }
{ Начат: 08.09.1999 14:54 }
{ $Id: evDeadCursor.pas,v 1.33 2014/07/29 12:54:56 lulin Exp $ }

// $Log: evDeadCursor.pas,v $
// Revision 1.33  2014/07/29 12:54:56  lulin
// - рисуем фабрики интерфейсов.
//
// Revision 1.32  2014/04/30 11:23:52  lulin
// - выпрямляем зависимости.
//
// Revision 1.31  2014/04/08 12:35:09  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.30  2014/02/17 16:25:54  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.29  2013/12/25 15:35:18  lulin
// {RequestLink:509706011}
// - перетрясаем модель.
//
// Revision 1.28  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. №23ac.
//
// Revision 1.27  2009/07/11 17:11:05  lulin
// {RequestLink:141264340}. №19.
//
// Revision 1.26  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. №22.
//
// Revision 1.25  2009/07/11 12:46:22  lulin
// {RequestLink:141264340}. №14.
//
// Revision 1.24  2009/04/09 14:12:36  lulin
// [$140837386]. №15.
//
// Revision 1.23  2008/04/15 08:23:45  lulin
// - передаём вью в качестве параметра.
//
// Revision 1.22  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.21  2008/04/14 07:48:09  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.20  2008/04/11 11:29:58  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.19  2007/12/04 12:47:00  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.14.2.10  2007/06/22 19:18:56  lulin
// - cleanup.
//
// Revision 1.14.2.9  2005/12/13 14:06:15  lulin
// - bug fix: была ошибка при Undo.
//
// Revision 1.14.2.8  2005/12/02 18:23:27  lulin
// - обрабока нотфификации об удалении/добавлении параграфа практически полностью перенесена на процессор.
//
// Revision 1.14.2.7  2005/11/07 06:25:22  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.14.2.6  2005/11/04 15:41:36  lulin
// - выделяем у якоря и у курсора общую функциональность.
//
// Revision 1.14.2.5  2005/07/21 06:46:11  lulin
// - модификация состояния курсора и его связей с другими курсорами разнесены на два разных интерфейса.
//
// Revision 1.14.2.4  2005/07/21 06:05:47  lulin
// - в процедуре поиска модифицируемый курсор заменен на немодифицируемый.
//
// Revision 1.14.2.3  2005/07/20 18:21:13  lulin
// - убран переходный интерфейс.
//
// Revision 1.14.2.2  2005/06/01 14:02:17  lulin
// - new unit: evCursor.
//
// Revision 1.14.2.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.12.2.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.12.2.1  2005/04/28 09:18:28  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.12.4.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.14  2005/05/16 15:31:11  lulin
// - cleanup: прямое использование объекта заменено на использование интерфейса.
//
// Revision 1.13  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.12.4.1  2005/04/21 14:46:54  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.12  2005/03/31 13:10:40  lulin
// - избавился от шаманства с присваиванием указателей вместо интерфейсов.
//
// Revision 1.11  2005/03/31 12:58:43  lulin
// - new method: _TevDeadCursor.Make.
//
// Revision 1.10  2005/03/16 09:50:10  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.9  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2003/10/02 16:33:23  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.7  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, для того чтобы не путать его с интерфейсом.
//
// Revision 1.6  2001/06/22 10:01:38  law
// - new property: ParaEnd.
//
// Revision 1.5  2001/03/30 11:54:34  law
// - курсор для текстовых параграфов вынесен в модуль evTextParaCursor.
//
// Revision 1.4  2000/12/15 15:10:34  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  Classes,
  
  l3Types,
  l3Base,
  l3ProtoPersistent,
  l3Variant,

  nevTools
  ;

type
  TevDeadCursor = class(Tl3ProtoPersistent, IevSavedCursor)
    private
    // property fields
      f_Position : Long;
    protected
    // internal methods
      procedure AssignPoint(const aPoint: InevBasePoint);
        virtual;
        {-}
      procedure AssignToPoint(const aPoint: InevBasePoint);
        virtual;
        {-}
    public
    // public methods
      class function Make(aTag: Tl3Tag): IevSavedCursor;
        reintroduce;
        {-}
      procedure Assign(P: TPersistent);
        override;
        {-}
      procedure AssignTo(P: TPersistent);
        override;
        {-}
      procedure Store(const Cursor: InevBasePoint);
        {-}
      procedure Load(const Cursor: InevBasePoint);
        {-}
      function  IevSavedCursor_Clone: IevSavedCursor;
      function  IevSavedCursor.Clone = IevSavedCursor_Clone;
        {-}
    public
    // public properties
      property Position: Long
        read f_Position
        write f_Position;
        {-}
  end;//TevDeadCursor

  TevTextParaDeadCursor = class(TevDeadCursor)
    private
    // property fields
      f_LineEnd : Bool;
      f_ParaEnd : Bool;
    protected
    // internal methods
      procedure AssignPoint(const aPoint: InevBasePoint);
        override;
        {-}
      procedure AssignToPoint(const aPoint: InevBasePoint);
        override;
        {-}
    public
    // public methods
      procedure Assign(P: TPersistent);
        override;
        {-}
    public
    // public properties
      property LineEnd: Bool
        read f_LineEnd
        write f_LineEnd;
        {-}
      property ParaEnd: Bool
        read f_ParaEnd
        write f_ParaEnd;
        {-}
  end;{TevTextParaDeadCursor}

  TevDeadCursorParent = class(TevDeadCursor)
    private
    // property fields
      f_Child : IevSavedCursor;
    protected
    // internal methods
      procedure AssignPoint(const aPoint: InevBasePoint);
        override;
        {-}
      procedure AssignToPoint(const aPoint: InevBasePoint);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure Assign(P: TPersistent);
        override;
        {-}
    public
    // public properties
      property Child: IevSavedCursor
        read f_Child
        write f_Child;
        {-}
  end;//TevDeadCursorParent

implementation

uses
  SysUtils,

  evInternalInterfaces
  ;

// start class TevDeadCursor 

class function TevDeadCursor.Make(aTag: Tl3Tag): IevSavedCursor;
  //reintroduce;
  {-}
var
 l_Cursor : TevDeadCursor;
begin
 l_Cursor := Create;
 try
  Result := l_Cursor;
 finally
  l3Free(l_Cursor);
 end;//try..finally
end;

procedure TevDeadCursor.Assign(P: TPersistent);
  {override;}
  {-}
var
 l_Point : InevPoint;
begin
 if (P Is TevDeadCursor) then
  Position := TevDeadCursor(P).Position
 else
 if Supports(P, InevPoint, l_Point) then
  AssignPoint(l_Point)
 else
  inherited;
end;

procedure TevDeadCursor.AssignTo(P: TPersistent);
  {override;}
  {-}
var
 l_Point : InevPoint;
begin
 if Supports(P, InevPoint, l_Point) then
  AssignToPoint(l_Point)
 else
  inherited;
end;

procedure TevDeadCursor.AssignPoint(const aPoint: InevBasePoint);
  //virtual;
  {-}
begin
 Position := aPoint.Position
end;

procedure TevDeadCursor.AssignToPoint(const aPoint: InevBasePoint);
  //virtual;
  {-}
begin
 aPoint.PositionW := Position;
end;

procedure TevDeadCursor.Store(const Cursor: InevBasePoint);
  {-}
begin
 if (Cursor <> nil) then
  AssignPoint(Cursor);
end;

procedure TevDeadCursor.Load(const Cursor: InevBasePoint);
  {-}
begin
 if (Cursor <> nil) then
  AssignToPoint(Cursor);
end;

function TevDeadCursor.IevSavedCursor_Clone: IevSavedCursor;
type
 RevDeadCursor = class of TevDeadCursor;
var
 l_Cursor : TevDeadCursor;
begin
 l_Cursor := RevDeadCursor(ClassType).Create;
 try
  l_Cursor.Assign(Self);
  Result := l_Cursor;
 finally
  l3Free(l_Cursor);
 end;//try..finally
end;

// start class TevDeadCursorParent 

procedure TevDeadCursorParent.Cleanup;
  {override;}
  {-}
begin
 Child := nil;
 inherited;
end;

procedure TevDeadCursorParent.Assign(P: TPersistent);
  {override;}
  {-}
var
 C : IevSavedCursor;
begin
 inherited;
 Child := nil;
 if (P Is TevDeadCursorParent) then
 begin
  if (TevDeadCursorParent(P).Child <> nil) then
  begin
   C := TevDeadCursorParent(P).Child.Clone;
   try
    Child := C;
   finally
    C := nil;
   end;//try..finally
  end;//TevDeadCursorParent(P).Child <> nil
 end;//P Is TevDeadCursorParent
end;

procedure TevDeadCursorParent.AssignPoint(const aPoint: InevBasePoint);
  //override;
  {-}
var
 C : IevSavedCursor;
begin
 inherited;
 if aPoint.HasInner then
 begin
  if aPoint.Inner.Obj.AsObject.QT(IevSavedCursor, C) then
   try
    C.Store(aPoint.Inner);
    Child := C;
   finally
    C := nil;
   end;//try..finally
 end;//aPoint.HasInner
end;

procedure TevDeadCursorParent.AssignToPoint(const aPoint: InevBasePoint);
  //override;
  {-}
var
 l_Pt : InevBasePoint;
begin
 inherited;
 if (Child = nil) then
  aPoint.Inner := nil
 else
 begin
  l_Pt := aPoint.Inner;
  if (l_Pt <> nil) then
   Child.Load(l_Pt);
 end;//Child = nil
end;

// start class TevTextParaDeadCursor 

procedure TevTextParaDeadCursor.Assign(P: TPersistent);
  {override;}
  {-}
begin
 inherited;
 if (P Is TevTextParaDeadCursor) then
 begin
  LineEnd := TevTextParaDeadCursor(P).LineEnd;
  ParaEnd := TevTextParaDeadCursor(P).ParaEnd;
 end;//P Is TevTextParaDeadCursor
end;

procedure TevTextParaDeadCursor.AssignPoint(const aPoint: InevBasePoint);
  //override;
  {-}
var
 l_Line : IevTagLine;
begin
 inherited;
 LineEnd := Supports(aPoint, IevTagLine, l_Line) AND l_Line.LineEnd;
 ParaEnd := aPoint.AtEnd(nil);
end;

procedure TevTextParaDeadCursor.AssignToPoint(const aPoint: InevBasePoint);
  //override;
  {-}
var
 l_Line : IevTagLine;
begin
 inherited;
 if Supports(aPoint, IevTagLine, l_Line) then
  l_Line.LineEnd := LineEnd;
 aPoint.SetAtEnd(nil, ParaEnd);
end;

end.

