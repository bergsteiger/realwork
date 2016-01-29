unit arDocObject;

{ $Id: arDocObject.pas,v 1.23 2015/04/08 11:20:16 dinishev Exp $ }

// $Log: arDocObject.pas,v $
// Revision 1.23  2015/04/08 11:20:16  dinishev
// Отъехал TK401515832. PDF определялся как JPEG-картинка.
//
// Revision 1.22  2015/04/03 13:50:21  lukyanets
// Изолируем HT
//
// Revision 1.21  2015/03/13 12:00:30  voba
// - локальное автосохранение документов
//
// Revision 1.20  2014/04/08 17:12:38  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/04/08 12:34:35  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2014/04/07 08:06:38  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.17  2014/04/07 06:57:01  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.16  2014/02/17 16:25:00  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.15  2014/02/13 10:12:54  lulin
// - рефакторим безликие списки.
//
// Revision 1.14  2013/10/23 12:25:56  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.13  2013/10/21 17:30:50  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.12  2013/10/21 15:42:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.11  2013/10/21 10:30:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.10  2013/10/18 15:38:39  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.9  2012/10/16 08:38:24  fireton
// - дополнительно анализируем файл объекта
//
// Revision 1.8  2011/01/28 11:46:08  voba
// - k : 251343383
//
// Revision 1.7  2009/09/02 14:31:21  lulin
// {RequestLink:161122154}.
//
// Revision 1.6  2009/07/20 12:50:37  lulin
// - подготавливаемся к переносу изменений в ветку.
//
// Revision 1.5  2009/06/25 07:49:34  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.4  2009/03/04 16:25:58  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.3  2008/10/22 08:36:11  fireton
// - bugfix: если данных не было, то их пытались записать (с AV)
//
// Revision 1.2  2008/10/17 13:25:29  fireton
// - возможность присоединения образов-некартинок
//
// Revision 1.1  2008/08/29 13:05:19  fireton
// - выделение объекта в документе в отдельную структуру
// - flash-топики теперь имеют текст, как обычные документы
//

interface

uses
 Classes,
 Windows,
 Graphics,
 SysUtils,

 //модули imageEn
 hyieutils,

 l3Types,
 l3Interfaces,
 l3InternalInterfaces,
 l3Base,
 l3ChangeNotifier,
 l3Memory,
 l3Variant,

 k2Types,
 k2Interfaces,
 k2TagGen,
 k2TagFilter,

 evdBufferedFilter,
 nevTools,

 //ddObjProxyStream,

 DT_Types
 ;

type
 TarDocObjectType = (dotImage, dotFlash, dotOther);

 TarDocObject = class(Tl3ChangeNotifier)
 private
  f_Data: Tl3SizedMemoryPool;
  f_ObjType: TarDocObjectType;
  f_StreamHandle: Integer;
  //f_Bitmap: Il3Bitmap;
  f_DocFamily: TFamilyID;
  //f_DocID    : TDocID;
  f_DocContainer : InevDocumentContainer;

  function BuildObjectIcon: TBitmap;

  function  pm_GetFilePath : TPathStr;
  procedure pm_SetFilePath(const aValue: TPathStr);

  procedure pm_SetObjType(const aValue: TarDocObjectType);

  function  pm_GetDataStream : IStream;
  procedure pm_SetDataStream(aDataStream : IStream);

  function  pm_GetDocument : Tl3Variant;
  function  pm_GetPara : Tl3Variant;

  function  GetParaType(aObjType : TarDocObjectType) : Tl3VariantDef;
 protected
  procedure Cleanup; override;
 public
  constructor Create(aDocContainer : InevDocumentContainer);
  procedure LoadFromFile(const aSrcFileName : TFileName);
  procedure ExportToFile(const aFileName: TFileName);
  //procedure PlaceToDoc(aTagGen: Ik2TagGenerator);
  procedure BitmapAssignTo(aDestBitmap : TIEBitmap);
  procedure PasteFromClipboard;
  function  MakePara : Tl3Variant;

  property FilePath: TPathStr read pm_GetFilePath write pm_SetFilePath;
  property ObjType: TarDocObjectType read f_ObjType write pm_SetObjType;
  property StreamHandle: Integer read f_StreamHandle write f_StreamHandle;
  property DataStream : IStream read pm_GetDataStream write pm_SetDataStream;
  property Document: Tl3Variant read pm_GetDocument;
  property Para : Tl3Variant read pm_GetPara;
 end;

 // "Подкладывает" доп поток с "картинкой" в evd-поток
 TarDocObjectMixer = class(Tk2TagFilter)
 private
  fDocId      : TDocID;
  fDataHandle : Integer;
  fProcessed  : boolean;
 protected
        {-}
  procedure AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
  procedure DoCloseStructure(NeedUndo: Boolean); override;
 public
  {* - создает экземпляр класа и цепляет его к генератору. }
  //class function SetTo(var theGenerator: Tk2TagGenerator; aDocObject: TarDocObject): Tk2TagGenerator; overload;
  //property DocObject: TarDocObject read f_DocObject write f_DocObject;
 end;


