unit evInterface;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evInterface -   }
{ Начат: 19.05.2005 16:36 }
{ $Id: evInterface.pas,v 1.24 2015/05/12 10:21:50 kostitsin Exp $ }

// $Log: evInterface.pas,v $
// Revision 1.24  2015/05/12 10:21:50  kostitsin
// {requestlink: 598140300 }
//
// Revision 1.23  2015/03/02 14:46:01  lulin
// - перетряхиваем слова.
//
// Revision 1.22  2014/04/21 17:21:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/04/08 17:13:19  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/03/27 14:19:58  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/03/21 17:15:14  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.17  2014/03/20 14:58:19  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.16  2014/03/18 17:40:22  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.15  2014/03/06 13:07:43  lulin
// - неправильно задавали собственное значение.
//
// Revision 1.14  2014/02/17 08:31:54  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.13  2013/10/23 12:25:49  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.12  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.11  2009/07/08 11:35:31  lulin
// - bug fix: падал тестовый Эверест.
//
// Revision 1.10  2009/07/06 13:32:06  lulin
// - возвращаемся от интерфейсов к объектам.
//
// Revision 1.9  2009/03/04 18:14:14  lulin
// - <K>: 137470629. Удалён ненужный интерфейс.
//
// Revision 1.8  2008/06/17 20:44:42  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.7  2008/02/14 17:08:54  lulin
// - _cleanup.
//
// Revision 1.6  2008/02/04 08:17:15  oman
// - new: Делаем кэшируемым (cq10552)
//
// Revision 1.5  2008/01/23 11:50:49  voba
// - У дефолтного стиля все параметры собственные (Own)
//
// Revision 1.4  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.2.8  2007/09/14 13:26:05  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.1.2.7.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.1.2.7  2007/09/11 18:49:58  lulin
// - удален ненужный параметр.
//
// Revision 1.1.2.6  2007/09/07 12:52:52  lulin
// - удален ненужный параметр.
//
// Revision 1.1.2.5  2007/09/06 15:21:25  lulin
// - переименовано свойство.
//
// Revision 1.1.2.4  2007/09/06 09:37:36  lulin
// - переименовано свойство.
//
// Revision 1.1.2.3  2005/11/18 13:26:24  lulin
// - в процедуру конца модификации теперь можно подавать пачку операций.
//
// Revision 1.1.2.2  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.1.2.1  2005/05/19 12:48:34  lulin
// - new unit: evInterface.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,
  l3CacheableBase,
  l3Variant,

  k2Interfaces,
  k2Base,

  nevBase,

  evTypes
  ;

type
  TevInheritance = (ev_iOwn, ev_iTransparent, ev_iParent);
   {* Тип принадлежности свойства. }

  TevInterface = class(Tl3CacheableBase{, Ik2TypeTableSource})
   {* Базовый клас для инструментов работающих с тегами. }
    protected
    // property fields
      f_Tag       : Tl3Variant;
    private
    // internal fields
      f_TagType   : Tk2Type;
      f_TypeTable : Tk2TypeTable;
      f_Context   : InevOp;
      f_Changes   : Long;
    protected
    // property methods
      function  pm_GetInheritance(Index: Long): TevInheritance;
        {-}
      function  pm_GetOwnParam(Index: Long): Tl3Variant;
        {-}
      function  pm_GetIsOwn(Index: Long): Bool;
        virtual;
        {-}
      procedure pm_SetIsOwn(Index: Long; Value: Bool);
        virtual;
        {-}
      function  pm_GetIsTransparent(Index: Long): Bool;
      procedure pm_SetIsTransparent(Index: Long; aValue: Bool);
        virtual;
        {-}
      function  pm_GetBoolParam(Index: Integer): Bool;
      procedure pm_SetBoolParam(Index: Integer; Value: Bool);
        {-}
      function  pm_GetLongParam(Index: Integer): Long;
      procedure pm_SetLongParam(Index: Integer; Value: Long);
        {-}
      function  pm_GetParam(Index: Long): Long;
        virtual;
      procedure pm_SetParam(anIndex: Long; aValue: Long);
        virtual;
        {-}
      function  pm_GetName: String;
        reintroduce;
        virtual;
      procedure pm_SetName(const Value: String);
        reintroduce;
        virtual;
        {-}
      procedure pm_SetContext(const Value: InevOp);
        virtual;
        {-}
