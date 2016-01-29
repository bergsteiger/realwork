unit evTagsListFilter;
{* Фильтр списка тегов. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: ev - }
{ Начат: 20.07.2001 15:30 }
{ $Id: evTagsListFilter.pas,v 1.27 2015/08/18 14:35:04 voba Exp $ }

// $Log: evTagsListFilter.pas,v $
// Revision 1.27  2015/08/18 14:35:04  voba
// - переставил местами параметры TevTagsListFilter.SetTo (генератор всегда первый)
//
// Revision 1.26  2013/10/23 12:25:49  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.25  2013/10/21 17:30:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.24  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.23  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.22  2009/03/03 12:46:04  lulin
// - <K>: 137465982. Отвязываемся от внутреннего определения дочерних типов.
//
// Revision 1.21  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.16.4.9  2007/08/14 15:19:22  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.16.4.8  2007/08/10 14:44:43  lulin
// - cleanup.
//
// Revision 1.16.4.7  2007/08/09 18:26:18  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.16.4.6  2007/08/09 13:59:22  lulin
// - cleanup.
//
// Revision 1.16.4.5  2007/08/09 13:50:11  lulin
// - избавляемся от излишней гибкости.
//
// Revision 1.16.4.4  2007/08/09 11:19:13  lulin
// - cleanup.
//
// Revision 1.16.4.3  2007/07/20 06:05:35  oman
// Warning fix
//
// Revision 1.16.4.2  2006/05/30 07:04:52  lulin
// - bug fix: не фильтровались метки при вставке из буфера обмена (CQ OIT5-21014).
//
// Revision 1.16.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.14.2.2  2005/05/18 12:32:10  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.14.2.1  2005/04/28 09:18:30  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.15  2005/04/25 08:58:29  voba
// - add class function SetTo for interfaces
//
// Revision 1.14.4.1  2005/04/25 14:04:57  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.15  2005/04/25 08:58:29  voba
// - add class function SetTo for interfaces
//
// Revision 1.14  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.13  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.12  2005/02/01 17:19:29  lulin
// - new method: TevTagsListFilter.MakeAttrList.
//
// Revision 1.11  2005/02/01 15:17:39  lulin
// - new method: TevTagsListFilter.SetTo.
//
// Revision 1.10  2004/11/04 17:43:44  lulin
// - new interface: _Ik2TypeTable.
//
// Revision 1.9  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.8  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.7  2004/05/14 14:08:50  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.6  2002/09/18 06:03:32  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.5  2001/07/24 06:43:44  law
// - new constructor: MakeAttr.
//
// Revision 1.4  2001/07/23 15:49:03  law
// - new behavior: сделана возможность задать для каждого типа тегов игнорируемые атрибуты.
//
// Revision 1.3  2001/07/20 13:36:00  law
// - comments: xHelpGen.
//
// Revision 1.2  2001/07/20 13:33:43  law
// - comments: поправлены.
//
// Revision 1.1  2001/07/20 13:32:25  law
// - new class: TevTagsListFilter - фильтр определенного списка дочерних тегов.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,

  k2Types,
  k2Interfaces,
  k2Base,
  k2TagGen,
  k2TagFilter
  ;

