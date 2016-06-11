{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ActnList;

{$T-,H+,X+}

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.UITypes, System.Actions, System.ImageList;

type
  /// <summary>Interface used by the framework to access an action in a
  /// class.</summary>
  IActionClient = interface
    ['{4CAAFEEE-73ED-4C4B-8413-8BF1C3FFD777}']
    /// <summary> The root component. This is usually a form on which the control which supports this interface is placed.
    /// This function is used by framework</summary>
    /// <returns> Instance of component that supports IRoot interface </returns>
    function GetRoot: TComponent;
    /// <summary> This method is used by the framework to determine that an instance of object which supports this
    /// interface is used when working with actions. See also <b>InitiateAction</b>. If returns <c>False</c> then the
    /// instance will be ignored</summary>
    /// <returns> The value set using the method <b>SetActionClient</b> </returns>
    function GetActionClient: Boolean;
    /// <summary> This method sets value that the <b>GetActionClient</b> function returns </summary>
    procedure SetActionClient(const Value: Boolean);
    function GetAction: TBasicAction;
    procedure SetAction(const Value: TBasicAction);
    /// <summary> When the framework performs periodical execution of <b>InitiateAction</b>, it invokes the controls in
    /// order defined by this index</summary>
    function GetIndex: Integer;
    /// <summary> Calls the action link's <b>Update</b> method if the instance is associated with an action link
    /// </summary>
    procedure InitiateAction;
    /// <summary> Action associated with this instance </summary>
    property Action: TBasicAction read GetAction write SetAction;
  end;

  /// <summary>The IIsChecked interface provides access to the IsChecked
  /// property for controls that can be checked.</summary>
  IIsChecked = interface
    ['{DE946EB7-0A6F-4458-AEB0-C911122630D0}']
    function GetIsChecked: Boolean;
    procedure SetIsChecked(const Value: Boolean);
    /// <summary> Determines whether the <b>IsChecked</b> property needs to be stored in the fmx-file </summary>
    /// <returns> <c>True</c> if <b>IsChecked</b> property needs to be stored, usually if it contains non default value
    /// </returns>
    function IsCheckedStored: Boolean;
    /// <summary> <c>True</c> if the control is in the ON state </summary>
    property IsChecked: Boolean read GetIsChecked write SetIsChecked;
  end;

  /// <summary>The IGroupName interface provides access to the GroupName
  /// property for controls that need to provide exclusive checking inside a
  /// group.</summary>
  IGroupName = interface(IIsChecked)
    ['{F5C14792-67AB-41F2-99C1-90C7F94102EE}']
    function GetGroupName: string;
    procedure SetGroupName(const Value: string);
    /// <summary> <c>True</c> if <b>GroupName</b> property should be stored</summary>
    /// <returns> <c>True</c> if <b>GroupName</b> property needs to be stored, usually if it contains non default
    /// (<c>''</c>, <c>'0'</c>, <c>'-1'</c>) value </returns>
    function GroupNameStored: Boolean;
    /// <summary> Name of the control group </summary>
    property GroupName: string read GetGroupName write SetGroupName;
  end;

  /// <summary>Interface used to access the Shortcut property of some
  /// classes.</summary>
  IKeyShortcut = interface
    ['{1AE6E932-9291-4BCD-93D1-DDD2A3E09394}']
    function GetShortcut: TShortcut;
    procedure SetShortcut(const Value: TShortcut);
    /// <summary> The combination of hot keys that the class should handle </summary>
    property Shortcut: TShortcut read GetShortcut write SetShortcut;
  end;

  /// <summary>If an object supports the ICaption interface, when the text of
  /// the object changes, the Text must also be changed.</summary>
  ICaption = interface
    ['{3D039C9C-8888-466F-A344-E7026EEE2C07}']
    function GetText: string;
    procedure SetText(const Value: string);
    /// <summary> If this function returns true, the text should be save in the fmx-file. </summary>
    function TextStored: Boolean;
    /// <summary> This property is used to changed the display text. </summary>
    property Text: string read GetText write SetText;
  end;

  /// <summary>Declares basic methods and properties used to manage lists of
  /// images.</summary>
  IGlyph = interface
  ['{62BDCA4F-820A-4058-B57A-FE8931DB3CCC}']
    function GetImageIndex: TImageIndex;
    procedure SetImageIndex(const Value: TImageIndex);
    function GetImages: TBaseImageList;
    procedure SetImages(const Value: TBaseImageList);
    ///<summary> Should be called when you change an instance or reference to instance of <b>TBaseImageList</b> or the
    /// <b>ImageIndex</b> property</summary>
    procedure ImagesChanged;
    ///<summary> Zero based index of an image. The default is <c>-1</c></summary>
    ///<remarks> If non-existing index is specified, an image is not drawn and no exception is raised</remarks>
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex;
    ///<summary> The list of images. Can be <c>nil</c></summary>
    property Images: TBaseImageList read GetImages write SetImages;
  end;

  TCustomActionList = class(TContainedActionList)
  private
    FImageLink: TImageLink;
    procedure SetImages(const Value: TBaseImageList);
    function GetImages: TBaseImageList;
  protected
    ///<summary> Should be called when you change an instance or reference to instance of <b>TBaseImageList</b> or the
    /// <b>ImageIndex</b> property</summary>
    procedure ImagesChanged; virtual;
  public
    destructor Destroy; override;
    function DialogKey(const Key: Word; const Shift: TShiftState): Boolean; virtual;
    ///<summary> The list of images. Can be <c>nil</c></summary>
    property Images: TBaseImageList read GetImages write SetImages;
  end;

  TActionList = class(TCustomActionList)
  published
    property Name;
    property Images;
    property State;
    property OnChange;
    property OnExecute;
    property OnStateChange;
    property OnUpdate;
  end;

  TActionLink = class(TContainedActionLink)
  private
    [Weak] FClient: TObject;
    FIsViewActionClient: Boolean;
    [Weak] FImages: TBaseImageList;
    FGlyph: IGlyph;
    FCaption: ICaption;
    FChecked: IIsChecked;
    FGroupName: IGroupName;
    procedure UpdateImages(const AImageListLinked: Boolean);
  protected
    procedure AssignClient(AClient: TObject); override;
    procedure SetAction(Value: TBasicAction); override;
    function IsCaptionLinked: Boolean; override;
    function IsCheckedLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetGroupIndex(Value: Integer); override;
    procedure SetImageIndex(Value: Integer); override;
    procedure Change; override;
    /// <summary> Reference to <b>IGlyph</b> interface of <b>Client</b>. <c>Nil</c> if <b>Client</b> is undefined or
    /// does not support this interface </summary>
    property Glyph: IGlyph read FGlyph;
  public
    function IsViewActionClient: Boolean;
    property Client: TObject read FClient;
    ///<summary> The list of images. Can be <c>nil</c></summary>
    property Images: TBaseImageList read FImages;
    property CaptionLinked: Boolean read IsCaptionLinked;
    /// <summary> Same as <b>IsHintLinked</b> </summary>
    property HintLinked: Boolean read IsHintLinked;
    property CheckedLinked: Boolean read IsCheckedLinked;
    property EnabledLinked: Boolean read IsEnabledLinked;
    property GroupIndexLinked: Boolean read IsGroupIndexLinked;
    property ShortCutLinked: Boolean read IsShortCutLinked;
    property VisibleLinked: Boolean read IsVisibleLinked;
    property OnExecuteLinked: Boolean read IsOnExecuteLinked;
  end;

  TActionLinkClass = class of TActionLink;

  TShortCutList = class(TCustomShortCutList)
  public
    function Add(const S: String): Integer; override;
  end;

  TCustomAction = class(TContainedAction)
  private
    FShortCutPressed: Boolean;
    [Weak] FTarget: TComponent;
    FUnsupportedArchitectures: TArchitectures;
    FUnsupportedPlatforms: TPlatforms;
    FOldVisible: Boolean;
    FOldEnabled: Boolean;
    FSupported: Boolean;
    FCustomText: string;
    FSupportedChecked: Boolean;
    FHideIfUnsupportedInterface: Boolean;
    function GetText: string; inline;
    procedure SetText(const Value: string); inline;
    function GetCustomActionList: TCustomActionList;
    procedure SetCustomActionList(const Value: TCustomActionList);
    procedure ReaderCaptionProc(Reader: TReader);
    procedure WriterCaptionProc(Writer: TWriter);
    procedure ReaderImageIndexProc(Reader: TReader);
    procedure WriterImageIndexProc(Writer: TWriter);
    procedure SetUnsupportedArchitectures(const Value: TArchitectures);
    procedure SetUnsupportedPlatforms(const Value: TPlatforms);
    procedure SetCustomText(const Value: string);
    procedure SetHideIfUnsupportedInterface(const Value: Boolean);
  protected
    procedure UpdateSupported;
    function IsSupportedInterface: Boolean; virtual;
    function CreateShortCutList: TCustomShortCutList; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetTarget(const Value: TComponent); virtual;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetVisible(Value: Boolean); override;
    procedure Loaded; override;
    procedure CustomTextChanged; virtual;
    property CustomText: string read FCustomText write SetCustomText;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
    function Update: Boolean; override;
    function IsDialogKey(const Key: Word; const Shift: TShiftState): Boolean;
    property Text: string read GetText write SetText;
    property Caption stored false;
    property ActionList: TCustomActionList read GetCustomActionList write SetCustomActionList;
    property HideIfUnsupportedInterface: Boolean read FHideIfUnsupportedInterface write SetHideIfUnsupportedInterface;
    property ShortCutPressed: Boolean read FShortCutPressed write FShortCutPressed;
    property Target: TComponent read FTarget write SetTarget;
    property UnsupportedArchitectures: TArchitectures read FUnsupportedArchitectures write SetUnsupportedArchitectures
      default [];
    property UnsupportedPlatforms: TPlatforms read FUnsupportedPlatforms write SetUnsupportedPlatforms default [];
    property Supported: Boolean read FSupported;
  end;

{ TCustomViewAction }

  TOnCreateComponent = procedure (Sender: TObject; var NewComponent: TComponent) of object;
  TOnBeforeShow = procedure (Sender: TObject; var CanShow: Boolean) of object;

  TCustomViewAction = class(TCustomAction)
  private
    [Weak] FComponent: TComponent;
    FOnCreateComponent: TonCreateComponent;
    FOnAfterShow: TNotifyEvent;
    FOnBeforeShow: TOnBeforeShow;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCreateComponent(var NewComponent: TComponent); virtual;
    procedure DoBeforeShow(var CanShow: Boolean); virtual;
    procedure DoAfterShow; virtual;
    function ComponentText: string; virtual;
    procedure ComponentChanged; virtual;
    procedure SetComponent(const Value: TComponent); virtual;
    property OnCreateComponent: TOnCreateComponent read FOnCreateComponent write FonCreateComponent;
    property OnBeforeShow: TOnBeforeShow read FOnBeforeShow write FOnBeforeShow;
    property OnAfterShow: TNotifyEvent read FOnAfterShow write FOnAfterShow;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    property Component: TComponent read FComponent write SetComponent;
  end;

  /// <summary>TAction is the base class for FireMonkey action objects. TAction
  /// and descendant classes implement actions to be used with controls, menu
  /// items, and tool buttons. The published properties and events of TAction
  /// actions can be managed in the Object Inspector at design time.</summary>
  TAction = class(TCustomAction)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoCheck;
    property Text;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property ShortCut default 0;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnExecute;
    property OnUpdate;
    property OnHint;
  end;

function TextToShortCut(Text: string): Integer;

implementation

uses
  FMX.Consts, FMX.Platform, FMX.Forms, FMX.Menus;

function TextToShortCut(Text: string): Integer;
var
  MenuService: IFMXMenuService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, MenuService) then
    Result:= MenuService.TextToShortCut(Text)
  else
    Result := -1;
