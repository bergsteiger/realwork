unit m3ArcMgr;

{$I m3Define.inc}

interface

uses
  Windows,
  SysUtils,

  ActiveX,
   COMObj,

  m2COMLib,

  m3ArcCla
  ;


type
  Tm3InflateStreamManager = class
   public
    class function MakeInterface (const AName: WideString): IStream; overload;

    class function MakeInterface (const AName: WideString;
                                  const AAccess: LongWord;
                                  const ASharedMode: LongWord;
                                  const ADistribution: LongWord;
                                  const AFlags: LongWord): IStream; overload;

    class function MakeInterface (const AStream: IStream): IStream; overload;

  end;//Tm3InflateStreamManager

  Tm3DeflateStreamManager = class
   public
    class function MakeInterface(const AName: WideString): IStream; overload;

    class function MakeInterface(const AName: WideString;
                                 const AAccess: LongWord;
                                 const ASharedMode: LongWord;
                                 const ADistribution: LongWord;
                                 const AFlags: LongWord): IStream; overload;

    class function MakeInterface(aNew: Boolean; const AStream: IStream): IStream; overload;

  end;//Tm3DeflateStreamManager

implementation

uses
  m3LZODeflateStreamNew,
  m3LZOInflateStreamNew,
  m3FileStream
  ;

// Tm3InflateStreamManager

class function Tm3InflateStreamManager.MakeInterface(const AName: WideString): IStream;
const
 CAccess = GENERIC_READ;
 CSharedMode = 0;
 CDistribution = OPEN_EXISTING;
 CFlags = FILE_ATTRIBUTE_NORMAL;
begin
 Result := MakeInterface(AName, CAccess, CSharedMode, CDistribution, CFlags);
end;

class function Tm3InflateStreamManager.MakeInterface(const AName: WideString;
                                                   const AAccess: LongWord;
                                                   const ASharedMode: LongWord;
                                                   const ADistribution: LongWord;
                                                   const AFlags: LongWord): IStream;
begin
 Result := MakeInterface(Tm3FileStream.Make(AName, AAccess, ASharedMode, ADistribution, AFlags));
end;

class function Tm3InflateStreamManager.MakeInterface(const AStream: IStream): IStream;
var
 l_GUID : AnsiString;
begin
 l_GUID := m2COMCLSIDFromStream(m2COMSetPosition(0, AStream));
 if (l_GUID = GUIDToString(Tm3LZOInflateStream.HeaderID)) then
  Result := Tm3LZOInflateStream.MakeInterface(AStream)
 else
 if (l_GUID = GUIDToString(Tm3LZOInflateStreamNew.HeaderID)) then
  Result := Tm3LZOInflateStreamNew.MakeInterface(AStream)
 else
  Result := m2COMSetPosition(0, AStream);
end;

// Tm3DeflateStreamManager

class function Tm3DeflateStreamManager.MakeInterface(const AName: WideString): IStream;
const
 CAccess = GENERIC_READ or GENERIC_WRITE;
 CSharedMode = 0;
 CDistribution = CREATE_ALWAYS;
 CFlags = FILE_ATTRIBUTE_NORMAL;
begin
 Result := MakeInterface(AName, CAccess, CSharedMode, CDistribution, CFlags);
end;

class function Tm3DeflateStreamManager.MakeInterface(const AName: WideString;
                                                   const AAccess: LongWord;
                                                   const ASharedMode: LongWord;
                                                   const ADistribution: LongWord;
                                                   const AFlags: LongWord): IStream;
begin
 Result := MakeInterface(false, Tm3FileStream.Make(AName, AAccess, ASharedMode, ADistribution, AFlags));
end;

class function Tm3DeflateStreamManager.MakeInterface(aNew: Boolean; const AStream: IStream): IStream;
var
 l_GUID : AnsiString;
begin
 l_GUID := m2COMCLSIDFromStream(m2COMSetPosition(0, AStream));
 m2COMSetPosition(0, AStream);
 if (l_GUID = GUIDToString(Tm3LZODeflateStream.HeaderID)) then
  Result := Tm3LZODeflateStream.MakeInterface(AStream)
 else
 if (l_GUID = GUIDToString(Tm3LZODeflateStreamNew.HeaderID)) then
  Result := Tm3LZODeflateStreamNew.MakeInterface(AStream)
 else
 if (l_GUID = GUIDToString(GUID_NULL)) then
 begin
  if aNew then
   Result := Tm3LZODeflateStreamNew.MakeInterface(AStream)
  else
   Result := Tm3LZODeflateStream.MakeInterface(AStream);
 end//l_GUID = GUIDToString(GUID_NULL)
 else
 begin
  Assert(false, 'Неопределённый алгоритм паковки');
  Result := aStream;
 end;//else
end;

end.

