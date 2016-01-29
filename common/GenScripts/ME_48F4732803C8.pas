unit evPersistentDataObject;

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
  procedure Create(const aBlock: IevdDataObject;
   anInternal: Boolean;
   aFormat: Tl3ClipboardFormat;
   const aTagStorageR: InevTagReader;
   const aTagStorageW: InevTagWriter;
   const aFormats: Tl3ClipboardFormats;
   const aFilters: InevTagGenerator); overload;
  procedure Create(aData: THandle;
   aFormat: Tl3ClipboardFormat;
   const aTagStorageR: InevTagReader;
   const aTagStorageW: InevTagWriter;
   const aFormats: Tl3ClipboardFormats); overload;
  function Make(const aBlock: IevdDataObject;
   anInternal: Boolean;
   aFormat: Tl3ClipboardFormat;
   const aTagStorageR: InevTagReader;
   const aTagStorageW: InevTagWriter;
   const aFormats: Tl3ClipboardFormats;
   const aFilters: InevTagGenerator): InevDataObjectPrim2; overload;
  function Make(aData: THandle;
   aFormat: Tl3ClipboardFormat;
   const aTagStorageR: InevTagReader;
   const aTagStorageW: InevTagWriter;
   const aFormats: Tl3ClipboardFormats): InevDataObjectPrim2; overload;
  function DataObjectClass: RevDataObject;
  function Sharp: Boolean;
  function GetIsQuestionNeedBeforeFlush: Boolean;
  function DoStore(aFormat: TnevFormat;
   const aPool: IStream;
   const aFilters: InevTagGenerator;
   aFlags: TevdStoreFlags): Boolean;
  function IsQuestionNeedBeforeFlush: Boolean;
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
  function Borders: TevPair;
 end;//TevPersistentDataObject
 
implementation

uses
 l3ImplUses
 , k2InternalInterfaces
 , SysUtils
 , l3Base
 , l3Stream
 , Classes
;

end.