end;

{$REGION 'TCustomActionList'}

destructor TCustomActionList.Destroy;
begin
  FImageLink.DisposeOf;
  inherited;
end;

function TCustomActionList.DialogKey(const Key: Word; const Shift: TShiftState): Boolean;
var
  I: Integer;
  LAction: TCustomAction;
begin
  Result := False;
  if (State <> asNormal) then
    Exit;
  for I := 0 to ActionCount - 1 do
  if (Actions[I] is TCustomAction) and
     (TCustomAction(Actions[I]).Supported) and
     (TCustomAction(Actions[I]).IsDialogKey(Key, Shift)) then
  begin
    LAction := TCustomAction(Actions[I]);
    LAction.ShortCutPressed := True;
    try
      Result := LAction.HandleShortCut;
      if (not Result) and
         (LAction.Enabled) and
         (LAction.HandlesTarget(nil)) then
      begin
        LAction.UpdateTarget(nil);
        if LAction.Enabled then
        begin
          LAction.ExecuteTarget(nil);
          Result := True;
        end;
      end;
    finally
      LAction.ShortCutPressed := False;
    end;
    if Result then Exit;
  end;
end;

function TCustomActionList.GetImages: TBaseImageList;
begin
  if FImageLink <> nil then
    Result := FImageLink.Images
  else
    Result := nil;
