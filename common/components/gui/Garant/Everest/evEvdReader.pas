unit evEvdReader;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evEvdReader -   }
{ Начат: 23.10.2001 12:29 }
{ $Id: evEvdReader.pas,v 1.24 2013/10/18 14:11:22 lulin Exp $ }

// $Log: evEvdReader.pas,v $
// Revision 1.24  2013/10/18 14:11:22  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.23  2013/04/05 12:02:15  lulin
// - портируем.
//
// Revision 1.22  2009/03/04 16:58:50  lulin
// - <K>: 137470629. Bug fix: не собиралась библиотека.
//
// Revision 1.21  2008/06/20 10:07:44  lulin
// - <K>: 94733082.
//
// Revision 1.20  2008/03/07 15:53:32  lulin
// - <K>: 86477888.
//
// Revision 1.19  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.2  2007/08/29 14:26:59  lulin
// - пакуем EVD-теги - вместо слова, пишем байт.
//
// Revision 1.1  2007/08/29 11:10:00  lulin
// - файлы переехали в общую папку.
//
// Revision 1.15.20.3  2007/08/29 08:30:12  lulin
// - не собиралась библиотека.
//
// Revision 1.15.20.2  2007/08/28 14:03:37  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.15.20.1  2005/06/23 12:55:33  lulin
// - файл с константами переехал в папку EVD.
//
// Revision 1.15  2004/09/21 12:55:40  lulin
// - Release заменил на Cleanup.
//
// Revision 1.14  2004/06/10 13:04:39  law
// - new property: TevCustomEvdStorageWriter.AccessByIndex.
//
// Revision 1.13  2002/01/29 14:49:37  law
// - test: попытки переименования потока main, которые ни к чему хорошему (ни по скорости, ни по размеру) не привели.
//
// Revision 1.12  2002/01/29 12:52:41  law
// - bug fix: убрано разрастание занимаемой памяти (надо внимательно подумать почему это так было).
//
// Revision 1.11  2002/01/28 13:01:25  law
// - new behavior: обходимся без исключительных ситуаций.
//
// Revision 1.10  2002/01/24 16:30:24  law
// - new behavior: сделан доступ по индексу к элементам хранилища.
//
// Revision 1.9  2002/01/11 13:56:51  law
// - added ToDo item.
//
// Revision 1.8  2001/11/28 14:19:30  law
// - new behavior: сделано создание хранилищ с автоматической паковкой.
//
// Revision 1.7  2001/10/29 13:31:02  law
// - cleanup: убраны ссылки на ComObj.
//
// Revision 1.6  2001/10/29 13:03:17  law
// - cleanup: try to optimize.
//
// Revision 1.5  2001/10/24 07:03:34  law
// - bug fix: не освобождался IStorage после чтения документа из него.
//
// Revision 1.4  2001/10/23 15:22:34  law
// - new behavior: сделано чтение evd из IStream.
//
// Revision 1.3  2001/10/23 10:30:51  law
// - new behavior: затачиваем для чтения из структурированного хранилища.
//
// Revision 1.2  2001/10/23 09:29:10  law
// - bug fix: не читались текстовые evd-файлы.
//
// Revision 1.1  2001/10/23 09:02:47  law
// - new unit: evEvdReader.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  ActiveX,

  l3Types,
  l3Base,
  l3Filer,

  evdReader,

  evEvdRd
  ;

type
  TevCustomEvdStorageReader = class(TevCustomEvdReader)
   {* Читатель тегов в формате evd из структурированного хранилища (IStorage). }
    private
    // property fields
      f_Storage : IStorage;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure CheckStorage(aFiler: Tl3CustomFiler);
        {-}
      procedure ConvertAfterSymbol(const aName: AnsiString; IsChild: Bool);
        override;
        {-}
      procedure ReadBlock(const aBlockType : AnsiString;
                                aBlockID   : Long);
        {-}                        
      function  PreProcessTypeID(const aTypeID: TevdAtomID): Bool;
        override;
        {-}
      function  PreProcessNewTypeID(const aTypeID: TevdNewAtomID): Bool;
        override;
        {-}
    public
    // public methods
      procedure Read;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-}
    public
    // public properties
      property Storage: IStorage
        read f_Storage
        write f_Storage;
        {-}
  end;//TevCustomEvdStorageReader

  TevEvdStorageReader = class(TevCustomEvdStorageReader)
   {*! Читатель тегов в формате evd (с published свойствами). }
    published
      property Filer;
        {-}
      property Generator;
        {-}
      property TextParser;
        {-}
  end;//TevEvdStorageReader

implementation

uses
  SysUtils,
  Classes,
  ComObj,

  l3Chars,
  l3InternalInterfaces,
  l3Parser,
  l3Stream,

  k2Tags,

  evdConst,

  m2COMLib,

  m3Const,
  m3ArcMgr,

  Document_Const
  ;

function _OpenStorage(const aStorage : IStorage;
                      const aName    : WideString): IStorage;
begin
 Result := m2COMOpenStorage(aStorage,
                            PWideChar(aName),
                            STGM_READ or STGM_SHARE_EXCLUSIVE,
                            false);
end;

function _OpenStream(const aStorage : IStorage;
                     const aName    : WideString): IStream;
begin
 Result := m2COMOpenStream(aStorage,
                           PWideChar(aName),
                           STGM_READ or STGM_SHARE_EXCLUSIVE,
                           false);
end;

// start class TevCustomEvdStorageReader

procedure TevCustomEvdStorageReader.Cleanup;
  //override;
  {-}
