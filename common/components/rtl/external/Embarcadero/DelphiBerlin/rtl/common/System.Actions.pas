{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Actions;
// This module is taken out of the overall functionality of the module Vcl.ActnList.pas

interface

uses
{$IF DEFINED(CLR)}
  System.ComponentModel.Design.Serialization,
{$ENDIF}
  System.SysUtils, System.Classes, System.Generics.Collections, System.UITypes;

type
{$REGION 'Add-ons for future use'}
  /// <summary> The class of errors that appear when working with actions </summary>
  EActionError = class(Exception)

  end;

  /// <summary>
  /// Current status of the input field. This value can be used in different
  /// type-validators on your own.
  /// </summary>
  TStatusAction = (
    /// <summary>
    /// Status invisible. The input fields are displayed as well as before the
    /// new properties.
    /// </summary>
    saNone,
    /// <summary>
    /// Displays the normal field in the normal state.
    /// </summary>
    saTrivial,
    /// <summary>
    /// This field contains the default value
    /// </summary>
    saDefault,
    /// <summary>
    /// Required field that has not yet filled.
    /// </summary>
    saRequiredEmpty,
    /// <summary>
    /// Required field is already filled.
    /// </summary>
    saRequired,
    /// <summary>
    /// Field been tested and it contains a valid value.
    /// </summary>
    saValid,
    /// <summary>
    /// The field has been tested and it contains an invalid value.
    /// </summary>
    saInvalid,
    /// <summary>
    /// Running some long operation.
    /// </summary>
    saWaiting,
    /// <summary>
    /// Perhaps the field contains an invalid value.
    /// </summary>
    saWarning,
    /// <summary>
    /// The field value is not used in this case.
    /// </summary>
    saUnused,
    /// <summary>
    /// This field value is calculated.
    /// </summary>
    saCalculated,
    /// <summary>
    /// The field value is incorrect
    /// </summary>
    saError,
    /// <summary>
    /// Another state (user defined)
    /// </summary>
    saOther);

{$ENDREGION}

  TContainedActionList = class;
  TContainedActionListClass = class of TContainedActionList;

  ///<summary> This is the base class that implements the operation with
  /// a list of keyboard shortcuts. Should be established descendants
  /// of this class (see TContainedAction.CreateShortCutList) for each platform (VCL, FMX), which should be overridden the method Add.</summary>
  TCustomShortCutList = class(TStringList)
  private
    function GetShortCuts(Index: Integer): System.Classes.TShortCut; inline;
  public
    function IndexOfShortCut(const ShortCut: System.Classes.TShortCut): Integer; overload;
    function IndexOfShortCut(const ShortCut: string): Integer; overload;
    property ShortCuts[Index: Integer]: System.Classes.TShortCut read GetShortCuts;
  end;

  /// <summary> The ancestor class of actions, that contained in the TContainedActionList </summary>
  /// <remarks> It implements to work with common properties for all platforms (FMX, VCL).</remarks>
  TContainedAction = class(TBasicAction)
  private
    FCategory: string;
    FActionList: TContainedActionList;
    FSavedEnabledState: Boolean;
    FDisableIfNoHandler: Boolean;
    FAutoCheck: Boolean;
    FCaption: string;
    FChecked: Boolean;
    FEnabled: Boolean;
    FGroupIndex: Integer;
    FHelpContext: THelpContext;
    FHelpKeyword: string;
    FHelpType: THelpType;
    FHint: string;
    FVisible: Boolean;
    FShortCut: System.Classes.TShortCut;
    FSecondaryShortCuts: TCustomShortCutList;
    FImageIndex: System.UITypes.TImageIndex;
    FChecking: Boolean;
    FStatusAction: TStatusAction;
    FOnHint: THintEvent;
    function GetIndex: Integer;
    procedure SetIndex(Value: Integer);
    procedure SetCategory(const Value: string);
    function GetSecondaryShortCuts: TCustomShortCutList;
    procedure SetSecondaryShortCuts(const Value: TCustomShortCutList);
    function IsSecondaryShortCutsStored: Boolean;
    procedure SetActionList(AActionList: TContainedActionList);
{$IF DEFINED(CLR)}
    class constructor Create;
{$ENDIF}
  protected
    procedure ReadState(Reader: TReader); override;
    ///<summary>This method should create an instance of a class defined for each platform.</summary>
    function SecondaryShortCutsCreated: boolean;
    function CreateShortCutList: TCustomShortCutList; virtual;

    // This properties moved from TCustomAction
    property SavedEnabledState: Boolean read FSavedEnabledState write FSavedEnabledState;
    // This methods moved from TCustomAction
    procedure AssignTo(Dest: TPersistent); override;
    function HandleShortCut: Boolean; virtual;

    procedure SetAutoCheck(Value: Boolean); virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure SetName(const Value: TComponentName); override;
    procedure SetChecked(Value: Boolean); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetGroupIndex(const Value: Integer); virtual;
    procedure SetHelpContext(Value: THelpContext); virtual;
    procedure SetHelpKeyword(const Value: string); virtual;
    procedure SetHelpType(Value: THelpType); virtual;
    procedure SetHint(const Value: string); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    procedure SetShortCut(Value: System.Classes.TShortCut); virtual;
    procedure SetImageIndex(Value: System.UITypes.TImageIndex); virtual;
    procedure SetStatusAction(const Value: TStatusAction); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    property ActionList: TContainedActionList read FActionList write SetActionList;
    function Suspended: Boolean; override;
    property Index: Integer read GetIndex write SetIndex stored False;
    // This properties moved from TCustomAction
    property DisableIfNoHandler: Boolean read FDisableIfNoHandler write FDisableIfNoHandler
      default True;
    property AutoCheck: Boolean read FAutoCheck write SetAutoCheck default False;
    property Caption: string read FCaption write SetCaption;
    property Checked: Boolean read FChecked write SetChecked default False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext default 0;
    property HelpKeyword: string read FHelpKeyword write SetHelpKeyword;
    property HelpType: THelpType read FHelpType write SetHelpType default htKeyword;
    property Hint: string read FHint write SetHint;
    property Visible: Boolean read FVisible write SetVisible default True;
    property ShortCut: System.Classes.TShortCut read FShortCut write SetShortCut default 0;
    property SecondaryShortCuts: TCustomShortCutList read GetSecondaryShortCuts
      write SetSecondaryShortCuts stored IsSecondaryShortCutsStored;
    property ImageIndex: System.UITypes.TImageIndex read FImageIndex write SetImageIndex default -1;
    // This methods moved from TCustomAction
    function DoHint(var HintStr: string): Boolean; dynamic;
    property OnHint: THintEvent read FOnHint write FOnHint;
    /// <summary>
    /// Current status of the input field.
    /// </summary>
    /// <remarks>
    /// This new proposed property
    /// </remarks>
    property StatusAction: TStatusAction read FStatusAction write SetStatusAction;
  published
    property Category: string read FCategory write SetCategory;
  end;

  /// <summary> This class is designed to communicate with some of the object. </summary>
  /// <remarks> It implements to work with common properties for all platforms (FMX, VCL).</remarks>
  TContainedActionLink = class(TBasicActionLink)
  protected
    procedure DefaultIsLinked(var Result: Boolean); virtual;
    function IsCaptionLinked: Boolean; virtual;
    function IsCheckedLinked: Boolean; virtual;
    function IsEnabledLinked: Boolean; virtual;
    function IsGroupIndexLinked: Boolean; virtual;
    function IsHelpContextLinked: Boolean; virtual;
    function IsHelpLinked: Boolean; virtual;
    function IsHintLinked: Boolean; virtual;
    function IsImageIndexLinked: Boolean; virtual;
    function IsShortCutLinked: Boolean; virtual;
    function IsVisibleLinked: Boolean; virtual;
    function IsStatusActionLinked: Boolean; virtual;
    procedure SetAutoCheck(Value: Boolean); virtual;
    procedure SetCaption(const Value: string); virtual;
    procedure SetChecked(Value: Boolean); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
    procedure SetGroupIndex(Value: Integer); virtual;
    procedure SetHelpContext(Value: THelpContext); virtual;
    procedure SetHelpKeyword(const Value: string); virtual;
    procedure SetHelpType(Value: THelpType); virtual;
    procedure SetHint(const Value: string); virtual;
    procedure SetImageIndex(Value: Integer); virtual;
    procedure SetShortCut(Value: System.Classes.TShortCut); virtual;
    procedure SetVisible(Value: Boolean); virtual;
    procedure SetStatusAction(const Value: TStatusAction); virtual;
  end;

  TContainedActionLinkClass = class of TContainedActionLink;
  TContainedActionClass = class of TContainedAction;

  TActionListState = (asNormal, asSuspended, asSuspendedEnabled);

  /// <summary>
  /// Auxiliary class for enumeration actions in TContainedActionList
  /// </summary>
  TActionListEnumerator = class
  private
    FIndex: Integer;
    FActionList: TContainedActionList;
    function GetCurrent: TContainedAction; inline;
  public
    constructor Create(AActionList: TContainedActionList);
    function MoveNext: Boolean; inline;
    property Current: TContainedAction read GetCurrent;
  end;

  TEnumActionListEvent = procedure(const Action: TContainedAction; var Done: boolean) of object;
  TEnumActionListRef = reference to procedure(const Action: TContainedAction; var Done: boolean);

  /// <summary> The base class for list of actions (without a published properties).
  /// It implements to work with common properties for all platforms (FMX, VCL).
  /// </summary>
  [RootDesignerSerializerAttribute('', '', False)]
  TContainedActionList = class(TComponent)
  private
    FActions: TList<TContainedAction>;
    FOnChange: TNotifyEvent;
    FOnExecute: TActionEvent;
    FOnUpdate: TActionEvent;
    FState: TActionListState;
    FOnStateChange: TNotifyEvent;
    function GetAction(Index: Integer): TContainedAction;
    procedure SetAction(Index: Integer; Value: TContainedAction);
    function GetActionCount: Integer;
{$IF DEFINED(CLR)}
    class constructor Create;
{$ENDIF}
  protected
    function ActionsCreated: Boolean; inline;
    procedure CheckActionsCreated; inline;
    procedure AddAction(const Action: TContainedAction);
    procedure RemoveAction(const Action: TContainedAction);
    procedure Change; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetChildOrder(Component: TComponent; Order: Integer); override;
    procedure SetState(const Value: TActionListState); virtual;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnExecute: TActionEvent read FOnExecute write FOnExecute;
    property OnUpdate: TActionEvent read FOnUpdate write FOnUpdate;
    function SameCategory(const Source, Dest: string;
                          const IncludeSubCategory: Boolean = True): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function GetEnumerator: TActionListEnumerator;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function EnumByCategory(Proc: TEnumActionListEvent;
                      const Category: string;
                      const IncludeSubCategory: Boolean = True): boolean; overload;
    function EnumByCategory(Proc: TEnumActionListRef;
                      const Category: string;
                      const IncludeSubCategory: Boolean = True): boolean; overload;
    property Actions[Index: Integer]: TContainedAction read GetAction write SetAction; default;
    property ActionCount: Integer read GetActionCount;
    property State: TActionListState read FState write SetState default asNormal;
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
  end;

{$REGION 'Action registration. This code moved from Vcl.ActnList'}

type
{$IF DEFINED(CLR)}
  TEnumActionProcInfo = TObject;
{$ELSE}
  TEnumActionProcInfo = Pointer;
{$ENDIF}
  TEnumActionProc = procedure(const Category: string; ActionClass: TBasicActionClass;
    Info: TEnumActionProcInfo) of object;

procedure RegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass;
  Resource: TComponentClass);