type
  TevTagAttr = record
   TypeID : Tk2TypePrim;
   TagID  : Long;
  end;//TevTagAttr

  TevTypeList = array of Tk2TypePrim;

  TevTagAttrArray = array of TevTagAttr;

  TevTagsListFilter = class(Tk2TagFilter)
   {* Фильтр списка тегов. }
    protected
    // property fields
      f_ExcludeChildList   : TevTypeList;
      f_IncludeChildList   : TevTypeList;
      f_ExcludeTagAttrList : TevTagAttrArray;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure DoStartChild(TypeID: Tk2Type);
        override;
        {-}
      procedure DoStartTag(TagID: Long);
        override;
        {-}
      procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      function  IsChildForExclude(aTypeID: Tk2Type): Bool;
        {-}
      function  IsTagForExclude(const aTagID: Long; aLevel : Integer): Bool;
        {-}
      procedure SetExcludeTagAttrList(const anExcludeTagAttrList : array of TevTagAttr);
        {-}
    public
    // public methods
      constructor Make(const anExcludeChildList : array of Tk2TypePrim);
        reintroduce;
        overload;
        {-}
      constructor Make(const anExcludeChildList : array of Tk2TypePrim;
                       const anIncludeChildList : array of Tk2TypePrim);
        reintroduce;
        overload;
        {-}
      constructor Make(const anExcludeChildList   : array of Tk2TypePrim;
                       const anIncludeChildList   : array of Tk2TypePrim;
                       const anExcludeTagAttrList : array of TevTagAttr);
        reintroduce;
        overload;
        {-}
      constructor MakeAttr(const anExcludeTagAttrList : array of TevTagAttr);
        {-}
      class function SetTo(var theGenerator           : Tk2TagGenerator;
                           const anExcludeTagAttrList : array of TevTagAttr): Tk2TagGenerator;
        reintroduce;
        overload;
        {-}
      class function SetTo(var theGenerator           : Ik2TagGenerator;
                           const anExcludeTagAttrList : array of TevTagAttr): Ik2TagGenerator;
        reintroduce;
        overload;
        {-}
      class function MakeAttrList(aTypeID       : Tk2TypePrim;
                                  const anAttrs : array of Long): TevTagAttrArray;
        {-}
    public
    // public properties
      property ExcludeChildList: TevTypeList
        read f_ExcludeChildList
        write f_ExcludeChildList;
        {* - список ID типов тегов для исключения. }
      property IncludeChildList: TevTypeList
        read f_IncludeChildList
        write f_IncludeChildList;
        {* - список ID типов тегов для включения. Просматривается после ExcludeChildList. }
      property ExcludeTagAttrList: TevTagAttrArray
        read f_ExcludeTagAttrList
        write f_ExcludeTagAttrList;
        {* - список исключаемых тегов для каждого типа. }
  end;//TevTagsListFilter

function evTagAttr(aTypeID: Tk2TypePrim; aTagID : Long): TevTagAttr;
  {* - "Конструктор" для записи типа TevTagAttr.}

implementation

uses
  k2Facade
  ;

function evTagAttr(aTypeID: Tk2TypePrim; aTagID : Long): TevTagAttr;
  {-}
begin
 with Result do
 begin
  TypeID := aTypeID;
  TagID := aTagID;
 end;//with Result
end;
  
// start class TevTagsListFilter

constructor TevTagsListFilter.Make(const anExcludeChildList : array of Tk2TypePrim);
  //overload;
  {-}
begin
 Create;
 if (@anExcludeChildList <> nil) then
 begin
  SetLength(f_ExcludeChildList, Succ(High(anExcludeChildList)));
  l3Move(anExcludeChildList[0], f_ExcludeChildList[0], Succ(High(anExcludeChildList)) * SizeOf(Long));
 end;//@anExcludeChildList <> nil
end;

constructor TevTagsListFilter.Make(const anExcludeChildList : array of Tk2TypePrim;
                                   const anIncludeChildList : array of Tk2TypePrim);
  //overload;
  {-}
begin
 Make(anExcludeChildList);
 if (@anIncludeChildList <> nil) then
 begin
  SetLength(f_IncludeChildList, Succ(High(anIncludeChildList)));
  l3Move(anIncludeChildList[0], f_IncludeChildList[0], Succ(High(anIncludeChildList)) * SizeOf(Long));
 end;//@anIncludeChildList <> nil
end;

constructor TevTagsListFilter.Make(const anExcludeChildList   : array of Tk2TypePrim;
                                   const anIncludeChildList   : array of Tk2TypePrim;
                                   const anExcludeTagAttrList : array of TevTagAttr);
  //overload;
  {-}
begin
 Make(anExcludeChildList, anIncludeChildList);
 SetExcludeTagAttrList(anExcludeTagAttrList);
end;

procedure TevTagsListFilter.SetExcludeTagAttrList(const anExcludeTagAttrList : array of TevTagAttr);
  {-}
begin
 if (@anExcludeTagAttrList <> nil) then
 begin
  SetLength(f_ExcludeTagAttrList, Succ(High(anExcludeTagAttrList)));
  l3Move(anExcludeTagAttrList[0], f_ExcludeTagAttrList[0], Succ(High(anExcludeTagAttrList)) * SizeOf(TevTagAttr));
 end;//@anExcludeTagAttrList <> nil
end;

constructor TevTagsListFilter.MakeAttr(const anExcludeTagAttrList : array of TevTagAttr);
  {-}