end;

type
  TImageLinkOfActionList = class(TImageLink)
  private
    [Weak] FActionList: TCustomActionList;
  protected
    procedure Change; override;
  public
    constructor Create(AOwner: TCustomActionList); reintroduce;
  end;

{ TImageLinkOfActionList }

constructor TImageLinkOfActionList.Create(AOwner: TCustomActionList);
begin
  inherited Create;
  FActionList := AOwner;
  IgnoreIndex := True;
end;

procedure TImageLinkOfActionList.Change;
begin
  if (FActionList <> nil) and (csDesigning in FActionList.ComponentState) then
    FActionList.Change;
end;

procedure TCustomActionList.SetImages(const Value: TBaseImageList);
begin
  if Images <> Value then
  begin
    if Value <> nil then
    begin
      if FImageLink = nil then
        FImageLink := TImageLinkOfActionList.Create(Self);
      FImageLink.Images := Value;
    end
    else
    begin
      FImageLink.DisposeOf;
      FImageLink := nil;
      if csDesigning in ComponentState then
        Change;
    end;
    ImagesChanged;
  end;
end;

procedure TCustomActionList.ImagesChanged;
var
  I, J: Integer;
begin
  for I := ActionCount - 1 downto 0 do
    if Actions[I] is TCustomAction then
      for J := TCustomAction(Actions[I]).ClientCount - 1 downto 0 do
        if TCustomAction(Actions[I]).Clients[J] is TActionLink then
          TActionLink(TCustomAction(Actions[I]).Clients[J]).Change;
