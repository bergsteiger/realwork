unit evdBufferedFilter;
{* Класс, предназначенный для фильтрации абзацев. }

{ Библиотека "EVD"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evdLeafParaFilter - }
{ Начат: 12.01.2004 19:54 }
{ $Id: evdBufferedFilter.pas,v 1.21 2014/04/08 17:13:24 lulin Exp $ }

// $Log: evdBufferedFilter.pas,v $
// Revision 1.21  2014/04/08 17:13:24  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/04/04 17:53:45  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/04/03 17:10:37  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/03/27 14:20:05  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.17  2013/10/21 15:43:12  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2013/10/18 14:11:31  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2011/09/15 12:43:55  voba
// - избавляемся от лишней буфферизации
//
// Revision 1.14  2011/05/16 08:07:32  voba
// - немного изменил логику TevdBufferedFilter.StopBufferingAndFlush, т к до NeedFlushBuffer вообще дело не доходило в случае если Generator = nil
//
// Revision 1.13  2011/02/10 14:19:07  lulin
// {RequestLink:253665539}.
//
// Revision 1.12  2010/08/02 14:55:04  fireton
// - удаление пустых строк в начале блока (K228692043)
//
// Revision 1.11  2009/11/12 12:42:22  voba
// - cc
//
// Revision 1.10  2009/09/15 08:45:23  narry
// - обновление
//
// Revision 1.9  2009/09/07 10:17:47  voba
// - opt. Убрали ненужную буфферизацию бинарных данных
//
// Revision 1.8  2009/09/02 14:31:31  lulin
// {RequestLink:161122154}.
//
// Revision 1.7  2009/03/04 13:33:09  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.6  2008/06/04 08:17:41  narry
// - исправление ошибки (К 93260874) - не работал фильтр тэгов (lulin)
//
// Revision 1.5  2007/08/09 17:17:11  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.4  2007/08/09 14:55:25  lulin
// - избавляемся от излишнего использования интерфейсов.
//
// Revision 1.3  2007/08/09 11:19:25  lulin
// - cleanup.
//
// Revision 1.2  2006/12/21 15:09:38  voba
// - new class TevdTagKeeperFilter
//
// Revision 1.1  2006/12/04 11:55:01  voba
// no message
//
// Revision 1.1  2005/06/23 13:52:47  lulin
// - фильтр листьевых параграфов переехал в папку EVD.
//
// Revision 1.13.8.1  2005/06/23 13:42:52  lulin
// - буфер документа переехал в папку K2.
//
// Revision 1.13  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.12  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.11  2005/03/18 16:11:22  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.10  2005/02/01 14:12:03  lulin
// - bug fix: при вставке комментарие теперь отрезаем ID параграфов - т.к. иначе на комментарии ставились закладки, ни и прочая...
//
// Revision 1.9  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2004/07/02 08:20:47  law
// - bug fix: не компилировалось.
//
// Revision 1.7  2004/06/29 14:26:41  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.6  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.5  2004/05/14 15:16:53  law
// - remove unit: evTypesE.
//
// Revision 1.4  2004/03/16 15:20:47  law
// - new unit: evDocumentBuffer.
//
// Revision 1.3  2004/01/20 13:28:44  narry
// - update: документирование ключевых методов класса
//
// Revision 1.2  2004/01/20 11:24:03  law
// - bug fix: при записи параграфа непонятно чем провинились Sub'ы.
//
// Revision 1.1  2004/01/12 17:24:33  law
// - new unit: evLeafParaFilter.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2TagFilter,
  k2DocumentBuffer,
  k2Base
  ;