begin
 Make([], [], anExcludeTagAttrList);
end;
  
procedure TevTagsListFilter.Cleanup;
  //override;
  {-}
begin
 IncludeChildList := nil;
 ExcludeChildList := nil;
 ExcludeTagAttrList := nil;
 inherited;
end;

class function TevTagsListFilter.SetTo(var theGenerator           : Tk2TagGenerator;
                                       const anExcludeTagAttrList : array of TevTagAttr
                                       ): Tk2TagGenerator;
  //reintroduce;
  {-}
begin
 if (Length(anExcludeTagAttrList) = 0) then
  // - не надо ничего фильтровать
 begin
  Result := theGenerator;
 end
 else
 begin
  Result := inherited SetTo(theGenerator);
  (Result As TevTagsListFilter).SetExcludeTagAttrList(anExcludeTagAttrList);
 end;//aHiddenStyles = []
end;

class function TevTagsListFilter.SetTo(var theGenerator           : Ik2TagGenerator;
                                       const anExcludeTagAttrList : array of TevTagAttr
                                       ): Ik2TagGenerator;
  //reintroduce;
  {-}
var
 l_Filter : TevTagsListFilter;
begin
 if (Length(anExcludeTagAttrList) = 0) then
  // - не надо ничего фильтровать
 begin
  Result := theGenerator;
 end
 else
 begin
  l_Filter := Create;
  try
   l_Filter.Generator := theGenerator;
   l_Filter.SetExcludeTagAttrList(anExcludeTagAttrList);
   theGenerator := l_Filter;
  finally
   l3Free(l_Filter);
  end;//try..finally
  Result := theGenerator;
 end;//aHiddenStyles = []
end;

class function TevTagsListFilter.MakeAttrList(aTypeID       : Tk2TypePrim;
                                              const anAttrs : array of Long): TevTagAttrArray;
  {-}
var
 l_Index : Integer;
begin
 SetLength(Result, Length(anAttrs));
 if (Length(anAttrs) > 0) then
 begin
  for l_Index := Low(anAttrs) to High(anAttrs) do
  begin
   Result[l_Index].TypeID := aTypeID;
   Result[l_Index].TagID := anAttrs[l_Index];
  end;//for l_Index
 end;//Length(anAttrs) > 0
end;
  
procedure TevTagsListFilter.DoStartChild(TypeID: Tk2Type);
  //override;
  {-}
begin
 if IsChildForExclude(TypeID) then
  StartSkipTags
 else
  inherited;
end;

procedure TevTagsListFilter.DoStartTag(TagID: Long);
  //override;
  {-}
begin
 if IsTagForExclude(TagID, 1) then
  StartSkipTags
 else
  inherited;
end;

procedure TevTagsListFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
begin
 if not IsTagForExclude(AtomIndex, 0) then
  inherited;
end;

function TevTagsListFilter.IsChildForExclude(aTypeID: Tk2Type): Bool;
  {-}
var
 i  : Long;
begin
 Result := false;
 if (ExcludeChildList <> nil) then
 begin
  for i := Low(ExcludeChildList) to High(ExcludeChildList) do
   if aTypeID.IsKindOf(ExcludeChildList[i]) then
   begin
    Result := true;
    break;
   end;//aTypeID..
  if Result AND (IncludeChildList <> nil) then
  begin
   for i := Low(IncludeChildList) to High(IncludeChildList) do
    if aTypeID.IsKindOf(IncludeChildList[i]) then
    begin
     Result := false;
     break;
    end;//aTypeID..
  end;//ExcludeChildList <> nil
 end;//ExcludeChildList <> nil
end;

function TevTagsListFilter.IsTagForExclude(const aTagID: Long; aLevel : Integer): Bool;
  {-}
var
 i  : Long;
 CT : Tk2Type;
begin
 Result := false;
 if (ExcludeTagAttrList <> nil) then
 begin
  CT := TopType[aLevel];
  for i := Low(ExcludeTagAttrList) to High(ExcludeTagAttrList) do
   with ExcludeTagAttrList[i] do
    if (aTagID = TagID) AND CT.IsKindOf(TypeID) then
    begin
     Result := true;
     break;
    end;//aTagID = TagID
 end;//ExcludeTagAttrList <> nil
end;

end.

