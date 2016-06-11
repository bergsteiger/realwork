{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.ShareContract;

interface

{$SCOPEDENUMS ON}

uses
  System.Sysutils, System.Win.WinRT, System.Classes, System.Generics.Collections, Winapi.Windows,
  WinAPI.WinRT, WinAPI.Foundation.Types, WinAPI.ApplicationModel.DataTransfer, WinAPI.Storage, WinAPI.Storage.Streams;

{$HPPEMIT 'using namespace Winapi::Applicationmodel::Datatransfer;'}

type
  /// <summary>Exception class for ShareContract specific exceptions</summary>
  EShareContractException = class(Exception);

  /// <summary>Signature for an event fired when a target application has been chosen</summary>
  TApplicationChosenEvent = procedure(const Sender: TObject; const AManager: IDataTransferManager;
    const Args: ITargetApplicationChosenEventArgs) of object;
  /// <summary>Signature for an event fired when requiring data for an ongoing transference</summary>
  TTransferDataEvent = procedure(const Sender: TObject; const ARequest: IDataProviderRequest) of object;
  /// <summary>Signature for a procedure to be executed when processing the application message queue is is needed</summary>
  TProcessMessagesProc = procedure of object;

  /// <summary>Class that encapsulate and provides access to the sharing contract</summary>
  TShareContract = class
  private type
    TDataTransferEventHandler = class(TInspectableObject,
        TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs_Delegate_Base,
        TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs)
    private
      [Weak] FOwner: TShareContract;
      procedure Invoke(sender: IDataTransferManager; args: IDataRequestedEventArgs); safecall;
    public
      constructor Create(const AOwner: TShareContract);
      destructor Destroy; override;
    end;

    TAppChosenEventHandler = class(TInspectableObject,
        TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs_Delegate_Base,
        TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs)
    private
      [Weak] FOwner: TShareContract;
      procedure Invoke(sender: IDataTransferManager; args: ITargetApplicationChosenEventArgs); safecall;
    public
      constructor Create(const AOwner: TShareContract);
    end;

    TDataProviderHandler = class(TInspectableObject, DataProviderHandler)
    private
      [Weak] FOwner: TShareContract;
      procedure Invoke(request: IDataProviderRequest); safecall;
    public
      constructor Create(const AOwner: TShareContract);
    end;

    TCompletedHandler = class(TInspectableObject,
        AsyncOperationCompletedHandler_1__IStorageFile_Delegate_Base,
        AsyncOperationCompletedHandler_1__IStorageFile)
    private
      FStatus: AsyncStatus;
      function GetAsyncStatus: AsyncStatus;
    public
      procedure Invoke(asyncInfo: IAsyncOperation_1__IStorageFile; aasyncStatus: AsyncStatus); safecall;
      property Status: AsyncStatus read GetAsyncStatus;
    end;

  private
    class var
    FProcessMessages: TProcessMessagesProc;
    class var
    FBasePath: string;

  private
    FOnTransferImage: TTransferDataEvent;
    FOnAppChosen: TApplicationChosenEvent;
    FPackageName: string;
    FContentSourceWebLink: string;
    FContentSourceApplicationLink: string;
    FImageFile: string;
    FIconFile: string;
    FWebAddress: string;
    FApplicationName: string;
    FDescription: string;
    FDataTitle: string;
    FDataText: string;
    FLogoFile: string;
    FRtfText: string;
    FHTML: string;

    procedure DoTransferImage(const ARequest: IDataProviderRequest);
    procedure DoAppChosen(sender: IDataTransferManager; args: ITargetApplicationChosenEventArgs);

    class procedure SetProcessMessages(const Value: TProcessMessagesProc); static;
  protected
    /// <summary>Window Handle needed to share data</summary>
    FWindowHandle: THandle;
    /// <summary>Interface to access to the SharingContract</summary>
    FTransferManager: IDataTransferManager;
    /// <summary>Event Registration token needed to unregister the DataRequestedHandler</summary>
    FSharingRequested: EventRegistrationToken;
    /// <summary>Event Registration token needed to unregister the AppChosenHandler</summary>
    FTargetAppRequested: EventRegistrationToken;
    /// <summary>EventHandler to manage DataRequest events</summary>
    FDataRequestedHandlerIntf: TypedEventHandler_2__IDataTransferManager__IDataRequestedEventArgs;
    /// <summary>EventHandler to manage AppChosen events</summary>
    FAppChosenHandlerIntf: TypedEventHandler_2__IDataTransferManager__ITargetApplicationChosenEventArgs;
    /// <summary>EventHandler to manage Image Transfer events</summary>
    FImageDataProvider: DataProviderHandler;

  private
    class procedure ProcessMessages;

  public
    constructor Create(AWinHandle: HWND);
    destructor Destroy; override;

    /// <summary>User invoked procedure to start sharing data with other applications</summary>
    procedure InitSharing;

    /// <summary>Property that holds a reference to the Application's ProcessMessages procedure</summary>
    class property OnProcessMessages: TProcessMessagesProc read FProcessMessages write SetProcessMessages;

    /// <summary>Commom path to be used with properties that hold a file name</summary>
    class property BasePath: string read FBasePath write FBasePath;

    /// <summary>Function that converts a FileName to a IRandomAccessStreamReference. Opens and loads the specified file.</summary>
    class function FileNameToStream(const AFileName: string): IRandomAccessStreamReference; static;
  public
    /// <summary>Application Name to be shared with the target application</summary>
    property ApplicationName: string read FApplicationName write FApplicationName;
    /// <summary>ContentSourceWebLink to be shared with the target application</summary>
    property ContentSourceWebLink: string read FContentSourceWebLink write FContentSourceWebLink;
    /// <summary>ContentSourceApplicationLink to be shared with the target application</summary>
    property ContentSourceApplicationLink: string read FContentSourceApplicationLink write FContentSourceApplicationLink;
    /// <summary>DataText to be shared with the target application</summary>
    property DataText: string read FDataText write FDataText;
    /// <summary>DataTitle to be shared with the target application</summary>
    property DataTitle: string read FDataTitle write FDataTitle;
    /// <summary>Description to be shared with the target application</summary>
    property Description: string read FDescription write FDescription;
    /// <summary>IconFile to be shared with the target application</summary>
    property IconFile: string read FIconFile write FIconFile;
    /// <summary>ImageFile to be shared with the target application</summary>
    property ImageFile: string read FImageFile write FImageFile;
    /// <summary>LogoFile to be shared with the target application</summary>
    property LogoFile: string read FLogoFile write FLogoFile;
    /// <summary>Package Name to be shared with the target application</summary>
    property PackageName: string read FPackageName write FPackageName;
    /// <summary>Web address to be shared with the target application</summary>
    property WebAddress: string read FWebAddress write FWebAddress;

    /// <summary>RtfText to be shared with the target application</summary>
    property RtfText: string read FRtfText write FRtfText;
    /// <summary>HTML to be shared with the target application</summary>
    property HTML: string read FHTML write FHTML;

    // Events...
    /// <summary>Event invoked when sharing an Image</summary>
    property OnTransferImage: TTransferDataEvent read FOnTransferImage write FOnTransferImage;
    /// <summary>Event invoked when user selects a target application that is going to receive the shared information</summary>
    property OnAppChosen: TApplicationChosenEvent read FOnAppChosen write FOnAppChosen;
  end;

implementation

uses
  WinAPI.CommonTypes, WinAPI.Foundation, WinAPI.Foundation.Collections,
  System.IOUtils, System.RTLConsts;


{ TShareContract }

constructor TShareContract.Create(AWinHandle: HWND);
begin
  inherited Create;

  if not Assigned(FProcessMessages) then
    raise EShareContractException.Create(SShareContractNotInitialized);

  FWindowHandle := AWinHandle;

  if TOSVersion.Check(10) then
  begin
    FTransferManager := TDataTransferManager.Interop.GetForWindow(FWindowHandle, TWinRTImportHelper.GetUIID<IDataTransferManager>);

    // Set Handler???
    FDataRequestedHandlerIntf := TDataTransferEventHandler.Create(Self);
    FSharingRequested := FTransferManager.add_DataRequested(FDataRequestedHandlerIntf);

    FAppChosenHandlerIntf := TAppChosenEventHandler.Create(Self);

    FTargetAppRequested := FTransferManager.add_TargetApplicationChosen(FAppChosenHandlerIntf);

    FImageDataProvider := TDataProviderHandler.Create(Self);
  end;
end;

destructor TShareContract.Destroy;
begin
  if FTransferManager <> nil then
  begin
    FTransferManager.remove_DataRequested(FSharingRequested);
    FTransferManager.remove_TargetApplicationChosen(FTargetAppRequested);
  end;
  inherited;
end;

procedure TShareContract.DoAppChosen(sender: IDataTransferManager; args: ITargetApplicationChosenEventArgs);
begin
  if Assigned(FOnAppChosen) then
    FOnAppChosen(Self, sender, args);
end;

procedure TShareContract.DoTransferImage(const ARequest: IDataProviderRequest);
begin
  if Assigned(FOnTransferImage) then
    FOnTransferImage(Self, ARequest)
  else
    ARequest.SetData(FileNameToStream(ImageFile));
end;

class function TShareContract.FileNameToStream(const AFileName: string): IRandomAccessStreamReference;
var
  LFileName: TWindowsString;
  LFileAsync: IAsyncOperation_1__IStorageFile;
  LCompHandler: AsyncOperationCompletedHandler_1__IStorageFile;
begin
  Result := nil;
  LFileName := TWindowsString.Create(TPath.Combine(FBasePath, AFileName));
  LFileAsync := TStorageFile.Statics.GetFileFromPathAsync(LFileName);

  LCompHandler := TShareContract.TCompletedHandler.Create;
  LFileAsync.Completed := LCompHandler;

  if TShareContract.TCompletedHandler(LCompHandler).Status = AsyncStatus.Completed then
    Result := TRandomAccessStreamReference.Statics.CreateFromFile(LFileAsync.GetResults);
end;

procedure TShareContract.InitSharing;
begin
  if TOsVersion.Check(10) then
    TDataTransferManager.Interop.ShowShareUIForWindow(FWindowHandle)
  else
    raise EShareContractException.CreateFmt(SShareContractNotSupported, [TOSVersion.ToString]);
end;

class procedure TShareContract.ProcessMessages;
begin
  if Assigned(FProcessMessages) then
    FProcessMessages;
end;

class procedure TShareContract.SetProcessMessages(const Value: TProcessMessagesProc);
begin
  FProcessMessages := Value;
end;

{ TShareContract.TDataTransferEventHandler }

constructor TShareContract.TDataTransferEventHandler.Create(const AOwner: TShareContract);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TShareContract.TDataTransferEventHandler.Destroy;
begin

  inherited;
end;

procedure TShareContract.TDataTransferEventHandler.Invoke(sender: IDataTransferManager;
  args: IDataRequestedEventArgs);
var
  LRequest: IDataRequest;
  LDataPackage: IDataPackage;
  LProperties: IDataPackagePropertySet;
  LProperties2: IDataPackagePropertySet2;
  LURI: IUriRuntimeClass;
  LWebURI: IUriRuntimeClass;
  LWebAppURI: IUriRuntimeClass;
  LWindowsString: TWindowsString;
begin
  LRequest := args.get_Request;
  LDataPackage := LRequest.get_Data;

  LProperties := LDataPackage.get_Properties;

  if FOwner.DataTitle <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.DataTitle);
    LProperties.Title := LWindowsString;
  end;

  if FOwner.ApplicationName <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.ApplicationName);
    LProperties.ApplicationName := LWindowsString;
  end;

  if FOwner.Description <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.Description);
    LProperties.Description := LWindowsString;
  end;

  if FOwner.ImageFile <> '' then
  begin
    LProperties.Thumbnail := FileNameToStream(FOwner.ImageFile);
  end;

  if FOwner.DataText <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.DataText);
    LDataPackage.SetText(LWindowsString);
  end;

  if FOwner.RtfText <> '' then
  begin
    LDataPackage.Properties.FileTypes.Append(TStandardDataFormats.Statics.Rtf);
    LWindowsString := TWindowsString.Create(FOwner.RtfText);
    LDataPackage.SetRtf(LWindowsString);
  end;

  if FOwner.HTML <> '' then
  begin
    LDataPackage.Properties.FileTypes.Append(TStandardDataFormats.Statics.Html);
    LWindowsString := TWindowsString.Create(FOwner.HTML);
    LDataPackage.SetHtmlFormat(THtmlFormatHelper.Statics.CreateHtmlFormat(LWindowsString));
  end;

  if FOwner.WebAddress <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.WebAddress);
    LURI := TUri.Factory.CreateUri(LWindowsString);
    LDataPackage.SetUri(LURI);
  end;

  LProperties2 := LDataPackage.get_Properties as IDataPackagePropertySet2;

  if FOwner.ContentSourceApplicationLink <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.ContentSourceApplicationLink);
    LWebAppURI := TUri.Factory.CreateUri(LWindowsString);
    LProperties2.ContentSourceApplicationLink := LWebAppURI;
  end;

  if FOwner.ContentSourceWebLink <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.ContentSourceWebLink);
    LWebURI := TUri.Factory.CreateUri(LWindowsString);
    LProperties2.ContentSourceWebLink := LWebURI;
  end;

  if FOwner.PackageName <> '' then
  begin
    LWindowsString := TWindowsString.Create(FOwner.PackageName);
    LProperties2.PackageFamilyName := LWindowsString;
  end;

  if FOwner.LogoFile <> '' then
    LProperties2.Square30x30Logo := FileNameToStream(FOwner.LogoFile);

  LRequest.Data.SetDataProvider(TStandardDataFormats.Statics.Bitmap, FOwner.FImageDataProvider);
end;

{ TShareContractComponent.TAppChosenEventHandler }

constructor TShareContract.TAppChosenEventHandler.Create(const AOwner: TShareContract);
begin
  FOwner := AOwner;
end;

procedure TShareContract.TAppChosenEventHandler.Invoke(sender: IDataTransferManager; args: ITargetApplicationChosenEventArgs);
begin
  FOwner.DoAppChosen(sender, args);
end;

{ TShareContract.TDataProviderHandler }

constructor TShareContract.TDataProviderHandler.Create(const AOwner: TShareContract);
begin
  FOwner := AOwner;
end;

procedure TShareContract.TDataProviderHandler.Invoke(request: IDataProviderRequest);
begin
  FOwner.DoTransferImage(request);
end;

{ TShareContract.TCompletedHandler }

function TShareContract.TCompletedHandler.GetAsyncStatus: AsyncStatus;
begin
  while FStatus = AsyncStatus.Started do
    TShareContract.ProcessMessages;

  Result := FStatus;
end;

procedure TShareContract.TCompletedHandler.Invoke(asyncInfo: IAsyncOperation_1__IStorageFile;
  aasyncStatus: AsyncStatus);
begin
  FStatus := aasyncstatus;
end;

end.
