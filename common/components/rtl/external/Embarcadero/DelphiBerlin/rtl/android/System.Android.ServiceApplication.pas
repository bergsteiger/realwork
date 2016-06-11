{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Android.ServiceApplication;

interface

uses
  System.SysUtils,
  System.Classes;

type
  /// <summary>Component to use services like an application module</summary>
  TServiceApplication = class(TComponent)
  private
    class constructor Create;
    procedure OnExceptionHandler(Sender: TObject);
  protected
    /// <summary>Exception Handler for non user managed exceptions</summary>
    /// <remarks>Exceptions not managed by the user will be shown in the android logcat</remarks>
    procedure DoHandleException(E: Exception); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // The following uses the current behaviour of the IDE module manager
    /// <summary>Create an Instance of the class type from InstanceClass param</summary>
    procedure CreateForm(InstanceClass: TComponentClass; var Reference); virtual;
    /// <summary>Initializes the service application</summary>
    procedure Initialize; virtual;
    /// <summary>Main loop of the application service</summary>
    procedure Run; virtual;
  end;

var
  /// <summary>Global var to acces to the Application Service</summary>
  Application: TServiceApplication = nil;

implementation

uses
{$IFDEF ANDROID}
  Androidapi.Log,
  Posix.Dlfcn,
  Androidapi.Helpers,
  AndroidApi.JNI,
  AndroidApi.JNI.App,
  Androidapi.JNIBridge,
  Androidapi.JNI.Os,
  AndroidApi.JNI.GraphicsContentViewText,
{$ENDIF ANDROID}
  System.Android.Service;

type
  TAndroidServiceCallbacks = class(TServiceCallbacks);

{ TServiceApplication }

constructor TServiceApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(System.Classes.ApplicationHandleException) then
    System.Classes.ApplicationHandleException := OnExceptionHandler;
end;

class constructor TServiceApplication.Create;
begin
  Application := TServiceApplication.Create(nil);
end;

procedure TServiceApplication.CreateForm(InstanceClass: TComponentClass; var Reference);
begin
  if InstanceClass.InheritsFrom(TAndroidBaseService) then
  begin
    try
      TComponent(Reference) := InstanceClass.Create(Self);
      if InstanceClass.InheritsFrom(TAndroidService) then
        TAndroidServiceCallbacks.FService := TAndroidService(Reference);
      if InstanceClass.InheritsFrom(TAndroidIntentService) then
        TAndroidServiceCallbacks.FIntentService := TAndroidIntentService(Reference);
    except
      TComponent(Reference) := nil;
      raise;
    end;
  end;
end;

destructor TServiceApplication.Destroy;
begin

  inherited Destroy;
end;

procedure TServiceApplication.DoHandleException(E: Exception);
{$IFDEF ANDROID}
var
  M: TMarshaller;
{$ENDIF ANDROID}
begin
{$IFDEF ANDROID}
  LOGE(M.AsUtf8(E.Message).ToPointer);
{$ENDIF ANDROID}
end;

procedure TServiceApplication.Initialize;
begin

end;

procedure TServiceApplication.OnExceptionHandler(Sender: TObject);
begin
  DoHandleException(Exception(ExceptObject));
end;

procedure TServiceApplication.Run;
begin

end;


{$IFDEF ANDROID}
/////////////////////
///  Glue code
/////////////////////

procedure SystemEntry(const LibName: string);

  function StrToCStr(const Str: string; Dest: MarshaledAString): MarshaledAString;  // Only ASCII chars
  var
    I: Integer;
  begin
    Result := Dest;
    for I := Low(Str) to High(Str) do
    begin
      Byte(Dest^) := Byte(Str[I]);
      Inc(Dest);
    end;
    Byte(Dest^) := 0;
  end;


type
  TMainFunction = procedure;
var
  CStr: MarshaledAString;
  DlsymPointer: Pointer;
  EntryPoint: TMainFunction;
  Lib: NativeUInt;
begin
  CStr := System.AllocMem(512);
  Lib := dlopen(StrToCStr(LibName, CStr), RTLD_LAZY);
  System.FreeMem(CStr);
  if Lib <> 0 then
  begin
    DlsymPointer := dlsym(Lib, '_NativeMain');
    dlclose(Lib);
    if DlsymPointer <> nil then
    begin
      EntryPoint := TMainFunction(DlsymPointer);
      EntryPoint;
    end;
  end;
end;

procedure OnCreateDelphi(PEnv: PJNIEnv; This: JNIObject; LibraryName: JNIString); cdecl;
var
  LService: JService;
begin
  if System.JavaContext = nil then
  begin
    PEnv^.GetJavaVM(PEnv, @System.JavaMachine);
    System.JavaContext := PEnv^.NewGlobalRef(PEnv, This);
  end;

  SystemEntry(JNIStringToString(PEnv, LibraryName));

  LService := TJService.Wrap(System.JavaContext);
  TAndroidServiceCallbacks.OnCreateCallback(LService);
end;

procedure OnDestroyDelphi(PEnv: PJNIEnv; This: JNIObject; Service: JNIObject); cdecl;
begin
  TAndroidServiceCallbacks.OnDestroyCallback;
end;

function OnStartCommandDelphi(PEnv: PJNIEnv; This: JNIObject; JNIStartIntent: JNIObject; Flags, StartID: Integer): Integer; cdecl;
var
  Intent: JIntent;
begin
  Intent := TJIntent.Wrap(JNIStartIntent);
  Result := TAndroidServiceCallbacks.OnStartCommandCallback(Intent, Flags, StartID);
end;

function OnBindDelphi(PEnv: PJNIEnv; This: JNIObject; JNIIntent: JNIObject): JNIObject; cdecl;
var
  Intent: JIntent;
  LBinder: JIBinder;
begin
  Intent := TJIntent.Wrap(JNIIntent);
  LBinder := TAndroidServiceCallbacks.OnBindCallback(Intent);
  Result := (LBinder as ILocalObject).GetObjectID;
end;

function onUnbindDelphi(PEnv: PJNIEnv; This: JNIObject; JNIIntent: JNIObject): Boolean; cdecl;
var
  Intent: JIntent;
begin
  Intent := TJIntent.Wrap(JNIIntent);
  Result := TAndroidServiceCallbacks.onUnbindCallback(Intent);
end;

procedure OnRebindDelphi(PEnv: PJNIEnv; This: JNIObject; JNIintent: JNIObject); cdecl;
var
  Intent: JIntent;
begin
  Intent := TJIntent.Wrap(JNIIntent);
  TAndroidServiceCallbacks.onRebindCallback(Intent);
end;

procedure OnTaskRemovedDelphi(PEnv: PJNIEnv; This: JNIObject; JNIrootIntent: JNIObject); cdecl;
var
  RootIntent: JIntent;
begin
  RootIntent := TJIntent.Wrap(JNIrootIntent);
  TAndroidServiceCallbacks.onTaskRemovedCallback(RootIntent);
end;

procedure OnConfigurationChangedDelphi(PEnv: PJNIEnv; This: JNIObject; JNInewConfig: JNIObject); cdecl;
var
  LConfig: JConfiguration;
begin
  LConfig := TJConfiguration.Wrap(JNInewConfig);
  TAndroidServiceCallbacks.onConfigurationChangedCallback(LConfig);
end;

procedure OnLowMemoryDelphi(PEnv: PJNIEnv; This: JNIObject); cdecl;
begin
  TAndroidServiceCallbacks.onLowMemoryCallback;
end;

procedure OnTrimMemoryDelphi(PEnv: PJNIEnv; This: JNIObject; level: Integer); cdecl;
begin
  TAndroidServiceCallbacks.onTrimMemoryCallback(level);
end;

procedure OnHandleIntentDelphi(PEnv: PJNIEnv; This: JNIObject; JNIintent: JNIObject); cdecl;
var
  Intent: JIntent;
begin
  Intent := TJIntent.Wrap(JNIIntent);
  TAndroidServiceCallbacks.onHandleIntentCallback(Intent);
end;

function getDelphiService: Int64 ; cdecl;
begin
  Result := TAndroidServiceCallbacks.GetDelphiService;
end;


function OnHandleMessageDelphi(PEnv: PJNIEnv; This: JNIObject; JNIMessage: JNIObject): Boolean; cdecl;
var
  LMessage: JMessage;
begin
  LMessage := TJMessage.Wrap(JNIMessage);
  Result := TAndroidServiceCallbacks.onHandleMessageCallback(LMessage);
end;


exports
  OnCreateDelphi,
  OnDestroyDelphi,
  OnStartCommandDelphi,
  OnBindDelphi,
  OnUnbindDelphi,
  OnRebindDelphi,
  OnTaskRemovedDelphi,
  OnConfigurationChangedDelphi,
  OnLowMemoryDelphi,
  OnTrimMemoryDelphi,
  OnHandleIntentDelphi,
  OnHandleMessageDelphi,
  getDelphiService;


{$ENDIF ANDROID}

end.
