{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpload;

interface
{.$I dc.inc}
{$I dcprod.inc}

{$IFNDEF D3}Delphi 3 or higher required{$ENDIF}

uses
  dcsystem, Windows, Classes, SysUtils, Messages, Controls, Dialogs,Forms,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcdreamlib,
  DCCommon, DCEnvOpt, DCGen,
  DCActiveXForm;

{-------------------------------------------------------------------------}

type
  TDCPackageLoader = class;

  TPackageUnloadedEvent = procedure(Sender : TDCPackageLoader; PackHandle : THandle) of object;
  TPackageLoadedEvent = TPackageUnloadedEvent;
  TRegisterComponentsEvent =
    procedure(Sender : TDCPackageLoader; PackHandle : THandle; const Page : string;
    ComponentClasses : array of TComponentClass) of object;
  TOnBeforeUnloadEvent = procedure(Sender : TDCPackageLoader; PackHandle : THandle;
    var CanUnload : Boolean) of object;

  TDCPackageLoaderOption = (plAutoSave, plUpdateOnLoad, plAutoLoad, {plTrackFields,} plAutoUpdate);
  TDCPackageLoaderOptions = set of TDCPackageLoaderOption;

{
This component handles packages. With it you'll be able to break huge application
into several packages. Your users will be able to load appropriate package into
main application when neccessary.

Thin main program with basic functionality and all logic separated into
loadable packages. This will allow you to customize program easily
for every user. 
}
  TOnGetPackageFileNameEvent = procedure(Sender: TObject; var Path: string) of object;

  TDCPackageLoader = class(TComponent)
  private
    FMessageShown : boolean;
    FAlreadyLoaded : boolean; // in loaded method this variable set true
    FOnLoaded : TNotifyEvent;
    FUseRegistry : Boolean;
    FOptions : TDCPackageLoaderOptions;
    FOnBeforeUnload : TOnBeforeUnloadEvent;
    FOnPackageUnloaded : TPackageUnloadedEvent;
    FOnPackageLoaded : TPackageLoadedEvent;
    FIniSection : string;
    FIniFile : string;
    FSavePackList, FPackageList : TCollection;
    FVersion : TDCVersion;
    FOnGetPackageFileName: TOnGetPackageFileNameEvent;
    function GetIniFile : string;
    function GetPackageHandle(Index : integer) : THandle;
    function GetConfigStr : string;
    procedure SetConfigStr(const S : string);
    procedure UnloadThatRequire(P : TObject);
  protected
    function GetPackagePath(Index : integer) : string;
    function GetPackageLoaded(Index : integer) : Boolean;
    procedure SetPackageLoaded(Index : integer; Value : Boolean);
    function GetPackageDesc(Index : integer) : string;
    procedure SetPackageDesc(Index : integer; const Value : string);
    function GetPackageCount : integer;
    procedure loaded; override;
    function RegisterPackageEx(const PackName, FullPackName : string; ALoad : Boolean) : THandle;
  public
    function RegisteredPackageCount : integer;
    procedure ListPackageHandles(L : TList);
    procedure ShowPackagesConfig;
    procedure DefaultSaveConfig;
    procedure DefaultLoadConfig;
    procedure UnRegisterPackages;
    function IsPackageRegistered(const PackName : string; var OldPackName : string) : Boolean;
    function RegisterPackage(const PackName : string; ALoad : Boolean) : THandle;
    procedure UnRegisterPackage(Index : integer);
    procedure LoadConfigFromIni(const FName, Section : string);
    procedure SaveConfigToIni(const FName, Section : string);
    procedure LoadConfigFromRegistry(const Key : string);
    procedure SaveConfigToRegistry(const Key : string);
    procedure BeginUpdates;
    procedure CancelUpdates;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property PackageHandle[Index : integer] : THandle read GetPackageHandle;
    property ConfigStr : string read GetConfigStr write SetConfigStr;
    property PackagePath[Index : integer] : string read GetPackagePath;
    property PackageCount : integer read GetPackageCount;
    property PackageDesc[Index : integer] : string read GetPackageDesc write SetPackageDesc;
    property PackageLoaded[Index : integer] : Boolean read GetPackageLoaded write SetPackageLoaded;
  published
    property UseRegistry : Boolean read FUseRegistry write FUseRegistry;
    property OnBeforeUnload : TOnBeforeUnloadEvent read FOnBeforeUnload write FOnBeforeUnload;
    property OnPackageUnloaded : TPackageUnloadedEvent read FOnPackageUnloaded write FOnPackageUnloaded;
    property OnPackageLoaded : TPackageLoadedEvent read FOnPackageLoaded write FOnPackageLoaded;
    property Options : TDCPackageLoaderOptions read FOptions write FOptions;
    property IniSection : string read FIniSection write FIniSection;
    property IniFile : string read FIniFile write FIniFile;
    property OnLoaded : TNotifyEvent read FOnLoaded write FOnLoaded;
    property OnGetPackageFileName: TOnGetPackageFileNameEvent read FOnGetPackageFileName write FOnGetPackageFileName;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

{ Returns instance of TDCPACKAGELOADER component. Only one instance of this component is
  allowed in application.}
function GetPackageLoader : TDCPackageLoader;

procedure RegisterPackage(const FileName : string);
function CreateDefaultPackageLoader(Owner : TComponent) : TDCPackageLoader;

procedure DCShowPackagesConfig;
procedure DCCanShowPackagesConfig(var VerbStates : TVerbStates);
procedure DCShowOnlyPackagesConfig;

implementation

uses
  DCPackagesForm;

{------------------------------------------------------------------}

var
  { Initialized package loader object }
  FDCPackageLoader : TDCPackageLoader = nil;

{-------------------------------------------------------------------------}

procedure RegisterPackage(const FileName : string);
begin
  if GetPackageLoader <> nil then
    GetPackageLoader.Registerpackage(FileName, True);
end;

{-------------------------------------------------------------------------}

type
  TPackageListItem = class(TCollectionItem)
  private
    FHandle : THandle;
    FEditorGroup : integer;
    FRequirePackages : TStrings;
    FDesc, FPath, FFullPath : string;
    FLoaded : Boolean;
//    FClasses,FFieldClasses,FNoIconClasses:TList;
    FSkipUnload : Boolean;
    procedure SetRequirePackages(V : TStrings);
  public
    constructor Create(ACollection : TCollection); override;
    destructor Destroy; override;
    procedure AssignTo(ADest : Tpersistent); override;
    function RequirePackage(const PackName : string) : Boolean;
  published
    property Handle : THandle read FHandle write FHandle;
    property Path : string read FPath write FPath;
    property Desc : string read FDesc write FDesc;
    property Loaded : Boolean read FLoaded write FLoaded;
    property SkipUnload : Boolean read FSkipUnload write FSkipUnload;
    property RequirePackages : TStrings read FRequirePackages write SetRequirePackages;
    property EditorGroup : integer read FEditorGroup write FEditorGroup;
  end;

  TPackageList = class(TCollection)
  public
    constructor Create;
//    Function ItemByHandle(Handle:THandle):TPackageListItem;
    function IndexByPath(const APath : string) : integer;
  end;

{------------------------------------------------------------------}

procedure SetPackageLoader(V : TDCPackageLoader);
begin
  if (v = nil) or (FDCPackageLoader = nil) then
    FDCPackageLoader := V
  else
    raise Exception.Create(SErrPackloaderExists);
end;

{------------------------------------------------------------------}

function GetPackageLoader : TDCPackageLoader;
begin
  Result := FDCPackageLoader;
end;

{------------------------------------------------------------------}

procedure TPackageListItem.AssignTo(ADest : Tpersistent);
begin
  if ADest is TPackageListItem then
    begin
      TPackageListItem(ADest).Handle := Handle;
      TPackageListItem(ADest).Path := Path;
      TPackageListItem(ADest).Desc := Desc;
      TPackageListItem(ADest).Loaded := Loaded;
      TPackageListItem(ADest).SkipUnload := SkipUnload;
      TPackageListItem(ADest).RequirePackages := RequirePackages;
      TPackageListItem(ADest).EditorGroup := EditorGroup;
    end
  else
    inherited;
end;

{------------------------------------------------------------------}

constructor TPackagelistItem.Create(ACollection : TCollection);
begin
  inherited;
//  FFieldClasses:=TList.Create;
//  FNoIconClasses:=TList.Create;
//  FClasses:=TList.Create;
  FRequirePackages := TStringList.Create;
end;

{------------------------------------------------------------------}

function TPackageListItem.RequirePackage(const PackName : string) : Boolean;
var
  TempName : string;
  i : integer;
begin
  TempName := ChangeFileExt(ExtractFileName(PackName), '');
  Result := False;
  for i := 0 to FRequirePackages.Count - 1 do
    if CompareText(TempName, FRequirePackages[i]) = 0 then
      begin
        Result := True;
        break;
      end;
end;

{------------------------------------------------------------------}

procedure TPackageListItem.SetRequirePackages(V : TStrings);
begin
  FRequirePackages.Assign(V);
end;

{------------------------------------------------------------------}

destructor TPackagelistItem.Destroy;
begin
  FRequirePackages.Free;
  inherited;
end;

{------------------------------------------------------------------}
var
  _PackageList : TStringList = nil;

const
{$IFDEF CPB3}
  RegisterProc = 'Register$qqrv'; //don't resource
  InstantRegisterProc = 'InstantRegister$qqrv'; //don't resource
{$ELSE}
  RegisterProc = '.Register@51F89FF7'; //don't resource
  InstantRegisterProc = '.InstantRegister@51F89FF7'; //don't resource
{$ENDIF}

procedure GetPackageInfoProc(const Name : string; NameType : TNameType; Flags : Byte; Param : Pointer);

  procedure CallByName(const PrName : string);
  var
    procname : string;
    p : procedure;
  begin
{$IFDEF CPB3}
    procname := Name;
//    {$IFDEF D4}
    procname := AnsiLowerCase(procname);
    procname[1] := AnsiUpperCase(procname[1])[1];
//    {$ENDIF}
    procname := '@' + procname + '@' + PrName;
{$ELSE}
    procname := Name + PrName;
{$ENDIF}
//    ShowMessage(ProcName);
    p := GetProcAddress(_package, PChar(ProcName));
    if Assigned(p) then
      p;
  end;

begin
  case NameType of
    ntContainsUnit :
      begin
        if (name = 'DDEReg') or (name = 'DBExpt') then //don't resource
          exit;
        CallbyName(RegisterProc);
        CallbyName(InstantRegisterProc);
      end;
    ntRequiresPackage :
      begin
        if not Assigned(_PackageList) then
          _PackageList := TStringList.Create;
        _PackageList.Add(Name);
      end;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.ListPackageHandles(L : TList);
var
  i : integer;
begin
  L.Clear;
  for i := 0 to PackageCount - 1 do
    if PackageLoaded[i] then
      L.Add(Pointer(PackageHandle[i]));
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.BeginUpdates;
begin
  FSavePackList.Assign(FPackageList);
end;

{-------------------------------------------------------------------------}

function TPackageList.IndexByPath(const APath : string) : integer;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    if CompareText(APath, (Items[i] as TPackageListItem).Path) = 0 then
      begin
        Result := i;
        exit;
      end;
  Result := -1;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.CancelUpdates;
var
  a, i : integer;
  APath : string;
  ALoaded : Boolean;
  Item : TPackageListItem;
begin
  // delete newly registered packages
  with FPackageList as TPackageList do
    for i := Count - 1 downto 0 do
      if (FSavePackList as TPackageList).IndexByPath(PackagePath[i]) = -1 then
        UnregisterPackage(i);
  // add packages that were unregistered before
  with FSavePackList as TPackageList do
    for i := 0 to Count - 1 do
      begin
        Item := (Items[i] as TPackageListItem);
        APath := Item.Path;
        ALoaded := Item.Loaded;
        if (FPackageList as TPackageList).IndexByPath(APath) = -1 then
          begin
            a := RegisterPackage(APath, Aloaded);
            if a >= 0 then
              if not Aloaded then
                PackageDesc[a] := Item.Desc;
          end;
      end;
  // restore package loaded flag
  for i := 0 to PackageCount - 1 do
    begin
      a := (FSavePackList as TPackageList).IndexByPath(PackagePath[i]);
      if a <> -1 then
        PackageLoaded[i] := TPackageListItem(FSavePackList.Items[a]).Loaded;
    end;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.SetConfigStr(const S : string);
var
  p : pchar;
  ALoad : Boolean;
  L : TStringList;
  a : integer;
  TmpPath: string;
begin
  P := PChar(S);
  UnRegisterPackages;
  L := TStringList.Create;
  try
    while p^ <> #0 do
      begin
        L.Clear;
        L.CommaText := StrPas(p);
        TmpPath := L[1];
        if Assigned(FOnGetPackageFileName) then
          FOnGetPackageFileName(Self, TmpPath);
        if (L.Count = 3) and FileExists(TmpPath) and (L[2][1] in ['0', '1']) then
          begin
            ALoad := L[2] = '1';
            a := RegisterPackageEx(L[1], TmpPath, Aload);
            if a >= 0 then
              if not Aload then
                PackageDesc[a] := L[0];
          end;
        inc(p, StrLen(p) + 1);
      end;
  finally
    L.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.LoadConfigFromIni(const FName, Section : string);
var
  P : PChar;
  TempStr : string;
  Size : integer;
begin
  if Section = '' then
    exit;
  GetMem(p, 32000);
  try
    Size := GetPrivateProfileSection(PChar(Section), p, 32000, Pchar(FName));
    if Size <> 0 then
      begin
        SetLength(TempStr, Size);
        Move(P^, TempStr[1], Size);
        ConfigStr := TempStr;
      end;
  finally
    FreeMem(p, 32000);
  end;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetConfigStr : string;
var
  L : TStringList;
  i : integer;
begin
  Result := '';
  L := TStringList.Create;
  with L do
    for i := 0 to PackageCount - 1 do
      begin
        Clear;
        Add(PackageDesc[i]);
        Add(PackagePath[i]);
        Add(IntToStr(integer(PackageLoaded[i])));
        Result := Result + CommaText + #0;
      end;
  L.Free;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.LoadConfigFromRegistry(const Key : string);
var
  TempStr : string;
begin
  TempStr := ReadFromRegistry(Key, '');
  TempStr := ChangeCharTo(#1, #0, TempStr);
  ConfigStr := TempStr;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.SaveConfigToRegistry(const Key : string);
var
  TempStr : string;
begin
  TempStr := ConfigStr;
  TempStr := ChangeCharTo(#0, #1, TempStr);
  WriteToRegistry(Key, TempStr);
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.SaveConfigToIni(const FName, Section : string);
begin
  WritePrivateProfileSection(PChar(Section), nil, Pchar(FName));
  WritePrivateProfileSection(PChar(Section), pchar(GetConfigStr), Pchar(FName));
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetIniFile : string;
begin
  if FIniFile = '' then
    Result := ChangeFileExt(ParamStr(0), '.INI') //don't resource
  else
    Result := FiniFile;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.DefaultLoadConfig;
begin
  if FUseRegistry then
    LoadConfigFromRegistry(FIniSection)
  else
    LoadConfigFromIni(GetIniFile, FIniSection);
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.loaded;
begin
  inherited;

  if Assigned(FOnLoaded) then
    FOnLoaded(Self);

  if not (csdesigning in ComponentState) and (plAutoLoad in FOptions) then
    begin
      try
        DefaultLoadConfig;
      finally
        FAlreadyLoaded := True;
        if plUpdateOnLoad in FOptions then
          DefaultSaveConfig;
      end;
    end;
end;

{-------------------------------------------------------------------------}

{Function TPackageList.ItemByHandle(Handle:THandle):TPackageListItem;
Var
  i:integer;
begin
  For i:=0 to Count-1 do
    if (Items[i] as TPackageListItem).Handle=Handle then
    begin
      Result:=TPackagelistItem(Items[i]);
      exit;
    end;
  raise Exception.Create(SUnkPackageHandle);
end;}

{-------------------------------------------------------------------------}

constructor TPackageList.Create;
begin
  inherited Create(TPackageListItem);
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetPackageCount : integer;
begin
  Result := FPackageList.Count;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetPackageHandle(Index : integer) : THandle;
begin
  Result := (TPackageList(FPackageList).Items[Index] as TPackageListItem).Handle;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.SetPackageDesc(Index : integer; const Value : string);
begin
  (TPackageList(FPackageList).Items[Index] as TPackageListItem).Desc := Value;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetPackageDesc(Index : integer) : string;
begin
  Result := (TPackageList(FPackageList).Items[Index] as TPackageListItem).Desc;
  if Result = '' then
    Result := PackagePath[Index];
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetPackagePath(Index : integer) : string;
begin
  Result := (TPackageList(FPackageList).Items[Index] as TPackageListItem).Path;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.GetPackageLoaded(Index : integer) : Boolean;
begin
  Result := (TPackageList(FPackageList).Items[Index] as TPackageListItem).Loaded;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.IsPackageRegistered(const PackName : string;
  var OldPackName : string) : Boolean;
var
  i : integer;
  PName : string;
begin
  PName := ExtractFileName(PackName);
  for i := 0 to PackageCount - 1 do
    begin
      if CompareText(PName, ExtractFileName(PackagePath[i])) = 0 then
        begin
          OldPackName := PackagePath[i];
          Result := True;
          exit;
        end;
    end;
  Result := False;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.RegisterPackageEx(const PackName, FullPackName : string;
  ALoad : Boolean) : THandle;
var
  OldName : string;
  P : TPackageListItem;
begin
  Result := INVALID_HANDLE_VALUE;
  if IsPackageRegistered(PackName, OldName) then
    begin
      ShowMessage(Format(SPackAlrRegist, [PackName, OldName]));
      exit;
    end;
  P := TPackageListItem(FPackageList.Add);
  P.Path := PackName;
  P.FFullPath := FullPackName;
  Result := P.Index;
  PackageLoaded[P.Index] := Aload;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.RegisterPackage(const PackName : string; ALoad : Boolean) : THandle;
begin
  Result := RegisterPackageEx(PackName, '', ALoad);
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.UnRegisterPackage(Index : integer);
begin
  PackageLoaded[Index] := False;
  if not PackageLoaded[Index] then
    (TPackageList(FPackageList).Items[Index] as TPackagelistItem).Free;
end;

{-------------------------------------------------------------------------}

{procedure TDCPackageLoader.UnloadVCLPackage;
begin
  If VCLLoaded then
    UnloadPackage(FVCLPackage);
end;}

{-------------------------------------------------------------------------}

{procedure TDCPackageLoader.LoadDBPackage;
var
  pp         : ^pointer;
begin
  If DBLoaded then exit;

  Fdbpackage := GetModuleHandle('VCLDB30.DPL');
  if Fdbpackage = 0 then
  begin
    Fdbpackage := LoadPackage('VCLDB30.DPL');
    DBLoaded:=Fdbpackage<>0;
  end;

  if Fdbpackage <> 0 then
    begin
      pp := GetProcAddress(Fdbpackage, 'Db.RegisterFieldsProc@471138AB');
      if Assigned(pp) then
        pp^ := @mregisterfieldproc;
    end;
end;}

{-------------------------------------------------------------------------}

{procedure TDCPackageLoader.UnloadDBPackage;
begin
  If DBloaded then
    UnloadPackage(FDBPackage);
end;}

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.UnloadThatRequire(P : TObject);
var
  i : integer;
begin
  with TPackageListItem(P) do
    begin
      if SkipUnload then exit;
      for i := 0 to FPackageList.Count - 1 do
        if (FPackageList.Items[i] <> P) and
           (TPackageListItem(FPackageList.Items[i]).RequirePackage(Path)) then
          PackageLoaded[i] := False;
    end;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.SetPackageLoaded(Index : integer; Value : Boolean);
var
  P : TPackageListItem;

//-----------------------------

  procedure SetTrue;
  var
    Flags       : integer;
    ASkipUnload : Boolean;
    OldDir      : string;
    _NewEditorGroup : integer;
    TmpPath     : string;
  begin
    if not CompiledWithPackages then
      begin
        if not FMessageShown then
          begin
            FMessageShown := True;
            ShowMessage(SErrWithoutPackages);
          end;
        exit;
      end;

    _Package := 0;
    _NewEditorGroup := 0;
    try
      if P.FFullPath = '' then
      begin
        TmpPath := P.Path;
        if Assigned(FOnGetPackageFileName) then
          FOnGetPackageFileName(Self, TmpPath);
      end
      else
        TmpPath := P.FFullPath;
      _Package := GetModuleHandle(PChar(TmpPath));
      ASkipUnload := (_Package <> 0);
      if _Package = 0 then
        begin
          OldDir := GetCurrentDir;
          SetCurrentDir(ExtractFilePath(TmpPath));
          try
            _NewEditorGroup := NewEditorGroup;
            _Package := LoadPackage(TmpPath);
          finally
            SetCurrentDir(OldDir);
          end;
        end;
      if _Package <> 0 then
        begin
          try
            P.Handle := _Package;
            if Assigned(_PackageList) then
              _PackageList.Clear;
            P.EditorGroup := _NewEditorGroup;
            GetPackageInfo(_Package, nil, flags, GetPackageInfoProc);
          except
            P.Loaded := True;
            PackageLoaded[Index] := False;
            _Package := 0;
            raise;
          end;
          P.Desc := GetPackageDescription(Pchar(TmpPath));
          P.RequirePackages := _PackageList;
        end;
      P.Loaded := _Package <> 0;
      if P.Loaded then
        begin
          BroadCastToNotifiers(Self, CM_PACKAGELOADED, _package, 0);
          if Assigned(FOnPackageLoaded) then
            FOnPackageLoaded(Self, _package);

        end;
      P.SkipUnload := ASkipUnload;
      if _Package = 0 then
        ShowMessage(Format(SErrorPackageLoad, [TmpPath]));
    except
      Windows.MessageBox(0,
        PChar(Exception(ExceptObject).Message), PChar(Application.Title), MB_ICONERROR + MB_OK);
    end;
  end;

//-----------------------------

  procedure SetFalse;
  var
    CanUnload : Boolean;
  begin
    with P do
      begin
        CanUnload := True;
        if Assigned(FOnBeforeUnload) then
          FOnBeforeUnload(Self, handle, CanUnload);
        if not CanUnload then
          exit;

        CanUnload := NotifiersAgree(Self, CM_BEFOREPACKAGEUNLOAD, Handle, 0);
        if not CanUnload then
          exit;
        if not SkipUnload then
          begin
            UnRegisterModuleClasses(Handle);
            FreeEditorGroup(EditorGroup);
            UnloadThatRequire(P);
            UnloadPackage(Handle);
          end;
        Loaded := False;
        BroadCastToNotifiers(Self, CM_PACKAGEUNLOADED, Handle, 0);
        if Assigned(FOnPackageUnloaded) then
          FOnPackageUnloaded(Self, Handle);
        Handle := 0;
      end;
  end;

//-----------------------------

begin
  P := TPackageList(FPackageList).Items[Index] as TPackagelistItem;
  if P.Loaded <> Value then
    begin
      try
        if Value then
          SetTrue
        else
          SetFalse;
      finally
        if (plAutoUpdate in FOptions) and ([csloading, csdestroying, csreading] * ComponentState = []) and FAlreadyLoaded then
          DefaultSaveConfig;
      end;
    end;
end;

{-------------------------------------------------------------------------}

constructor TDCPackageLoader.Create(AOwner : TComponent);
begin
(*
  {$IFDEF Demo}
   If (Not DelphiRunning) then
     begin
       ShowMessage('Unregistered version of Package Loader won''t run without Delphi');
       Application.Terminate;
     end;
  {$ENDIF}
*)
  if GetPackageLoader <> nil then
    raise Exception.Create(SOnlyOnePackageLoader);
  inherited;

  FPackageList := TPackagelist.Create;
  FSavePackList := TPackageList.Create;
//  FOptions:=[plAutoSave,plAutoLoad{,plTrackFields}];
  SetPackageLoader(Self);
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.UnRegisterPackages;
var
  i : integer;
begin
  for i := 0 to PackageCount - 1 do
    PackageLoaded[i] := False;
  FPackageList.Clear;
end;

{-------------------------------------------------------------------------}

procedure TDCPackageLoader.DefaultSaveConfig;
begin
  if FUseRegistry then
    SaveConfigToRegistry(FIniSection)
  else
    SaveConfigToIni(GetIniFile, FIniSection);
end;

{-------------------------------------------------------------------------}

destructor TDCPackageLoader.Destroy;
begin
  if not (csdesigning in ComponentState) and (plAutoSave in FOptions) then
    begin
      DefaultSaveConfig;
      UnregisterPackages;
    end;
  FPackageList.Free;
  FSavePackList.Free;
  inherited;
  if GetPackageLoader = Self then
    SetPackageLoader(nil);
end;

{--------------------------------------------}

procedure TDCPackageLoader.ShowPackagesConfig;
begin
  DCShowPackagesConfig;
end;

{--------------------------------------------}

function CreateDefaultPackageLoader(Owner : TComponent) : TDCPackageLoader;
begin
  Result := TDCPackageLoader.Create(Owner);
  with Result do
    begin
      IniSection := SRegPackages;
      UseRegistry := True;
      Options := [];
      try
        DefaultLoadConfig;
      finally
        DefaultSaveConfig;
        Options := [plAutoSave, plAutoUpdate];
      end;
    end;
end;

{-------------------------------------------------------------------------}

function TDCPackageLoader.RegisteredPackageCount : integer;
var
  i : integer;
begin
  Result := 0;
  for I := 0 to PackageCount - 1 do
    if PackageLoaded[i] then
      inc(Result);
end;

{-------------------------------------------------------------------------}

function DCCanConfigPackages : Boolean;
begin
{$IFDEF D3}
  Result := CompiledWithPackages or (GetPackageLoader <> nil);
{$ELSE}
  Result := False;
{$ENDIF}
end;

{-------------------------------------------------------------------------}

procedure DCCanShowPackagesConfig(var VerbStates : TVerbStates);
begin
  if not DCCanConfigPackages then
    Exclude(VerbStates, vsEnabled);
end;

{-------------------------------------------------------------------------}

procedure _Register;
begin
  RegisterNonInstant([TDCPackageLoader]);

  RegisterVerb(SVerbCfgPackagesActivex, nil, DCShowPackagesConfig);
  RegisterVerb(SVerbCfgPackages, DCCanShowPackagesConfig, DCShowOnlyPackagesConfig);
end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------------------}

procedure DCShowPackagesConfig;
var
  EnvOpts : TList;
begin
  EnvOpts := TList.Create;
  try
    if CompiledWithPackages and (GetPackageLoader <> nil) then
      EnvOpts.Add(TDCPackagesEditor);
    EnvOpts.Add(TDCActiveXEditor);
    ShowEnvOptions(EnvOpts);
  finally
    EnvOpts.Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure DCShowOnlyPackagesConfig;
var
  EnvOpts : TList;
begin
  if GetPackageLoader = nil then
    begin
      Beep;
      Exit;
    end;
  EnvOpts := TList.Create;
  try
    EnvOpts.Add(TDCPackagesEditor);
    ShowEnvOptions(EnvOpts);
  finally
    EnvOpts.Free;
  end;
end;

{-------------------------------------------------------------------------}

initialization
  RunRegister;

  OptionFormCaptions.AddObject(SRegPackages, TObject(TDCPackagesEditor));
  OptionFormCaptions.AddObject(SPalActiveX, TObject(TDCActiveXEditor));
finalization
  GetPackageLoader.Free;
  _PackageList.Free;
end.

