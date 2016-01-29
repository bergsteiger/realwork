{ ******************************************************* }
{                                                         }
{               Delphi FireMonkey Platform                }
{                                                         }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc.   }
{                                                         }
{ ******************************************************* }

unit FMX.ActnList;

{$T-,H+,X+}

interface

uses
  System.Classes, System.SysUtils, System.Actions;

type
  /// <summary> The usual list of actions (without published properties) in Fire Monkey </summary>
  TCustomActionList = class(TContainedActionList)
  public
    function DialogKey(const Key: Word; const Shift: TShiftState): boolean; virtual;
  end;

  /// <summary> The usual list of actions (with published properties) in Fire Monkey </summary>
  TActionList = class(TCustomActionList)
  published
    property Name;
    property State;
    property OnChange;
    property OnExecute;
    property OnStateChange;
    property OnUpdate;
  end;

  /// <summary> This class is designed to communicate with some of the object in Fire Monkey </summary>
  TActionLink = class(TContainedActionLink)
  protected
  end;

  TActionLinkClass = class of TActionLink;

  /// <summary> List of additional combinations of hot keys in Fire Monkey </summary>
  TShortCutList = class(TCustomShortCutList)
  public
    function Add(const S: String): Integer; override;
  end;

  /// <summary> The usual action (without published properties) in Fire Monkey </summary>
  TCustomAction = class(TContainedAction)
  private
    FShortCutPressed: boolean;
    FTarget: TComponent;
    FUnsupportedArchitectures: TArchitectures;
    FUnsupportedPlatforms: TPlatforms;
    FOldVisible: boolean;
    FOldEnabled: boolean;
    FSupported: boolean;
    FCustomText: string;
    FSupportedChecked: boolean;
    FHideIfUnsupportedInterface: boolean;
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
    procedure SetHideIfUnsupportedInterface(const Value: boolean);
  protected
    procedure SetShortCutPressed(const Value: boolean); inline;
    procedure UpdateSupported;
    function IsSupportedInterface: boolean; virtual;
    function CreateShortCutList: TCustomShortCutList; override;
    procedure DefineProperties(Filer: TFiler); override;
    function IsDialogKey(const Key: Word; const Shift: TShiftState): boolean;
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
    property Text: string read GetText write SetText;
    property Caption stored false;
    property ActionList: TCustomActionList read GetCustomActionList write SetCustomActionList;
    property HideIfUnsupportedInterface: boolean read FHideIfUnsupportedInterface write SetHideIfUnsupportedInterface;
    property ShortCutPressed: boolean read FShortCutPressed;
    property Target: TComponent read FTarget;
    property UnsupportedArchitectures: TArchitectures read FUnsupportedArchitectures write SetUnsupportedArchitectures default [];
    property UnsupportedPlatforms: TPlatforms read FUnsupportedPlatforms write SetUnsupportedPlatforms default [];
    property Supported: boolean read FSupported;
  end;

  /// <summary> The usual action (with published properties) in Fire Monkey </summary>
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
    property ShortCut default 0;
    property SecondaryShortCuts;
    property Visible;
    property UnsupportedArchitectures;
    property UnsupportedPlatforms;
    property OnExecute;
    property OnUpdate;
  end;

function TextToShortCut(Text: string): integer; inline;

implementation

uses System.RTLConsts, FMX.Consts, FMX.Platform, FMX.Forms, FMX.Menus;

function TextToShortCut(Text: string): Integer;
var
  MenuService: IFMXMenuService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService)) then
    Result:= MenuService.TextToShortCut(Text)
  else
    Result := -1;
end;

{ TCustomActionList }

function TCustomActionList.DialogKey(const Key: Word; const Shift: TShiftState): boolean;
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
    LAction.SetShortCutPressed(True);
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
      LAction.SetShortCutPressed(False);
    end;
    if Result then Exit;
  end;
end;

{ TCustomShortCutList }

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
    raise EActionError.CreateFMT(StrErrorShortCut, [S]);
end;

{ TCustomAction }

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

function TCustomAction.IsDialogKey(const Key: Word; const Shift: TShiftState): boolean;
var
  k: word;
  SState: TShiftState;
  I: integer;
  MenuService: IFMXMenuService;
begin
  Result := False;
  if (not Supported) or
     (not TPlatformServices.Current.SupportsPlatformService(IFMXMenuService, IInterface(MenuService))) then
    Exit;
  if ShortCut <> 0 then
  begin
    MenuService.ShortCutToKey(ShortCut, k, SState);
    Result := (k = Key) and (Shift = SState);
  end;
  if (not Result) and (SecondaryShortCutsCreated) then
  begin
    I := 0;
    while (not Result) and (I < SecondaryShortCuts.Count) do
    begin
      MenuService.ShortCutToKey(SecondaryShortCuts.ShortCuts[I], k, SState);
      Result := (k = Key) and (Shift = SState);
      inc(I);
    end;
  end;
end;

procedure TCustomAction.Loaded;
begin
  inherited;
  if Supported and (([csLoading, csDestroying] * ComponentState) = []) then
    CustomTextChanged;
end;

function TCustomAction.Execute: Boolean;
begin
  Result := False;
  if (not Supported) or Assigned(ActionList) and (ActionList.State <> asNormal) then
    exit;
  Update;
  if Enabled and AutoCheck then
    if (not Checked) or (Checked and (GroupIndex = 0)) then
      Checked := not Checked;
  Result := Enabled and inherited Execute;
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

procedure TCustomAction.SetHideIfUnsupportedInterface(const Value: boolean);
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

procedure TCustomAction.SetShortCutPressed(const Value: boolean);
begin
  FShortCutPressed := Value;
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

function TCustomAction.IsSupportedInterface: boolean;
begin
  Result := True;
end;

procedure TCustomAction.UpdateSupported;
var LSupp: boolean;
begin
  if (([csDesigning] * ComponentState) <> []) or (vDesignAction) then
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

{ TAction }

constructor TAction.Create(AOwner: TComponent);
begin
  inherited;
  DisableIfNoHandler := True;
end;

initialization

finalization

end.