procedure UnRegisterActions(const AClasses: array of TBasicActionClass);
procedure EnumRegisteredActions(Proc: TEnumActionProc; Info: TEnumActionProcInfo; FrameworkType: string = '');
function CreateAction(AOwner: TComponent; ActionClass: TBasicActionClass; FrameworkType: string = ''): TBasicAction;

{$IF DEFINED(CLR)}
var
  vDesignAction: boolean;
  RegisterActionsProc: procedure(const CategoryName: string;
                                 const AClasses: array of TBasicActionClass;
                                       Resource: TComponentClass);
  UnRegisterActionsProc: procedure(const AClasses: array of TBasicActionClass);
  EnumRegisteredActionsProc: procedure(Proc: TEnumActionProc;
                                       Info: TObject;
                                       const FrameworkType: string);
  CreateActionProc: function(AOwner: TComponent;
                             ActionClass: TBasicActionClass;
                             const FrameworkType: string): TBasicAction;
{$ELSE}
var
  vDesignAction: boolean;
const
  RegisterActionsProc: procedure(const CategoryName: string;
                                 const AClasses: array of TBasicActionClass;
                                       Resource: TComponentClass) = nil;
  UnRegisterActionsProc: procedure(const AClasses: array of TBasicActionClass) = nil;
  EnumRegisteredActionsProc: procedure(Proc: TEnumActionProc;
                                       Info: Pointer;
                                       const FrameworkType: string) = nil;
  CreateActionProc: function(AOwner: TComponent;
                             ActionClass: TBasicActionClass;
                             const FrameworkType: string): TBasicAction = nil;
{$ENDIF}
{$ENDREGION}