end;
{$ENDREGION}

{$REGION 'TActionLink'}

function TActionLink.IsViewActionClient: Boolean;
begin
  Result := FIsViewActionClient and (TCustomViewAction(Action).Component = Client);
end;

procedure TActionLink.SetAction(Value: TBasicAction);
begin
  if Value <> Action then
  begin
    FIsViewActionClient := (Value is TCustomViewAction);
    UpdateImages(False);
  end;
  inherited;
end;

procedure TActionLink.AssignClient(AClient: TObject);
begin
  inherited;
  FClient := AClient;
  FGlyph := nil;
  FCaption := nil;
  FChecked := nil;
  FGroupName := nil;
  Supports(FClient, IGlyph, FGlyph);
  Supports(FClient, ICaption, FCaption);
  if Supports(FClient, IGroupName, FGroupName) then
    FChecked := FGroupName
  else
    Supports(FClient, IIsChecked, FChecked);
end;

function TActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited and (FCaption <> nil) and (FCaption.Text = TContainedAction(Action).Caption);
end;

function TActionLink.IsCheckedLinked: Boolean;
begin
  if IsViewActionClient then
    Result := False
  else
    Result := inherited and (FChecked <> nil) and (FChecked.IsChecked = TContainedAction(Action).Checked);
end;

