{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit ExpertsUIInternalWizard;

interface

uses
  Windows, ToolsApi, Controls, Forms, SysUtils, Classes, Dialogs, ComObj,
  WizardAPI,
  Generics.Collections, ExpertsUIIniOptions,
  Graphics;

type

  IPageMrWizard = interface
  ['{96A05927-BD09-4C2E-93F6-98D535CAEA34}']
    function GetImage: TBitmap;
    function LoadImage: TBitmap;
    procedure UpdateButtons;
    procedure UpdateSteps;
  end;


  TCustomPageMrWizard = class(TInterfacedObject, IMrWizard, IPageMrWizard)
  strict private
    { Wizard Info }
    FWizard: IWizard;

    FHelpContext: Integer;
    FCaption: string;
    FBitmap: TBitmap;

    { Ini info }
    FUIOptions: TWizardIniOptions;
    procedure InitOptions(const AOptionsFileName: string);
  private
    procedure AddFirstPage(out AID: TGuid; out AName: string);


    { IMrWizard }
    procedure Start;
    function FirstPage: IWizardPage;
    procedure Cancel;
    function GetWizard: IWizard;
    procedure SetWizard(const Value: IWizard);
    function GetPersonality: string;
    { IPageMrWizard }
    function GetImage: TBitmap;
    function HandleFirstPage(const CurrentPage: IWizardPage): IWizardPage;
    procedure UpdateButtons; virtual;
    procedure UpdateSteps;
  protected
    { Wizard Utility functions }
    function CanFinish: Boolean; virtual;
    function GetFirstPage: IWizardpage; virtual;
    procedure DoOnShowing; virtual;
    procedure Finish; virtual;
    function Caption: string;
    function GetHelpContext: Integer;
    procedure AddSelectablePages(const ParentID: TGUID; const ParentName: string); virtual;
    function GetFirstPageGuidAndName(out AID: TGUID; out AName: string): Boolean; virtual;
    function HasSelectablePages: Boolean; virtual;
    function FirstSelectablePage: IWizardpage; virtual;
    property Wizard: IWizard read GetWizard;
    function LoadImage: TBitmap; virtual;
  public
    constructor Create(const ACaption: string;
    AHelpContext: Integer; const AImage: string; const AOptionsFile: string);
    destructor Destroy; override;
  end;

  TCustomMrWizardPageClass = class(TPersistent)
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    Name: string;
    Guid: TGUID;
  end;

  TPageListMrWizard = class(TCustomPageMrWizard, IWizardEvents)
  private
    function GetNextPageDictionary: TDictionary<string, TCustomMrWizardPageClass>;
    procedure UpdatePageCount(AList: TList<TCustomMrWizardPageClass>); overload;
    function GetSelectedPageList: TList<TCustomMrWizardPageClass>;
    function ClonePage(APage: TCustomMrWizardPageClass): TCustomMrWizardPageClass;
    function GetPageCount(AList: TList<TCustomMrWizardPageClass>): Integer;
    function GetPageIndex(AList: TList<TCustomMrWizardPageClass>): Integer;
    procedure UpdateButtonsInternal(AList: TList<TCustomMrWizardPageClass>);
  protected
    procedure UpdatePageCount; overload;
    { IWizardEvents }
    procedure OnEnterPage(LastPage, CurrentPage: IWizardPage; PageTransition: TPageTransition); virtual;
    procedure OnLeavePage(WizardPage: IWizardPage; PageTransition: TPageTransition); virtual;
    procedure OnLeavingPage(WizardPage: IWizardPage; PageTransition: TPageTransition; var Allow: Boolean); virtual;
    function IsPageSelected(APage: TCustomMrWizardPageClass): Boolean; virtual;
    function CreateWizardPage(APage: TCustomMrWizardPageClass): IWizardPage; virtual;
    procedure GetSelectablePages(AList: TList<TCustomMrWizardPageClass>); virtual;
    function HandleNextPage(const CurrentPage: IWizardPage): IWizardPage;
    procedure AddSelectablePages(const ParentID: TGUID; const ParentName: string); override; final;
    function HasSelectablePages: Boolean; override; final;
    function FirstSelectablePage: IWizardpage; override; final;
  public
    constructor Create(const ACaption: string;
    AHelpContext: Integer; const AImageName: string; const AOptionsFileName: string);
    procedure UpdateButtons; override;
  end;

  TCustomMrWizardPage = class(TWizardPage, IWizardPage, IWizardPageEvents, IWizardPageStatus)
  private
    FID: TGuid;
    { IWizardPage }
    function Close: Boolean;
    procedure Clear;
  protected
    procedure UpdateInfo; virtual;
    { IWizardPage }
    function Page: TFrame; virtual;
    { IWizardPageStatus }
    function IsComplete: Boolean; virtual;
    { IWizardPageEvents }
    procedure OnLeavingPage(PageTransition: TPageTransition; var Allow: Boolean); virtual;
    procedure OnEnterPage(PageTransition: TPageTransition); virtual;
    procedure OnLeavePage(PageTransition: TPageTransition); virtual;
  public
    function PageID: TGUID; override;
    constructor Create(AID: TGuid; const AName, ATitle, ADescription: string);
    function GetImage: TBitmap;  override;

  end;

const
  // Wizard control margins
  cRadioLeftMargin = 10;
  cLabelLeftMargin = 10;

implementation

{ TPageListMrWizard }

constructor TPageListMrWizard.Create(const ACaption: string;
AHelpContext: Integer; const AImageName: string; const AOptionsFileName: string);
begin
  inherited;
end;

function TPageListMrWizard.IsPageSelected(APage: TCustomMrWizardPageClass): Boolean;
begin
  Result := True;
end;

procedure TPageListMrWizard.OnEnterPage(LastPage, CurrentPage: IWizardPage;
  PageTransition: TPageTransition);
begin
  UpdatePageCount;
end;

procedure TPageListMrWizard.OnLeavePage(WizardPage: IWizardPage;
  PageTransition: TPageTransition);
begin

end;

procedure TPageListMrWizard.OnLeavingPage(WizardPage: IWizardPage;
  PageTransition: TPageTransition; var Allow: Boolean);
begin

end;

function TPageListMrWizard.CreateWizardPage(APage: TCustomMrWizardPageClass): IWizardPage;
begin
  Result := nil;
end;

function TPageListMrWizard.GetNextPageDictionary: TDictionary<string, TCustomMrWizardPageClass>;
var
  LList: TList<TCustomMrWizardPageClass>;
  LPage: TCustomMrWizardPageClass;
  LPrevPage: string;
begin
  LPrevPage := GetFirstPage.Name;
  LList := GetSelectedPageList;
  try
    Result := TObjectDictionary<string, TCustomMrWizardPageClass>.Create([doOwnsValues]);
    for LPage in LList do
      begin
        Result.Add(LPrevPage, ClonePage(LPage));
        LPrevPage := LPage.Name;
      end;
  finally
    LList.Free;
  end;
end;

function TPageListMrWizard.ClonePage(APage: TCustomMrWizardPageClass): TCustomMrWizardPageClass;
begin
  Result := TCustomMrWizardPageClass(APage.ClassType.Create);
  Result.Assign(APage);
end;

procedure TPageListMrWizard.GetSelectablePages(AList: TList<TCustomMrWizardPageClass>);
begin
  Assert(False);
end;

function TPageListMrWizard.GetSelectedPageList: TList<TCustomMrWizardPageClass>;
var
  LList: TList<TCustomMrWizardPageClass>;
  LPage: TCustomMrWizardPageClass;
begin
  LList := TObjectList<TCustomMrWizardPageClass>.Create;
  GetSelectablePages(LList);
  try
    Result := TObjectList<TCustomMrWizardPageClass>.Create;
    for LPage in LList do
      if IsPageSelected(LPage) then
        Result.Add(ClonePage(LPage));
  finally
    LList.Free;
  end;
end;

// Handler to get next page
function TPageListMrWizard.HandleNextPage(
  const CurrentPage: IWizardPage): IWizardPage;
var
  LNextPage: TCustomMrWizardPageClass;
  LDictionary: TDictionary<string, TCustomMrWizardPageClass>;
  LLastPage: Boolean;
begin
  LLastPage := True;
  Result := nil;
  LDictionary := GetNextPageDictionary;
  try
    if LDictionary.TryGetValue(CurrentPage.Name, LNextPage) then
    begin
      Result := CreateWizardPage(LNextPage);
      LLastPage := not LDictionary.ContainsKey(LNextPage.Name);
    end;
  finally
    LDictionary.Free;
  end;
// Causes problems when validation of a page fails
//  Wizard.Finish := LLastPage;
//  Wizard.Next := not LLastPage;
end;

procedure TPageListMrWizard.UpdatePageCount;
var
  LList: TList<TCustomMrWizardPageClass>;
begin
  LList := GetSelectedPageList;
  try
    UpdatePageCount(LList);
  finally
    LList.Free;
  end;
end;

procedure TPageListMrWizard.UpdateButtons;
var
  LList: TList<TCustomMrWizardPageClass>;
begin
  LList := GetSelectedPageList;
  try
    UpdateButtonsInternal(LList);
  finally
    LList.Free;
  end;
end;

function TPageListMrWizard.GetPageCount(AList: TList<TCustomMrWizardPageClass>): Integer;
begin
  Result := AList.Count+1;
end;

function TPageListMrWizard.GetPageIndex(AList: TList<TCustomMrWizardPageClass>): Integer;
var
  LName: string;
  I: Integer;
begin
  if Wizard.CurrentPage <> nil then
  begin
    if Wizard.CurrentPage = GetFirstPage then
      Exit(1)
    else
    begin
      LName := Wizard.CurrentPage.Name;
      for I := 0 to AList.Count - 1 do
        if AList[I].Name = LName then
        begin
          Exit(I + 2);
        end;
    end;
  end;
  Assert(False);
  Result := 0;
end;

procedure TPageListMrWizard.UpdatePageCount(AList: TList<TCustomMrWizardPageClass>);
var
  LPageCount: Integer;
  LPageIndex: Integer;
begin
  if Wizard.CurrentPage <> nil then
  begin
    LPageCount := GetPageCount(AList);
    LPageIndex := GetPageIndex(AList);
    Assert(LPageIndex <> 0);
    Wizard.PageCount := LPageCount;
    Wizard.PageIndex := LPageIndex;
    UpdateButtonsInternal(AList);
  end;
end;

procedure TPageListMrWizard.UpdateButtonsInternal(AList: TList<TCustomMrWizardPageClass>);
var
  LPageCount: Integer;
  LPageIndex: Integer;
begin
  if Wizard.CurrentPage <> nil then
  begin
    LPageCount := GetPageCount(AList);
    LPageIndex := GetPageIndex(AList);
    Wizard.Next := LPageIndex < LPageCount;
    Wizard.Finish := (LPageIndex = LPageCount) or CanFinish;
    Wizard.Back := LPageIndex > 1;
  end;
end;

// override
procedure TPageListMrWizard.AddSelectablePages(const ParentID: TGUID; const ParentName: string);
var
  LParentID: TGUID;
  LParentName: string;

  procedure AddPage(const ChildID: TGUID; const ChildName: string;
      Callback: TWizardFunctionCallback; AllowBack: Boolean);
  begin
    Wizard.AddPage(LParentID, LParentName, ChildId,
      ChildName, Callback, AllowBack);
    LParentID := ChildId;
    LParentName := ChildName;
  end;

var
  LList: TList<TCustomMrWizardPageClass>;
  LPage: TCustomMrWizardPageClass;
begin
  LParentID := ParentID;
  LParentName := ParentName;
  LList := TObjectList<TCustomMrWizardPageClass>.Create;
  GetSelectablePages(LList);
  try
    for LPage in LList do
      AddPage(LPage.Guid, LPage.Name, HandleNextPage, True);
    UpdatePageCount(LList);
  finally
    LList.Free;
  end;
end;

// override;
function TPageListMrWizard.HasSelectablePages: Boolean;
var
  LList: TList<TCustomMrWizardPageClass>;
begin
  LList := GetSelectedPageList;
  try
    Result := LList.Count > 0;
  finally
    LList.Free;
  end;
end;

// override
function TPageListMrWizard.FirstSelectablePage: IWizardpage;
var
  LList: TList<TCustomMrWizardPageClass>;
begin
  LList := GetSelectedPageList;
  try
    Assert(LList.Count > 0);
    Result := CreateWizardPage(LList[0]);
//    Wizard.Next := LList.Count > 1;
//    Wizard.Finish := (LList.Count = 1) or CanFinish;
  finally
    LList.Free;
  end;
end;

{ TCustomMrWizardPageClass }

procedure TCustomMrWizardPageClass.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomMrWizardPageClass then
  begin
    TCustomMrWizardPageClass(Dest).Name := Name;
    TCustomMrWizardPageClass(Dest).Guid := Guid;
  end
  else
    inherited;
end;

{ TCustomMrWizardPage }

procedure TCustomMrWizardPage.Clear;
begin

end;

function TCustomMrWizardPage.Close: Boolean;
begin
  Result := True;
end;

constructor TCustomMrWizardPage.Create(AID: TGuid; const AName, ATitle, ADescription: string);
begin
  inherited Create;
  FID := AID;
  Title := ATitle;
  Description := ADescription;
  Name := AName;
end;

// override
function TCustomMrWizardPage.GetImage: TBitmap;
var
  Intf: IPageMrWizard;
begin
  if Supports(Wizard.MrWizard, IPageMrWizard, Intf) then
    Result := Intf.GetImage
  else
    Result := nil;
end;

function TCustomMrWizardPage.IsComplete: Boolean;
begin
  Result := False;
end;

procedure TCustomMrWizardPage.OnEnterPage(PageTransition: TPageTransition);
begin
  UpdateInfo;
end;

procedure TCustomMrWizardPage.OnLeavePage(PageTransition: TPageTransition);
begin

end;

procedure TCustomMrWizardPage.OnLeavingPage(PageTransition: TPageTransition;
  var Allow: Boolean);
begin

end;

function TCustomMrWizardPage.Page: TFrame;
begin
  Assert(False);
  Result := nil;
end;

procedure TCustomMrWizardPage.UpdateInfo;
begin

end;

// override
function TCustomMrWizardPage.PageID: TGUID;
begin
  Result := FID;
end;

const
  { Wizard State }
  ivFormTop = 'FormTop';
  ivFormLeft = 'FormLeft';
  ivFormWidth = 'FormWidth';
  ivFormHeight = 'FormHeight';


procedure TCustomPageMrWizard.InitOptions(const AOptionsFileName: string);
begin
  TWizardIniOptions.InitOptions(AOptionsFileName, FUIOptions);
end;

function TCustomPageMrWizard.LoadImage: TBitmap;
begin
  Result := nil;
end;

//function TCustomPageMrWizard.LoadImage: TBitmap;
//begin
//  if FImageName <> '' then
//    Result := LoadImage(FImageName)
//  else
//    Result := nil;
//end;

//function TCustomPageMrWizard.LoadImage(Instance: THandle; const ResourceName: string): TBitmap;
//begin
//  Result := TBitmap.Create;
//  try
//    Result.LoadFromResourceName(Instance, ResourceName);
//  except
//    FreeAndNil(Result);
//  end;
//end;

constructor TCustomPageMrWizard.Create(const ACaption: string;
    AHelpContext: Integer; const AImage: string; const AOptionsFile: string);
begin
  inherited Create;
  FCaption := ACaption;
  FHelpContext := AHelpContext;
  FWizard := nil;
//  FImageName := AImage;
  InitOptions(AOptionsFile);
end;

destructor TCustomPageMrWizard.Destroy;
begin
  FWizard := nil;
  FUIOPtions.Free;
  FBitmap.Free;
  inherited;
end;

procedure TCustomPageMrWizard.DoOnShowing;
begin
//
end;

function TCustomPageMrWizard.CanFinish: Boolean;
begin
  Result := False;
end;

procedure TCustomPageMrWizard.AddFirstPage(out AID: TGUID; out AName: string);
begin
  if GetFirstPageGuidAndName(AID, AName) then
  begin
    Wizard.AddPage(AID,
      AName, HandleFirstPage);
  end;
end;

// Called to initialize wizard when first page is shown
function TCustomPageMrWizard.HandleFirstPage(const CurrentPage: IWizardPage): IWizardPage;
begin
//  Wizard.Back := False;
//  Wizard.Next := HasSelectablePages;
//  Wizard.Finish := (not HasSelectablePages) or CanFinish;
//  Wizard.Cancel := True;
  if HasSelectablePages then
    Result := FirstSelectablePage;
end;

procedure TCustomPageMrWizard.Cancel;
begin
  if FUIOptions <> nil then
  begin
    FUIOptions[ivFormLeft] := Wizard.WizardForm.Left;
    FUIOptions[ivFormTop] := Wizard.WizardForm.Top;
    FUIOptions[ivFormWidth] := Wizard.WizardForm.Width;
    FUIOptions[ivFormHeight] := Wizard.WizardForm.Height;
  end;
end;


procedure TCustomPageMrWizard.Start;
var
  LID: TGUID;
  LName: string;
begin
  if Wizard <> nil then
  begin
    if FUIOptions <> nil then
    begin
      Wizard.WizardForm.Left := FUIOptions.GetOption(ivFormLeft, Wizard.WizardForm.Left);
      Wizard.WizardForm.Top := FUIOptions.GetOption(ivFormTop, Wizard.WizardForm.Top);
      Wizard.WizardForm.Width := FUIOptions.GetOption(ivFormWidth, Wizard.WizardForm.Width);
      Wizard.WizardForm.Height := FUIOptions.GetOption(ivFormHeight, Wizard.WizardForm.Height);
    end;
    DoOnShowing;

    AddFirstPage(LID, LName);
    // Add all pages, even if they are not currently selectable
    //if HasSelectablePages then
      AddSelectablePages(LID,
      LName);
  end;
end;

procedure TCustomPageMrWizard.UpdateButtons;
begin
end;

procedure TCustomPageMrWizard.UpdateSteps;
begin
  if Wizard <> nil then
    Wizard.UpdateSteps;
end;

function TCustomPageMrWizard.HasSelectablePages: Boolean;
begin
  Result := False;
end;

procedure TCustomPageMrWizard.AddSelectablePages(const ParentID: TGUID; const ParentName: string);
begin
  Assert(False);
end;

procedure TCustomPageMrWizard.Finish;
begin
  if FUIOptions <> nil then
  begin
    FUIOptions[ivFormLeft] := Wizard.WizardForm.Left;
    FUIOptions[ivFormTop] := Wizard.WizardForm.Top;
    FUIOptions[ivFormWidth] := Wizard.WizardForm.Width;
    FUIOptions[ivFormHeight] := Wizard.WizardForm.Height;
  end;
end;

function TCustomPageMrWizard.FirstSelectablePage: IWizardpage;
begin
  Assert(False);
end;

function TCustomPageMrWizard.FirstPage: IWizardpage;
begin
  Result := GetFirstPage as IWizardPage;
//  Wizard.Back := False;
//  Wizard.Next := True;
//  Wizard.Finish := CanFinish;
//  Wizard.Cancel := True;
end;

function TCustomPageMrWizard.GetFirstPage: IWizardpage;
begin
  Assert(False); // Ancestor must override
end;

function TCustomPageMrWizard.GetFirstPageGuidAndName(out AID: TGUID;
  out AName: string): Boolean;
begin
  AID := TGuid.Empty;
  AName := '';
  Result := False;
end;

function TCustomPageMrWizard.GetHelpContext: Integer;
begin
  Result := FHelpContext;
end;

function TCustomPageMrWizard.GetImage: TBitmap;
begin
  if FBitmap = nil then
    FBitmap := LoadImage;
  Result := FBitmap;
end;

function TCustomPageMrWizard.Caption: string;
begin
  Result := FCaption;
end;

function TCustomPageMrWizard.GetPersonality: string;
begin
  // Just return current personality
  Result := PersonalityServices.CurrentPersonality;
end;


function TCustomPageMrWizard.GetWizard: IWizard;
begin
  Result := FWizard;
end;

procedure TCustomPageMrWizard.SetWizard(const Value: IWizard);
begin
  FWizard := Value;
end;


end.