begin
 Storage := nil;
 inherited;
end;

procedure TevCustomEvdStorageReader.CheckStorage(aFiler: Tl3CustomFiler);
  {-}
var
 l_StorageSource : Il3StorageSource;
begin
 if (aFiler <> nil) AND
    Supports(aFiler, Il3StorageSource, l_StorageSource) then
  try
   Storage := l_StorageSource.Storage;
  finally
   l_StorageSource := nil;
  end//try..finally
 else
  Storage := nil;
end;

procedure TevCustomEvdStorageReader.Read;
  //override;
  {-}
begin
 CheckStorage(Filer);
 if (Storage = nil) then
  inherited
 else begin
  StartChild(k2_typDocument); 
{ TODO -oЛюлин А. В. -cНедоделка : Начало документа и его тип пока никуда не пишутся }
  try
   inherited;
  finally
   SafeFinish(false);
  end;//try..finally
 end;//Storage = nil
end;

procedure TevCustomEvdStorageReader.CloseStream(NeedUndo: Bool);
  //override;
  {-}
begin
 inherited;
 Storage := nil;
end;

procedure TevCustomEvdStorageReader.ReadBlock(const aBlockType : AnsiString;
                                              aBlockID   : Long);
  {-}
var
 l_OldFiler   : Tl3CustomFiler;
 l_OldParser  : Tl3CustomParser;
 l_Parser     : Tl3CustomParser;
 l_OldStorage : IStorage;
 l_Stream     : TStream;
 l_OldBinary  : Bool;
 l_OldForceBinary : Bool;
begin
 AddIntegerAtom(k2_tiHandle, aBlockID);
 l_OldBinary := Binary;
 try
  l_OldFiler := Self.Filer.Use;
  try
   l_OldParser := Parser.Use;
   try
    l_OldStorage := Storage;
    try
     l_Parser := Tl3CustomParser.Create;
     try
      l_Parser.Assign(Parser);
      l_Parser.Filer := nil;
      try
       Storage := _OpenStorage(Storage, m3IndexPrefix+aBlockType);
      except
       Storage := _OpenStorage(Storage, aBlockType);
      end;//try..except
      try
       Storage := _OpenStorage(Storage, m3IndexPrefix+IntToStr(aBlockID));
      except
       Storage := _OpenStorage(Storage, IntToStr(aBlockID));
      end;//try..except
//      try
//       l3IStream2Stream(_OpenStream(Storage, m3IndexPrefix + IntToStr(k2_idDocument)), l_Stream);
//      except
       l3IStream2Stream(_OpenStream(Storage, 'main'), l_Stream);
//      end;//try..except
      try
       l_Parser.Filer.Stream := l_Stream;
      finally
       l3Free(l_Stream);
      end;//try..finally
      Parser := l_Parser;
      Self.Filer := l_Parser.Filer;
     finally
      l3Free(l_Parser);
     end;//try..finally
     l_OldForceBinary := f_ForceBinary;
     try
      if Binary then
       f_ForceBinary := true;
      inherited Read;
     finally
      f_ForceBinary := l_OldForceBinary;
     end;//try..finally
    finally
     Storage := l_OldStorage;
     l_OldStorage := nil;
    end;//try..finally
   finally
    Parser := l_OldParser;
    l3Free(l_OldParser);
   end;//try..finally
  finally
   Self.Filer := l_OldFiler;
   l3Free(l_OldFiler);
  end;//try..finally
 finally
  Binary := l_OldBinary;
 end;//try..finally
end;

procedure TevCustomEvdStorageReader.ConvertAfterSymbol(const aName: AnsiString; IsChild: Bool);
  //override;
  {-}
begin
 with Parser do
  if (TokenChar = cc_Minus) then begin
   NextToken;
   CheckTokenChar('>');
   // - это ссылка
   NextToken;
   StartObject(GetObjectID(aName, IsChild));
   try
    ReadBlock(aName, TokenInt);
   finally
    SafeFinish;
   end;//try..finally
   NextToken;
  end else
   inherited;
end;

function TevCustomEvdStorageReader.PreProcessTypeID(const aTypeID: TevdAtomID): Bool;
  //override;
  {-}
var
 l_TypeID : Word;
 l_F      : Tl3CustomFiler;
begin
 Result := inherited PreProcessTypeID(aTypeID);
 if not Result then begin
  if (aTypeID.rID = unpack_idLink) then
  begin
   // - разбираем ссылку
   l_F := Filer;
   l_TypeID := l_F.ReadWord;
   StartChild(TypeTable.TypeByHandle[l_TypeID]);
   try
    ReadBlock(IntToStr(l_TypeID), l_F.ReadLong);
   finally
    SafeFinish;
   end;//try..finally
   Result := true;
  end;//aTypeID.rID
 end;//Result
end;

function TevCustomEvdStorageReader.PreProcessNewTypeID(const aTypeID: TevdNewAtomID): Bool;
  //override;
  {-}
var
 l_TypeID : Byte;
 l_F      : Tl3CustomFiler;
begin
 Result := inherited PreProcessNewTypeID(aTypeID);
 if not Result then begin
  if (aTypeID.rID = evd_pack_idLink) then
  begin
   // - разбираем ссылку
   l_F := Filer;
   l_TypeID := l_F.ReadByte;
   StartChild(TypeTable.TypeByHandle[l_TypeID]);
   try
    ReadBlock(IntToStr(l_TypeID), l_F.ReadLong);
   finally
    SafeFinish;
   end;//try..finally
   Result := true;
  end;//aTypeID.rID
 end;//Result
end;

end.

