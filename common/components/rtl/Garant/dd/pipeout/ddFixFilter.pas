unit ddFixFilter;

{ $Id: ddFixFilter.pas,v 1.69 2015/07/03 15:21:06 voba Exp $ }

// $Log: ddFixFilter.pas,v $
// Revision 1.69  2015/07/03 15:21:06  voba
// - обжтопики старые не грузились
//
// Revision 1.68  2014/08/05 06:29:43  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.67  2014/06/25 14:19:49  lulin
// - делаем регистрацию атрибутов в отдельном списке.
//
// Revision 1.66  2014/04/22 17:32:45  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.65  2014/04/08 17:13:31  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.64  2014/04/07 06:53:36  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.63  2014/04/04 06:58:28  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.62  2014/03/28 06:13:19  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.61  2014/03/04 14:33:41  lulin
// - переводим идентификаторы Sub'ов и сегментов на нормальные Enum'ы.
//
// Revision 1.60  2013/10/30 10:36:37  voba
// - отказ от fSrchList
//
// Revision 1.59  2013/10/23 12:26:09  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.58  2013/10/21 15:43:19  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.57  2013/10/21 10:31:07  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.56  2013/10/18 15:39:04  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.55  2013/04/11 16:46:52  lulin
// - отлаживаем под XE3.
//
// Revision 1.54  2013/03/13 12:17:22  narry
// Не выводим в лог отладочную информацию
//
// Revision 1.53  2013/01/22 12:42:00  narry
// Обновление
//
// Revision 1.52  2011/11/07 09:08:10  narry
// Не работает импорт документов (296632243)
//
// Revision 1.51  2011/10/21 07:31:47  narry
// TddNullDocFilter обрушивает импорт (294600294)
//
// Revision 1.50  2011/10/05 11:10:40  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.49  2011/09/15 12:44:39  voba
// - избавляемся от лишней буфферизации
//
// Revision 1.48  2010/11/30 11:47:18  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.47  2009/03/04 16:26:01  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.46  2009/02/20 13:27:56  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.45  2008/10/23 10:56:07  fireton
// - избавляемся от пустых параграфов в objtopic'ах
//
// Revision 1.44  2008/09/23 12:17:50  fireton
// - импорт/экспорт номера судебного дела
//
// Revision 1.43  2008/06/23 08:27:55  narry
// - не собиралось
//
// Revision 1.42  2008/06/11 11:50:27  narry
// - ошибочное срабатываение на ряде документов
//
// Revision 1.41  2008/06/10 14:02:01  narry
// - пропуск доукментов с InternalHandle = 0
//
// Revision 1.40  2008/02/19 14:58:52  lulin
// - переводим сортировку списков на новые, менее виртуальные, рельсы.
//
// Revision 1.39  2008/02/05 12:49:17  lulin
// - упрощаем базовые объекты.
//
// Revision 1.38  2007/09/17 07:09:22  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.37  2007/09/11 19:23:13  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.36  2007/08/09 18:05:25  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.35  2007/08/09 11:19:21  lulin
// - cleanup.
//
// Revision 1.34  2007/06/25 12:19:51  narry
// - поддержка команды !SERVICEINFO
//
// Revision 1.33  2005/11/02 16:35:41  narry
// - чистка кода
//
// Revision 1.32  2005/10/18 09:06:50  lulin
// - исправлено, то что не компилировалось в связи с переездом модулей.
//
// Revision 1.31  2005/05/20 15:15:32  lulin
// - new unit: evStyleInterface.
//
// Revision 1.30  2005/03/28 11:32:22  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.29  2005/03/25 17:09:14  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.28  2005/03/21 10:05:00  lulin
// - new interface: _Ik2Type.
//
// Revision 1.27  2005/03/18 16:11:30  lulin
// - remove method: Tk2AtomR.Write.
//
// Revision 1.26  2005/03/10 07:39:41  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.25  2005/02/25 16:21:21  narry
// - update: поддержка Аннотаций
//
// Revision 1.24  2004/12/16 16:06:39  narry
// - update: расширение списка фильтруемых атомов
//
// Revision 1.23  2004/09/21 12:21:14  lulin
// - Release заменил на Cleanup.
//
// Revision 1.22  2004/09/09 09:32:03  narry
// - update: фильтрация ActiveIntervals
//
// Revision 1.21  2004/09/01 13:32:59  narry
// - new property: Write2Log
//
// Revision 1.20  2004/06/29 14:26:48  law
// - избавляемся от метода Tk2AtomR._Set.
//
// Revision 1.19  2004/06/03 12:27:13  narry
// - update: новая идеология окна конфигурации
//
// Revision 1.18  2004/06/02 16:22:38  narry
// - Update: исправление кодировки текста
//
// Revision 1.17  2004/05/27 14:57:25  narry
// - update: фильтрация атрибутов блока
//
// Revision 1.16  2004/05/14 16:58:43  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.15  2004/05/14 14:48:56  law
// - исправлены префиксы у констант.
//
// Revision 1.14  2004/05/14 14:29:01  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.13  2004/05/06 09:04:03  narry
// - update: поддержка типа документа DictEntry
//
// Revision 1.12  2004/03/17 13:30:51  narry
// - update: переименование модулей
//
// Revision 1.11  2003/12/02 08:18:22  voba
// no message
//
// Revision 1.10  2003/07/18 14:07:04  narry
// - add: добавлена фильтрация ExternalVerlink
//
// Revision 1.9  2003/03/17 13:20:01  narry
// Новые команды версионности
//
// Revision 1.8  2002/09/19 13:50:08  law
// - cvs directives.
//

