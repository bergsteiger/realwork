unit evPersistentDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evPersistentDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevPersistentDataObject" MUID: (48F4732803C8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Memory
 , l3Interfaces
 , evdInterfaces
 , nevTools
 , nevBase
 , l3Core
 , l3IID
 , evDataObject
;

type
 RevDataObject = class of TevDataObject;

 TevPersistentDataObject = class(Tl3MemoryStream, Il3DataObjectInfo, IevdDataObject, InevDataObjectPrim2)
  private
   f_TagStorageR: InevTagReader;
   f_TagStorageW: InevTagWriter;
   f_Formats: Tl3ClipboardFormats;
   f_SameFormat: Boolean;
   f_Format: Tl3ClipboardFormat;
  protected
   function DataObjectClass: RevDataObject; virtual;
   function Sharp: Boolean; virtual;
   function GetIsQuestionNeedBeforeFlush: Boolean; virtual;
   function DoStore(aFormat: TnevFormat;
    const aPool: IStream;
    const aFilters: InevTagGenerator;
    aFlags: TevdStoreFlags): Boolean; virtual;
   function pm_GetIsQuestionNeedBeforeFlush: Boolean;
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload;
    {* сохраняет выделение в G. }
   function Store(aFormat: TevdClipboardFormat;
    const aPool: IStream;
    const aFilters: TevdTagGenerator;
    aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean; overload;
    {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
   function pm_GetBorders: TevPair;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* метод для реализации QueryInterface (Для перекрытия в потомках) }
  public
   constructor Create(const aBlock: IevdDataObject;
    anInternal: Boolean;
    aFormat: Tl3ClipboardFormat;
    const aTagStorageR: InevTagReader;
    const aTagStorageW: InevTagWriter;
    const aFormats: Tl3ClipboardFormats;
    const aFilters: InevTagGenerator); reintroduce; overload;
   constructor Create(aData: THandle;
    aFormat: Tl3ClipboardFormat;
    const aTagStorageR: InevTagReader;
    const aTagStorageW: InevTagWriter;
    const aFormats: Tl3ClipboardFormats); reintroduce; overload;
   class function Make(const aBlock: IevdDataObject;
    anInternal: Boolean;
    aFormat: Tl3ClipboardFormat;
    const aTagStorageR: InevTagReader;
    const aTagStorageW: InevTagWriter;
    const aFormats: Tl3ClipboardFormats;
    const aFilters: InevTagGenerator): InevDataObjectPrim2; reintroduce; overload;
   class function Make(aData: THandle;
    aFormat: Tl3ClipboardFormat;
    const aTagStorageR: InevTagReader;
    const aTagStorageW: InevTagWriter;
    const aFormats: Tl3ClipboardFormats): InevDataObjectPrim2; reintroduce; overload;
  protected
   property Format: Tl3ClipboardFormat
    read f_Format;
 end;//TevPersistentDataObject

implementation

uses
 l3ImplUses
 , k2InternalInterfaces
 , SysUtils
 , l3Base
 , l3Stream
 , Classes
 //#UC START# *48F4732803C8impl_uses*
 //#UC END# *48F4732803C8impl_uses*
;

constructor TevPersistentDataObject.Create(const aBlock: IevdDataObject;
 anInternal: Boolean;
 aFormat: Tl3ClipboardFormat;
 const aTagStorageR: InevTagReader;
 const aTagStorageW: InevTagWriter;
 const aFormats: Tl3ClipboardFormats;
 const aFilters: InevTagGenerator);
//#UC START# *48F475A20016_48F4732803C8_var*
//#UC END# *48F475A20016_48F4732803C8_var*
begin
//#UC START# *48F475A20016_48F4732803C8_impl*
 inherited Make(Sharp);
 f_Format := aFormat;
 f_Formats := aFormats;
 f_TagStorageR := aTagStorageR;
 f_TagStorageW := aTagStorageW;
 if (aBlock <> nil) then
  if anInternal then
   aBlock.Store(f_Format, Self, aFilters, evDefaultStoreFlags + [evd_sfInternal])
  else
   aBlock.Store(f_Format, Self, aFilters, evDefaultStoreFlags - [evd_sfInternal]);
//#UC END# *48F475A20016_48F4732803C8_impl*
end;//TevPersistentDataObject.Create

constructor TevPersistentDataObject.Create(aData: THandle;
 aFormat: Tl3ClipboardFormat;
 const aTagStorageR: InevTagReader;
 const aTagStorageW: InevTagWriter;
 const aFormats: Tl3ClipboardFormats);
//#UC START# *48F4764A01A0_48F4732803C8_var*
//#UC END# *48F4764A01A0_48F4732803C8_var*
begin
//#UC START# *48F4764A01A0_48F4732803C8_impl*
 inherited Make(Sharp);
 f_Format := aFormat;
 f_Formats := aFormats;
 f_TagStorageR := aTagStorageR;
 f_TagStorageW := aTagStorageW;
 MemoryPool.AsHandle := aData;
//#UC END# *48F4764A01A0_48F4732803C8_impl*
end;//TevPersistentDataObject.Create

class function TevPersistentDataObject.Make(const aBlock: IevdDataObject;
 anInternal: Boolean;
 aFormat: Tl3ClipboardFormat;
 const aTagStorageR: InevTagReader;
 const aTagStorageW: InevTagWriter;
 const aFormats: Tl3ClipboardFormats;
 const aFilters: InevTagGenerator): InevDataObjectPrim2;
var
 l_Inst : TevPersistentDataObject;
begin
 l_Inst := Create(aBlock, anInternal, aFormat, aTagStorageR, aTagStorageW, aFormats, aFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevPersistentDataObject.Make

class function TevPersistentDataObject.Make(aData: THandle;
 aFormat: Tl3ClipboardFormat;
 const aTagStorageR: InevTagReader;
 const aTagStorageW: InevTagWriter;
 const aFormats: Tl3ClipboardFormats): InevDataObjectPrim2;
var
 l_Inst : TevPersistentDataObject;
begin
 l_Inst := Create(aData, aFormat, aTagStorageR, aTagStorageW, aFormats);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevPersistentDataObject.Make

function TevPersistentDataObject.DataObjectClass: RevDataObject;
//#UC START# *48F4795901B5_48F4732803C8_var*
//#UC END# *48F4795901B5_48F4732803C8_var*
begin
//#UC START# *48F4795901B5_48F4732803C8_impl*
 Result := TevDataObject;
//#UC END# *48F4795901B5_48F4732803C8_impl*
end;//TevPersistentDataObject.DataObjectClass

function TevPersistentDataObject.Sharp: Boolean;
//#UC START# *48F479680376_48F4732803C8_var*
//#UC END# *48F479680376_48F4732803C8_var*
begin
//#UC START# *48F479680376_48F4732803C8_impl*
 Result := false;
//#UC END# *48F479680376_48F4732803C8_impl*
end;//TevPersistentDataObject.Sharp

function TevPersistentDataObject.GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *48F4818300A5_48F4732803C8_var*
//#UC END# *48F4818300A5_48F4732803C8_var*
begin
//#UC START# *48F4818300A5_48F4732803C8_impl*
 Result := (Size >= 512 * 1024);
//#UC END# *48F4818300A5_48F4732803C8_impl*
end;//TevPersistentDataObject.GetIsQuestionNeedBeforeFlush

function TevPersistentDataObject.DoStore(aFormat: TnevFormat;
 const aPool: IStream;
 const aFilters: InevTagGenerator;
 aFlags: TevdStoreFlags): Boolean;
//#UC START# *48F481B6035B_48F4732803C8_var*
//#UC END# *48F481B6035B_48F4732803C8_var*
begin
//#UC START# *48F481B6035B_48F4732803C8_impl*
 f_SameFormat := (aFormat = f_Format);
 Result := (f_TagStorageR.ReadTag(aFormat, aPool, aFilters, Self, aFlags) > 0);
//#UC END# *48F481B6035B_48F4732803C8_impl*
end;//TevPersistentDataObject.DoStore

function TevPersistentDataObject.pm_GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *4680FC190114_48F4732803C8get_var*
//#UC END# *4680FC190114_48F4732803C8get_var*
begin
//#UC START# *4680FC190114_48F4732803C8get_impl*
 Result := GetIsQuestionNeedBeforeFlush;
//#UC END# *4680FC190114_48F4732803C8get_impl*
end;//TevPersistentDataObject.pm_GetIsQuestionNeedBeforeFlush

procedure TevPersistentDataObject.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evDefaultStoreFlags);
 {* сохраняет выделение в G. }
//#UC START# *47C68BFD011C_48F4732803C8_var*
var
 l_FilerSource : Ik2FilerSource;
//#UC END# *47C68BFD011C_48F4732803C8_var*
begin
//#UC START# *47C68BFD011C_48F4732803C8_impl*
 Position := 0;
 if f_SameFormat AND Supports(G, Ik2FilerSource, l_FilerSource) then
  try
   with l_FilerSource.Filer do
   begin
    Seek(0, soBeginning);
    l3CopyStream(Self, Stream);
   end;//with l_FilerSource.Filer
  finally
   l_FilerSource := nil;
  end//try..finally
 else
 if (f_TagStorageW <> nil) then
  f_TagStorageW.WriteTag(aView, f_Format, Self, G, [ev_lfInternal])
//#UC END# *47C68BFD011C_48F4732803C8_impl*
end;//TevPersistentDataObject.Store

function TevPersistentDataObject.Store(aFormat: TevdClipboardFormat;
 const aPool: IStream;
 const aFilters: TevdTagGenerator;
 aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean;
 {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
//#UC START# *47C68C6701AF_48F4732803C8_var*
//#UC END# *47C68C6701AF_48F4732803C8_var*
begin
//#UC START# *47C68C6701AF_48F4732803C8_impl*
 Result := DoStore(aFormat, aPool, aFilters, aFlags);
//#UC END# *47C68C6701AF_48F4732803C8_impl*
end;//TevPersistentDataObject.Store

function TevPersistentDataObject.pm_GetBorders: TevPair;
//#UC START# *47C6962E028E_48F4732803C8get_var*
//#UC END# *47C6962E028E_48F4732803C8get_var*
begin
//#UC START# *47C6962E028E_48F4732803C8get_impl*
 Result.rStart := 0;
 Result.rFinish := Pred(High(Integer));
//#UC END# *47C6962E028E_48F4732803C8get_impl*
end;//TevPersistentDataObject.pm_GetBorders

procedure TevPersistentDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F4732803C8_var*
//#UC END# *479731C50290_48F4732803C8_var*
begin
//#UC START# *479731C50290_48F4732803C8_impl*
 f_TagStorageR := nil;
 f_TagStorageW := nil;
 f_Formats := nil;
 inherited;
//#UC END# *479731C50290_48F4732803C8_impl*
end;//TevPersistentDataObject.Cleanup

function TevPersistentDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* метод для реализации QueryInterface (Для перекрытия в потомках) }
//#UC START# *48F475350256_48F4732803C8_var*
var
 l_DataObject : TevDataObject;
//#UC END# *48F475350256_48F4732803C8_var*
begin
//#UC START# *48F475350256_48F4732803C8_impl*
 Result.SetOk;
 if IID.EQ(IDataObject) then
 begin
  l_DataObject := DataObjectClass.Create(Self, f_Formats, nil);
  try
   IDataObject(Obj) := l_DataObject;
  finally
   l3Free(l_DataObject);
  end;//try..finally
 end
 else
 if IID.EQ(InevTagReader) then
  InevTagReader(Obj) := f_TagStorageR
 else
 if IID.EQ(InevTagWriter) then
  InevTagWriter(Obj) := f_TagStorageW
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *48F475350256_48F4732803C8_impl*
end;//TevPersistentDataObject.COMQueryInterface

end.