// Новая схема хранения объектов в текстовых документах
 (*
 TarObject_CheckExtNumber = class(TevdBufferedFilter)
 {*- реализует выдачу внешнего номера для всех объектов в доке}
 //private
 // f_DocID: Integer;
 protected
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
  function NeedStartBuffering(aID : Integer): Boolean; override;
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
 public
  //procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
        {-}
  //class function SetTo(var theGenerator: Tk2TagGenerator; aDocID: Integer): Pointer; overload;
  //property DocID: Integer read f_DocID write f_DocID;
 end;
 *)
 
(*
TarObject_PasteFilter = class(Tk2TagFilter)
{*- реализует срезание внешнего номера для всех объектов вставляемых в док}
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 end;
*)
implementation
uses
 Types,
 l3Stream,
 l3ShellUtils,
 l3BitmapContainer,
 l3IEBitmapContainer,
 l3InterfacedComponent,
 l3GraphicContainer,
 l3Clipboard,

 k2Tags,
 k2SizedMemoryPool,
 k2InPlaceGenerator,

 m3StorageInterfaces,

 evBitmapReader,

 DT_Const,
 DT_Serv,

 ddFileFormats,

 imageenio,

 arImageUtils,

 ExtDataPara_Const,
 BitmapPara_Const,
 Document_Const
 ;

constructor TarDocObject.Create(aDocContainer : InevDocumentContainer);
begin
 inherited Create{(nil)};

 f_DocContainer := aDocContainer;

 if (Document.ChildrenCount > 0) and (Para.IsKindOf(k2_typBitMapPara)) then
  ObjType := dotImage
 else
  ObjType := dotOther;
end;

procedure TarDocObject.Cleanup;
begin
 l3Free(f_Data);
 inherited;
end;

function  TarDocObject.pm_GetDocument : Tl3Variant;
begin
 Result := f_DocContainer.ExistingDocument.AsObject;
end;

function TarDocObject.pm_GetPara : Tl3Variant;
begin
 if (Document.ChildrenCount > 0) then
  Result := Document.Child[0]
 else
  Result := nil;
end;


function TarDocObject.GetParaType(aObjType : TarDocObjectType) : Tl3VariantDef;
begin
 if aObjType = dotImage then
  Result := k2_typBitMapPara
 else
  Result := k2_typExtDataPara;
end;

function TarDocObject.MakePara : Tl3Variant;
var
 lTag : Il3TagRef;
begin
 if (Document.ChildrenCount < 0) then
 begin
  lTag := GetParaType(ObjType).MakeTag;
  Document.AddChild(lTag.AsObject);
 end;
 Result := Document.Child[0];
end;

function TarDocObject.pm_GetFilePath : TPathStr;
begin
 Result := Para.Attr[k2_tiExternalPath].AsString;
end;

function TarDocObject.BuildObjectIcon: TBitmap;
begin
 Result := BuildFileIcon(FilePath);
end;

procedure TarDocObject.pm_SetFilePath(const aValue: TPathStr);
begin
 if not AnsiSameText(FilePath, aValue) then
 begin
  Changing;
   MakePara.StrA[k2_tiExternalPath] := aValue;
  Changed;
 end;
end;

procedure TarDocObject.pm_SetObjType(const aValue: TarDocObjectType);
var
 lTag : Il3TagRef;
begin
 if f_ObjType <> aValue then
 begin
  f_ObjType := aValue;
  if (Document.ChildrenCount > 0) then
  begin
   if Document.Child[0].TagType <> GetParaType(f_ObjType) then
   begin
    lTag := GetParaType(ObjType).MakeTag;
    lTag.AsObject.AssignTag(Document.Child[0]);
    Document.DeleteChildren(nil);
    Document.AddChild(lTag.AsObject);
   end;
  end;
 end;