type
  TevdCustomBufferedFilter = class(Tk2TagFilter)
   protected
    // internal fields
    f_Buffer : Tk2DocumentBuffer;

    // internal methods
      procedure Cleanup;
        override;
   public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
  end;

  TevdTagKeeperFilter = class(TevdCustomBufferedFilter)
   {*- Умеет накапливать нужные теги (задается в NeedKeepThisTag),
     накопленная информация может быть использована в DoKeepComplete.
     В принципе не требует окончания тега. Например, может прерывать
     накопление по вновь пришедшему "нужному" тегу.
     Может применятся на вложенных структурах (блоки) для укладки в БД сабов.
     Не буфферизует данные, накапливает только для собственных целей.
     После использования накопленные данные уничтожаются.}
   private
    fStarted : Boolean;
   protected
    function NeedKeepThisTag(aID : Integer) : Boolean;
       virtual;
         {*- Нужно ли накапливать этот тег}
    procedure DoKeepComplete;
       virtual;
         {*- накопление завершено. Перекрывать в потомках}
   public
     procedure KeepComplete;
         {*- завершить накопление}

     procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
       override;
         {-}
     procedure CloseStructure(NeedUndo: Bool);
       override;
         {-}
     procedure StartChild(TypeID: Tl3VariantDef);
       override;
         {-}
     procedure StartTag(TagID: Integer);
       override;
         {-}
  end;

  TevdBufferedFilter = class(TevdCustomBufferedFilter)
  {*- Умеет буфферизовывать нужные теги (задается в NeedStartBuffering),
     Буфферизуемая информация не передается дальше. После завершения тега,
     его содержимое может быть модифицированно и возвращено в "трубу" или уничтожено.
     Используется для сложной фильтрации тегов}
    protected
    // internal methods
      function  NeedStartBuffering(aID : Integer): Boolean;
        virtual;
        {* - Функция, определяющая тип Тегов, для которых будет выполняться буферизация.}
      function  NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
        virtual;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
      procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
        virtual;
        {* - Сбрасывает Тег в трубу.}
      procedure FlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
        {-}
      procedure StopBufferingAndFlush(aNeedUndo: Boolean; aTopObject: Tk2Base; aNeedCloseBracket : Boolean);
        {-}
    public
    // public methods
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
        override;
        {-}
      procedure StartTag(TagID: Integer);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-}
  end;

  TevdCustomChildBufferedFilter = class(TevdBufferedFilter)
  protected
    function ChildTypeForFiltering: Tk2Type; virtual;
    function NeedStartBuffering(aID : Integer): Boolean; override;
  end;

  TevdChildBufferedFilter = class(TevdBufferedFilter)
  private
   fBuffChildID : Integer;
  protected
    function NeedStartBuffering(aID : Integer): Boolean; override;
  public
    // public methods
   constructor Create(aChildID : Integer; anOwner: Tk2TagGeneratorOwner = nil); reintroduce;
        {-}
   class function SetTo(var theGenerator: Tk2TagGenerator; aChildID: Long):
       Pointer; overload;
   class procedure SetTo(var theGenerator: Ik2TagGenerator; aChildID: Long); overload;
  end;


  TevdTagBufferedFilter = class(TevdBufferedFilter)
  private
   fBuffTagID : Integer;

  protected
    function NeedStartBuffering(aID : Integer): Boolean; override;
  public
    // public methods
   constructor Create(aTagID : Integer; anOwner: Tk2TagGeneratorOwner = nil); reintroduce;
  end;

implementation

uses
  l3Base,

  k2Tags,

  LeafPara_Const
  ;

// start class TevdBufferedFilter

constructor TevdCustomBufferedFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_Buffer := Tk2DocumentBuffer.Create;
 f_Buffer.Start;
end;

procedure TevdCustomBufferedFilter.Cleanup;
begin
 f_Buffer.Finish;
 l3Free(f_Buffer);
 inherited;
end;

// start class TevdBufferedFilter

function TevdBufferedFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := False;
 // по-умолчанию ничего не делаем
end;

function  TevdBufferedFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

procedure TevdBufferedFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
  //virtual;
  {-}
begin
 if Generator <> nil then
 begin
  if (aTagId < 0) then
  begin
   // - записываем ребёнка
   Generator.StartChild(TypeTable.TypeByHandle[-aTagId]);
   try
    aLeaf.AsObject.WriteTag(Generator);
   finally
    if aNeedCloseBracket then
     Generator.Finish;
   end;//try..finally
  end//aTagId < 0
  else
  begin
   // - записываем тег
   Generator.StartTag(aTagId);
   try
    aLeaf.AsObject.WriteTag(Generator);
   finally
    if aNeedCloseBracket then
     Generator.Finish;
   end;//try..finally
  end;//aTagId < 0
 end;
end;

procedure TevdBufferedFilter.FlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
  {-}
begin
 if NeedFlushBuffer(aLeaf, aTagId) then
  DoFlushBuffer(aLeaf, aTagId, aNeedCloseBracket);
end;

procedure TevdBufferedFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if (SkipLevel = 0) then
 begin
  if NeedStartBuffering(-Tk2Type(TypeID).ID) then
   IncSkipTags;
 end;//SkipLevel = 0
 if SkipLevel > 0 then
  f_Buffer.StartChild(TypeID);
 inherited;
end;

procedure TevdBufferedFilter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
begin
 if SkipLevel > 0 then
  f_Buffer.AddAtomEx(AtomIndex, Value);
 inherited;
end;

procedure TevdBufferedFilter.StartTag(TagID: Integer);
begin
 if (SkipLevel = 0) then
 begin
  if NeedStartBuffering(TagID) then
   IncSkipTags;
 end;//SkipLevel = 0

 if SkipLevel > 0 then
 begin
  if (f_Buffer.CurrentStartLevel = 1) then
  // - открываем коробку для тегов (K 93260874)
   f_Buffer.StartChild(CurrentType);
  f_Buffer.StartTag(TagID);
 end;//SkipLevel > 0
 inherited;
end;