{$REGION 'shortcuts registration'}
function RegisterShortCut(ShortCut: TShortCut; Index: integer = -1): integer;
function UnregisterShortCut(ShortCut: TShortCut): boolean;
function RegisteredShortCutCount: integer;
function RegisteredShortCut(Index: integer): TShortCut;
{$ENDREGION}


implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF MACOS}
  System.RTLConsts;

{$REGION 'Action registration. This code moved from Vcl.ActnList'}

procedure RegisterActions(const CategoryName: string; const AClasses: array of TBasicActionClass;
  Resource: TComponentClass);
begin
  if Assigned(RegisterActionsProc) then
    RegisterActionsProc(CategoryName, AClasses, Resource)
  else
    raise EActionError.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidActionRegistration);
end;

procedure UnRegisterActions(const AClasses: array of TBasicActionClass);
begin
  if Assigned(UnRegisterActionsProc) then
    UnRegisterActionsProc(AClasses)
  else
    raise EActionError.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidActionUnregistration);
end;

procedure EnumRegisteredActions(Proc: TEnumActionProc; Info: TEnumActionProcInfo; FrameworkType: string = '');
begin
  if Assigned(EnumRegisteredActionsProc) then
    EnumRegisteredActionsProc(Proc, Info, FrameworkType)
  else
    raise EActionError.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidActionEnumeration);