interface

{$I ddDefine.inc}

uses
  l3Types,
  l3Variant,

  k2Types,
  k2Base,
  k2TagGen,
  k2TagFilter,
  k2DocumentBuffer, k2Interfaces,
  evdBufferedFilter;

type
  TddFixFilter = class(Tk2TagFilter)
  private
   f_Buffer   : Tk2DocumentBuffer;
   f_DelayTags: Boolean;
   f_ParaLen  : Longint;
  protected
   procedure Cleanup; override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoStartTag(TagID: Long); override;
   procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
   procedure DoCloseStructure(NeedUndo: Bool); override;
  public
   constructor Create(aOwner: Tk2TagGeneratorOwner); override;
  end;

  TddWrongTagFixFilter = class(Tk2TagFilter)
  private
   FWrite2Log: Boolean;
  protected
   f_IntNumber: Long;
   f_ExtNumber: Long;
   f_Skip     : Long;
   procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
   procedure DoStartTag(TagID: Long); override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoCloseStructure(NeedUndo: Bool); override;
   procedure Out2Log(aText: AnsiString; const IncSkip: Boolean = False);
  public
   constructor Create(aOwner: Tk2TagGeneratorOwner); override;
   class function SetTo(var theGenerator : Tk2TagGenerator; aWrite2Log : Boolean = false): Pointer; overload;

   property IntNumber: long
    write f_IntNumber;
   property Write2Log: Boolean
    read FWrite2Log
    write FWrite2Log;
  end;

 {TFixInternalNumberHandleFilter}
 TFixInternalNumberHandleFilter = class(Tk2TagFilter)
 private
  fIntHandle: Integer;
 protected
  procedure DoStartChild(TypeID: Tk2Type); override;
  procedure DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
 public
 {-}
  class function SetTo(var theGenerator: Tk2TagGenerator; aInternalHandle : Integer): Pointer; overload;
 end;

 TddNullDocFilter = class(TevdChildBufferedFilter)
 private
  f_IntHandle: Integer;
 protected
  function CheckNeedFlushBuffer: Boolean;

 public
        {-}
  procedure AddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Tl3VariantDef); override;

 {-}
  class function SetTo(var theGenerator: Tk2TagGenerator): Pointer; overload;
 end;

 TddChildBiteOffFilter = class(TevdChildBufferedFilter)
 private
  f_IsActive: Boolean;
 protected
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
 public
  {-}
  class function SetTo(var theGenerator: Tk2TagGenerator;
                     const aChildToDelete: Integer;
                           aIsActive: Boolean = True): Pointer; overload;
  property IsActive: Boolean read f_IsActive write f_IsActive;
 end;