end;

function  TarDocObject.pm_GetDataStream : IStream;
begin
 if (Para = nil) or not Para.Attr[k2_tiData].IsStream(Result) then
  Result := nil;
end;

procedure TarDocObject.pm_SetDataStream(aDataStream : IStream);
var
 lStream : Tk2SizedMemoryPool;

 l_Read      : Large;
 l_Written   : Large;
 l_Position  : Large;
begin
 Changing;
 try
  if (aDataStream = nil) then
  begin
   if Para <> nil then Para.AttrW[k2_tiData, nil] := nil
  end
  else
  begin
   lStream := Tk2SizedMemoryPool.Create;
   try
    aDataStream.Seek(0, STREAM_SEEK_SET, l_Position);
    aDataStream.CopyTo(lStream as IStream, High(Large), l_Read, l_Written);
    MakePara.AttrW[k2_tiData, nil] := lStream;
   finally
    l3Free(lStream);
   end;
  end;
 finally
  Changed;
 end;
end;

procedure TarDocObject.PasteFromClipboard;
var
 l_BitmapHandle : THandle;
 l_BitmapReader : TevBitmapHandleReader;
 l_Point        : IUnknown;
 l_Para         : InevObject;
 l_G            : Tk2InPlaceGenerator;

begin
 //if fDocClass = dtFlash then Exit;
 if IsClipboardFormatAvailable(cf_Bitmap) and OpenClipboard(0) then
 try
  l_BitmapHandle := GetClipboardData(cf_Bitmap);
  l_BitmapReader := TevBitmapHandleReader.Make(l_BitmapHandle);
  try
   //with Document.TextSource do
   begin
    if (Document.ChildrenCount > 0) then
    begin
     l_G := Tk2InPlaceGenerator.Make(Para);
     try
      l_BitmapReader.NeedOpenDocument := false;
      l_Point := l_G;
     finally
      l3Free(l_G);
     end;//try..finally
    end
    else
    begin
     if not Document.QT(InevObject, l_Para) then
      Assert(false);
     l_Point := l_Para.MakePoint;
    end;//Document.ChildrenCount > 0

    f_DocContainer.TagWriter.WriteTagEx(nil, l_BitmapReader, l_Point);
   end;{with Document.TextSource}
  finally
   l3Free(l_BitmapReader);
  end;{try..finally}
 finally
  CloseClipboard;
 end;{try..finally}
end;

procedure TarDocObject.BitmapAssignTo(aDestBitmap : TIEBitmap);
var
 l_Bmp    : TBitmap;
 l_IEBmp  : TIEBitmap;
 l_IO     : TImageEnIO;
 l_Stream : TStream;
 l_Bitmap : Il3Bitmap;
begin
 l_Bitmap := nil;
 case ObjType of
  dotImage:
   begin
    if DataStream = nil then
     Exit;

    l_IEBmp := TIEBitmap.Create;
    try
     l_IO := TImageEnIO.CreateX;
     try
      l3IStream2Stream(DataStream, l_Stream);
      try
       l_IO.IEBitmap := l_IEBmp;
       l_IO.LoadFromStream(l_Stream);

       aDestBitmap.Assign(l_IEBmp);
       //l_Bitmap := Tl3IEBitmapContainer.Make;
       //l_Bitmap.Assign(l_IEBmp);
      finally
       l3Free(l_Stream);
      end;
     finally
      l3Free(l_IO);
     end;
    finally
     l3Free(l_IEBmp);
    end;
   end;

  dotFlash: ;
  dotOther:
   begin
    if FilePath = '' then
     Exit;
    l_Bmp := BuildObjectIcon;
    try
     aDestBitmap.Assign(l_Bmp);
     //l_Bitmap := Tl3BitmapContainer.Make;
     //l_Bitmap.Assign(l_Bmp);
    finally
     l3Free(l_Bmp);
    end;
   end;
 end;
end;