end;

function CreateAction(AOwner: TComponent; ActionClass: TBasicActionClass; FrameworkType: string = ''): TBasicAction;
var
  LDesignAction: boolean;
begin
  if Assigned(CreateActionProc) then
  begin
    LDesignAction := vDesignAction;
    try
      vDesignAction := True;
      Result := CreateActionProc(AOwner, ActionClass, FrameworkType)
    finally
      vDesignAction := LDesignAction;
    end;
  end
  else
    raise EActionError.CreateRes({$IFNDEF CLR}@{$ENDIF}SInvalidActionCreation);
end;
{$ENDREGION}

{ TCustomShortCutList }

function TCustomShortCutList.GetShortCuts(Index: Integer): System.Classes.TShortCut;
begin
  Result := TShortCut(Objects[Index]);
end;

function TCustomShortCutList.IndexOfShortCut(const ShortCut: System.Classes.TShortCut): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if System.Classes.TShortCut(Objects[I]) = ShortCut then
    begin
      Result := I;
      break;
    end;
end;

function TCustomShortCutList.IndexOfShortCut(const ShortCut: string): Integer;
var
  S: string;
  I: Integer;
  function StripText(S: string): string;
  begin
    if Length(S) = 1 then
      Result := S
    else
      Result := UpperCase(StringReplace(S, ' ', '', [rfReplaceAll]));
  end;

begin
  Result := -1;
  if ShortCut = '' then
    Exit;
  S := StripText(ShortCut);
  if S <> '' then
    for I := 0 to Count - 1 do
      if StripText(Strings[I]) = S then
      begin
        Result := I;
        break;
      end;
end;

{ TContainedAction }

{$IF DEFINED(CLR)}
class constructor TContainedAction.Create;
begin
  GroupDescendentsWith(TContainedAction, TControl);
end;
{$ENDIF}

constructor TContainedAction.Create(AOwner: TComponent);
begin
  inherited;
  FEnabled := True;
  FVisible := True;
  FImageIndex := -1;
end;

destructor TContainedAction.Destroy;
begin
  if Assigned(ActionList) then
    ActionList.RemoveAction(Self);
  FreeAndNil(FSecondaryShortCuts);
  inherited;
end;

procedure TContainedAction.AssignTo(Dest: TPersistent);
begin
  if Dest is TContainedAction then
  begin
    TContainedAction(Dest).AutoCheck := AutoCheck;
    TContainedAction(Dest).Caption := Caption;
    TContainedAction(Dest).Checked := Checked;
    TContainedAction(Dest).Enabled := Enabled;
    TContainedAction(Dest).GroupIndex := GroupIndex;
    TContainedAction(Dest).HelpContext := HelpContext;
    TContainedAction(Dest).HelpKeyword := HelpKeyword;
    TContainedAction(Dest).HelpType := HelpType;
    TContainedAction(Dest).Hint := Hint;
    TContainedAction(Dest).Visible := Visible;
    TContainedAction(Dest).ShortCut := ShortCut;
    if TContainedAction(Dest).SecondaryShortCuts <> nil then
    begin
      if SecondaryShortCuts = nil then
        TContainedAction(Dest).SecondaryShortCuts.Clear
      else
        TContainedAction(Dest).SecondaryShortCuts := SecondaryShortCuts;
    end;
    TContainedAction(Dest).ImageIndex := ImageIndex;
    TContainedAction(Dest).StatusAction := StatusAction;
    TContainedAction(Dest).Tag := Tag;
    TContainedAction(Dest).OnExecute := OnExecute;
    TContainedAction(Dest).OnHint := OnHint;
    TContainedAction(Dest).OnUpdate := OnUpdate;
    TContainedAction(Dest).OnChange := OnChange;
  end
  else if Dest = nil then
  begin
    raise EActionError.CreateFMT(SParamIsNil, ['Dest']);
  end
  else
    inherited AssignTo(Dest);