function TActionLink.IsEnabledLinked: Boolean;
begin
  if IsViewActionClient then
    Result := False
  else
    Result := inherited;
end;

function TActionLink.IsGroupIndexLinked: Boolean;
var
  S: string;
begin
  if IsViewActionClient then
    Result := False
  else
  begin
    Result := inherited and (FGroupName <> nil);
    if Result then
    begin
      S := FGroupName.GroupName;
      Result := (S = '') or (S = '0') or (S = TContainedAction(Action).GroupIndex.ToString);
    end;
  end;
end;

function TActionLink.IsOnExecuteLinked: Boolean;
begin
  if IsViewActionClient then
    Result := False
  else
    Result := inherited;
end;

function TActionLink.IsShortCutLinked: Boolean;
begin
  if IsViewActionClient then
    Result := False
  else
    Result := inherited;
end;

function TActionLink.IsVisibleLinked: Boolean;
begin
  if IsViewActionClient then
    Result := False
  else
    Result := inherited;
end;

function TActionLink.IsImageIndexLinked: Boolean;
begin
  Result := (FGlyph <> nil) and (Action is TCustomAction) and
    ((FGlyph.ImageIndex = TCustomAction(Action).ImageIndex) or (TCustomAction(Action).ImageIndex < 0));
end;

procedure TActionLink.UpdateImages(const AImageListLinked: Boolean);
var
  NewImages: TBaseImageList;
begin
  if (Action is TCustomAction) and (TCustomAction(Action).ActionList <> nil) then
    NewImages := TCustomAction(Action).ActionList.Images
  else
    NewImages := nil;
  if FImages <> NewImages then
  begin
    if AImageListLinked and (FGlyph <> nil) then
    begin
      FImages := NewImages;
      FGlyph.Images := FImages
    end
    else
      FImages := NewImages;
  end;
end;

procedure TActionLink.Change;
var
  ImagesLinked: Boolean;
begin
  ImagesLinked := (FGlyph <> nil) and (Action is TCustomAction) and (TCustomAction(Action).ActionList <> nil) and
    ((FGlyph.Images = FImages) or (FGlyph.Images = nil));
  UpdateImages(ImagesLinked);
end;

procedure TActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FCaption.Text := Value;
end;

procedure TActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then
    FChecked.IsChecked := Value;
end;

procedure TActionLink.SetGroupIndex(Value: Integer);
begin
  if IsGroupIndexLinked then
    FGroupName.GroupName := Value.ToString;
end;

procedure TActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    FGlyph.ImageIndex := Value;
end;

{$ENDREGION}

{$REGION 'TShortCutList'}

function TShortCutList.Add(const S: String): Integer;
var
  ShortCut: NativeInt;
begin
  ShortCut := TextToShortCut(S);
  if ShortCut <> 0 then
  begin
    Result := inherited Add(S);
    Objects[Result] := TObject(ShortCut);
  end
  else
    raise EActionError.CreateFMT(SErrorShortCut, [S]);
end;

{$ENDREGION}

{$REGION 'TCustomAction'}

constructor TCustomAction.Create(AOwner: TComponent);
begin
  inherited;
  FSupported := True;
  FOldEnabled := Enabled;
  FOldVisible := Visible;
end;

function TCustomAction.CreateShortCutList: TCustomShortCutList;
begin
  Result := TShortCutList.Create;
end;

procedure TCustomAction.ReaderCaptionProc(Reader: TReader);
var S: string;
begin
  try
    S := Reader.ReadString;
  except
    S := '';
  end;
  if S <> '' then Text := S;
end;

procedure TCustomAction.WriterCaptionProc(Writer: TWriter);
begin
  Writer.WriteString(Caption);
