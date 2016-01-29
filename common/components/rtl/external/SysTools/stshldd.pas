{*********************************************************}
{*                  STSHLDD.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}
unit StShlDD;

interface

{$IFDEF VER110}
{$HPPEMIT '#define _di_IEnumFORMATETC IEnumFORMATETC' }
{$ENDIF}

{$IFNDEF VERSION3}
  !! Error: This unit can only be compiled with Delphi 3 and above
{$ENDIF}

uses
  SysUtils, Windows, Forms, Classes, Controls, ShellApi,
  {$IFDEF VERSION3} ActiveX, {$ELSE} Ole2, {$ENDIF}
  StShBase, StBase, StConst, ShlObj, ComCtrls, CommCtrl,
  Messages, StVInfo, Menus, StStrl, StSrMgr, Graphics,
  StdCtrls, Clipbrd, ComObj;

{$I STCONST.INC}

type

  PStFormatArray = ^TStFormatArray;
  TStFormatArray = array [0..255] of TFormatEtc;

  PStPidlArray = ^TStPidlArray;
  TStPidlArray = array [0..(MaxWord div SizeOf(PItemIDList)) - 1] of PItemIDList;

  PStDragDropData = ^TStDragDropData;
  TStDragDropData = record
    Effect     : Integer;
    Point      : TPoint;
    DataObject : IDataObject;
  end;

  TStDropSource = class(TInterfacedObject, IDropSource)
    function GiveFeedback(dwEffect: Longint): HResult; stdcall;
    function QueryContinueDrag(fEscapePressed: BOOL;
      grfKeyState: Longint): HResult; stdcall;
  end;

  TStDataObject = class(TInterfacedObject, IDataObject)
  protected {private}
    { property variables }
    FParentPidl : PItemIDList;
    FPidlCount  : Integer;
    FSimplePidl : PItemIDList;

    { internal variables }
    PidlArray  : TStPidlArray;
    Formats    : TStFormatArray;
    MS1        : TMemoryStream;                                        {!!.01}
    MS2        : TMemoryStream;                                        {!!.01}

  public
    { methods }
    function DAdvise(const formatetc: TFormatEtc; advf: Longint;
      const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
      stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc:
      IEnumFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc;
      out formatetcOut: TFormatEtc): HResult; stdcall;
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium):
      HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium):
      HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult;
      stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium;
      fRelease: BOOL): HResult; stdcall;

    constructor Create(const PidlArrayIn : TStPidlArray;
      const ParentPidlIn : PItemIDList; const Count : Integer);

    destructor Destroy; override;                                      {!!.01}

    { properties }
    property ParentPidl : PItemIDList
      read FParentPidl
      write FParentPidl;

    property PidlCount : Integer
      read FPidlCount
      write FPidlCount;

    property SimplePidl : PItemIDList
      read FSimplePidl
      write FSimplePidl;
  end;

  TStEnumFormatEtc = class(TInterfacedObject, IEnumFormatEtc)
  protected {private}
    { property variables }
    FCurrentIndex : Integer;
    Formats       : TStFormatArray;

  public

    { properties }
    property CurrentIndex : Integer
      read FCurrentIndex
      write FCurrentIndex;

    { methods }
    function Clone(out Enum: IEnumFormatEtc): HResult; stdcall;
    function Next(celt: Longint; out elt;
      pceltFetched: PLongint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;

    constructor Create(AFormats : TStFormatArray);
  end;

implementation

{$IFDEF TRIALRUN}
uses
  Registry,
  IniFiles,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

{ TStDropSource }

function TStDropSource.GiveFeedback(dwEffect: Integer): HResult;
begin
  Result := DRAGDROP_S_USEDEFAULTCURSORS;
end;

function TStDropSource.QueryContinueDrag(fEscapePressed: BOOL;
  grfKeyState: Integer): HResult;
begin
  if fEscapePressed then
    Result := DRAGDROP_S_CANCEL
  else if ((grfKeyState and MK_LBUTTON) = 0) then begin
    Result := DRAGDROP_S_DROP
  end else
    Result := S_OK;
end;

{ TStDataObject }

constructor TStDataObject.Create(const PidlArrayIn : TStPidlArray;
  const ParentPidlIn : PItemIDList; const Count : Integer);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  Move(PidlArrayIn, PidlArray, (Count * SizeOf(PItemIDList)));
  FParentPidl := ILClone(ParentPidlIn);
  ILRemoveLastID(FParentPidl);
  FPidlCount := Count;
  ZeroMemory(@Formats, SizeOf(Formats));
  { Add the pidl format. }
  Formats[0].cfFormat := PidlFormat;
  Formats[0].ptd      := nil;
  Formats[0].dwAspect := DVASPECT_CONTENT;
  Formats[0].lIndex   := -1;
  Formats[0].tymed    := TYMED_HGLOBAL;
  Formats[1].cfFormat := CF_HDROP;
  Formats[1].ptd      := nil;
  Formats[1].dwAspect := DVASPECT_CONTENT;
  Formats[1].lIndex   := -1;
  Formats[1].tymed    := TYMED_HGLOBAL;
  Formats[2].cfFormat := CF_TEXT;
  Formats[2].ptd      := nil;
  Formats[2].dwAspect := DVASPECT_CONTENT;
  Formats[2].lIndex   := -1;
  Formats[2].tymed    := TYMED_HGLOBAL;
end;

destructor TStDataObject.Destroy;                                      {!!.01}
begin                                                                  {!!.01}
  MS1.Free;                                                            {!!.01}
  MS2.Free;                                                            {!!.01}
  inherited;                                                           {!!.01}
end;                                                                   {!!.01}

function TStDataObject.DAdvise(const formatetc: TFormatEtc; advf: Integer;
  const advSink: IAdviseSink; out dwConnection: Integer): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TStDataObject.DUnadvise(dwConnection: Integer): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TStDataObject.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

function TStDataObject.EnumFormatEtc(dwDirection: Integer;
  out enumFormatEtc: IEnumFormatEtc): HResult;
begin
  if (dwDirection = DATADIR_GET) then begin
    enumFormatEtc := TStEnumFormatEtc.Create(Formats);
    Result := S_OK;
  end
  else begin
    enumFormatEtc := nil;
    Result := E_NOTIMPL;
  end;
end;

function TStDataObject.GetCanonicalFormatEtc(const formatetc: TFormatEtc;
  out formatetcOut: TFormatEtc): HResult;
begin
  Move(formatetc, formatetcOut, SizeOf(TFormatEtc));
  formatetcOut.ptd := nil;
  Result := DATA_S_SAMEFORMATETC;
end;

function TStDataObject.GetData(const formatetcIn: TFormatEtc;
  out medium: TStgMedium): HResult;
var
  Offset : UINT;
  I      : Integer;
  Buff   : Pointer;
  HMem   : THandle;
  Pidl   : PItemIDList;
  FName  : array [0..MAX_PATH - 1] of Char;
  DF     : TDropFiles;
begin
  { Changed the use of the memory stream to use a class member   }     {!!.01}
  { variable (2 actually) rather than a local variable. This was }
  { necessary because the pidl data was being recreated on every }
  { mouse movement. The effect was not noticable when dragging   }
  { small numbers of files, but was very noticable when dragging }
  { large numbers of files. Now we only build the pidl data once }
  { and reference the existing data on each mouse move. }
  Result := QueryGetData(formatetcIn);
  if Result <> S_OK then
    Exit;
  { Build the data structure the shell expects. }
  FillChar(medium, SizeOf(medium), 0);
  medium.tymed := TYMED_HGLOBAL;
  if formatetcIn.cfFormat = PidlFormat then begin
    if MS1 = nil then begin
      MS1 := TMemoryStream.Create;
      MS1.Position := 0;
      { First value in the buffer is the pidl count. }
      MS1.Write(FPidlCount, SizeOf(FPidlCount));
      { Next is the array of offset values. The first offset }
      { is for the parent pidl. The offset value is one byte }
      { past the size of the offset array. The offset array  }
      { is variable based on the number of pidls passed.     }
      Offset := ((SizeOf(UINT) * 2) + (PidlCount * SizeOf(UINT)));
      MS1.Write(Offset, SizeOf(Offset));
      Inc(Offset, ILGetSize(FParentPidl));
      { Now write out the remaining offset values. }
      for I := 0 to Pred(PidlCount) do begin
        MS1.Write(Offset, SizeOf(UINT));
        Inc(Offset, ILGetSize(PidlArray[I]));
      end;
      { Write the parent pidl. }
      MS1.Write(FParentPidl^, ILGetSize(FParentPidl));
      { Write the pidl array. }
      for I := 0 to Pred(PidlCount) do
        MS1.Write(PidlArray[I]^, ILGetSize(PidlArray[I]));
      { Get some global memory and copy the memory stream to it. }
    end;
    HMem := GlobalAlloc(
      GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT, MS1.Size);
    Buff := GlobalLock(HMem);
    MS1.Position := 0;
    MS1.Read(Buff^, MS1.Size);
    GlobalUnlock(HMem);
    medium.hGlobal := HMem;
  end else if formatetcIn.cfFormat = CF_TEXT then begin
    { Not implemented. }
  end else if formatetcIn.cfFormat = CF_HDROP then begin
    if MS2 = nil then begin
      MS2 := TMemoryStream.Create;
      MS2.Position := 0;
      ZeroMemory(@DF, SizeOf(DF));
      DF.pFiles := SizeOf(DF);
      MS2.Write(DF, SizeOf(DF));
      for I := 0 to Pred(PidlCount) do begin
        Pidl := ILCombine(FParentPidl, PidlArray[I]);
        ZeroMemory(@FName, SizeOf(FName));
        SHGetPathFromIdList(Pidl, FName);
        ILFree(Pidl);
        MS2.Write(FName, StrLen(FName) + 1);
      end;
      { Write out the last null for double-null termination. }
      Offset := 0;
      MS2.Write(Offset, 1);
    end;
    HMem := GlobalAlloc(GMEM_SHARE or
      GMEM_MOVEABLE or GMEM_ZEROINIT, MS2.Size);
    Buff := GlobalLock(HMem);
    MS2.Position := 0;
    MS2.Read(Buff^, MS2.Size);
    GlobalUnlock(HMem);
    medium.hGlobal := HMem;
  end else begin
    Result := DV_E_FORMATETC;
    Exit;
  end;
  if medium.hGlobal = 0 then
    Result := E_OUTOFMEMORY
  else
    Result := S_OK;
end;

function TStDataObject.GetDataHere(const formatetc: TFormatEtc;
  out medium: TStgMedium): HResult;
begin
  Result := E_NOTIMPL;
end;

function TStDataObject.QueryGetData(const formatetc: TFormatEtc): HResult;
var
  I, Count : Integer;
begin
  Count := 0;
  { See how many formats we have. }
  for I := 0 to 255 do
    if Formats[I].cfFormat = 0 then begin
      Count := I;
      Break;
    end;
  Result := DV_E_FORMATETC;
  if (formatetc.dwAspect <> DVASPECT_CONTENT) then
    Exit;
  for I := 0 to Pred(Count) do
    if Formats[I].cfFormat = formatetc.cfFormat then begin
      Result := DV_E_TYMED;
      if (Formats[I].tymed and formatetc.tymed) <> 0 then begin
        Result := S_OK;
        Exit;
      end;
    end;
end;

function TStDataObject.SetData(const formatetc: TFormatEtc;
  var medium: TStgMedium; fRelease: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

{ TStEnumFormatEtc }

function TStEnumFormatEtc.Clone(out Enum: IEnumFormatEtc): HResult;
var
  StEnum : TStEnumFormatEtc;
begin
  StEnum := TStEnumFormatEtc.Create(Formats);
  StEnum.Formats := Formats;
  Enum := StEnum;
  Result := S_OK;
end;

constructor TStEnumFormatEtc.Create(AFormats : TStFormatArray);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  ZeroMemory(@Formats, SizeOf(Formats));
  Formats := AFormats;
  FCurrentIndex := 0;
end;

function TStEnumFormatEtc.Next(celt: Integer; out elt;
  pceltFetched: PLongint): HResult;
var
  I, Count : Integer;
begin
  Count := 0;
  { See how many formats we have. }
  for I := 0 to 255 do
    if Formats[I].cfFormat = 0 then begin
      Count := I;
      Break;
    end;
  I := 0;
  while (I < celt) and (FCurrentIndex < Count) do begin
    TStFormatArray(elt)[I] := Formats[FCurrentIndex];
    Inc(I);
    Inc(FCurrentIndex);
  end;
  if pceltFetched <> nil then
    pceltFetched^ := I;
  if I = 0 then begin
    Result := S_FALSE;
    Exit;
  end;
  if FCurrentIndex = Count then
    Result := S_FALSE
  else
    Result := S_OK;
end;

function TStEnumFormatEtc.Reset: HResult;
begin
  FCurrentIndex := 0;
  Result := S_OK;
end;

function TStEnumFormatEtc.Skip(celt: Integer): HResult;
var
  I, Count : Integer;
begin
  Inc(FCurrentIndex, celt);
  { See how many formats we have. }
  Count := 0;
  for I := 0 to 255 do
    if Formats[I].cfFormat = 0 then begin
      Count := I;
      Break;
    end;
  if FCurrentIndex >= Count then begin
    FCurrentIndex := Count;
    Result := S_FALSE
  end else
    Result := S_OK;
end;

end.