end;

function TContainedAction.GetIndex: Integer;
begin
  if (ActionList <> nil) and (ActionList.FActions <> nil) then
    Result := ActionList.FActions.IndexOf(Self)
  else
    Result := -1;
end;

procedure TContainedAction.SetIndex(Value: Integer);
var
  CurIndex, Count: Integer;
begin
  CurIndex := GetIndex;
  if CurIndex >= 0 then
  begin
    Count := ActionList.FActions.Count;
    if Value < 0 then
      Value := 0;
    if Value >= Count then
      Value := Count - 1;
    if Value <> CurIndex then
    begin
      ActionList.FActions.Delete(CurIndex);
      ActionList.FActions.Insert(Value, Self);
    end;
  end;
end;

function TContainedAction.GetParentComponent: TComponent;
begin
  if ActionList <> nil then
    Result := ActionList
  else
    Result := inherited GetParentComponent;
end;

procedure TContainedAction.SetParentComponent(AParent: TComponent);
begin
  if not(csLoading in ComponentState) and (AParent is TContainedActionList) then
    ActionList := TContainedActionList(AParent);
end;

function TContainedAction.HandleShortCut: Boolean;
begin
  Result := Execute;
end;

function TContainedAction.HasParent: Boolean;
begin
  if ActionList <> nil then
    Result := True
  else
    Result := inherited HasParent;
end;

procedure TContainedAction.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TContainedActionList then
    ActionList := TContainedActionList(Reader.Parent);
end;

procedure TContainedAction.SetActionList(AActionList: TContainedActionList);
begin
  if AActionList <> ActionList then
  begin
    if ActionList <> nil then
      ActionList.RemoveAction(Self);
    if AActionList <> nil then
      AActionList.AddAction(Self);
  end;
end;

procedure TContainedAction.SetCategory(const Value: string);
begin
  if Value <> Category then
  begin
    FCategory := Value;
    if Assigned(ActionList) then
    begin
      ActionList.Change;
    end;
  end;
end;

procedure TContainedAction.SetAutoCheck(Value: Boolean);
var
  I: Integer;
begin
  if Value <> FAutoCheck then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetAutoCheck(Value);
    FAutoCheck := Value;
    Change;
  end;
end;

procedure TContainedAction.SetCaption(const Value: string);
var
  I: Integer;
begin
  if Value <> FCaption then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetCaption(Value);
    FCaption := Value;
    Change;
  end;
end;

procedure TContainedAction.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := (Name = Caption) and ((Owner = nil) or not(csLoading in Owner.ComponentState));
  inherited SetName(Value);
  { Don't update caption to name if we've got clients connected. }
  if ChangeText and (ClientCount = 0) then
    Caption := Value;
end;

procedure TContainedAction.SetChecked(Value: Boolean);
var
  I: Integer;
  Action: TContainedAction;
begin
  if FChecking then
    Exit;
  FChecking := True;
  try
    if Value <> FChecked then
    begin
      for I := 0 to ClientCount - 1 do
        if Clients[I] is TContainedActionLink then
          TContainedActionLink(Clients[I]).SetChecked(Value);
      FChecked := Value;
      if (FGroupIndex > 0) and FChecked and (ActionList <> nil) then
        for I := 0 to ActionList.ActionCount - 1 do
        begin
          Action := ActionList.Actions[I];
          if (Action <> Self) and (Action.FGroupIndex = FGroupIndex) then
            Action.Checked := False;
        end;
      Change;
    end;
  finally
    FChecking := False;
  end;
end;

procedure TContainedAction.SetEnabled(Value: Boolean);
var
  I: Integer;
begin
  if Value <> FEnabled then
  begin
    if Assigned(ActionList) then
    begin
      if ActionList.State = asSuspended then
      begin
        FEnabled := Value;
        Exit;
      end
      else if (ActionList.State = asSuspendedEnabled) then
        Value := True;
    end;
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetEnabled(Value);
    FEnabled := Value;
    Change;
  end;
end;

procedure TContainedAction.SetGroupIndex(const Value: Integer);
var
  I: Integer;
  Action: TContainedAction;
  NewChecked: Boolean;
