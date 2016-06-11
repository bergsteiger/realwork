{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

/// <summary>Classes and Helper utililities for dealing with WinRT interfaces and strings</summary>
unit System.Win.WinRT;

interface

uses
  Winapi.Winrt, System.RTTI, System.SysUtils, System.TypInfo;

type
  /// <summary>Exception base class for all WinRT exceptions </summary>
  EWinRTException = class(Exception);

  /// <summary>Base Delphi object needed for Windows Runtime classes. Implements IInspectable interface</summary>
  TInspectableObject = class(TInterfacedObject, IInspectable)
  protected
    FIIDS: array of TGUID;
  public
    /// <summary>Gets the interfaces that are implemented by the current Windows Runtime class</summary>
    function GetIids(out iidCount: Cardinal; out iids: PGUID): HRESULT; stdcall;
    /// <summary>Gets the fully qualified name of the current Windows Runtime object</summary>
    function GetRuntimeClassName(out className: HSTRING): HRESULT; stdcall;
    /// <summary>Gets the trust level of the current Windows Runtime object</summary>
    function GetTrustLevel(out trust: TrustLevel): HRESULT; stdcall;
  end;


  /// <summary>Helper needed to automate life cycle of HSTRING type and conversions from/to string</summary>
  TWindowsString = record
  strict private type
    TWindowsStringNexus = class(TInterfacedObject)
    private
      FString: HSTRING;
    public
      constructor Create(AString: HSTRING);
      destructor Destroy; override;
    end;
    PWindowsString = ^TWindowsString;
  private
    FNexus: IInterface;
    FHandle: HSTRING;
    FValid: Boolean;
  public
    constructor Create(const S: string); overload;
    /// <summary>Checks that the internal HSTRING was created successfully</summary>
    property Valid: Boolean read FValid;

    class operator Implicit(const S: TWindowsString): HSTRING; inline;
    class operator Explicit(const S: string): TWindowsString;
    /// <summary>Gets the string representation of the given HSTRING</summary>
    class function HStringToString(const hs: HSTRING): string; static;
  end;

  /// <summary>Record helper for HSTRING</summary>
  THStringHelper = record helper for HString
    /// <summary>Gets the string representation of the given HSTRING</summary>
    function ToString: string; inline;
  end;

  /// <summary>Custom atribute to store the Class Name of an imported WinRT class</summary>
  WinRTClassNameAttribute = class(TCustomAttribute)
  private
    FSignature: string;
  public
    constructor Create(const S: string);
    /// <summary>Gets the signature of the Class</summary>
    property Signature: string read FSignature;
  end;

{$M+}
  /// <summary>Helper used to import a WinRT class</summary>
  TWinRTImportHelper = class
  private
    class var FContext: TRttiContext;
    class constructor Create;
    class destructor Destroy;
  public
    /// <summary>Gets the UIID of a given interface</summary>
    class function GetUIID<T: IInterface>: TGUID; static;
    /// <summary>Gets the WinRT ActivationFactory related to the given TypeInfo. Also gets it's Class Name</summary>
    class function GetFactoryOrStatics(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
    /// <summary>Gets the WinRT ActivateInstance related to the given TypeInfo. Also gets it's Class Name</summary>
    class function CreateInstance(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
    /// <summary>Gets the Class Name of a Class Type</summary>
    class function GetClassName(const ClassType: TRttiType): HString;
    /// <summary>Cached RTTI Context to share among all WinRTImport</summary>
    class property Context: TRttiContext read FContext;
  end;

  /// <summary>Base class of all WinRT Imports</summary>
  TWinRTImport = class
  protected
    /// <summary>Inline function to use ImporHelper sibling</summary>
    class function GetFactoryOrStatics(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable; inline;
    /// <summary>Inline function to use ImporHelper sibling</summary>
    class function CreateInstance(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable; inline;
  end;

  TWinRTGenericImportF<F: IInspectable> = class(TWinRTImport)
  private
    class var FRTClassName: HString;
    class var FFactory: F;
    class function GetFactory: F; static;
    class destructor Destroy;
  public
    class property Factory: F read GetFactory;
    class property RTClassName: HString read FRTClassName;
  end;

  TWinRTGenericImportS<S: IInspectable> = class(TWinRTImport)
  private
    class var FRTClassName: HString;
    class var FStatics: S;
    class function GetStatics: S; static;
    class destructor Destroy;
  public
    class property RTClassName: HString read FRTClassName;
    class property Statics: S read GetStatics;
  end;

  TWinRTGenericImportI<I: IInspectable> = class(TWinRTImport)
  private
    class var FRTClassName: HString;
    class destructor Destroy;
  public
    class function Create: I; static;
    class property RTClassName: HString read FRTClassName;
  end;

  TWinRTGenericImportF2<F1, F2: IInspectable> = class(TWinRTGenericImportF<F1>)
  private
    class var FFactory2: F2;
    class function GetFactory2: F2; static;
  public
    class property Factory2: F2 read GetFactory2;
  end;

  TWinRTGenericImportFS<F, S: IInspectable> = class(TWinRTGenericImportF<F>)
  private
    class var FStatics: S;
    class function GetStatics: S; static;
  public
    class property Statics: S read GetStatics;
  end;

  TWinRTGenericImportFI<F: IInspectable; I: IInspectable> = class(TWinRTGenericImportF<F>)
  public
    class function Create: I; static;
  end;

  TWinRTGenericImportS2<S1, S2: IInspectable> = class(TWinRTGenericImportS<S1>)
  private
    class var FStatics2: S2;
    class function GetStatics2: S2; static;
  public
    class property Statics2: S2 read GetStatics2;
  end;

  TWinRTGenericImportSI<S: IInspectable; I: IInspectable> = class(TWinRTGenericImportS<S>)
  public
    class function Create: I; static;
  end;

  TWinRTGenericImportF2I<F1, F2, I: IInspectable> = class(TWinRTGenericImportF2<F1, F2>)
  public
    class function Create: I; static;
  end;

  TWinRTGenericImportFS2<F, S1, S2: IInspectable> = class(TWinRTGenericImportFS<F, S1>)
  private
    class var FStatics2: S2;
    class function GetStatics2: S2; static;
  public
    class property Statics2: S2 read GetStatics2;
  end;

  TWinRTGenericImportFSI<F, S, I: IInspectable> = class(TWinRTGenericImportFS<F, S>)
  public
    class function Create: I; static;
  end;

  TWinRTGenericImportS2I<S1, S2, I: IInspectable> = class(TWinRTGenericImportS2<S1, S2>)
  public
    class function Create: I; static;
  end;

  TWinRTGenericImportS3<S1, S2, S3: IInspectable> = class(TWinRTGenericImportS2<S1, S2>)
  private
    class var FStatics3: S3;
    class function GetStatics3: S3; static;
  public
    class property Statics3: S3 read GetStatics3;
  end;

  TWinRTGenericImportSO<S: IInspectable; O: IUnknown> = class(TWinRTGenericImportS<S>)
  private
    class var FInterop: O;
    class function GetInterop: O; static;
  public
    class property Interop: O read GetInterop;
  end;

  TWinRTGenericImportS2O<S1, S2: IInspectable; O: IUnknown> = class(TWinRTGenericImportS2<S1, S2>)
  private
    class var FInterop: O;
    class function GetInterop: O; static;
  public
    class property Interop: O read GetInterop;
  end;
{$M-}

var
  RoInitType: RO_INIT_TYPE = RO_INIT_MULTITHREADED;

implementation

uses
  System.RTLConsts;

var
  SaveInitProc: Pointer;
  InitWinRTCalled: Boolean = False;
  NeedToUninitialize: Boolean = False;

function Succeeded(Res: HResult): Boolean;
begin
  Result := Res and $80000000 = 0;
end;

procedure InitWinRT;
begin
  if InitWinRTCalled then Exit;
  if SaveInitProc <> nil then
    TProcedure(SaveInitProc);
  if TOSVersion.Check(6, 2) then
    NeedToUninitialize := Succeeded(RoInitialize(RoInitType));
  InitWinRTCalled := True;
end;

{ TInspectableObject }
function TInspectableObject.GetIids(out iidCount: Cardinal;
  out iids: PGUID): HRESULT;
var
  Cxt: TRttiContext;
  Typ: TRttiType;
  IntfTable: PInterfaceTable;
begin
  if Length(FIIDS) = 0 then
  begin
    Cxt := TRttiContext.Create;
    try
      Typ := Cxt.GetType(Self.ClassType);
      IntfTable := Typ.GetInterfaceTable;
      SetLength(FIIDS, IntfTable^.EntryCount-2);

      Move(IntfTable^.Entries[0], FIIDs[0], IntfTable^.EntryCount);
    finally
      Cxt.Free;
    end;
  end;
  iidCount := Length(FIIDS);
  if Length(Fiids) > 0 then
    iids := @Fiids[0]
  else
    IIDs := nil;
  Result := S_OK;
end;

function TInspectableObject.GetRuntimeClassName(out className: HSTRING): HRESULT;
var
  Str: string;
begin
  Str := Self.ClassName;
  Result := WindowsCreateString(PChar(Str), Length(Str), className);
end;

function TInspectableObject.GetTrustLevel(out trust: TrustLevel): HRESULT;
begin
  trust := TrustLevel.BaseTrust;                                       
  Result := S_OK;
end;


{ TWindowsString.TWindowsStringNexus }

constructor TWindowsString.TWindowsStringNexus.Create(AString: HSTRING);
begin
  inherited Create;
  FString := AString;
end;

destructor TWindowsString.TWindowsStringNexus.Destroy;
begin
  WindowsDeleteString(FString);
  inherited Destroy;
end;

{ TWindowsString }

constructor TWindowsString.Create(const S: string);
begin
  FValid := Succeeded(WindowsCreateString(PChar(S), System.Length(S), FHandle));
  FNexus := TWindowsStringNexus.Create(FHandle);
end;

class operator TWindowsString.Explicit(const S: string): TWindowsString;
begin
  Result := TWindowsString.Create(S);
end;

class operator TWindowsString.Implicit(const S: TWindowsString): HSTRING;
begin
  Result := S.FHandle;
end;

class function TWindowsString.HStringToString(const hs: HSTRING): string;
begin
  Result := WindowsGetStringRawBuffer(hs, nil);
end;

{ WinRTClassNameAttribute }

constructor WinRTClassNameAttribute.Create(const S: string);
begin
  FSignature := S;
end;

{ TWinRTImportHelper }

class constructor TWinRTImportHelper.Create;
begin
  FContext := TRttiContext.Create;
end;

class destructor TWinRTImportHelper.Destroy;
begin
  FContext.Free;
end;

class function TWinRTImportHelper.CreateInstance(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
var
  LType: TRttiType;
  LTypeData: PTypeData;
  LCreated: IInspectable;
  LGUID: TGUID;
begin
  LType := TWinRTImportHelper.Context.GetType(ATypeInfo);
  LTypeData := GetTypeData(ATypeInfo);
  if LType = nil then
    raise EWinRTException.CreateFmt(SWinRTNoRTTI, [TWindowsString.HStringToString(AClassName)]);
  LGUID := LTypeData^.Guid;

  if AClassName <= 0 then
    AClassName := TWinRTImportHelper.GetClassName(LType);

  if not SUCCEEDED(RoActivateInstance(AClassName, LCreated)) then
    raise EWinRTException.CreateFmt(SWinRTInstanceError, [TWindowsString.HStringToString(AClassName)]);

  if LCreated.QueryInterface(LGUID, Result) <> 0 then
    raise EWinRTException.CreateFmt(SWinRTICreatedError, [TWindowsString.HStringToString(AClassName)]);
end;

class function TWinRTImportHelper.GetFactoryOrStatics(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
var
  LType: TRttiType;
  LTypeData: PTypeData;
  LCreated: IInspectable;
  LGUID: TGUID;
begin
  LType := TWinRTImportHelper.Context.GetType(ATypeInfo);
  LTypeData := GetTypeData(ATypeInfo);
  if LType = nil then
    raise EWinRTException.CreateFmt(SWinRTNoRTTI, [TWindowsString.HStringToString(AClassName)]);
  LGUID := LTypeData^.Guid;

  if AClassName <= 0 then
    AClassName := TWinRTImportHelper.GetClassName(LType);

  if not SUCCEEDED(RoGetActivationFactory(AClassName, LGUID, LCreated)) then
    raise EWinRTException.CreateFmt(SWinRTFactoryError, [TWindowsString.HStringToString(AClassName)]);

  if LCreated.QueryInterface(LGUID, Result) <> 0 then
    raise EWinRTException.CreateFmt(SWinRTWrongFactoryError, [TWindowsString.HStringToString(AClassName)]);
end;

class function TWinRTImportHelper.GetUIID<T>: TGUID;
begin
  Result := GetTypeData(TypeInfo(T))^.Guid;
end;

class function TWinRTImportHelper.GetClassName(const ClassType: TRttiType): HString;
var
  Attrs: TArray<TCustomAttribute>;
  Sig: WinRTClassNameAttribute;
  LStr: string;
begin
  Attrs := ClassType.GetAttributes;
  if Length(Attrs) > 0 then
  begin
    Sig := WinRTClassNameAttribute(Attrs[0]);
    LStr := Sig.Signature;
  end
  else
    LStr := '';

  if not SUCCEEDED(WindowsCreateString(PWideChar(LStr), Length(LStr), Result)) then
    raise EWinRTException.CreateFmt(SWinRTHStringError, [LStr]);
end;

{ TWinRTImport }

class function TWinRTImport.CreateInstance(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
begin
  Result := TWinRTImportHelper.CreateInstance(ATypeInfo, AClassName);
end;

class function TWinRTImport.GetFactoryOrStatics(ATypeInfo: PTypeInfo; var AClassName: HString): IInspectable;
begin
  Result := TWinRTImportHelper.GetFactoryOrStatics(ATypeInfo, AClassName);
end;

{ TWinRTGenericImportFI<F,I> }

class function TWinRTGenericImportFI<F, I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportF<F> }

class destructor TWinRTGenericImportF<F>.Destroy;
begin
  if TOSVersion.Check(6, 2) then
    WindowsDeleteString(FRTClassName);
end;

class function TWinRTGenericImportF<F>.GetFactory: F;
begin
  if FFactory = nil then
    FFactory := F(GetFactoryOrStatics(TypeInfo(F), FRTClassName));
  Result := FFactory;
end;

{ TWinRTGenericImportI<I> }

class function TWinRTGenericImportI<I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportS<T> }

class destructor TWinRTGenericImportS<S>.Destroy;
begin
  if TOSVersion.Check(6, 2) then
    WindowsDeleteString(FRTClassName);
end;

class function TWinRTGenericImportS<S>.GetStatics: S;
begin
  if FStatics = nil then
    FStatics := S(GetFactoryOrStatics(TypeInfo(S), FRTClassName));
  Result := FStatics;
end;

class destructor TWinRTGenericImportI<I>.Destroy;
begin
  if TOSVersion.Check(6, 2) then
    WindowsDeleteString(FRTClassName);
end;

{ TWinRTGenericImportFS<F, S> }

class function TWinRTGenericImportFS<F, S>.GetStatics: S;
begin
  if FStatics = nil then
    FStatics := S(GetFactoryOrStatics(TypeInfo(S), FRTClassName));
  Result := FStatics;
end;

{ TWinRTGenericImportSI<S, I> }

class function TWinRTGenericImportSI<S, I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportS2<S1, S2> }

class function TWinRTGenericImportS2<S1, S2>.GetStatics2: S2;
begin
  if FStatics2 = nil then
    FStatics2 := S2(GetFactoryOrStatics(TypeInfo(S2), FRTClassName));
  Result := FStatics2;
end;

{ TWinRTGenericImportS3<S1, S2, S3> }

class function TWinRTGenericImportS3<S1, S2, S3>.GetStatics3: S3;
begin
  if FStatics3 = nil then
    FStatics3 := S3(GetFactoryOrStatics(TypeInfo(S3), FRTClassName));
  Result := FStatics3;
end;

{ TWinRTGenericImportFSI<F, S, I> }

class function TWinRTGenericImportFSI<F, S, I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportFS2<F, S1, S2> }

class function TWinRTGenericImportFS2<F, S1, S2>.GetStatics2: S2;
begin
  if FStatics2 = nil then
    FStatics2 := S2(GetFactoryOrStatics(TypeInfo(S2), FRTClassName));
  Result := FStatics2;
end;

{ TWinRTGenericImportF2<F1, F2> }

class function TWinRTGenericImportF2<F1, F2>.GetFactory2: F2;
begin
  if FFactory2 = nil then
    FFactory2 := F2(GetFactoryOrStatics(TypeInfo(F2), FRTClassName));
  Result := FFactory2;
end;

{ TWinRTGenericImportF2I<F1, F2, I> }

class function TWinRTGenericImportF2I<F1, F2, I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportS2I<S1, S2, I> }

class function TWinRTGenericImportS2I<S1, S2, I>.Create: I;
begin
  Result := I(CreateInstance(TypeInfo(I), FRTClassName));
end;

{ TWinRTGenericImportSO<S, O> }

class function TWinRTGenericImportSO<S, O>.GetInterop: O;
begin
  if FInterop = nil then
    if Statics.QueryInterface(TWinRTImportHelper.GetUIID<O>, FInterop) <> 0 then
      raise EWinRTException.Create(SWinRTInteropError);

  Result := FInterop;
end;

{ TWinRTGenericImportS2O<S1, S2, O> }

class function TWinRTGenericImportS2O<S1, S2, O>.GetInterop: O;
begin
  if FInterop = nil then
    if Statics.QueryInterface(TWinRTImportHelper.GetUIID<O>, FInterop) <> 0 then
      raise EWinRTException.Create(SWinRTInteropError);

  Result := FInterop;
end;

{ THStringHelper }

function THStringHelper.ToString: string;
begin
  Result := TWindowsString.HStringToString(Self);
end;

initialization
  if not IsLibrary then
  begin
    SaveInitProc := InitProc;
    InitProc := @InitWinRT;
  end;

finalization
  if NeedToUninitialize and TOSVersion.Check(6, 2) then
    RoUninitialize;

end.