end;

procedure TCustomAction.ReaderImageIndexProc(Reader: TReader);
begin
  ImageIndex := Reader.ReadInteger;
end;

procedure TCustomAction.WriterImageIndexProc(Writer: TWriter);
begin
  Writer.WriteInteger(ImageIndex);
end;

procedure TCustomAction.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Caption', ReaderCaptionProc, WriterCaptionProc, False);
  Filer.DefineProperty('ImageIndex', ReaderImageIndexProc, WriterImageIndexProc, ImageIndex <> -1);
end;

function TCustomAction.IsDialogKey(const Key: Word; const Shift: TShiftState): Boolean;
var
  I: Integer;
  MenuService: IFMXMenuService;
  procedure UpdateResult(ShortCut: System.Classes.TShortCut);
  var
    k: word;
    SState: TShiftState;
  begin
    SState := [];
    k := 0;
    if MenuService <> nil then
      MenuService.ShortCutToKey(ShortCut, k, SState)
    else
    begin
      k := ShortCut and not (scCommand + scShift + scCtrl + scAlt);
      if ShortCut and scShift <> 0 then Include(SState, ssShift);
      if ShortCut and scCtrl <> 0 then Include(SState, ssCtrl);
      if ShortCut and scAlt <> 0 then Include(SState, ssAlt);
      if ShortCut and scCommand <> 0 then Include(SState, ssCommand);
    end;
    Result := (k = Key) and (Shift = SState);
  end;
begin
  Result := False;
  MenuService := nil;
  if Supported and (ShortCut <> 0) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, MenuService);
    UpdateResult(ShortCut);
    if (not Result) and (SecondaryShortCutsCreated) then
    begin
      I := 0;
      while (not Result) and (I < SecondaryShortCuts.Count) do
      begin
        UpdateResult(SecondaryShortCuts.ShortCuts[I]);
        inc(I);
      end;
    end;
  end;
end;

procedure TCustomAction.Loaded;
begin
  inherited;
  UpdateSupported;
  if Supported and (([csLoading, csDestroying] * ComponentState) = []) then
    CustomTextChanged;
end;

function TCustomAction.Execute: Boolean;
begin
  Result := False;
  if Supported and not Suspended then
  begin
    Update;
    if Enabled and AutoCheck then
      if (not Checked) or (Checked and (GroupIndex = 0)) then
        Checked := not Checked;
    if Enabled then
      Result := ((ActionList <> nil) and ActionList.ExecuteAction(Self)) or
        ((Application <> nil) and Application.ExecuteAction(Self)) or inherited Execute or
        ((Application <> nil) and Application.ActionExecuteTarget(Self));
  end;
end;

function TCustomAction.Update: Boolean;
begin
  if FHideIfUnsupportedInterface then
  begin
    if not FSupportedChecked then
    begin
      UpdateSupported;
      FSupportedChecked := True;
    end;
  end;
  if Supported then
    Result := ((ActionList <> nil) and ActionList.UpdateAction(Self)) or
               (Application.UpdateAction(Self)) or inherited Update
  else
    Result := False;
end;

function TCustomAction.GetCustomActionList: TCustomActionList;
begin
  Result := TCustomActionList(inherited ActionList);
end;

procedure TCustomAction.SetCustomActionList(const Value: TCustomActionList);
begin
  inherited ActionList := Value;
end;

procedure TCustomAction.CustomTextChanged;
begin

end;

procedure TCustomAction.SetCustomText(const Value: string);
begin
  if FCustomText <> Value then
  begin
    FCustomText := Value;
    if (Supported or vDesignAction) and
      (([csLoading, csDestroying] * ComponentState) = []) then
      CustomTextChanged;
  end;
end;

procedure TCustomAction.SetEnabled(Value: Boolean);
var
  V: Boolean;
begin
  V := Value and Supported;
  if Supported or (csLoading in ComponentState) then
    FOldEnabled := Value;
  if V <> Enabled then
    inherited SetEnabled(V);