begin
  if Value <> FGroupIndex then
  begin
    NewChecked := FChecked;
    // We carry out checks. If there is Action with the same value GroupIndex,
    // you must reset the current value of the Checked.
    if (Value > 0) and NewChecked and (ActionList <> nil) then
      for I := 0 to ActionList.ActionCount - 1 do
      begin
        Action := ActionList.Actions[I];
        if (Action <> Self) and (Action.FGroupIndex = Value) and (Action.Checked) then
        begin
          NewChecked := False;
          break;
        end;
      end;
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
      begin
        if NewChecked <> FChecked then
          TContainedActionLink(Clients[I]).SetChecked(NewChecked);
        TContainedActionLink(Clients[I]).SetGroupIndex(Value);
      end;
    FChecked := NewChecked;
    FGroupIndex := Value;
    Change;
  end;
end;

procedure TContainedAction.SetHelpContext(Value: THelpContext);
var
  I: Integer;
begin
  if Value <> FHelpContext then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetHelpContext(Value);
    FHelpContext := Value;
    Change;
  end;
end;

procedure TContainedAction.SetHelpKeyword(const Value: string);
var
  I: Integer;
begin
  if Value <> FHelpKeyword then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetHelpKeyword(Value);
    FHelpKeyword := Value;
    Change;
  end;
end;

procedure TContainedAction.SetHelpType(Value: THelpType);
var
  I: Integer;
begin
  if Value <> FHelpType then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetHelpType(Value);
    FHelpType := Value;
    Change;
  end;
end;

procedure TContainedAction.SetHint(const Value: string);
var
  I: Integer;
begin
  if Value <> FHint then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetHint(Value);
    FHint := Value;
    Change;
  end;
end;

procedure TContainedAction.SetVisible(Value: Boolean);
var
  I: Integer;
begin
  if Value <> FVisible then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetVisible(Value);
    FVisible := Value;
    Change;
  end;
end;

function TContainedAction.Suspended: Boolean;
begin
  Result := (ActionList <> nil) and (ActionList.State <> asNormal);
end;

procedure TContainedAction.SetShortCut(Value: System.Classes.TShortCut);
var
  I: Integer;
begin
  if Value <> FShortCut then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetShortCut(Value);
    FShortCut := Value;
    Change;
  end;
end;

function TContainedAction.CreateShortCutList: TCustomShortCutList;
begin
  // This method is implemented in descendant classes.
  Result := nil;
end;

function TContainedAction.SecondaryShortCutsCreated: boolean;
begin
  result := FSecondaryShortCuts <> nil;
end;

function TContainedAction.GetSecondaryShortCuts: TCustomShortCutList;
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := CreateShortCutList;
  Result := FSecondaryShortCuts;
end;

procedure TContainedAction.SetSecondaryShortCuts(const Value: TCustomShortCutList);
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := CreateShortCutList;
  FSecondaryShortCuts.Assign(Value);
end;

function TContainedAction.IsSecondaryShortCutsStored: Boolean;
begin
  Result := Assigned(FSecondaryShortCuts) and (FSecondaryShortCuts.Count > 0);
end;

function TContainedAction.DoHint(var HintStr: string): Boolean;
begin
  Result := True;
  if Assigned(FOnHint) then
    FOnHint(HintStr, Result);
end;

procedure TContainedAction.SetImageIndex(Value: System.UITypes.TImageIndex);
var
  I: Integer;
begin
  if Value <> FImageIndex then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetImageIndex(Value);
    FImageIndex := Value;
    Change;
  end;
end;

procedure TContainedAction.SetStatusAction(const Value: TStatusAction);
var
  I: Integer;
begin
  if Value <> FStatusAction then
  begin
    for I := 0 to ClientCount - 1 do
      if Clients[I] is TContainedActionLink then
        TContainedActionLink(Clients[I]).SetStatusAction(Value);
    FStatusAction := Value;
    Change;
  end;
end;

{ TActionListEnumerator }

constructor TActionListEnumerator.Create(AActionList: TContainedActionList);
begin
  if AActionList = nil then
    raise EActionError.CreateFMT(SParamIsNil, ['AActionList']);
  inherited Create;
  FIndex := -1;
  FActionList := AActionList;
end;

function TActionListEnumerator.GetCurrent: TContainedAction;
begin
  Result := FActionList[FIndex];
end;

function TActionListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FActionList.ActionCount - 1;
  if Result then
    Inc(FIndex);
end;

{ TContainedActionList }

{$IF DEFINED(CLR)}
class constructor TContainedActionList.Create;
begin
  GroupDescendentsWith(TContainedActionList, TControl);
end;
{$ENDIF}

constructor TContainedActionList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActions := TList<TContainedAction>.Create;
  FState := asNormal;