implementation

uses
 k2Tags, 
 evdStyles, evStyleInterface, evdTypes,
 l3Base,
 SysUtils, k2StackGenerator,

 LeafPara_Const,
 TextPara_Const,
 Document_Const,
 Sub_Const,
 Block_Const
 ;

constructor TddFixFilter.Create(aOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 f_Buffer:= Tk2DocumentBuffer.Create(aOwner);
end;

procedure TddFixFilter.Cleanup;
begin
 l3Free(f_Buffer);
 inherited;
end;

procedure TddFixFilter.DoStartChild(TypeID: Tk2Type);
begin
 if TypeID.IsKindOf(k2_typTextPara) then
 begin
   f_DelayTags:= True;
   f_ParaLen:= 0;
   f_Buffer.Start;
 end; // TypeID = k2_idTextPara
 if f_DelayTags then
  f_Buffer.StartChild(TypeID)
 else // f_DelayTags
  inherited;
end;

procedure TddFixFilter.DoStartTag(TagID: Long);
begin
 if f_DelayTags then
  f_Buffer.StartTag(TagId)
 else
  inherited;
end;

procedure TddFixFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if f_DelayTags then
  f_Buffer.AddAtomEx(AtomIndex, Value)
 else
 begin
  inherited;
  if (AtomIndex = k2_tiText) and CurrentType.IsKindOf(k2_typTextPara)
      and (Value.Kind = k2_vkString) then
    f_ParaLen:= Value.AsString.AsWStr.SLen;
 end;
end;

procedure TddFixFilter.DoCloseStructure(NeedUndo: Bool);
var
 i         : Integer;
 l_Child   : Tl3Variant;
 l_StyleEv : TevStyleInterface;
begin
  if f_DelayTags then
  begin
   with f_Buffer do
   begin
    Finish;
    with Root do
     if IsKindOf(k2_typTextPara) then
     begin
      f_DelayTags := false;
      Finish;
      // - закрываем первый Start
      { Перебрать сегменты на предмет неправильно оформленных }
      with f_Buffer.Root.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)]) do
      begin
       if IsValid then
       begin
        i:= 0;
        while i < ChildrenCount do
        begin
         l_Child:= Child[i];
         if (l_Child.IntA[k2_tiStart] <= 1) and (l_Child.IntA[k2_tiFinish] >= f_ParaLen)
             and (l_Child.IntA[k2_tiStyle] <> ev_saTxtNormalANSI) then
         begin
          l_StyleEv := TevStyleInterface.Create;
          try
           l_StyleEv.SelectStyledObjectType(k2_typTextPara);
           l_StyleEv.SelectStyle(l_Child.IntA[k2_tiStyle]);
           if l_StyleEv.Apply2Para then
           begin
             f_Buffer.Root.IntA[k2_tiStyle] := l_Child.IntA[k2_tiStyle];
             DeleteChild(i);
           end // l_StyleEv.Apply2Para
           else
             Inc(i);
          finally
           l3Free(l_StyleEv);
          end;{try..finally}
         end
         else
           Inc(i);
        end; // while i < ChildrenCount
       end;
      end; // with
      Generator.StartChild(TagType);
      try
       AsObject.WriteTag(Generator);
      finally
       Generator.Finish;
      end;//try..finally
      Root := nil;
     end; // .. k2_idTextPara ..
   end;//with f_Buffer
  end // f_DelayTags
  else
    inherited;
end;

constructor TddWrongTagFixFilter.Create(aOwner: Tk2TagGeneratorOwner);
begin
  inherited;
  FWrite2Log:= True;
