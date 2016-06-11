{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsUIWizard;

interface

uses Classes, Generics.Collections, Forms, WizardAPI, SysUtils, Windows, Graphics;

type
  TWizardPageItems = class;


  TCustomExpertsWizardPage = class;
  TCustomExpertsWizard = class;
  TExpertsWizardPageTransition = (eptNext,
                                 eptPrev,
                                 eptFinish);

  TOnPageEnterPageEvent = procedure(Sender: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition) of object;
  TOnPageLeavePageEvent = procedure(Sender: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition) of object;
  TOnPageLeavingPageEvent = procedure(Sender: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition; var Allow: Boolean) of object;
  //TOnPageValidatePageEvent = procedure(Sender: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition; var Valid: Boolean) of object;

  TOnWizardEnterPageEvent = procedure(Sender: TCustomExpertsWizard; LastPage, CurrentPage: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition) of object;
  TOnWizardLeavePageEvent = procedure(Sender: TCustomExpertsWizard; CurrentPage: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition) of object;
  TOnWizardLeavingPageEvent = procedure(Sender: TCustomExpertsWizard; WizardPage: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition; var Allow: Boolean) of object;
  //TOnWizardValidatePageEvent = procedure(Sender: TCustomExpertsWizard; WizardPage: TCustomExpertsWizardPage; PageTransition: TExpertsWizardPageTransition; var Valid: Boolean) of object;
  TOnWizardBooleanEvent = procedure(Sender: TCustomExpertsWizard; var AResult: Boolean) of object;


  TOnLoadWizardImage = procedure(Sender: TCustomExpertsWizard; var AImage: TBitmap) of object;
  TCustomExpertsWizard = class(TComponent)
  private
    FWizardPageIntfDictionary: TDictionary<IWizardPage, TCustomExpertsWizardPage>;
    FWizardPages: TWizardPageItems;
    FCaption: string;
    FWizard: IWizard;
    FHelpContext: integer;
    FOnCanFinish: TOnWizardBooleanEvent;
    FOnLeavePageEvent: TOnWizardLeavePageEvent;
    FOnLeavingPageEvent: TOnWizardLeavingPageEvent;
    FOnEnterPageEvent: TOnWizardEnterPageEvent;
    FOnLoadWizardImage: TOnLoadWizardImage;
    FOnShowing: TNotifyEvent;
    FShowSteps: Boolean;
    //FOnValidatePageEvent: TOnWizardValidatePageEvent;
    //FImageResourceName: string;
    class var FKey: Integer;
    class var FUpdatePageCount: TDictionary<Integer, TProc>;
    class
    function AddUpdatePageCount(AProc: TProc): Integer;
    class procedure RemoveUpdatePageCount(AID: Integer);
    procedure SetWizardPages(const Value: TWizardPageItems);
    function FindWizardPage(const AWizardPageIntf: IWizardPage): TCustomExpertsWizardPage;
    procedure AddWizardPageIntf(const AWizardPageIntf: IWizardPage; AWizardPage: TCustomExpertsWizardPage);
    function GetPageEnabled(AWizardPage: TCustomExpertsWizardPage): Boolean;
    procedure SetPageEnabled(AWizardPage: TCustomExpertsWizardPage;
      const Value: Boolean);
    function GetWizardOwner: TComponent;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function DoOnLoadImage: TBitmap;
    procedure DoOnEnterPage(LastPage, CurrentPage: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure DoOnLeavePage(CurrentPage: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition);
    procedure DoOnLeavingPage(WizardPage: TCustomExpertsWizardPage;
      PageTransition: TExpertsWizardPageTransition; var Allow: Boolean);
    function DoOnCanFinish: Boolean;
    class procedure UpdatePageCount;
  public
    procedure Execute(AFinishProc: TProc);
  public
    class constructor ClassCreate;
    class destructor ClassDestroy;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Next: Boolean;
    function NextOrFinish: Boolean;
    procedure UpdateSteps;
    procedure UpdateButtons;
    property ShowSteps: Boolean read FShowSteps write FShowSteps;
    property WizardOwner: TComponent read GetWizardOwner;
    property WizardPages: TWizardPageItems read FWizardPages write SetWizardPages;
    property PageEnabled[AWizardPage: TCustomExpertsWizardPage]: Boolean read GetPageEnabled write SetPageEnabled;
    property Caption: string read FCaption write FCaption;
    //property ImageResourceName: string read FImageResourceName write FImageResourceName;
    property HelpContext: Integer read FHelpContext write FHelpContext;
    property OnEnterPage: TOnWizardEnterPageEvent read FOnEnterPageEvent write FOnEnterPageEvent;
    property OnLeavePage: TOnWizardLeavePageEvent read FOnLeavePageEvent write FOnLeavePageEvent;
    property OnLeavingPage: TOnWizardLeavingPageEvent read FOnLeavingPageEvent write FOnLeavingPageEvent;
    //property OnValidatePage: TOnWizardValidatePageEvent read FOnValidatePageEvent write FOnValidatePageEvent;
    property OnLoadImage: TOnLoadWizardImage read FOnLoadWizardImage write FOnLoadWizardImage;
    property OnShowing: TNotifyEvent read FOnShowing write FOnShowing;
    property OnCanFinish: TOnWizardBooleanEvent read FOnCanFinish write FOnCanFinish;
  end;

  TExpertsWizard = class(TCustomExpertsWizard)
  published
    property WizardPages;
    property Caption;
    property ShowSteps;
    //property ImageResourceName;
    property HelpContext;
    property OnEnterPage;
    property OnLeavePage;
    property OnLeavingPage;
    property OnLoadImage;
    property OnShowing;
    property OnCanFinish;
  end;

  TExpertsWizardPageEvent = procedure(Sender: TCustomExpertsWizardPage) of object;
  TExpertsWizardPageBooleanEvent = procedure(Sender: TCustomExpertsWizardPage; var AResult: Boolean) of object;

  TCustomExpertsFrameWizardPage = class;

  // Wizard frame optionally implements this interface
  IExpertsWizardPageFrame = interface
  ['{4D51725C-97D6-43BF-A820-7C02B778B677}']
    function ExpertsFrameValidatePage(ASender: TCustomExpertsWizardPage; var AHandled: Boolean): Boolean;
    procedure ExpertsFrameUpdateInfo(ASender: TCustomExpertsWizardPage; var AHandled: Boolean);
    procedure ExpertsFrameCreated(APage: TCustomExpertsFrameWizardPage);
    procedure ExpertsFrameEnterPage(APage: TCustomExpertsFrameWizardPage);
  end;

  TCustomExpertsWizardPage = class(TComponent)
  private
    FTitle: string;
    FDescription: string;
    FInfo: string;
    FOnWizardPageCreated: TExpertsWizardPageEvent;
    FOnLeavePageEvent: TOnPageLeavePageEvent;
    FOnLeavingPageEvent: TOnPageLeavingPageEvent;
    FOnEnterPageEvent: TOnPageEnterPageEvent;
    FOnUpdateInfo: TExpertsWizardPageEvent;
    FOnValidatePage: TExpertsWizardPageEvent;
    FOnIsCompleteEvent: TExpertsWizardPageBooleanEvent;
    FWizardPageIntf: IWizardPage;
   // FOnValidatePageEvent: TOnPageValidatePageEvent;
//    function GetWizardInfo: string;
    procedure SetWizardInfo(const Value: string);
    procedure DoOnValidatePage(var Valid: Boolean);
    procedure SetDescription(const Value: string);
    procedure SetTitle(const Value: string);
  protected
    procedure DoOnUpdateInfo; virtual;
    procedure DoOnEnterPage(
      PageTransition: TExpertsWizardPageTransition); virtual;
    procedure DoOnLeavePage(
      PageTransition: TExpertsWizardPageTransition); virtual;
    procedure DoOnLeavingPage(
      PageTransition: TExpertsWizardPageTransition; var Allow: Boolean); virtual;
    procedure DoOnIsComplete(
      out AIsComplete: Boolean); virtual;
//    procedure AddWizardPageIntf(AWizard: TCustomExpertsWizard; const AWizardPageIntf: IWizardPage);
    procedure DoOnWizardPageCreated(AWizard: TCustomExpertsWizard); virtual;
    function GetGuid: TGuid; virtual; abstract;
    function CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage; virtual;

    property Guid: TGuid read GetGuid;
    property WizardPageIntf: IWizardPage read FWizardPageIntf;
  public
    procedure UpdateInfo; virtual;
    function ValidatePage: Boolean; virtual;
    property Title: string read FTitle write SetTitle;
    property Description: string read FDescription write SetDescription;
    property WizardInfo: string read FInfo write SetWizardInfo;
    property OnWizardPageCreated: TExpertsWizardPageEvent read FOnWizardPageCreated write FOnWizardPageCreated;
    property OnEnterPage: TOnPageEnterPageEvent read FOnEnterPageEvent write FOnEnterPageEvent;
    property OnLeavePage: TOnPageLeavePageEvent read FOnLeavePageEvent write FOnLeavePageEvent;
    property OnLeavingPage: TOnPageLeavingPageEvent read FOnLeavingPageEvent write FOnLeavingPageEvent;
    property OnValidatePage: TExpertsWizardPageEvent read FOnValidatePage write FOnValidatePage;
    property OnUpdateInfo: TExpertsWizardPageEvent read FOnUpdateInfo write FOnUpdateInfo;
    property OnIsComplete: TExpertsWizardPageBooleanEvent read FOnIsCompleteEvent write FOnIsCompleteEvent;
  end;

  TExpertsWizardFrameCreateEvent = procedure(Sender: TCustomExpertsFrameWizardPage;
    AOwner: TComponent; out AFrame: TFrame) of object;
  TExpertsWizardFrameCreatedEvent = procedure(Sender: TCustomExpertsFrameWizardPage;
    AFrame: TFrame) of object;
  TExpertsWizardFrameOptionChangeEvent = procedure(Sender: TCustomExpertsFrameWizardPage) of object;
  TCustomExpertsFrameWizardPage = class(TCustomExpertsWizardPage)
  private
    FFrame: TFrame;
    FOnFrameCreate: TExpertsWizardFrameCreateEvent;
    FOnFrameCreated: TExpertsWizardFrameCreatedEvent;
    FGuid: TGuid;
    FOnFrameOptionsChange: TExpertsWizardFrameOptionChangeEvent;
   protected
    function GetGuid: TGuid; override;
    function CreateFrame(AOwner: TComponent): TFrame;
    function CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage; override;
    procedure DoOnEnterPage(
      PageTransition: TExpertsWizardPageTransition); override;
  public
    procedure UpdateInfo; override;
    function ValidatePage: Boolean; override;
    procedure DoOnFrameOptionsChanged;
    property OnFrameOptionChanged: TExpertsWizardFrameOptionChangeEvent read FOnFrameOptionsChange write FOnFrameOptionsChange;
    property OnFrameCreate: TExpertsWizardFrameCreateEvent read FOnFrameCreate write FOnFrameCreate;
    property OnFrameCreated: TExpertsWizardFrameCreatedEvent read FOnFrameCreated write FOnFrameCreated;
    property Frame: TFrame read FFrame;
  end;

  TExpertsFrameWizardPage = class(TCustomExpertsFrameWizardPage)
  published
    property OnFrameCreate;
    property OnFrameCreated;
    property OnFrameOptionChanged;
    property Title;
    property Description;
    property OnWizardPageCreated;
    property OnEnterPage;
    property OnLeavePage;
    property OnLeavingPage;
    property OnUpdateInfo;
    property OnIsComplete;
  end;

  TCustomExpertsFeaturesWizardPage = class;

  TFeaturesWizardPageEvent = procedure(AFeaturesWizardPage: TCustomExpertsFeaturesWizardPage) of object;

  TCustomExpertsFeaturesWizardPage = class(TCustomExpertsWizardPage)
  private
    FFeaturesWizardPageIntf: IFeaturesPage;
    FOnFeatureChecked: TFeaturesWizardPageEvent;
    FOnFeatureSelected: TFeaturesWizardPageEvent;
    function GetChecked(ID: Integer): Boolean;
    procedure SetChecked(ID: Integer; Check: Boolean);
    function GetSelected: Integer;
    function GetCaption(ID: Integer): string;
    function GetDescription(ID: Integer): string;
    procedure OnFeaturesPageIntfChecked(const Sender: IFeaturesPage);
    procedure OnFeaturesPageIntfSelected(const Sender: IFeaturesPage);
    //procedure UpdateFeaturePageInfo;
    procedure OnEnterFeaturesPage(APageTransition: TPageTransition);
    procedure OnLeaveFeaturesPage(APageTransition: TPageTransition);
    procedure OnLeavingFeaturesPage(APageTransition: TPageTransition;
      var AAllow: Boolean);
  protected
    function GetGuid: TGuid; override;
    function CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage; override;
    procedure DoOnWizardPageCreated(AWizard: TCustomExpertsWizard); override;
  public
    procedure UpdateInfo; override;
    procedure AddFeature(ID: Integer; const Name, Description: string); overload;
    procedure AddFeature(Parent, ID: Integer; const Name, Description: string); overload;
    procedure AddFeatureGroup(ID: Integer; const Name, Description: string); overload;
    procedure AddFeatureGroup(Parent, ID: Integer; const Name, Description: string); overload;
    property Selected: Integer read GetSelected;
    property Captions[ID: Integer]: string read GetCaption;
    property Descriptions[ID: Integer]: string read GetDescription;
    property Checked[ID: Integer]: Boolean read GetChecked write SetChecked;
    property OnFeatureChecked: TFeaturesWizardPageEvent read FOnFeatureChecked write FOnFeatureChecked;
    property OnFeatureSelected: TFeaturesWizardPageEvent read FOnFeatureSelected write FOnFeatureSelected;
    property OnWizardPageCreated;
  end;

  TExpertsFeaturesWizardPage = class(TCustomExpertsFeaturesWizardPage)
  published
    property Title;
    property Description;
    property OnFeatureChecked;
    property OnFeatureSelected;
    property OnWizardPageCreated;
    property OnEnterPage;
    property OnLeavePage;
    property OnLeavingPage;
  end;

  TWizardPageItem = class(TCollectionItem)
  private
    FWizardPage: TCustomExpertsWizardPage;
    FEnabled: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetWizardPage(Value: TCustomExpertsWizardPage);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property WizardPage: TCustomExpertsWizardPage read FWizardPage write SetWizardPage;
  end;

{ TWizardPageItems }

  TWizardPageItems = class(TCollection)
  private
    FWizard: TCustomExpertsWizard;
    function GetPageItem(Index: Integer): TWizardPageItem;
    procedure SetPageItem(Index: Integer; Value: TWizardPageItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AWizard: TCustomExpertsWizard;
      ItemClass: TCollectionItemClass);
    function  Add: TWizardPageItem;
    property Wizard: TCustomExpertsWizard read FWizard;
    property Items[Index: Integer]: TWizardPageItem read GetPageItem
      write SetPageItem; default;
  end;

const
  cExpertsLeftMargin = 10;

implementation

uses ExpertsUIInternalWizard,
  ToolsAPI, ExpertsUIResStrs, Dialogs, Vcl.Controls;

resourcestring
  sWizardPageItemEnabled = 'Enabled';
  sWizardPageItemPage = 'Component';
  sWizardPageItemFormat = 'Component: %s, Enabled: %s';
  rsNoComponent = '(none)';
const
  sTrue = 'True';
  sFalse = 'False';

type
  TExpertsWizardPageArray = TArray<TCustomExpertsWizardPage>;

  TExpertsMrWizard = class(TPageListMrWizard, IWizardEvents)
  private
    FWizard: TCustomExpertsWizard;
    FFinishProc: TProc;
    FFirstWizardPage: IWizardPage;
    FUpdatePageCount: Integer;
    function GetExpertsWizardPageArray: TExpertsWizardPageArray;
    function CreatePageClass(
      AWizardPage: TCustomExpertsWizardPage): TCustomMrWizardPageClass;
  protected
    procedure Finish; override;
    procedure DoOnShowing; override;
    function GetFirstPage: IWizardpage; override;
    function GetFirstPageGuidAndName(out AID: TGUID;
      out AName: string): Boolean; override;
    function LoadImage: TBitmap; override;
    procedure OnEnterPage(LastPage, CurrentPage: IWizardPage; PageTransition: TPageTransition); override;
    procedure OnLeavePage(CurrentPage: IWizardPage; PageTransition: TPageTransition); override;
    procedure OnLeavingPage(WizardPage: IWizardPage; PageTransition: TPageTransition; var Allow: Boolean); override;
    function CanFinish: Boolean; override;
    procedure GetSelectablePages(AList: TList<TCustomMrWizardPageClass>); override;
    function IsPageSelected(APage: TCustomMrWizardPageClass): Boolean; override;
    function CreateWizardPage(APage: TCustomMrWizardPageClass): IWizardPage; override;
  public
    constructor Create(AFinishProc: TProc; AWizard: TCustomExpertsWizard; const ACaption: string;
    AHelpContext: Integer; const AImageName: string; const AOptionsFileName: string);
    destructor Destroy; override;
  end;

  TExpertsMrWizardPageClass = class(TCustomMrWizardPageClass)
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    WizardPage: TCustomExpertsWizardPage;
    Wizard: TCustomExpertsWizard;
  end;

  TExpertsMrWizardPage = class(TCustomMrWizardPage)
  private
    FWizardPage: TCustomExpertsFrameWizardPage;
  protected
    function Page: TFrame; override;
    procedure OnLeavingPage(PageTransition: TPageTransition; var Allow: Boolean); override;
    procedure OnEnterPage(PageTransition: TPageTransition); override;
    procedure OnLeavePage(PageTransition: TPageTransition); override;
    function IsComplete: Boolean; override;
    procedure UpdateInfo; override;
  public
    constructor Create(AWizardPage: TCustomExpertsFrameWizardPage);
  end;

{ TCustomExpertsWizard }

constructor TCustomExpertsWizard.Create(AOwner: TComponent);
begin
  inherited;
  FWizardPages := TWizardPageItems.Create(Self, TWizardPageItem);
end;

destructor TCustomExpertsWizard.Destroy;
begin
  FWizardPages.Free;
  inherited;
end;

class destructor TCustomExpertsWizard.ClassDestroy;
begin
  FUpdatePageCount.Free;
  inherited;
end;

procedure TCustomExpertsWizard.DoOnEnterPage(LastPage,
  CurrentPage: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  if Assigned(FOnEnterPageEvent) then
    FOnEnterPageEvent(Self, LastPage, CurrentPage, PageTransition);
end;

procedure TCustomExpertsWizard.DoOnLeavePage(
  CurrentPage: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition);
begin
  if Assigned(FOnLeavePageEvent) then
    FOnLeavePageEvent(Self, CurrentPage, PageTransition);
end;

procedure TCustomExpertsWizard.DoOnLeavingPage(
  WizardPage: TCustomExpertsWizardPage;
  PageTransition: TExpertsWizardPageTransition; var Allow: Boolean);
begin
//  //if Assigned(FOnValidatePageEvent) then
//  begin
//    try
//      case PageTransition of
//        prNext,
//        prFinish:
//        begin
//          //Allow := True;
//          Allow := WizardPage.ValidatePage;
//
//          //FOnValidatePageEvent(Self, WizardPage, PageTransition, Allow);
//        end;
//      end;
//    except
//      on E: Exception do
//      begin
//        MessageDlg(E.Message, mtError, [mbOK], 0);
//        Allow := False;
//      end;
//    end;
//  end;

  if Assigned(FOnLeavingPageEvent) then
    FOnLeavingPageEvent(Self, WizardPage, PageTransition, Allow);
end;

function TCustomExpertsWizard.DoOnLoadImage: TBitmap;
begin
  Result := nil;
  if Assigned(FOnLoadWizardImage) then
    FOnLoadWizardImage(Self, Result);
end;

function TCustomExpertsWizard.DoOnCanFinish: Boolean;
begin
  Result := False;
  if Assigned(FOnCanFinish) then
    FOnCanFinish(Self, Result);
end;

procedure TCustomExpertsWizard.Execute(AFinishProc: TProc);
const
  sIni = '.ini';
var
  Wizard: IWizard;
begin
  if BorlandWizards <> nil then
  begin
    FWizardPageIntfDictionary := TDictionary<IWizardPage, TCustomExpertsWizardPage>.Create;
    try
      Wizard := BorlandWizards.CreateWizard(TExpertsMrWizard.Create(AFinishProc, Self,
         Self.Caption, Self.HelpContext,
         '', //Self.ImageResourceName, // do not localize
         ChangeFileExt(Self.ClassName, sIni)));
      Wizard.Options := [woInformation, woPageNumbering];
      if ShowSteps then
        Wizard.Options := Wizard.Options + [woSteps];

      Wizard.InfoLines := 2;
      FWizard := Wizard;
      try
        Wizard.Show;
      finally
        FWizard := nil;
      end;
    finally
      FWizardPageIntfDictionary.Free;
    end;
  end;
end;

function TCustomExpertsWizard.FindWizardPage(
  const AWizardPageIntf: IWizardPage): TCustomExpertsWizardPage;
begin
  Result := nil;
  if FWizardPageIntfDictionary <> nil then
    FWizardPageIntfDictionary.TryGetValue(AWizardPageIntf, Result);
end;

function TCustomExpertsWizard.GetPageEnabled(
  AWizardPage: TCustomExpertsWizardPage): Boolean;
var
  I: Integer;
begin
  for I := 0 to FWizardPages.Count - 1 do
    if FWizardPages.Items[I].WizardPage = AWizardPage then
      Exit(FWizardPages.Items[I].Enabled);
  Result := False;
end;

function TCustomExpertsWizard.GetWizardOwner: TComponent;
begin
  if FWizard <> nil then
    Result := FWizard.Owner
  else
    Result := nil;
end;

class function TCustomExpertsWizard.AddUpdatePageCount(AProc: TProc): Integer;
begin
  Inc(FKey);
  FUpdatePageCount.Add(FKey, AProc);
  Result := FKey;
end;

procedure TCustomExpertsWizard.AddWizardPageIntf(const AWizardPageIntf: IWizardPage; AWizardPage: TCustomExpertsWizardPage);
begin
  FWizardPageIntfDictionary.AddOrSetValue(AWizardPageIntf, AWizardPage);
end;

class constructor TCustomExpertsWizard.ClassCreate;
begin
  FUpdatePageCount := TDictionary<Integer, TProc>.Create;
end;

function TCustomExpertsWizard.Next: Boolean;
begin
  Result := FWizard.GoNext;
end;

function TCustomExpertsWizard.NextOrFinish: Boolean;
var
  LForm: TCustomForm;
begin
  if FWizard.Next then
    Result := FWizard.GoNext
  else if FWizard.Finish then
  begin
    Result := FWizard.GoFinish;
    if Result then
    begin
      LForm := Screen.ActiveCustomForm;
      if LForm <> nil then
        if LForm.ClassName = 'TWizardForm' then
           LForm.ModalResult := mrOK;
    end;
  end
  else
    Result := False;
end;

procedure TCustomExpertsWizard.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TCustomExpertsWizardPage) then
    for I := 0 to FWizardPages.Count - 1 do
      if FWizardPages.Items[I].WizardPage = AComponent then
        FWizardPages.Items[I].WizardPage := nil
end;

class procedure TCustomExpertsWizard.RemoveUpdatePageCount(AID: Integer);
begin
  FUpdatePageCount.Remove(AID);
end;

procedure TCustomExpertsWizard.SetPageEnabled(
  AWizardPage: TCustomExpertsWizardPage; const Value: Boolean);
var
  I: Integer;
begin
  for I := 0 to FWizardPages.Count - 1 do
    if FWizardPages.Items[I].WizardPage = AWizardPage then
      FWizardPages.Items[I].Enabled := Value;
end;

procedure TCustomExpertsWizard.SetWizardPages(
  const Value: TWizardPageItems);
begin
  FWizardPages.Assign(Value);
end;

procedure TCustomExpertsWizard.UpdateButtons;
var
  LPageMrWizard: IPageMrWizard;
begin
  if Self.FWizard <> nil then
   if Supports(Self.FWizard.MrWizard, IPageMrWizard, LPageMrWizard) then
      LPageMrWizard.UpdateButtons;

end;

class procedure TCustomExpertsWizard.UpdatePageCount;
var
  LProc: TProc;
begin
  for LProc in FUpdatePageCount.Values do
    LProc;
end;

procedure TCustomExpertsWizard.UpdateSteps;
var
  LPageMrWizard: IPageMrWizard;
begin
  if Self.FWizard <> nil then
    if Supports(Self.FWizard.MrWizard, IPageMrWizard, LPageMrWizard) then
      LPageMrWizard.UpdateSteps;
end;

{ TExpertsMrWizard }

function TExpertsMrWizard.CanFinish: Boolean;
begin
  Result := FWizard.DoOnCanFinish;
end;

constructor TExpertsMrWizard.Create(AFinishProc: TProc; AWizard: TCustomExpertsWizard; const ACaption: string;
  AHelpContext: Integer; const AImageName, AOptionsFileName: string);
begin
  FFinishProc := AFinishProc;
  FWizard := AWizard;
  FUpdatePageCount := FWizard.AddUpdatePageCount(
    procedure
    begin
      UpdatePageCount;
    end);
  inherited Create(ACaption, AHelpContext, AImageName, AOptionsFileName);
end;

function TExpertsMrWizard.CreateWizardPage(APage: TCustomMrWizardPageClass): IWizardPage;
begin
  if APage is TExpertsMrWizardPageClass then
  begin
    Result := TExpertsMrWizardPageClass(APage).WizardPage.FWizardPageIntf;
    if Result = nil then
    begin
      Result := TExpertsMrWizardPageClass(APage).WizardPage.CreateWizardPage(FWizard);
      TExpertsMrWizardPageClass(APage).WizardPage.FWizardPageIntf := Result;
      FWizard.AddWizardPageIntf(Result, TExpertsMrWizardPageClass(APage).WizardPage);
      TExpertsMrWizardPageClass(APage).WizardPage.DoOnWizardPageCreated(FWizard);
    end;
  end
  else
    Result := nil;
  Assert(Result <> nil);
end;

destructor TExpertsMrWizard.Destroy;
begin
  FWizard.RemoveUpdatePageCount(FUpdatePageCount);
  inherited;
end;

procedure TExpertsMrWizard.DoOnShowing;
begin
  if Assigned(Self.FWizard.FOnShowing) then
    Self.FWizard.FOnShowing(Self);

end;

procedure TExpertsMrWizard.Finish;
begin
  inherited;
  if Assigned(FFinishProc) then
    try
      FFinishProc;
    except
      ApplicationHandleException(nil);
    end;
end;

// Add all but first page to list
procedure TExpertsMrWizard.GetSelectablePages(AList: TList<TCustomMrWizardPageClass>);
var
  I: Integer;
  LWizardPage: TCustomExpertsWizardPage;
  LEnabledPages: TExpertsWizardPageArray;
  LFirstEnabled: Integer;
begin
  LEnabledPages := GetExpertsWizardPageArray;
  LFirstEnabled := 0;
  for I := 0 to Length(LEnabledPages) - 1 do
  begin
    if FWizard.GetPageEnabled(LEnabledPages[I]) then
    begin
      LFirstEnabled := I;
      break;
    end;
  end;
  for I := LFirstEnabled + 1 to Length(LEnabledPages) - 1 do
  begin
    LWizardPage := LEnabledPages[I];
    AList.Add(CreatePageClass(LWizardPage));
  end;
end;

//function TDSServerMrWizard.HandleFirstPage(
//  const CurrentPage: IWizardPage): IWizardPage;
//begin
//
//end;

function TExpertsMrWizard.CreatePageClass(AWizardPage: TCustomExpertsWizardPage): TCustomMrWizardPageClass;
var
  APageClass: TExpertsMrWizardPageClass;
begin
  APageClass := TExpertsMrWizardPageClass.Create;
  APageClass.Name := AWizardPage.Name;
  APageClass.Guid := AWizardPage.Guid;
  APageClass.Wizard := FWizard;
  APageClass.WizardPage := AWizardPage;
  Result := APageClass;
end;

function TExpertsMrWizard.GetExpertsWizardPageArray: TExpertsWizardPageArray;
var
  I: Integer;
  LWizardPage: TCustomExpertsWizardPage;
begin
  for I := 0 to FWizard.WizardPages.Count - 1 do
  begin
    //if FWizard.WizardPages[I].Enabled then
    begin
      LWizardPage := FWizard.WizardPages[I].WizardPage;
      if LWizardPage <> nil then
      begin
        SetLength(Result, Length(Result)+1);
        Result[Length(Result)-1] := LWizardPage;
      end;
    end;
  end;
end;

// override
function TExpertsMrWizard.GetFirstPage: IWizardpage;
var
  LPageClass: TCustomMrWizardPageClass;
  LEnabledPages: TExpertsWizardPageArray;
  LEnabled: Boolean;
  I: Integer;
  LWizardPage: TCustomExpertsWizardPage;
  LFirstEnabled: Integer;
begin
  if FFirstWizardPage = nil then
  begin
    LEnabledPages := GetExpertsWizardPageArray;

    LFirstEnabled := 0;
    for I := 0 to Length(LEnabledPages) - 1 do
    begin
      LWizardPage := LEnabledPages[I];
      LEnabled := FWizard.GetPageEnabled(LWizardPage);
      if LEnabled then
      begin
        LFirstEnabled := I;
        break;
      end;
    end;


    if Length(LEnabledPages) > 0 then
    begin
      LPageClass := CreatePageClass(LEnabledPages[LFirstEnabled]);
      try
        FFirstWizardPage := CreateWizardPage(LPageClass);
      finally
        LPageClass.Free;
      end;
    end;
  end;
  Result := FFirstWizardPage;
end;

function TExpertsMrWizard.GetFirstPageGuidAndName(out AID: TGUID;
  out AName: string): Boolean;
var
  LPageClass: TCustomMrWizardPageClass;
  LPageArray: TExpertsWizardPageArray;
  LFirstEnabled: Integer;
  LWizardPage: TCustomExpertsWizardPage;
  LEnabled: Boolean;
  I: Integer;
begin
  Result := False;
  LPageArray := GetExpertsWizardPageArray;
  LFirstEnabled := 0;
  if Length(LPageArray) > 0 then
  begin

    for I := 0 to Length(LPageArray) - 1 do
    begin
      LWizardPage := LPageArray[I];
      LEnabled := FWizard.GetPageEnabled(LWizardPage);
      if LEnabled then
      begin
        LFirstEnabled := I;
        break;
      end;
    end;

    if Length(LPageArray) > 0 then
    begin
      LPageClass := CreatePageClass(LPageArray[LFirstEnabled]);
      try
        AID := LPageClass.Guid;
        AName := LPageClass.Name;
        Result := True;
      finally
        LPageClass.Free;
      end;
    end;
  end;
end;

// IsPageShown/valid
function TExpertsMrWizard.IsPageSelected(APage: TCustomMrWizardPageClass): Boolean;
begin
  if APage is TExpertsMrWizardPageClass then
    with TExpertsMrWizardPageClass(APage) do
      Result := Wizard.PageEnabled[WizardPage]
  else
    Result := True;
end;

function TExpertsMrWizard.LoadImage: TBitmap;
begin
  Result :=  FWizard.DoOnLoadImage;
end;

function Transition(PageTransition: TPageTransition): TExpertsWizardPageTransition;
begin
  case PageTransition of
    TPageTransition.prNext: Result := TExpertsWizardPageTransition.eptNext;
    TPageTransition.prPrev: Result := TExpertsWizardPageTransition.eptPrev;
    TPageTransition.prFinish: Result := TExpertsWizardPageTransition.eptFinish;
  else
    Result := TExpertsWizardPageTransition.eptNext;
    Assert(False);
  end;
end;

procedure TExpertsMrWizard.OnEnterPage(LastPage, CurrentPage: IWizardPage;
  PageTransition: TPageTransition);
begin
  inherited;
  FWizard.DoOnEnterPage(FWizard.FindWizardPage(LastPage),
    FWizard.FindWizardPage(CurrentPage), Transition(PageTransition));
end;

procedure TExpertsMrWizard.OnLeavePage(CurrentPage: IWizardPage;
  PageTransition: TPageTransition);
begin
  inherited;
  FWizard.DoOnLeavePage(FWizard.FindWizardPage(CurrentPage),
    Transition(PageTransition));
end;

procedure TExpertsMrWizard.OnLeavingPage(WizardPage: IWizardPage;
  PageTransition: TPageTransition; var Allow: Boolean);
begin
  FWizard.DoOnLeavingPage(FWizard.FindWizardPage(WizardPage),
    Transition(PageTransition), Allow);
end;

{ TWizardPageItems }

constructor TWizardPageItems.Create(AWizard: TCustomExpertsWizard;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FWizard := AWizard;
end;

function TWizardPageItems.Add: TWizardPageItem;
begin
  Result := TWizardPageItem(inherited Add);
end;

function TWizardPageItems.GetPageItem(Index: Integer): TWizardPageItem;
begin
  Result := TWizardPageItem(inherited Items[Index]);
end;

function TWizardPageItems.GetAttrCount: Integer;
begin
  Result := 2;
end;


function TWizardPageItems.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sWizardPageItemEnabled;
    1: Result := sWizardPageItemPage;
  else
    Result := '';
  end;
end;

function TWizardPageItems.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: if Items[ItemIndex].Enabled then
         Result := sTrue else Result := sFalse; // do not localize
    1: if Items[ItemIndex].FWizardPage <> nil then
         Result := Items[ItemIndex].FWizardPage.Name
       else
         Result := ''  //do not localize
  else
    Result := '';
  end;
end;

function TWizardPageItems.GetOwner: TPersistent;
begin
  Result := FWizard;
end;

procedure TWizardPageItems.SetPageItem(Index: Integer; Value: TWizardPageItem);
begin
  Items[Index].Assign(Value);
end;

procedure TWizardPageItems.Update(Item: TCollectionItem);
begin
{+ !!  if (FWizardPage <> nil) and
    not (csLoading in FWizardPage.ComponentState) then }
end;

{ TWebPageItem }

constructor TWizardPageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FEnabled := True;
end;

destructor TWizardPageItem.Destroy;
begin
  inherited Destroy;
end;

function TWizardPageItem.GetDisplayName: string;
var
  LName: string;
  LEnabled: string;
begin
  if FWizardPage <> nil then
    LName := FWizardPage.Name
  else
    LName := rsNoComponent;
  if FEnabled then
    LEnabled := sTrue
  else
    LEnabled := sFalse;

  Result := Format(sWizardPageItemFormat, [LName, LEnabled]);
end;

procedure TWizardPageItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TWizardPageItem then
  begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      with TWizardPageItem(Dest) do
      begin
        Enabled := Self.Enabled;
        WizardPage := Self.WizardPage;
      end;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else inherited AssignTo(Dest);
end;

procedure TWizardPageItem.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed(False);
    TCustomExpertsWizard.UpdatePageCount;
  end;
end;

procedure TWizardPageItem.SetWizardPage(Value: TCustomExpertsWizardPage);
begin
  if Assigned(Value) then
  begin
    Value.FreeNotification(TWizardPageItems(Collection).FWizard);
    FWizardPage := nil;
  end;
  FWizardPage := Value;
end;


{ TExpertsMrWizardPageClass }

procedure TExpertsMrWizardPageClass.AssignTo(Dest: TPersistent);
begin
  if Dest is TExpertsMrWizardPageClass then
  begin
    inherited;
    TExpertsMrWizardPageClass(Dest).WizardPage := WizardPage;
    TExpertsMrWizardPageClass(Dest).Wizard := Wizard;
  end
  else
    inherited;
end;

{ TCustomExpertsWizardPage }

procedure TCustomExpertsWizardPage.DoOnUpdateInfo;
begin
  if Assigned(FOnUpdateInfo) then
    FOnUpdateInfo(Self);
end;

procedure TCustomExpertsWizardPage.DoOnValidatePage(var Valid: Boolean);
begin
  if Assigned(FOnValidatePage) then
    FOnValidatePage(Self);
end;


procedure TCustomExpertsWizardPage.DoOnEnterPage(
  PageTransition: TExpertsWizardPageTransition);
begin
  UpdateInfo;
  if Assigned(FOnEnterPageEvent) then
    FOnEnterPageEvent(Self, PageTransition);
end;

procedure TCustomExpertsWizardPage.DoOnLeavePage(
  PageTransition: TExpertsWizardPageTransition);
begin
  if Assigned(FOnLeavePageEvent) then
    FOnLeavePageEvent(Self, PageTransition);
end;

procedure TCustomExpertsWizardPage.DoOnLeavingPage(
  PageTransition: TExpertsWizardPageTransition; var Allow: Boolean);
begin
//  if Assigned(FOnValidatePageEvent) then
//  begin
    try
      case PageTransition of
        eptNext,
        eptFinish:
        begin
          Allow := ValidatePage;
        end;
      end;
    except
      on E: Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOK], 0);
        Allow := False;
      end;
    end;
  if Allow then
    if Assigned(FOnLeavingPageEvent) then
      FOnLeavingPageEvent(Self, PageTransition, Allow);
end;

procedure TCustomExpertsWizardPage.DoOnIsComplete(out AIsComplete: Boolean);
begin
  AIsComplete := True;
  if Assigned(FOnIsCompleteEvent) then
    FOnIsCompleteEvent(Self, AIsComplete);
end;

function TCustomExpertsWizardPage.CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage;
begin
  Result := nil;
end;

procedure TCustomExpertsWizardPage.DoOnWizardPageCreated(AWizard: TCustomExpertsWizard);
begin
  if Assigned(FOnWizardPageCreated) then
    FOnWizardPageCreated(Self);
end;

//function TCustomExpertsWizardPage.GetWizardInfo: string;
//begin
//  if Assigned(FWizardPageIntf) then
//    Result := FWizardPageIntf.Info;
//end;

procedure TCustomExpertsWizardPage.SetDescription(const Value: string);
begin
  FDescription := Value;
  if Assigned(FWizardPageIntf) then
    FWizardPageIntf.Description := Value;
end;

procedure TCustomExpertsWizardPage.SetTitle(const Value: string);
begin
  FTitle := Value;
  if Assigned(FWizardPageIntf) then
    FWizardPageIntf.Title := Value;
end;

procedure TCustomExpertsWizardPage.SetWizardInfo(const Value: string);
begin
  FInfo := Value;
  if Assigned(FWizardPageIntf) then
    FWizardPageIntf.Info := Value;
end;

procedure TCustomExpertsWizardPage.UpdateInfo;
begin
  DoOnUpdateInfo;
  if Assigned(FWizardPageIntf) then
    FWizardPageIntf.Info := FInfo;
end;

function TCustomExpertsWizardPage.ValidatePage: Boolean;
begin
  Result := True;
  DoOnValidatePage(Result);
end;

{ TExpertsMrWizardPage }

constructor TExpertsMrWizardPage.Create(AWizardPage: TCustomExpertsFrameWizardPage);
begin
  inherited Create(AWizardPage.FGuid, AWizardPage.Name, AWizardPage.Title, AWizardPage.Description);
  FWizardPage := AWizardPage;
end;

procedure TExpertsMrWizardPage.UpdateInfo;
begin
  inherited;
  FWizardPage.DoOnUpdateInfo;
end;

procedure TExpertsMrWizardPage.OnEnterPage(
  PageTransition: TPageTransition);
begin
  inherited;
  FWizardPage.DoOnEnterPage(Transition(PageTransition));
end;

procedure TExpertsMrWizardPage.OnLeavePage(
  PageTransition: TPageTransition);
begin
  inherited;
  FWizardPage.DoOnLeavePage(
    Transition(PageTransition));
end;

procedure TExpertsMrWizardPage.OnLeavingPage(
  PageTransition: TPageTransition; var Allow: Boolean);
begin
  FWizardPage.DoOnLeavingPage(
    Transition(PageTransition), Allow);
end;

function TExpertsMrWizardPage.IsComplete: Boolean;
begin
  FWizardPage.DoOnIsComplete(Result);
end;

function TExpertsMrWizardPage.Page: TFrame;
begin
  Result := FWizardPage.CreateFrame(Wizard.Owner);
end;

{ TCustomExpertsFrameWizardPage }

function TCustomExpertsFrameWizardPage.CreateFrame(AOwner: TComponent): TFrame;
var
  Intf: IExpertsWizardPageFrame;
begin
  if FFrame = nil then
  begin
    if Assigned(OnFrameCreate) then
      OnFrameCreate(Self, AOwner, FFrame)
    else
      FFrame := nil;
    if FFrame = nil then
      FFrame := TFrame.Create(AOwner);  // Create an empty frame to prevent AV
                                        
    if Supports(FFrame, IExpertsWizardPageFrame, Intf) then
      Intf.ExpertsFrameCreated(Self);
    if Assigned(FOnFrameCreated) then
      OnFrameCreated(Self, FFrame);
  end;
  Result := FFrame;
end;

function TCustomExpertsFrameWizardPage.CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage;
begin
  Assert(WizardPageIntf = nil);
  Result := TExpertsMrWizardPage.Create(Self);
end;

procedure TCustomExpertsFrameWizardPage.DoOnEnterPage(
  PageTransition: TExpertsWizardPageTransition);
var
  Intf: IExpertsWizardPageFrame;
begin
  inherited;
  if Supports(FFrame, IExpertsWizardPageFrame, Intf)  then
  begin
    Intf.ExpertsFrameEnterPage(Self);
  end;

end;

procedure TCustomExpertsFrameWizardPage.DoOnFrameOptionsChanged;
begin
  if Assigned(FOnFrameOptionsChange) then
    FOnFrameOptionsChange(Self);
end;

function TCustomExpertsFrameWizardPage.GetGuid: TGuid;
begin
  if FGuid = TGUID.Empty then
    CreateGuid(FGuid);
  Result := FGuid;
end;

procedure TCustomExpertsFrameWizardPage.UpdateInfo;
var
  LHandled: Boolean;
  Intf: IExpertsWizardPageFrame;
begin
  LHandled := False;
  if Supports(FFrame, IExpertsWizardPageFrame, Intf)  then
  begin
    Intf.ExpertsFrameUpdateInfo(Self, LHandled);
  end;
  if not LHandled then
    inherited;
end;

function TCustomExpertsFrameWizardPage.ValidatePage: Boolean;
var
  LHandled: Boolean;
  Intf: IExpertsWizardPageFrame;
begin
  LHandled := False;
  Result := True;
  if Supports(FFrame, IExpertsWizardPageFrame, Intf)  then
  begin
    Result := Intf.ExpertsFrameValidatePage(Self, LHandled);
  end;
  if not LHandled then
    Result := inherited;
end;

{ TCustomExpertsFeaturesWizardPage }

procedure TCustomExpertsFeaturesWizardPage.AddFeatureGroup(ID: Integer;
  const Name, Description: string);
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  FFeaturesWizardPageIntf.AddFeatureGroup(ID, Name, Description);
end;

procedure TCustomExpertsFeaturesWizardPage.DoOnWizardPageCreated(AWizard: TCustomExpertsWizard);
var
  LImage: TBitmap;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  if name <> '' then
    FFeaturesWizardPageIntf.name := name;
  FFeaturesWizardPageIntf.OnChecked := OnFeaturesPageIntfChecked;
  FFeaturesWizardPageIntf.OnSelected := OnFeaturesPageIntfSelected;
  FFeaturesWizardPageIntf.Title :=  Title;
  FFeaturesWizardPageIntf.Description := Description;
  // Load image here.  IFeaturesWizard implementation does not set the image
  LImage := AWizard.DoOnLoadImage;
  if LImage <> nil then
    FWizardPageIntf.Image := LImage;
  inherited;
end;

procedure TCustomExpertsFeaturesWizardPage.AddFeature(ID: Integer; const Name,
  Description: string);
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  FFeaturesWizardPageIntf.AddFeature(ID, Name, Description);
end;

procedure TCustomExpertsFeaturesWizardPage.AddFeature(Parent, ID: Integer;
  const Name, Description: string);
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  FFeaturesWizardPageIntf.AddFeature(Parent, ID, Name, Description);
end;

procedure TCustomExpertsFeaturesWizardPage.AddFeatureGroup(Parent, ID: Integer;
  const Name, Description: string);
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  FFeaturesWizardPageIntf.AddFeatureGroup(Parent, ID, Name, Description);
end;

procedure TCustomExpertsFeaturesWizardPage.OnEnterFeaturesPage(APageTransition: TPageTransition);
begin
  UpdateInfo;
  DoOnEnterPage(Transition(APageTransition));
end;

procedure TCustomExpertsFeaturesWizardPage.OnLeaveFeaturesPage(APageTransition: TPageTransition);
begin
  DoOnLeavePage(Transition(APageTransition));
end;

procedure TCustomExpertsFeaturesWizardPage.OnLeavingFeaturesPage(APageTransition: TPageTransition;
  var AAllow: Boolean);
begin
  DoOnLeavingPage(Transition(APageTransition), AAllow);
end;

function TCustomExpertsFeaturesWizardPage.CreateWizardPage(AWizard: TCustomExpertsWizard): IWizardPage;
var
  LEventHandlers: IWizardPageEventHandlers;
begin
  Assert(FFeaturesWizardPageIntf = nil);
  FFeaturesWizardPageIntf := BorlandWizards.CreatePage(IFeaturesPage) as IFeaturesPage;
    Result := FFeaturesWizardPageIntf;
  Supports(FFeaturesWizardPageIntf, IWizardPageEventHandlers, LEventHandlers);
  Assert(LEventHandlers <> nil);
  if LEventHandlers <> nil then
  begin
    LEventHandlers.EnterPageEvent := OnEnterFeaturesPage;
    LEventHandlers.LeavePageEvent := OnLeaveFeaturesPage;
    LEventHandlers.LeavingPageEvent := OnLeavingFeaturesPage;
  end;
end;

function TCustomExpertsFeaturesWizardPage.GetCaption(ID: Integer): string;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  Result := FFeaturesWizardPageIntf.GetCaption(ID);
end;

function TCustomExpertsFeaturesWizardPage.GetChecked(ID: Integer): Boolean;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  Result := FFeaturesWizardPageIntf.GetChecked(ID);
end;

function TCustomExpertsFeaturesWizardPage.GetDescription(ID: Integer): string;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  Result := FFeaturesWizardPageIntf.GetDescription(ID);
end;

function TCustomExpertsFeaturesWizardPage.GetGuid: TGuid;
begin
  Result := IFeaturesPage;
end;

function TCustomExpertsFeaturesWizardPage.GetSelected: Integer;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  Result := FFeaturesWizardPageIntf.GetSelected
end;

procedure TCustomExpertsFeaturesWizardPage.OnFeaturesPageIntfChecked(
  const Sender: IFeaturesPage);
begin
  if Assigned(FOnFeatureChecked) then
    FOnFeatureChecked(Self);
end;

procedure TCustomExpertsFeaturesWizardPage.UpdateInfo;
var
  ASelected: Integer;
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  ASelected := FFeaturesWizardPageIntf.Focused;
  if ASelected <> -1 then
    WizardInfo := FFeaturesWizardPageIntf.Descriptions[ASelected]
  else
    WizardInfo := rsNoFeatureSelected;
  inherited; // Call event
end;

procedure TCustomExpertsFeaturesWizardPage.OnFeaturesPageIntfSelected(
  const Sender: IFeaturesPage);
begin
  UpdateInfo;
  if Assigned(FOnFeatureSelected) then
    FOnFeatureSelected(Self);
end;

procedure TCustomExpertsFeaturesWizardPage.SetChecked(ID: Integer;
  Check: Boolean);
begin
  Assert(FFeaturesWizardPageIntf <> nil);
  FFeaturesWizardPageIntf.SetChecked(ID, Check);
end;

end.