procedure TarDocObject.LoadFromFile(const aSrcFileName : TFileName);
var
 lStream    : Tl3FileStream;
 lType : TarDocObjectType;

 function CalcType : TarDocObjectType;
 var
  l_DocFormat  : TddFileFormat;
  l_ImageFormat: TIOFileType;
 begin
  l_ImageFormat := FindStreamFormat(lStream);
  if l_ImageFormat <> ioUnknown then
  begin
   if l_ImageFormat = ioJPEG then // JPEG ли это?
   begin
    l_DocFormat := ddGetFileFormat(lStream);
    if l_DocFormat = ffUnknown then
     Result := dotImage
    else
     Result := dotOther;
   end // if l_ImageFormat = ioJPEG then // JPEG ли это?
   else
    Result := dotImage;
  end // if l_ImageFormat <> ioUnknown then
  else
   if ddGetFileFormat(lStream) = ffFlash then
    Result := dotFlash
   else
    Result := dotOther;
 end;

begin
 lStream := Tl3FileStream.Create(aSrcFileName, l3_fmRead);
 try
  lType := CalcType;
  if ObjType <> lType then
   if ObjType = dotFlash then
    Exit // Другой тип документа, так менять нельзя
   else
    ObjType := lType;

   DataStream := lStream as IStream;
 finally
  l3Free(lStream);
 end;

 if FilePath = '' then
   FilePath := ExtractFileName(aSrcFileName);
end;

procedure TarDocObject.ExportToFile(const aFileName: TFileName);
var
 lStream: Tl3FileStream;

 l_Read      : Large;
 l_Written   : Large;
 l_Position  : Large;

begin
 if DataStream = nil then
  Exit;

 lStream := Tl3FileStream.Create(aFileName, l3_fmCreateReadWrite);
 try
  //DataStream.Seek(0, STREAM_SEEK_SET, l_Position);
  DataStream.CopyTo(lStream as IStream, High(Large), l_Read, l_Written);
 finally
  l3Free(lStream);
 end;
end;

{TarDocObjectMixer}
procedure TarDocObjectMixer.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
begin
 if TopType[0].IsKindOf(k2_typDocument) then {заполнение элементарных полей документа}
 begin
  if (AtomIndex = k2_tiInternalHandle) then
   fDocID := TDocID(Value.AsInteger);
 end
 else
  if TopType[0].IsKindOf([k2_typBitMapPara, k2_typExtDataPara]) then
  begin
   if (AtomIndex = k2_tiData) then
    fProcessed := True;

   if (AtomIndex = k2_tiInternalHandle) then
    fDataHandle := Value.AsInteger;
  end;
 Inherited;
end;

procedure TarDocObjectMixer.DoCloseStructure(NeedUndo: Boolean);
  //virtual;
  {-вызывается на закрывающуюся скобку}
 procedure lStreamLoad;
 var
  l_IStream : IStream;
  l_Stream  : TStream;

 begin
  l_IStream := dtGetObjectStream(CurrentFamily, fDocID, fDataHandle, m3_saRead);

  l3IStream2Stream(l_IStream, l_Stream);
  try
   AddStreamAtom(k2_tiData, l_Stream);
  finally
   l3Free(l_Stream);
  end;
 end;

begin
 if not fProcessed and CurrentType.IsKindOf([k2_typBitMapPara, k2_typExtDataPara]) then
 begin
  lStreamLoad;
  fProcessed := True;
 end
 else
 if not fProcessed and CurrentType.IsKindOf(k2_typDocument) then
 begin
  {if DocObject.ObjType = dotImage then
   StartChild(k2_typBitmapPara)
  else}
   StartChild(k2_typExtDataPara);
  try
   lStreamLoad;
  finally
   Finish;
  end;
 end;
 inherited;
end;

{TarObject_CheckExtNumber}
(*function TarObject_CheckExtNumber.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
 Result := (aTagID = -k2_idExtDataPara) or (aTagID = -k2_idBitmapPara);
end;

function TarObject_CheckExtNumber.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := (aID = -k2_idExtDataPara) or (aID = -k2_idBitmapPara);
// if Result then
//  fExtHandlePresent := False;
end;

procedure TarObject_CheckExtNumber.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
begin
 if aLeaf.IntA[k2_tiExternalHandle] = 0 then
  aLeaf.IntA[k2_tiExternalHandle] := GlobalDataProvider.GetFreeExtObjID(CurrentFamily);
 Inherited;
end;
*)

(*
{TarObject_PasteFilter}
procedure TarObject_PasteFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if not (((AtomIndex = k2_tiExternalHandle) or (AtomIndex = k2_tiInternalHandle)) and
         (CurrentType.IsKindOf([k2_typBitMapPara, k2_typExtDataPara]))) then
  inherited;
end;
*)
end.