end;

class function TddWrongTagFixFilter.SetTo(var theGenerator : Tk2TagGenerator; aWrite2Log : Boolean = false): Pointer;
begin
 Result := inherited SetTo(theGenerator);
 with (theGenerator as TddWrongTagFixFilter) do
 begin
  FWrite2Log := aWrite2Log;
 end;
end;

procedure TddWrongTagFixFilter.DoStartChild(TypeID: Tk2Type);
var
 l_Type : Tk2Type;
begin
 l_Type := TypeID;
 if l_Type.IsKindOf(k2_typDocument) then
 begin
  f_IntNumber:= 0;
  f_ExtNumber:= 0;
  f_Skip     := 0;
 end; // (TypeID = k2_idDocument) or (TypeID = k2_idDictEntry)
 if f_Skip = 0 then
  inherited
 else
  Inc(f_Skip);
end;

procedure TddWrongTagFixFilter.DoCloseStructure(NeedUndo: Bool);
begin
 if f_Skip = 0 then
  inherited
 else
  Dec(f_Skip);
end;

procedure TddWrongTagFixFilter.Out2Log(aText: AnsiString; const IncSkip: Boolean = False);
begin
 if IncSkip then
  Inc(f_Skip);
 if Write2Log then
  if f_ExtNumber <> 0 then
   l3System.Msg2Log(Format('Топик %d атрибут в тексте - %s', [f_ExtNumber, aText]))
  else
   l3System.Msg2Log(Format('Атрибут в тексте - %s', [aText]));
end;

procedure TddWrongTagFixFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_String : Tl3CustomString;
begin
 (* типа стерто (31.10.05)
 if (Value.Kind = k2_vkString) then
 begin
  l_String := VariantAsString(Value);
  try
   // - здесь правим неправильную кодировку русских параграфов
   // 02.06.2004 - через неделю стереть
   if not l_String.Empty AND (l_String.CodePage = CP_WesternWin) and (l_String is Tl3String) then
    Tl3String(l_String)._CodePage := CP_ANSI;
  finally
   l3Free(l_String);
  end;//try..finally
 end;
 *)
 if f_Skip = 0 then
 begin
  if CurrentType.IsKindOf(k2_typDocument) then
   case AtomIndex of
    k2_tiType              : Out2Log('Type');
    k2_tiUserType          : Out2Log('UserType');
    k2_tiUser              : Out2Log('User');
    k2_tiNumber            : Out2Log('Number');
    k2_tiSortDate          : Out2Log('SortDate');
    //k2_tiNoActiveDate      : Out2Log('NoActiveDate');
    k2_tiRelExternalHandle : Out2Log('RelExternalHandle');
    k2_tiRelInternalHandle : Out2Log('RelInternalHandle');
    k2_tiPriority          : Out2Log('Priority');
    k2_tiExternalVerLink   : Out2Log('ExternalVerLink');
    //k2_tiPreActiveDate     : Out2Log('PreActiveDate');
    k2_tiPriceLevel        : Out2Log('PriceLevel');
    k2_tiSource            : Out2Log('Source');
    k2_tiComment           : //выкинуть комментарии, начинающиеся с !
     begin
      if Value.Kind = k2_vkString then
       if (not Value.AsString.Empty) and (Value.AsString.AsWStr.S[0] <> '!') then
        inherited;
     end;
   else
    begin
     inherited;
     if AtomIndex = k2_tiExternalHandle then
      f_ExtNumber:= Value.AsInteger
     else
     if AtomIndex = k2_tiInternalHandle then
      f_IntNumber:= Value.AsInteger;
    end;
   end // case
  else
   inherited;
 end;
end;

