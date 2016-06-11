{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Vcl.ShareContract;

interface

{$SCOPEDENUMS ON}

uses
  System.Win.ShareContract, System.Classes, System.Generics.Collections;


type
  /// <summary>Custom component to manage the ShareContract</summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TCustomSharingContract = class(TComponent)
  private
    FShareContract: TShareContract;
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
    FOnTransferImage: TTransferDataEvent;
    FOnAppChosen: TApplicationChosenEvent;
    function GetOnTransferImage: TTransferDataEvent;
    procedure SetOnTransferImage(const Value: TTransferDataEvent);
    function GetApplicationName: string;
    function GetContentSourceApplicationLink: string;
    function GetContentSourceWebLink: string;
    function GetDataText: string;
    function GetDataTitle: string;
    function GetDescription: string;
    function GetHTML: string;
    function GetIconFile: string;
    function GetImageFile: string;
    function GetLogoFile: string;
    function GetPackageName: string;
    function GetRtfText: string;
    function GetWebAddress: string;
    procedure SetApplicationName(const Value: string);
    procedure SetContentSourceApplicationLink(const Value: string);
    procedure SetContentSourceWebLink(const Value: string);
    procedure SetDataText(const Value: string);
    procedure SetDataTitle(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetHTML(const Value: string);
    procedure SetIconFile(const Value: string);
    procedure SetImageFile(const Value: string);
    procedure SetLogoFile(const Value: string);
    procedure SetPackageName(const Value: string);
    procedure SetRtfText(const Value: string);
    procedure SetWebAddress(const Value: string);
    procedure CheckShareContract;
    function GetOnAppChosen: TApplicationChosenEvent;
    procedure SetOnAppChosen(const Value: TApplicationChosenEvent);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>Initialize sharing with current state of sharing properties</summary>
    procedure InitSharing;

    /// <summary>Property to manage the Application Name that is going to be shared</summary>
    property ApplicationName: string read GetApplicationName write SetApplicationName;
    /// <summary>Property to manage the ContentSource WebLink that is going to be shared</summary>
    property ContentSourceWebLink: string read GetContentSourceWebLink write SetContentSourceWebLink;
    /// <summary>Property to manage the ContentSource ApplicationLink that is going to be shared</summary>
    property ContentSourceApplicationLink: string read GetContentSourceApplicationLink write SetContentSourceApplicationLink;
    /// <summary>Property to manage the Data Text that is going to be shared</summary>
    property DataText: string read GetDataText write SetDataText;
    /// <summary>Property to manage the Data Title that is going to be shared</summary>
    property DataTitle: string read GetDataTitle write SetDataTitle;
    /// <summary>Property to manage the Description that is going to be shared</summary>
    property Description: string read GetDescription write SetDescription;
    /// <summary>Property to manage the Icon File that is going to be shared</summary>
    property IconFile: string read GetIconFile write SetIconFile;
    /// <summary>Property to manage the Image File that is going to be shared</summary>
    property ImageFile: string read GetImageFile write SetImageFile;
    /// <summary>Property to manage the Logo File that is going to be shared</summary>
    property LogoFile: string read GetLogoFile write SetLogoFile;
    /// <summary>Property to manage the Package Name that is going to be shared</summary>
    property PackageName: string read GetPackageName write SetPackageName;
    /// <summary>Property to manage the WebAddress that is going to be shared</summary>
    property WebAddress: string read GetWebAddress write SetWebAddress;

    /// <summary>Property to manage the Rtf Text that is going to be shared</summary>
    property RtfText: string read GetRtfText write SetRtfText;
    /// <summary>Property to manage the HTML that is going to be shared</summary>
    property HTML: string read GetHTML write SetHTML;

    /// <summary>Event invoked when sharing an Image</summary>
    property OnTransferImage: TTransferDataEvent read GetOnTransferImage write SetOnTransferImage;
    /// <summary>Event invoked when user selects a target application that is going to receive the shared information</summary>
    property OnAppChosen: TApplicationChosenEvent read GetOnAppChosen write SetOnAppChosen;
  end;

  /// <summary>Component to manage Windows Sharing Contract</summary>
  TSharingContract = class(TCustomSharingContract)
  published
    property ApplicationName;
    property ContentSourceWebLink;
    property ContentSourceApplicationLink;
    property DataText;
    property DataTitle;
    property Description;
    property IconFile;
    property ImageFile;
    property LogoFile;
    property PackageName;
    property WebAddress;

    property RtfText;
    property HTML;

    property OnTransferImage;
    property OnAppChosen;
  end;


implementation

uses
  Vcl.Controls, Vcl.Forms,
  System.RTLConsts,
  System.SysUtils;


{ TCustomSharingContract }

constructor TCustomSharingContract.Create(AOwner: TComponent);
begin
  inherited;
  TShareContract.OnProcessMessages := Application.ProcessMessages;
  TShareContract.BasePath := ExtractFilePath(Application.ExeName);
  if Application.MainFormHandle <> 0 then
    FShareContract := TShareContract.Create(Application.MainFormHandle);
end;

destructor TCustomSharingContract.Destroy;
begin
  FShareContract.Free;
  inherited;
end;

function TCustomSharingContract.GetApplicationName: string;
begin
  if FShareContract <> nil then
    FApplicationName := FShareContract.ApplicationName;
  Result := FApplicationName;
end;

function TCustomSharingContract.GetContentSourceApplicationLink: string;
begin
  if FShareContract <> nil then
    FContentSourceApplicationLink := FShareContract.ContentSourceApplicationLink;
  Result := FContentSourceApplicationLink;
end;

function TCustomSharingContract.GetContentSourceWebLink: string;
begin
  if FShareContract <> nil then
    FContentSourceWebLink := FShareContract.ContentSourceWebLink;
  Result := FContentSourceWebLink;
end;

function TCustomSharingContract.GetDataText: string;
begin
  if FShareContract <> nil then
    FDataText := FShareContract.DataText;
  Result := FDataText;
end;

function TCustomSharingContract.GetDataTitle: string;
begin
  if FShareContract <> nil then
    FDataTitle := FShareContract.DataTitle;
  Result := FDataTitle;
end;

function TCustomSharingContract.GetDescription: string;
begin
  if FShareContract <> nil then
    FDescription := FShareContract.Description;
  Result := FDescription;
end;

function TCustomSharingContract.GetHTML: string;
begin
  if FShareContract <> nil then
    FHTML := FShareContract.HTML;
  Result := FHTML;
end;

function TCustomSharingContract.GetIconFile: string;
begin
  if FShareContract <> nil then
    FIconFile := FShareContract.IconFile;
  Result := FIconFile;
end;

function TCustomSharingContract.GetImageFile: string;
begin
  if FShareContract <> nil then
    FImageFile := FShareContract.ImageFile;
  Result := FImageFile;
end;

function TCustomSharingContract.GetLogoFile: string;
begin
  if FShareContract <> nil then
    FLogoFile := FShareContract.LogoFile;
  Result := FLogoFile;
end;

function TCustomSharingContract.GetOnAppChosen: TApplicationChosenEvent;
begin
  if FShareContract <> nil then
    FOnAppChosen := FShareContract.OnAppChosen;
  Result := FOnAppChosen;
end;

function TCustomSharingContract.GetOnTransferImage: TTransferDataEvent;
begin
  if FShareContract <> nil then
    FOnTransferImage := FShareContract.OnTransferImage;
  Result := FOnTransferImage;
end;

function TCustomSharingContract.GetPackageName: string;
begin
  if FShareContract <> nil then
    FPackageName := FShareContract.PackageName;
  Result := FPackageName;
end;

function TCustomSharingContract.GetRtfText: string;
begin
  if FShareContract <> nil then
    FRtfText := FShareContract.RtfText;
  Result := FRtfText;
end;

function TCustomSharingContract.GetWebAddress: string;
begin
  if FShareContract <> nil then
    FWebAddress := FShareContract.WebAddress;
  Result := FWebAddress;
end;

procedure TCustomSharingContract.InitSharing;
begin
  CheckShareContract;
  if FShareContract = nil then
  begin
    FShareContract := TShareContract.Create(Application.MainFormHandle);
    // Set Shared Data
    FShareContract.ApplicationName := FApplicationName;
    FShareContract.ContentSourceApplicationLink := FContentSourceApplicationLink;
    FShareContract.ContentSourceWebLink := FContentSourceWebLink;
    FShareContract.DataText := FDataText;
    FShareContract.DataTitle := FDataTitle;
    FShareContract.Description := FDescription;
    FShareContract.HTML := FHTML;
    FShareContract.IconFile := FIconFile;
    FShareContract.ImageFile := FImageFile;
    FShareContract.LogoFile := FLogoFile;
    FShareContract.PackageName := FPackageName;
    FShareContract.RtfText := FRtfText;
    FShareContract.WebAddress := FWebAddress;
    // Set Events...
    FShareContract.OnAppChosen := FOnAppChosen;
    FShareContract.OnTransferImage := FOnTransferImage;
  end;

  FShareContract.InitSharing;
end;

procedure TCustomSharingContract.CheckShareContract;
begin
  if not TOSVersion.Check(10) then
    raise EShareContractException.Create(SShareContractNotAvailable);
end;

procedure TCustomSharingContract.SetApplicationName(const Value: string);
begin
  FApplicationName := Value;
  if FShareContract <> nil then
    FShareContract.ApplicationName := FApplicationName;
end;

procedure TCustomSharingContract.SetContentSourceApplicationLink(const Value: string);
begin
  FContentSourceApplicationLink := Value;
  if FShareContract <> nil then
    FShareContract.ContentSourceApplicationLink := FContentSourceApplicationLink;
end;

procedure TCustomSharingContract.SetContentSourceWebLink(const Value: string);
begin
  FContentSourceWebLink := Value;
  if FShareContract <> nil then
    FShareContract.ContentSourceWebLink := FContentSourceWebLink;
end;

procedure TCustomSharingContract.SetDataText(const Value: string);
begin
  FDataText := Value;
  if FShareContract <> nil then
    FShareContract.DataText := FDataText;
end;

procedure TCustomSharingContract.SetDataTitle(const Value: string);
begin
  FDataTitle := Value;
  if FShareContract <> nil then
    FShareContract.DataTitle := FDataTitle;
end;

procedure TCustomSharingContract.SetDescription(const Value: string);
begin
  FDescription := Value;
  if FShareContract <> nil then
    FShareContract.Description := FDescription;
end;

procedure TCustomSharingContract.SetHTML(const Value: string);
begin
  FHTML := Value;
  if FShareContract <> nil then
    FShareContract.HTML := FHTML;
end;

procedure TCustomSharingContract.SetIconFile(const Value: string);
begin
  FIconFile := Value;
  if FShareContract <> nil then
    FShareContract.IconFile := FIconFile;
end;

procedure TCustomSharingContract.SetImageFile(const Value: string);
begin
  FImageFile := Value;
  if FShareContract <> nil then
    FShareContract.ImageFile := FImageFile;
end;

procedure TCustomSharingContract.SetLogoFile(const Value: string);
begin
  FLogoFile := Value;
  if FShareContract <> nil then
    FShareContract.LogoFile := FLogoFile;
end;

procedure TCustomSharingContract.SetOnAppChosen(const Value: TApplicationChosenEvent);
begin
  FOnAppChosen := Value;
  if FShareContract <> nil then
    FShareContract.OnAppChosen := FOnAppChosen;
end;

procedure TCustomSharingContract.SetOnTransferImage(const Value: TTransferDataEvent);
begin
  FOnTransferImage := Value;
  if FShareContract <> nil then
    FShareContract.OnTransferImage := FOnTransferImage;
end;

procedure TCustomSharingContract.SetPackageName(const Value: string);
begin
  FPackageName := Value;
  if FShareContract <> nil then
    FShareContract.PackageName := FPackageName;
end;

procedure TCustomSharingContract.SetRtfText(const Value: string);
begin
  FRtfText := Value;
  if FShareContract <> nil then
    FShareContract.RtfText := FRtfText;
end;

procedure TCustomSharingContract.SetWebAddress(const Value: string);
begin
  FWebAddress := Value;
  if FShareContract <> nil then
    FShareContract.WebAddress := FWebAddress;
end;


end.
