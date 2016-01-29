unit evEvdWriter;
{* Писатель тегов в формате evd в структурированное хранилище (IStorage). }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evEvdWriter -   }
{ Начат: 19.10.2001 11:29 }
{ $Id: evEvdWriter.pas,v 1.51 2014/10/30 13:43:51 lulin Exp $ }

// $Log: evEvdWriter.pas,v $
// Revision 1.51  2014/10/30 13:43:51  lulin
// - перетряхиваем код.
//
// Revision 1.50  2014/04/09 15:44:57  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.49  2013/10/21 17:30:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.48  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.47  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.46  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.45  2013/10/18 08:01:17  lulin
// - работа по избавлению от ненужного Enum.
//
// Revision 1.44  2013/04/05 12:02:15  lulin
// - портируем.
//
// Revision 1.43  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.42  2009/03/04 16:58:50  lulin
// - <K>: 137470629. Bug fix: не собиралась библиотека.
//
// Revision 1.41  2008/06/20 10:07:44  lulin
// - <K>: 94733082.
//
// Revision 1.40  2008/03/21 14:09:12  lulin
// - cleanup.
//
// Revision 1.39  2008/03/07 15:53:32  lulin
// - <K>: 86477888.
//
// Revision 1.38  2008/02/07 09:32:56  lulin
// - подготавливаемся к переносу списка целых на модель.
//
// Revision 1.37  2008/02/05 18:20:34  lulin
// - удалено ненужное свойство строк.
//
// Revision 1.36  2008/02/05 09:57:37  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.35  2008/02/01 15:14:29  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.34  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.5  2007/09/07 14:47:34  lulin
// - добавлено удаление последнего элемента списка.
//
// Revision 1.4  2007/08/29 14:52:31  lulin
// - не пишем информацию о текстовых скобках.
//
// Revision 1.3  2007/08/29 14:26:59  lulin
// - пакуем EVD-теги - вместо слова, пишем байт.
//
// Revision 1.2  2007/08/29 11:28:52  lulin
// - файлы переехали в общую папку.
//
// Revision 1.1  2007/08/29 11:10:00  lulin
// - файлы переехали в общую папку.
//
// Revision 1.27.8.4  2007/08/09 18:26:18  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.27.8.3  2007/08/09 11:19:12  lulin
// - cleanup.
//
// Revision 1.27.8.2  2005/07/21 13:00:34  lulin
// - писатель формата EVD переехал в папку EVD.
//
// Revision 1.27.8.1  2005/06/23 12:55:33  lulin
// - файл с константами переехал в папку EVD.
//
// Revision 1.27  2005/03/28 11:32:07  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.26  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.25  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.24  2004/06/10 13:04:39  law
// - new property: TevCustomEvdStorageWriter.AccessByIndex.
//
// Revision 1.23  2004/06/10 09:32:09  law
// - bug fix: неправильно записывались документы в бинарном виде в структурированное хранилище.
//
// Revision 1.22  2004/06/01 16:51:18  law
// - удален конструктор Tl3VList.MakePersistent - пользуйтесь _Tl3ObjectRefList.
//
// Revision 1.21  2004/05/14 14:48:47  law
// - исправлены префиксы у констант.
//
// Revision 1.20  2004/05/14 14:08:49  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.19  2002/06/17 13:44:44  law
// - new const: m3_saRead, m3_saReadWrite, m3_saCreate.
//
// Revision 1.18  2002/02/22 10:30:51  law
// - optimization: используем интерфейс Im3IndexedStorage.
//
// Revision 1.17  2002/02/07 15:22:29  law
// - rename class: IevBlock -> TevBlock, для того чтобы не путать его с интерфейсом.
//
// Revision 1.16  2002/01/30 15:47:21  law
// - new behavior: сделано размазывание блоков.
//
// Revision 1.15  2002/01/29 14:49:37  law
// - test: попытки переименования потока main, которые ни к чему хорошему (ни по скорости, ни по размеру) не привели.
//
// Revision 1.14  2002/01/24 16:30:24  law
// - new behavior: сделан доступ по индексу к элементам хранилища.
//
// Revision 1.13  2002/01/05 11:00:43  law
// - some cosmetics.
//
// Revision 1.12  2001/12/24 14:47:38  voba
// - bug fix: подключили новый индексатор к Архивариусу.
//
// Revision 1.11  2001/11/28 14:19:30  law
// - new behavior: сделано создание хранилищ с автоматической паковкой.
//
// Revision 1.10  2001/11/20 17:37:28  law
// - new behavior: сделана "рыба" для проверки работы индексатора.
//
// Revision 1.9  2001/11/20 14:29:40  law
// - new unit: m3ParaIndexBuilder.
//
// Revision 1.8  2001/11/02 15:11:18  law
// - change.
//
// Revision 1.7  2001/11/01 13:18:02  law
// - new field: f_IsPlain.
// - bug fix: при записи не в IStorage и не Plain писалось коряво.
//
// Revision 1.6  2001/10/29 13:31:01  law
// - cleanup: убраны ссылки на ComObj.
//
// Revision 1.5  2001/10/29 13:04:44  law
// - new behavior: пока сделано сохранение документов в IStorage в неструктурированном виде.
//
// Revision 1.4  2001/10/24 07:02:43  law
// - new behavior: сделано пакование только для Binary формата.
//
// Revision 1.3  2001/10/23 16:46:07  law
// - new behavior: прикручено пакование потоков при записи.
// - bug fix: %binary для документа писалось и в текстовом режиме.
//
// Revision 1.2  2001/10/23 15:22:00  law
// - new behavior: сделана запись ссылок на блоки в двоичный формат.
//
// Revision 1.1  2001/10/19 16:20:41  law
// - new unit: evEvdWriter.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  ActiveX,

  Classes,

  l3Types,
  l3Base,
  l3Filer,
  l3ObjectRefList,
  l3ProtoObject,
  l3ProtoObjectRefList,

  {$IfDef evUseIndexBuilder}
  m3IndexInterfaces,
  {$EndIf evUseIndexBuilder}

  m3StorageInterfaces,

  k2Types,
  k2Interfaces,
  k2Base,
  k2TagGen,

  evdWriter
  ;