end;

destructor TContainedActionList.Destroy;
begin
  if FActions <> nil then
    while FActions.Count > 0 do
{$IF not Defined(AUTOREFCOUNT)}
      FActions.Last.Free;
{$ELSE}
      FActions.Last.ActionList := nil;
{$ENDIF}
  FreeAndNil(FActions);
  inherited;
end;

procedure TContainedActionList.CheckActionsCreated;
begin
  if not ActionsCreated then
    raise EActionError.CreateFMT(SParamIsNil, ['Actions']);
end;

function TContainedActionList.ActionsCreated: Boolean;
begin
  Result := FActions <> nil;
end;

procedure TContainedActionList.AddAction(const Action: TContainedAction);
begin
  CheckActionsCreated;
  if Action = nil then
    raise EActionError.CreateFMT(SParamIsNil, ['Action']);
  FActions.Add(Action);
  Action.FActionList := Self;
  Action.FreeNotification(Self);
end;

procedure TContainedActionList.Change;
var
  I: Integer;
begin
  if ActionsCreated then
  begin
    if Assigned(FOnChange) then
      FOnChange(Self);
    for I := 0 to FActions.Count - 1 do
      FActions.List[I].Change;
  end;
end;

function TContainedActionList.SameCategory(const Source, Dest: string;
                                           const IncludeSubCategory: Boolean = True): Boolean;
begin
  if IncludeSubCategory and
     (Source.Length < Dest.Length) and
     (Dest.Chars[Source.Length] = '.') then
    Result := String.Compare(Source, 0, Dest, 0, Source.Length, True) = 0
  else
    Result := String.Compare(Source, Dest, True) = 0;
end;

function TContainedActionList.EnumByCategory(Proc: TEnumActionListEvent;
                                       const Category: string;
                                       const IncludeSubCategory: Boolean = True): boolean;
begin
  Result := False;
  if Assigned(Proc) then
    Result := EnumByCategory(procedure(const Action: TContainedAction; var Done: boolean)
                   begin
                     Proc(Action, Done);
                   end, Category, IncludeSubCategory);
end;

function TContainedActionList.EnumByCategory(Proc: TEnumActionListRef;
                                       const Category: string;
                                       const IncludeSubCategory: Boolean = True): boolean;
var
  A: TContainedAction;
  Tmp: TList<TContainedAction>;
begin
  Result := False;
  if Assigned(Proc) then
  begin
    Tmp := TList<TContainedAction>.Create;
    try
      for A in self do
        if SameCategory(Category, A.Category, IncludeSubCategory) then
          Tmp.Add(A);
      for A in Tmp do
      begin
        Proc(A, Result);
        if Result then Break;
      end;
    finally
      FreeAndNil(Tmp);
    end;
  end;
end;

function TContainedActionList.ExecuteAction(Action: TBasicAction): Boolean;
begin
  CheckActionsCreated;
  Result := False;
  if Assigned(FOnExecute) then
    FOnExecute(Action, Result);
end;

function TContainedActionList.UpdateAction(Action: TBasicAction): Boolean;
begin
  CheckActionsCreated;
  Result := False;
  if Assigned(FOnUpdate) then
    FOnUpdate(Action, Result);
end;

function TContainedActionList.GetAction(Index: Integer): TContainedAction;
begin
  CheckActionsCreated;
  Result := FActions[Index];
end;

procedure TContainedActionList.SetAction(Index: Integer; Value: TContainedAction);
begin
  CheckActionsCreated;
  FActions[Index].Assign(Value);
end;

function TContainedActionList.GetActionCount: Integer;
begin
  if FActions <> nil then
    Result := FActions.Count
  else
    Result := 0;
end;

procedure TContainedActionList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  Action: TContainedAction;
begin
  CheckActionsCreated;
  if @Proc = nil then
    raise EActionError.CreateFMT(SParamIsNil, ['Proc']);
  for I := 0 to FActions.Count - 1 do
  begin
    Action := FActions.List[I];
    if Action.Owner = Root then
      Proc(Action);
  end;
end;

function TContainedActionList.GetEnumerator: TActionListEnumerator;
begin
  Result := TActionListEnumerator.Create(Self);
end;

procedure TContainedActionList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (AComponent is TContainedAction) then
      RemoveAction(TContainedAction(AComponent));
  end;
end;

procedure TContainedActionList.RemoveAction(const Action: TContainedAction);
begin
  if (FActions <> nil) and (FActions.Remove(Action) >= 0) then
  begin
    Action.RemoveFreeNotification(Self);
    Action.FActionList := nil;
  end;
end;