procedure TddWrongTagFixFilter.DoStartTag(TagID: Long);
begin
 if f_Skip = 0 then
 begin
  if TopType[1].IsKindOf(k2_typDocument)
     or TopType[1].IsKindOf(k2_typSub)
     or TopType[1].IsKindOf(k2_typBlock) then
   case TagID of
    k2_tiGroups         : Out2Log('Groups', True);
    k2_tiAccGroups      : Out2Log('AccGroups', True);
    k2_tiSources        : Out2Log('Sources', True);
    k2Tags.k2_tiTypes          : Out2Log('Types', True);
    k2Tags.k2_tiClasses        : Out2Log('Classes', True);
    k2Tags.k2_tiKeyWords       : Out2Log('KeyWords', True);
    k2_tiNumANDDates    : Out2Log('NumANDDates', True);
    k2_tiLogRecords     : Out2Log('LogRecords', True);
    k2_tiStages         : Out2Log('Stages', True);
    k2_tiChecks         : Out2Log('Checks', True);
    k2_tiWarnings       : Out2Log('Warnings', True);
    k2_tiPublishedIn    : Out2Log('PublishedIn', True);
    k2Tags.k2_tiPrefix         : Out2Log('Prefix', True);
    k2_tiTerritory      : Out2Log('Territory', True);
    k2_tiNorm           : Out2Log('Norm', True);
    k2_tiActiveIntervals: Out2Log('ActiveIntervals', True);
    k2_tiAlarms         : Out2Log('Alarms', True);
    k2_tiAnnoClasses    : Out2Log('AnnoClasses', True);
    k2Tags.k2_tiServiceInfo    : Out2Log('ServiceInfo', True);
    k2_tiLinkedDocuments: Out2Log('LinkedDocuments', True);
   else
     inherited;
   end
  else
   inherited;
 end
 else
  Inc(f_Skip);
end;

{TFixInternalNumberHandleFilter}

procedure TFixInternalNumberHandleFilter.DoStartChild(TypeID: Tk2Type);
begin
 Inherited;
 if TypeID.IsKindOf(k2_typDocument) then
  Generator.AddIntegerAtom(k2_tiInternalHandle, fIntHandle);
end;

procedure TFixInternalNumberHandleFilter.DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then

 else
  inherited;
end;

class function TFixInternalNumberHandleFilter.SetTo(var theGenerator: Tk2TagGenerator; aInternalHandle : Integer): Pointer;
begin
 Result := inherited SetTo(theGenerator);
 with (theGenerator as TFixInternalNumberHandleFilter) do
 begin
  fIntHandle := aInternalHandle;
 end;
end;

{TddNullDocFilter}
procedure TddNullDocFilter.AddAtomEx(AtomIndex: Integer; const Value:
    Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_IntHandle:= Value.AsInteger;
 inherited;
end;

function TddNullDocFilter.CheckNeedFlushBuffer: Boolean;
begin
// нельзя передать документ дальше, если у него ЕСТЬ нулевой InternalHandle
 Result:= f_IntHandle > 0;
 {$IFDEF Debug}
 if not Result then
  l3System.Msg2Log('%s skipped', [ClassName]);
 {$ENDIF}
end;

procedure TddNullDocFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID.IsKindOf(k2_typLeafPara) and (SkipLevel = 2) and CheckNeedFlushBuffer then
  StopBufferingAndFlush(False, TopObject[0], false);
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
  f_IntHandle:= 0;
end;

class function TddNullDocFilter.SetTo(var theGenerator: Tk2TagGenerator): Pointer;
var
 l_Filter : TddNullDocFilter;
begin
 l_Filter := Create(k2_idDocument);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

{TddChildBiteOffFilter}
function TddChildBiteOffFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
// все накопленное просто убивается нафик, в случае, если фильтр активен
 Result := not f_IsActive;
end;

class function TddChildBiteOffFilter.SetTo(var theGenerator: Tk2TagGenerator;
                                         const aChildToDelete: Integer;
                                               aIsActive: Boolean = True): Pointer;
  {-}
var
 l_Filter : TddChildBiteOffFilter;
begin
 l_Filter := Create(aChildToDelete);
 try
  l_Filter.IsActive := aIsActive;
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;



end.