type
  TevCustomEvdStorageWriter = class;

  TevPartContainer = class(Tl3ProtoObject)
    private
    // property fields
      f_RootStorage : Im3IndexedStorage;
      f_PrevStream  : TStream;
      f_Writer      : TevCustomEvdStorageWriter;
      f_Type        : Tk2Type;
      f_ID          : Long;
    protected
    // property methods
      procedure pm_SetPrevStream(aValue: TStream);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aWriter     : TevCustomEvdStorageWriter;
                         const aType : Tk2Type);
        reintroduce;
        {-}
      procedure AddAtomEx(anAtomIndex  : Long;
                          const aValue : Tk2Variant);
        {-}
    public
    // public properties
      property RootStorage: Im3IndexedStorage
        read f_RootStorage
        write f_RootStorage;
        {-}
      property PrevStream: TStream
        read f_PrevStream
        write pm_SetPrevStream;
        {-}
      property Writer: TevCustomEvdStorageWriter
        read f_Writer
        write f_Writer;
        {-}
      property TagType: Tk2Type
        read f_Type;
        {-}
      property ID: Long
        read f_ID
        write f_ID;
        {-}
  end;//TevPartContainer

  TevCustomEvdStorageWriter = class(TevdCustomNativeWriter)
   {* Писатель тегов в формате evd в структурированное хранилище (IStorage). }
    private
    // property fields
      f_Storage : Im3IndexedStorage;
      f_Plain   : Bool;
      f_IsPlain : Bool;
      f_Stack   : Tl3ProtoObjectRefList;
      f_Stream  : TStream;
      f_InBlock : Bool;
      f_Block   : TevPartContainer;
      {$IfDef evUseIndexBuilder}
      f_IndexBuilder : Im3ParaIndexBuilder;
      {$EndIf evUseIndexBuilder}
      f_BuildIndex    : Bool;
      f_AccessByIndex : Bool;
    protected
    // property methods
      procedure pm_SetBlock(aValue: TevPartContainer);
        {-}
      procedure pm_SetStream(aValue: TStream);
        {-}
      function  pm_GetIndent: Long;
        override;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure FilerChanged(aFiler: Tl3CustomFiler);
        override;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-}
      procedure CheckStorage(aFiler: Tl3CustomFiler);
        {-}
      procedure DoStartChild(TypeID: Tk2Type);
        override;
        {-}
      function  SaveInStorage(const aType: Tk2Type): Bool;
        {-}
      procedure DoCloseStructure(NeedUndo: Bool);
        override;
        {-}
      function  WriteBuf(B: PAnsiChar; Len: Long): Long;
        override;
        {-}
      procedure WriteLink(aBlock: TevPartContainer);
        {-}  
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure AddAtomEx(AtomIndex   : Long;
                          const Value : Tk2Variant);
        override;
        {-}
      procedure OutEOL;
        override;
        {-}
      procedure OutHeader;
        override;
        {-}
    public
    // public properties
      property Storage: Im3IndexedStorage
        read f_Storage
        write f_Storage;
        {-}
      property Stream: TStream
        read f_Stream
        write pm_SetStream;
        {-}  
      property Plain: Bool
        read f_Plain
        write f_Plain
        default false;
        {-}
      property InBlock: Bool
        read f_InBlock;
        {-}
      property Block: TevPartContainer
        read f_Block
        write pm_SetBlock;
        {-}
      {$IfDef evUseIndexBuilder}
      property IndexBuilder: Im3ParaIndexBuilder
        read f_IndexBuilder
        write f_IndexBuilder;
        {* - построитель индекса. }
      {$EndIf evUseIndexBuilder}
      property BuildIndex: Bool
        read f_BuildIndex
        write f_BuildIndex
        default true;
        {-}
      property AccessByIndex: Bool
        read f_AccessByIndex
        write f_AccessByIndex
        default false;
        {-}
  end;//TevCustomEvdStorageWriter

  TevEvdStorageWriter = class(TevCustomEvdStorageWriter)
   {*! Писатель тегов в формате evd в структурированное хранилище (IStorage).
       (С published свойствами) }
    published
      property Filer;
        {-}
      {$IfDef evdNeedEverestTxt}
      property Binary;
        {-}
      {$EndIf evdNeedEverestTxt}  
      property OutEndComment;
        {-}
  end;//TevEvdStorageWriter