procedure TevdBufferedFilter.StopBufferingAndFlush(aNeedUndo: Boolean; aTopObject: Tk2Base; aNeedCloseBracket : Boolean);
  {-}
var
 l_ID   : Integer;
 l_Leaf : Tl3Variant;
begin
 if not aNeedCloseBracket then
 begin
  // закрываем скобки для любого уровня (K228692043)
  //Assert (SkipLevel >= 2);
  while SkipLevel >= 2 do
  begin
   f_Buffer.Finish;
   DecSkipTags;
  end; // while
 end;//not aNeedCloseBracket
 if (SkipLevel = 1) then
 begin
  if aTopObject.IsProp then
   l_ID := aTopObject.AsProp.TagIndex
  else
   l_ID := -aTopObject.TagType.ID;
  DecSkipTags;
  if aTopObject.IsProp then
  begin
  // - закрываем коробку для тегов
   Assert(f_Buffer.CurrentStartLevel = 2);
   f_Buffer.Finish(aNeedUndo);
   l_Leaf := f_Buffer.Root.Attr[l_ID];
  end//aTopObject.IsProp
  else
   l_Leaf := f_Buffer.Root;
  if not aNeedUndo then
   FlushBuffer(l_Leaf, l_ID, aNeedCloseBracket);
  f_Buffer.Root := nil;
 end;//SkipLevel = 0
end;

procedure TevdBufferedFilter.CloseStructure(NeedUndo: Bool);
var
 l_Def : Tk2Base;
begin
 if (SkipLevel > 1) then
 begin
  f_Buffer.Finish(NeedUndo);
  l_Def := TopObject[0];
  inherited;
  StopBufferingAndFlush(NeedUndo, l_Def, true);
 end//f_Filtered
 else
  inherited;
end;

{TevdCustomChildBufferedFilter}

function TevdCustomChildBufferedFilter.ChildTypeForFiltering: Tk2Type;
  //virtual;
  {-}
begin
 Result := k2_typLeafPara;
end;

function TevdCustomChildBufferedFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -ChildTypeForFiltering.ID;
end;

{TevdChildBufferedFilter}
constructor TevdChildBufferedFilter.Create(aChildID : Integer; anOwner: Tk2TagGeneratorOwner = nil);
begin
 Inherited Create(anOwner);
 fBuffChildID := aChildID;
end;

function TevdChildBufferedFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -fBuffChildID;
end;

class function TevdChildBufferedFilter.SetTo(var theGenerator: Tk2TagGenerator;
    aChildID: Long): Pointer;
  {-}
var
 l_Filter : TevdChildBufferedFilter;
begin
 l_Filter := Create(aChildID, nil);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

class procedure TevdChildBufferedFilter.SetTo(var theGenerator: Ik2TagGenerator; aChildID: Long);
var
 l_Filter : TevdChildBufferedFilter;
begin
 l_Filter := Create(aChildID, nil);
 try
  l_Filter.Generator := theGenerator;
  theGenerator := l_Filter;
 finally
  l3Free(l_Filter);
 end;//try..finally
 //Result := theGenerator;
end;

{TevdTagBufferedFilter}
constructor TevdTagBufferedFilter.Create(aTagID : Integer; anOwner: Tk2TagGeneratorOwner = nil);
begin
 Inherited Create(anOwner);
 fBuffTagID := aTagID;
end;

function TevdTagBufferedFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = fBuffTagID;
end;

{TevdTagKeeperFilter}
function TevdTagKeeperFilter.NeedKeepThisTag(aID : Integer) : Boolean;
begin
 Result := False;
 // по-умолчанию ничего не делаем
end;

procedure TevdTagKeeperFilter.KeepComplete;
begin
 if fStarted then
 begin
  f_Buffer.FinishAll;
  DoKeepComplete;
  fStarted := False;
  f_Buffer.Root := nil;
 end;
end;

procedure TevdTagKeeperFilter.DoKeepComplete;
begin

end;

procedure TevdTagKeeperFilter.AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
begin
 if fStarted then
  f_Buffer.AddAtomEx(AtomIndex, Value);
 inherited;
end;

procedure TevdTagKeeperFilter.CloseStructure(NeedUndo: Bool);
var
 l_ID  : Integer;
begin
 inherited;
 if fStarted then
  f_Buffer.Finish;

 if fStarted and f_Buffer.IsFinished then
  KeepComplete;
end;

procedure TevdTagKeeperFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if NeedKeepThisTag(-Tk2Type(TypeID).ID) then
 begin
  KeepComplete;
  fStarted := True;
 end;

 if fStarted then
  f_Buffer.StartChild(TypeID);
 inherited;
end;

procedure TevdTagKeeperFilter.StartTag(TagID: Integer);
begin
 if NeedKeepThisTag(TagID) then
 begin
  KeepComplete;
  fStarted := True;
 end;

 if fStarted then
  f_Buffer.StartTag(TagID);

 inherited;
end;

end.

