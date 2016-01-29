unit l3DataObject;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3Interfaces
 , l3InternalInterfaces
 , l3LongintList
 , l3StringList
 , ActiveX
 , Windows
;

type
 Tl3DataObject = class(Tl3SimpleObject, IDataObject, Il3DragImageSource)
  {* Базовый класс для работы с IDataObject. }
  procedure Create(const aFormats: Tl3ClipboardFormats);
  function DoGetData(const aFormatEtcIn: TFormatEtc;
   var medium: Tl3StoragePlace): HResult;
  function DoGetDataHere(const aFormatEtcIn: TFormatEtc;
   const medium: Tl3StoragePlace): HResult;
  procedure WriteFilesAndSetNames(aNames: Tl3StringList);
  function Bitmap: Il3Bitmap;
  function AcceptableTymed: Integer;
  procedure CheckFormats;
  function DoQueryGetData(const aFormatEtc: TFormatEtc): HResult;
  procedure SetDragBitmap(const aBitmap: Il3Bitmap);
  function Image: Il3Bitmap;
  function GetData(const formatetcIn: TFormatEtc;
   out medium: TStgMedium): HResult; stdcall;
  function GetDataHere(const formatetc: TFormatEtc;
   out medium: TStgMedium): HResult; stdcall;
  function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
  function GetCanonicalFormatEtc(const formatetc: TFormatEtc;
   out formatetcOut: TFormatEtc): HResult; stdcall;
  function SetData(const formatetc: TFormatEtc;
   var medium: TStgMedium;
   fRelease: BOOL): HResult; stdcall;
  function EnumFormatEtc(dwDirection: Integer;
   out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
  function DAdvise(const formatetc: TFormatEtc;
   advf: Integer;
   const advSink: IAdviseSink;
   out dwConnection: Integer): HResult; stdcall;
  function DUnadvise(dwConnection: Integer): HResult; stdcall;
  function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
 end;//Tl3DataObject
 
implementation

uses
 l3ImplUses
 , l3DataObjectEnum
 , l3Base
 , SysUtils
 , ShlObj
;

end.