implementation

uses
  SysUtils,
  ComObj,

  l3Chars,
  l3InternalInterfaces,
  l3Stream,
  l3String,

  k2Tags,

  evdConst,

  m2COMLib,

  m3Const,
  {$IfDef evUseIndexBuilder}
  m3ParaIndexBuilder,
  {$EndIf evUseIndexBuilder}
  //m3ArcMgr,
  m3StorageTools,

  Block_Const,
  Document_Const
  ;

function _OpenStorage(const aStorage : Im3IndexedStorage;
                      const aName    : WideString): Im3IndexedStorage;
begin
 Result := m3COMOpenStorage(aStorage,
                            l3PCharLen(aName),
                            m3_saReadWrite,
                            true);
end;

function _OpenStream(const aStorage : Im3IndexedStorage;
                     const aName    : WideString): IStream;
begin
 Result := m3COMOpenStream(aStorage,
                             l3PCharLen(aName),
                             m3_saCreate,
                             true);
end;

// start class TevCustomEvdStorageWriter

constructor TevCustomEvdStorageWriter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  //override;
  {-}
begin
 inherited;
 BuildIndex := true;
end;

procedure TevCustomEvdStorageWriter.Cleanup;
  //override;
  {-}
begin
 {$IfDef evUseIndexBuilder}
 IndexBuilder := nil;
 {$EndIf evUseIndexBuilder}
 l3Free(f_Stack);
 Stream := nil;
 Storage := nil;
 Block := nil;
 inherited;
end;

procedure TevCustomEvdStorageWriter.pm_SetBlock(aValue: TevPartContainer);
  {-}
begin
 if l3Set(f_Block, aValue) then
  f_InBlock := (f_Block <> nil);
end;

procedure TevCustomEvdStorageWriter.pm_SetStream(aValue: TStream);
  {-}
begin
 l3Set(f_Stream, aValue);
end;

function TevCustomEvdStorageWriter.pm_GetIndent: Long;
  //override;
  {-}
begin
 Result := inherited pm_GetIndent;
 if not f_IsPlain AND (f_Stack <> nil) then
  Dec(Result, f_Stack.Hi);
end;

procedure TevCustomEvdStorageWriter.FilerChanged(aFiler: Tl3CustomFiler);
  //override;
  {-}
begin
 inherited;
 CheckStorage(aFiler);
end;