end;

procedure TCustomAction.SetHideIfUnsupportedInterface(const Value: Boolean);
begin
  if FHideIfUnsupportedInterface <> Value then
  begin
    FHideIfUnsupportedInterface := Value;
    if FHideIfUnsupportedInterface then
      FSupportedChecked := False;
  end;
end;

procedure TCustomAction.SetVisible(Value: Boolean);
var
  V: Boolean;
begin
  V := Value and Supported;
  if Supported or (csLoading in ComponentState) then
    FOldVisible := Value;
  if V <> Visible then
    inherited SetVisible(V);
end;

function TCustomAction.GetText: string;
begin
  Result := inherited Caption;
end;

procedure TCustomAction.SetTarget(const Value: TComponent);
begin
  FTarget := Value;
end;

procedure TCustomAction.SetText(const Value: string);
begin
  Caption := Value;
end;

function TCustomAction.IsSupportedInterface: Boolean;
begin
  Result := True;
end;

procedure TCustomAction.UpdateSupported;
var
  LSupp: Boolean;
begin
  if (([csDesigning, csLoading] * ComponentState) <> []) or vDesignAction then
    LSupp := True
  else
  begin
    LSupp := not ((TOSVersion.Architecture in FUnsupportedArchitectures) or
      (TOSVersion.Platform in FUnsupportedPlatforms));
    if LSupp and FHideIfUnsupportedInterface then
      LSupp := IsSupportedInterface;
  end;
  if LSupp <> FSupported then
  begin
    FSupported := LSupp;
    if FSupported then
    begin
      SetEnabled(FOldEnabled);
      SetVisible(FOldVisible);
    end
    else
    begin
      SetVisible(False);
      SetEnabled(False);
    end;
    Change;
  end;
end;

procedure TCustomAction.SetUnsupportedArchitectures(const Value: TArchitectures);
begin
  if FUnsupportedArchitectures <> Value then
  begin
    FUnsupportedArchitectures := Value;
    UpdateSupported;
  end;
end;

procedure TCustomAction.SetUnsupportedPlatforms(const Value: TPlatforms);
begin
  if FUnsupportedPlatforms <> Value then
  begin
    FUnsupportedPlatforms := Value;
    UpdateSupported;
  end;
end;

{$ENDREGION}

{$REGION 'TCustomViewAction'}

procedure TCustomViewAction.DoCreateComponent(
  var NewComponent: TComponent);
begin
  if Assigned(FOnCreateComponent) then
    FonCreateComponent(Self, NewComponent);
end;

procedure TCustomViewAction.DoBeforeShow(var CanShow: Boolean);
begin
  if Assigned(FOnBeforeShow) then
    FOnBeforeShow(Self, CanShow);
end;

procedure TCustomViewAction.DoAfterShow;
begin
  if Assigned(FOnAfterShow) then
    FOnAfterShow(Self);
end;

function TCustomViewAction.HandlesTarget(Target: TObject): Boolean;
begin
  result := True;
end;

procedure TCustomViewAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FComponent) then
    Component := nil;
end;

function TCustomViewAction.ComponentText: string;
begin
  Result := '';
  if FComponent <> nil then
  begin
    if FComponent is TCommonCustomForm then
      result := TCommonCustomForm(FComponent).Caption
    else
      result := FComponent.Name;
  end;
end;

procedure TCustomViewAction.SetComponent(const Value: TComponent);
begin
  if FComponent <> Value then
  begin
    if FComponent <> nil then
    begin
      FComponent.RemoveFreeNotification(Self);
      FComponent := nil;
    end;
    FComponent := Value;
    if FComponent <> nil then
      FComponent.FreeNotification(Self);
    ComponentChanged;
  end;
end;

procedure TCustomViewAction.ComponentChanged;
begin

end;

{$ENDREGION}

{$REGION 'TAction'}

constructor TAction.Create(AOwner: TComponent);
begin
  inherited;
  DisableIfNoHandler := True;
end;

{$ENDREGION}

end.
