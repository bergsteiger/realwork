unit ActiveX;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Rtl"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Rtl/Win/ActiveX.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Rtl::Rtl::ActiveX
//
// ActiveX / OLE 2 Interface Unit.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  Windows
  ;

type
 IEnumFORMATETC = interface(IUnknown)
  {* �������� �� ������ ������ IDataObject. }
   ['{8FDCFD24-3B06-444D-98A9-7C250B54D48C}']
   function Next(celt: Integer;
    out elt;
    pceltFetched: PLongint): HResult; stdcall;
   function Skip(celt: Integer): HResult; stdcall;
   function Reset: HResult; stdcall;
   function Clone(out Enum: IEnumFORMATETC): HResult; stdcall;
 end;//IEnumFORMATETC

 TStgMedium = record
 end;//TStgMedium

 IStream = interface(IUnknown)
  {* �����. }
   ['{F9C63F24-4E9E-4D13-AEA7-2E1CC301DBC3}']
 end;//IStream

 TFormatEtc = record
 end;//TFormatEtc

 IAdviseSink = interface(IUnknown)
   ['{15439050-1E5B-4F96-AB3B-2F7215C67D66}']
 end;//IAdviseSink

 IDropSource = interface(IUnknown)
   ['{776E8CD1-A4A3-4383-8647-2C34D8B8DAC9}']
 end;//IDropSource

 IDropTarget = interface(IUnknown)
   ['{9B77F3D9-C3C7-4143-8439-3591802F77AE}']
 end;//IDropTarget

 IEnumStatData = interface(IUnknown)
   ['{C190C4EA-7EB2-40F1-A77A-8CEBCB2B66E6}']
 end;//IEnumStatData

 IEnumFormatEtc = IEnumFORMATETC;

 PFormatEtc = record
 end;//PFormatEtc

 TStatStg = record
 end;//TStatStg

 IDataObject = interface(IUnknown)
  {* ������ �������������� ������ ��� ������ ������ ��� drag-and-drop. }
   ['{D1B49E97-39B1-4ED5-9B33-5B1093FF9C37}']
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

 IEnumStatStg = interface(IUnknown)
   ['{441B4CA8-58FB-4B30-BAFA-C1D6521FF7D6}']
 end;//IEnumStatStg

 TCLSID = record
 end;//TCLSID

(*
 MCommonStorage = PureMixIn
   function DestroyElement(aName: PWideChar): HResult; stdcall;
   function EnumElements(unused1: Integer;
     unused2: Pointer;
     unused3: Integer;
     out theStatStg: IEnumStatStg): HResult; stdcall;
   function Stat(out theStatStg: TStatStg;
     aStatFlag: Integer): HResult; stdcall;
 end;//MCommonStorage
*)

 IStorage = interface(IUnknown)
  {* ����������������� ���������. }
   ['{DBD1670E-4A5F-4030-896C-85BCA17997B1}']
  // MCommonStorage
   function DestroyElement(aName: PWideChar): HResult; stdcall;
   function EnumElements(unused1: Integer;
     unused2: Pointer;
     unused3: Integer;
     out theStatStg: IEnumStatStg): HResult; stdcall;
   function Stat(out theStatStg: TStatStg;
     aStatFlag: Integer): HResult; stdcall;
 end;//IStorage

 TIID = record
 end;//TIID

 POleStr = System.PWideChar;

 TSNB = ^POleStr;

implementation

end.