procedure TevCustomEvdStorageWriter.OpenStream;
  //override;
  {-}
{$IfDef evUseIndexBuilder}
var
 l_IndexBuilder   : Tm3ParaIndexBuilder;
{$EndIf evUseIndexBuilder}
begin
 inherited;
 CheckStorage(Filer);
 f_IsPlain := Plain OR (Storage = nil);
 {$IfDef evUseIndexBuilder}
 if not f_IsPlain AND BuildIndex AND (IndexBuilder = nil) then begin
  l_IndexBuilder := Tm3ParaIndexBuilder.Create(_OpenStorage(Storage, 'index'));
  try
   IndexBuilder := l_IndexBuilder;
  finally
   l3Free(l_IndexBuilder);
  end;//try..finally
 end;//not IsPlain..
 {$EndIf evUseIndexBuilder}
end;

procedure TevCustomEvdStorageWriter.CloseStream(NeedUndo: Bool);
  //override;
  {-}
begin
 inherited;
 if (f_Stack <> nil) then
  f_Stack.Clear;
 Block := nil;
 Stream := nil;
 Storage := nil;
 {$IfDef evUseIndexBuilder}
 IndexBuilder := nil;
 {$EndIf evUseIndexBuilder}
end;

procedure TevCustomEvdStorageWriter.CheckStorage(aFiler: Tl3CustomFiler);
  {-}
var
 l_StorageSource : Il3StorageSource;
begin
 if (aFiler <> nil) then begin
  Stream := aFiler.Stream;
  if Supports(aFiler, Il3StorageSource, l_StorageSource) then
   try
    Storage := l_StorageSource.Storage As Im3IndexedStorage;
   finally
    l_StorageSource := nil;
   end//try..finally
  else
   Storage := nil;
 end else
  Storage := nil;
end;

function TevCustomEvdStorageWriter.SaveInStorage(const aType: Tk2Type): Bool;
  {-}
begin
 Result := (aType.IsKindOf(k2_typBlock));
// Result := (aType.IsKindOf(k2_typDocument));
end;

procedure TevCustomEvdStorageWriter.DoStartChild(TypeID: Tk2Type);
  //override;
  {-}
var
 CT : Tk2Type;
 l_Block : TevPartContainer;
begin
 if f_IsPlain then
  inherited
 else begin
  CT := CurrentType;
  if SaveInStorage(CT) then begin
   l_Block := TevPartContainer.Create(Self, CT);
   try
    if (f_Stack = nil) then
     f_Stack := Tl3ProtoObjectRefList.Make;
    f_Stack.Add(l_Block); 
    Block := l_Block;
   finally
    l3Free(l_Block);
   end;//try..finally
   if
     {$IfDef evdNeedEverestTxt}
     Binary AND
     {$EndIf evdNeedEverestTxt}
     CT.IsKindOf(k2_typDocument) then
    OutBinary;
  end else
   inherited;
 end;
end;

procedure TevCustomEvdStorageWriter.WriteLink(aBlock: TevPartContainer);
  {-}
begin
 with aBlock do begin
  if not TagType.IsKindOf(k2_typDocument) then begin
   {$IfDef evdNeedEverestTxt}
   if Binary then begin
   {$EndIf evdNeedEverestTxt}
    WriteByte(evd_pack_idLink);
    WriteByte(TagType.ID);
    WriteLong(ID);
   {$IfDef evdNeedEverestTxt}
   end else begin
    DoIndent;
    OutPropertyName(TagType, -TagType.ID);
    OutString(' -> ');
    OutString(IntToStr(ID));
    OutEOL;
   end;//Binary
   {$EndIf evdNeedEverestTxt}
  end;//not..k2_idDocument..
 end;//with aBlock
end;
  
procedure TevCustomEvdStorageWriter.DoCloseStructure(NeedUndo: Bool);
  //override;
  {-}
var
 CT : Tk2Type;
begin
 if f_IsPlain then
  inherited
 else begin
  CT := CurrentType;
  if InBlock AND CT.IsKindOf(Block.TagType) then
  begin
   with f_Stack do 
   begin
    DeleteLast;
    with Block do begin
     Storage := RootStorage; // - восстанавливаем хранилище
     Stream := PrevStream;   // - восстанавливаем поток
    end;//with Block
    WriteLink(Block);
    if Empty then
     Block := nil
    else
     Block := TevPartContainer(Last);
   end;//with f_Stack
  end else
   inherited;
 end;
end;

procedure TevCustomEvdStorageWriter.AddAtomEx(AtomIndex   : Long;
                                              const Value : Tk2Variant);
  //override;
  {-}