(*      function  pm_GetTypeID: Long;
        {-}
      procedure pm_SetTypeID(Value: Long);
        {-}*)
      function  pm_GetTypeTable: Tk2TypeTable;
(*      procedure pm_SetTypeTable(const Value: Tk2TypeTable);*)
        {-}
      procedure pm_SetTagType(const Value: Tk2Type);
        {-}
      function  pm_GetTag: Tl3Variant;
        virtual;
      procedure pm_SetTag(aValue: Tl3Variant);
        virtual;
        {-}
    protected
    // internal methods
      procedure NotifyChange;
        {-}
      procedure DoNotifyChange;
        virtual;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      procedure  SetTransparent(const Path: array of Long);
        {-}
      procedure Changing;
        virtual;
        {-}
      procedure Changed;
        virtual;
        {-}
      procedure ChangedEx(aCancel: Boolean);
        virtual;
        {-}
      function IsDefault : Boolean;
        virtual;
        {-}
    public
    // public properties
      property IsOwn[Index: Long]: Bool
        read pm_GetIsOwn
        write pm_SetIsOwn;
        {* - собственное свойство? }
      property IsTransparent[Index: Long]: Bool
        read pm_GetIsTransparent
        write pm_SetIsTransparent;
        {* - прозрачное свойство? }
      property Inheritance[Index: Long]: TevInheritance
        read pm_GetInheritance;
        {* - принадлежность свойства. }
      property OwnParam[Index: Long]: Tl3Variant
        read pm_GetOwnParam;
        {* - собственный параметр тега. }
      property Param[Index: Long]: Long
        read pm_GetParam
        write pm_SetParam;
        {* - параметр тега. }
      property Name: String
        read pm_GetName
        write pm_SetName;
        {* - имя тега. }
      property Context: InevOp
        read f_Context
        write pm_SetContext;
        {* - контекст операций. }
      property TagType: Tk2Type
        read f_TagType
        write pm_SetTagType;
        {* - тип тега. }
(*      property TypeID: Long
        read pm_GetTypeID
        write pm_SetTypeID;
        {* - идентификатор типа тега. }*)
      property TypeTable: Tk2TypeTable
        read pm_GetTypeTable{
        write pm_SetTypeTable};
        {* - таблица типов тегов. }
      property Tag: Tl3Variant
        read pm_GetTag
        write pm_SetTag;
        {* - тег с которым работает инструмент. }
  end;//TevInterface

implementation

uses
  l3Const,

  k2Tags,
  k2Facade,
  k2NonOptimizeContext
  ;

// start class TevInterface 

procedure TevInterface.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Context);
 Tag := nil;
 inherited;
 f_TagType := nil;
 f_TypeTable := nil;
end;

procedure TevInterface.NotifyChange;
  {-}
begin
 if (Self <> nil) then begin
  if (f_Changes < 0) then
   f_Changes := 0;
  if (f_Changes = 0) then
   DoNotifyChange;
 end;//Self <> nil
end;

procedure TevInterface.DoNotifyChange;
  //virtual;
  {-}
begin
end;

procedure TevInterface.Changing;
  //override;
  {-}
begin
 Inc(f_Changes);
end;

procedure TevInterface.Changed;
  //override;
  {-}
begin
 ChangedEx(False);
end;

procedure TevInterface.ChangedEx(aCancel: Boolean);
begin
 Dec(f_Changes);
 if not(aCancel) then
  NotifyChange;
end;

function TevInterface.IsDefault : Boolean;
begin
 Result := True;
end;

procedure TevInterface.SetTransparent(const Path: array of Long);
  {-}
var
 i : Long;
begin
 for i := Low(Path) to High(Path) do IsTransparent[Path[i]] := true;
end;

function TevInterface.pm_GetInheritance(Index: Long): TevInheritance;
  {-}
begin
 if IsOwn[Index] then begin
  if IsTransparent[Index] then
   Result := ev_iTransparent
  else
   Result := ev_iOwn;
 end else Result := ev_iParent;
end;

function TevInterface.pm_GetOwnParam(Index: Long): Tl3Variant;
  {-}
begin
 Result := Tag.AsObject.rOwnAtom(Index);
end;