procedure TContainedActionList.SetChildOrder(Component: TComponent; Order: Integer);
begin
  if (FActions <> nil) and (FActions.IndexOf(TContainedAction(Component)) >= 0) then
    (Component as TContainedAction).Index := Order;
end;

procedure TContainedActionList.SetState(const Value: TActionListState);
var
  I: Integer;
  Action: TContainedAction;
  OldState: TActionListState;
begin
  if FState <> Value then
  begin
    CheckActionsCreated;
    OldState := FState;
    FState := Value;
    try
      if State <> asSuspended then
      for I := 0 to FActions.Count - 1 do
        if FActions.List[I] <> nil then
        begin
          Action := FActions.List[I];
          case Value of
            asNormal:
              begin
                if OldState = asSuspendedEnabled then
                  Action.Enabled := Action.SavedEnabledState;
                Action.Update;
              end;
            asSuspendedEnabled:
              begin
                Action.SavedEnabledState := Action.Enabled;
                Action.Enabled := True;
              end;
          end;
        end;
    finally
      if Assigned(FOnStateChange) then
        FOnStateChange(Self);
    end;
  end;
end;

{$REGION 'implementation of TActionLink (is simple)'}
{ TContainedActionLink }

procedure TContainedActionLink.DefaultIsLinked(var Result: Boolean);
begin
  Result := Action is TContainedAction;
end;

function TContainedActionLink.IsCaptionLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsCheckedLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsEnabledLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsGroupIndexLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsHelpContextLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsHelpLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsHintLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsImageIndexLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsShortCutLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsVisibleLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

function TContainedActionLink.IsStatusActionLinked: Boolean;
begin
  DefaultIsLinked(Result);
end;

procedure TContainedActionLink.SetAutoCheck(Value: Boolean);
begin

end;

procedure TContainedActionLink.SetCaption(const Value: string);
begin

end;

procedure TContainedActionLink.SetChecked(Value: Boolean);
begin

end;

procedure TContainedActionLink.SetEnabled(Value: Boolean);
begin

end;

procedure TContainedActionLink.SetGroupIndex(Value: Integer);
begin

end;

procedure TContainedActionLink.SetHelpContext(Value: THelpContext);
begin

end;

procedure TContainedActionLink.SetHelpKeyword(const Value: string);
begin

end;

procedure TContainedActionLink.SetHelpType(Value: THelpType);
begin

end;

procedure TContainedActionLink.SetHint(const Value: string);
begin

end;

procedure TContainedActionLink.SetImageIndex(Value: Integer);
begin

end;

procedure TContainedActionLink.SetShortCut(Value: System.Classes.TShortCut);
begin

end;

procedure TContainedActionLink.SetVisible(Value: Boolean);
begin

end;

procedure TContainedActionLink.SetStatusAction(const Value: TStatusAction);
begin

end;
{$ENDREGION}

{$REGION 'shortcuts registration'}
var
  vShortCuts: TList<TShortCut>;

function RegisterShortCut(ShortCut: TShortCut; Index: integer = -1): integer;
begin
  Result := -1;
  if ShortCut > 0 then
  begin
    if not Assigned(vShortCuts) then
    begin
      vShortCuts := TList<TShortCut>.Create;
    end;
    if vShortCuts.IndexOf(ShortCut) < 0 then
    begin
      if (Index >= 0) and (Index < vShortCuts.Count) then
      begin
        vShortCuts.Insert(Index, ShortCut);
        Result := Index;
      end
      else
        Result := vShortCuts.Add(ShortCut);
    end;
  end;
end;

function UnregisterShortCut(ShortCut: TShortCut): boolean;
var Index: integer;
begin
  Result := False;
  if (ShortCut > 0) and (Assigned(vShortCuts)) then
  begin
    Index := vShortCuts.IndexOf(ShortCut);
    if Index >= 0 then
    begin
      vShortCuts.Delete(Index);
      if vShortCuts.Count = 0 then
        FreeAndNil(vShortCuts);
      Result := True;
    end;
  end;
end;

function RegisteredShortCutCount: integer;
begin
  if (Assigned(vShortCuts)) then
    Result := vShortCuts.Count
  else
    Result := 0;
end;

function RegisteredShortCut(Index: integer): TShortCut;
begin
  if (Index >= 0) and (Index < RegisteredShortCutCount) then
    Result := vShortCuts.Items[Index]
  else
    raise ERangeError.CreateFmt(SListIndexError, [Index]);
end;
{$ENDREGION}

initialization
  vShortCuts := nil;
  vDesignAction := False;

finalization
  FreeAndNil(vShortCuts);

end.
