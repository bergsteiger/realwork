unit ActiveX;

interface

uses
 l3IntfUses
 , Windows
;

type
 IEnumFORMATETC = interface
  {* Итератор по данным внутри IDataObject. }
  function Next(celt: Integer;
   out elt;
   pceltFetched: PLongint): HResult; stdcall;
  function Skip(celt: Integer): HResult; stdcall;
  function Reset: HResult; stdcall;
  function Clone(out Enum: IEnumFORMATETC): HResult; stdcall;
 end;//IEnumFORMATETC
 
 TStgMedium = record
 end;//TStgMedium
 
 IStream = interface
  {* Поток. }
 end;//IStream
 
 TFormatEtc = record
 end;//TFormatEtc
 
 IAdviseSink = interface
 end;//IAdviseSink
 
 IDropSource = interface
 end;//IDropSource
 
 IDropTarget = interface
 end;//IDropTarget
 
 IEnumStatData = interface
 end;//IEnumStatData
 
 IEnumFormatEtc = IEnumFORMATETC;
 
 PFormatEtc = record
 end;//PFormatEtc
 
 TStatStg = record
 end;//TStatStg
 
 IDataObject = interface
  {* Объект представляющий данные для буфера обмена или drag-and-drop. }
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
 end;//IDataObject
 
 IEnumStatStg = interface
 end;//IEnumStatStg
 
 TCLSID = record
 end;//TCLSID
 
 (*
 MCommonStorage = interface
  function DestroyElement(aName: PWideChar): HResult;
  function EnumElements(unused1: Integer;
   unused2: Pointer;
   unused3: Integer;
   out theStatStg: IEnumStatStg): HResult;
  function Stat(out theStatStg: TStatStg;
   aStatFlag: Integer): HResult;
 end;//MCommonStorage
 *)
 
 IStorage = interface
  {* Структурированное хранилище. }
  function DestroyElement(aName: PWideChar): HResult;
  function EnumElements(unused1: Integer;
   unused2: Pointer;
   unused3: Integer;
   out theStatStg: IEnumStatStg): HResult;
  function Stat(out theStatStg: TStatStg;
   aStatFlag: Integer): HResult;
 end;//IStorage
 
 TIID = record
 end;//TIID
 
 POleStr = PWideChar;
 
 TSNB = ^POleStr;
 
implementation

uses
 l3ImplUses
;

end.