function TevInterface.pm_GetIsOwn(Index: Long): Bool;
  {override;}
  {-}
begin
 Result := not OwnParam[Index].IsNull;
end;

procedure TevInterface.pm_SetIsOwn(Index: Long; Value: Bool);
  {-}
begin
 if not Value then
  Tag.AttrW[Index, Context] := nil;
end;

function TevInterface.pm_GetIsTransparent(Index: Long): Bool;
  {override;}
  {-}
begin
 with OwnParam[Index] do
  Result := not IsNull AND IsTransparent;
end;

procedure TevInterface.pm_SetIsTransparent(Index: Long; aValue: Bool);
  {-}
var
 l_Prop : Tk2CustomPropertyPrim;
begin
 with Tag do
 begin
  l_Prop := Tk2Type(TagType).Prop[Index];
  if aValue then
   AttrW[l_Prop.TagIndex, Context] := Tk2Type(l_Prop.AtomType).TransparentTag
  else
   AttrW[l_Prop.TagIndex, Context] := nil;
 end;//with Tag
end;

function TevInterface.pm_GetBoolParam(Index: Integer): Bool;
  {-}
begin
 Result := Bool(Param[Index]);
end;

procedure TevInterface.pm_SetBoolParam(Index: Integer; Value: Bool);
  {-}
begin
 Param[Index] := Ord(Value);
end;

function  TevInterface.pm_GetLongParam(Index: Integer): Long;
  {-}
begin
 Result := Param[Index];
end;

procedure TevInterface.pm_SetLongParam(Index: Integer; Value: Long);
  {-}
begin
 Param[Index] := Value;
end;

function TevInterface.pm_GetParam(Index: Long): Long;
  {virtual;}
  {-}
begin
 Result := Tag.rLong(Index, l3NilLong);
end;

procedure TevInterface.pm_SetParam(anIndex: Long; aValue: Long);
  {virtual;}
  {-}
begin
 Changing;
 try
  Tag.IntW[anIndex, Tk2NonOptimizeContext.Instance{Context}] := aValue;
 finally
  Changed;
 end;//try..finally
end;

function TevInterface.pm_GetName: String;
  {-}
begin
 Result := Tag.Attr[k2_tiName].AsString;
end;

procedure TevInterface.pm_SetName(const Value: String);
  {virtual;}
  {-}
begin
 Tag.StrW[k2_tiName, Context] := Value;
end;

procedure TevInterface.pm_SetContext(const Value: InevOp);
  {virtual;}
  {-}
begin
 f_Context := Value;
end;

(*function TevInterface.pm_GetTypeID: Long;
  {-}
begin
 if (f_TagType = nil) then
  Result := l3NilLong
 else
  Result := f_TagType.ID;
end;

procedure TevInterface.pm_SetTypeID(Value: Long);
  {-}
begin
 f_TagType := nil;
 if (Value <> l3NilLong) then TagType := TypeTable[Value];
end;*)

(*procedure TevInterface.pm_SetTypeTable(const Value: Tk2TypeTable);
  {-}
begin
 f_TypeTable := Value;
end;*)

procedure TevInterface.pm_SetTagType(const Value: Tk2Type);
  {-}
begin
 if (f_TagType <> Value) then
 begin
  f_TagType := Value;
(*  if (f_TagType <> nil) then
  begin
   if not f_TagType.IsNull then
    TypeTable := f_TagType.TypeTable
   else
    TypeTable := nil;
  end;//f_TagType <> nil*)
 end;//f_TagType <> Value
end;

function TevInterface.pm_GetTag: Tl3Variant;
  {-}
begin
 Result := f_Tag;
end;

procedure TevInterface.pm_SetTag(aValue: Tl3Variant);
  {-}
begin
 if (f_Tag <> aValue) then
 begin
  aValue.SetRef(f_Tag);
  if (aValue <> nil) AND (TagType = nil) then
   if (aValue.TagType = nil) then
    TagType := nil
   else
    TagType := Tk2Type(aValue.TagType);
 end;//f_Tag <> aValue
end;

function TevInterface.pm_GetTypeTable: Tk2TypeTable;
  {-}
begin
 if (f_TypeTable = nil) then
  f_TypeTable := k2.TypeTable;
 Result := f_TypeTable;
end;

end.