begin
 if f_IsPlain then
  inherited
 else if InBlock then
  Block.AddAtomEx(AtomIndex, Value)
 else
  inherited;
 {$IfDef evUseIndexBuilder}
 if not f_IsPlain AND BuildIndex AND (AtomIndex = k2_tiText) then begin
  if (Value.Kind = k2_vkString) then
   IndexBuilder.AddPara(Value.AsString);
 end;//AtomIndex = k2_tiText
 {$EndIf evUseIndexBuilder}
end;

procedure TevCustomEvdStorageWriter.OutEOL;
  //override;
  {-}
begin
 WriteBuf(cc_EOL, cc_EOL_Len);
end;

procedure TevCustomEvdStorageWriter.OutHeader;
  //override;
  {-}
begin
 if f_IsPlain then
  inherited;
end;
  
function TevCustomEvdStorageWriter.WriteBuf(B: PAnsiChar; Len: Long): Long;
  //override;
  {-}
begin
 if f_IsPlain then
  Result := inherited WriteBuf(B, Len)
 else
  Result := Stream.Write(B^, Len);
end;
  
// start class TevPartContainer

constructor TevPartContainer.Create(aWriter     : TevCustomEvdStorageWriter;
                                    const aType : Tk2Type);
  //reintroduce;
  {-}
begin
 inherited Create;
 Writer := aWriter;
 RootStorage := aWriter.Storage;
 PrevStream := aWriter.Stream;
 l3Set(f_Type, aType);
 if aType.IsKindOf(k2_typDocument) then
  ID := 0
 else
  ID := -1; 
end;

procedure TevPartContainer.Cleanup;
  //override;
  {-}
begin
 l3Free(f_Type);
 RootStorage := nil;
 PrevStream := nil;
 inherited;
end;

procedure TevPartContainer.AddAtomEx(anAtomIndex  : Long;
                             const aValue : Tk2Variant);
  {-}
var
 l_Stream  : TStream;
 l_IStream : IStream;
 l_IndexedStorage : Im3IndexedStorage;
begin
 if (ID = -1) then begin
  if (anAtomIndex = k2_tiHandle) then begin
   with aValue do begin
    Case Kind of
     k2_vkInteger :
     begin
      ID := AsInteger;
      with Writer do
      begin
       {$IfDef evdNeedEverestTxt}
       if Binary then
       {$EndIf evdNeedEverestTxt}
       begin
        if AccessByIndex then
         Storage := _OpenStorage(RootStorage, m3IndexPrefix + IntToStr(TagType.ID))
        else
         Storage := _OpenStorage(RootStorage, IntToStr(TagType.Id));
       end//Binary
       {$IfDef evdNeedEverestTxt}
       else
        Storage := _OpenStorage(RootStorage, TagType.AsString);
       if Binary then
       begin
       {$EndIf evdNeedEverestTxt}
        if AccessByIndex then
        begin
         Storage := _OpenStorage(Storage, m3IndexPrefix + IntToStr(ID));
         if l3IOk(Storage.QueryInterface(Im3IndexedStorage, l_IndexedStorage)) then
          try
           l_IndexedStorage.SetIndexParam(8, 8 * SizeOf(Byte{Tk2TypeID}));
          finally
           l_IndexedStorage := nil;
          end;//try..finally
        end//AccessByIndex
        else
         Storage := _OpenStorage(Storage, IntToStr(ID));
       {$IfDef evdNeedEverestTxt}
       end//Binary
       else
        Storage := _OpenStorage(Storage, IntToStr(ID));
       {$EndIf evdNeedEverestTxt};
//       l_IStream := _OpenStream(Storage, m3IndexPrefix + IntToStr(k2_idDocument));
       l_IStream := _OpenStream(Storage, 'main');
       try
        l3IStream2Stream(l_IStream, l_Stream);
        try
         Stream := l_Stream;
        finally
         l3Free(l_Stream);
        end;//try..finally
       finally
        l_IStream := nil;
       end;//try..finally
       {$IfDef evdNeedEverestTxt}
       if Binary then
       {$EndIf evdNeedEverestTxt}
       begin
        //WasBinary := false;
        OutBinary;
       end;//Binary
      end;//with Writer
     end;//ev_tkInteger
     else
      raise Exception.Create('Invalid identifier type');
    end;//Case Kind
   end;//with aValue
  end else
   raise Exception.Create('Identifier expected');
 end else
  Writer.WriteAtom(anAtomIndex, aValue);
end;

procedure TevPartContainer.pm_SetPrevStream(aValue: TStream);
  {-}
begin
 l3Set(f_PrevStream, aValue);
end;

end.

