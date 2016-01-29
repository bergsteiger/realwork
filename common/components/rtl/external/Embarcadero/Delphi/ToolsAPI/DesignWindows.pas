{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DesignWindows;

interface

uses Winapi.Messages, System.Win.Registry, System.SysUtils, System.Classes,
     Vcl.Controls, Vcl.Forms, DesignIntf, ComponentDesigner;

type
  TDesignWindow = class(TForm, IUnknown, IDesignWindow, IDesignNotification,
    IEditHandler, IActivatable)
  private
    FSelection: IDesignerSelections;
    FOwner: TComponent;
    FDesigner: IDesigner;
    FComponentDesigner: IComponentDesigner;
    FActive: Boolean;
    procedure ComponentRead(Component: TComponent);
    procedure ReaderSetName(Reader: TReader; Component: TComponent;
      var Name: string);
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure SetDesigner(const Value: IDesigner);
  protected
    procedure Activated; dynamic;
    procedure ActivateInspector(Ch: Char);
    function ClipboardComponents: Boolean;
    procedure CopyComponents(Root: TComponent;
      const Components: IDesignerSelections);
    procedure PasteComponents(AOwner, AParent: TComponent;
      const Components: IDesignerSelections);
    procedure SetSelection(const Components: IDesignerSelections);
    function UniqueName(Component: TComponent): string; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // IEditHandler
    function GetEditState: TEditState; virtual;
    function EditAction(Action: TEditAction): Boolean; virtual;

    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure ItemInserted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); virtual;
    procedure DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean); virtual;
    procedure DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean); virtual;
    procedure ItemsModified(const Designer: IDesigner); virtual;

    // IDesignWindowActions
    procedure WindowHide; virtual;
    procedure WindowShow; virtual;

    property Active: Boolean read FActive;
    property Designer: IDesigner read FDesigner write SetDesigner;
    property ComponentDesigner: IComponentDesigner read FComponentDesigner;
  end;

procedure LoadFormPos(const Reg: TRegIniFile;
                      const SectionName: string;
                      const Form: TCustomForm);

procedure SaveFormPos(const Reg: TRegIniFile;
                      const SectionName: string;
                      const Form: TCustomForm);


implementation

uses DeskStrs, Winapi.Windows, Math, Vcl.Clipbrd, DesignEditors, VCLEditors;

procedure LoadFormPos(const Reg: TRegIniFile;
                      const SectionName: string;
                      const Form: TCustomForm);
var L, T, W, H, MI: Integer;
    M: TMonitor;
    P: TPoint;
begin
  L := Reg.ReadInteger(SectionName, ivLeft, 0);
  T := Reg.ReadInteger(SectionName, ivTop, 0);
  W := Reg.ReadInteger(SectionName, ivWidth, 0);
  H := Reg.ReadInteger(SectionName, ivHeight, 0);
  MI := Reg.ReadInteger(SectionName, ivMonitorIndex, -1);
  if ((Form.Owner is TForm) and (Form.Parent = nil)) and
     ((W <= 0) or (H <= 0)) then
  begin
    W := Form.Width;
    H := Form.Height;
    L := (TForm(Form.Owner).Width - W) div (2);
    T := (TForm(Form.Owner).Height - H) div (2);
  end;
  if (W > 1) and (H > 1) then
  begin
    if (Form.Owner is TForm) and (Form.Parent = nil) then
    begin
      P.X := 0;
      P.Y := 0;
      P := TForm(Form.Owner).ClientToScreen(P);
      L := L + P.X;
      T := T + P.Y;
      Form.SetBounds(L, T, W, H);
      M := Screen.MonitorFromWindow(TForm(Form.Owner).Handle);
      if M <> nil then
      begin
        L := L - M.Left;
        T := T - M.Top;
      end;
    end
    else
    begin
      if (MI >= 0) and (MI < Screen.MonitorCount) then
        M := Screen.Monitors[MI]
      else
        M := Screen.MonitorFromWindow(Form.Handle);
    end;
    if M <> nil then
    begin
      L := Max(0, Min(L, M.Width - W));
      T := Max(0, Min(T, M.Height - H));
      L := L + M.Left;
      T := T + M.Top;
    end
    else
    begin
      L := Max(0, Min(L, Screen.Width - W));
      T := Max(0, Min(T, Screen.Height - H));
    end;
    Form.SetBounds(L, T, W, H);
  end;
end;

procedure SaveFormPos(const Reg: TRegIniFile;
                      const SectionName: string;
                      const Form: TCustomForm);
var L, T: integer;
    M: TMonitor;
    P: TPoint;
begin
  if (Form.Owner is TForm) and (Form.Parent = nil) then
  begin
    M := nil;
    P.X := 0;
    P.Y := 0;
    P := TForm(Form.Owner).ClientToScreen(P);
    L := Form.Left - P.X;
    T := Form.Top - P.Y;
  end
  else
  begin
    M := Screen.MonitorFromWindow(Form.Handle);
    L := Form.Left;
    T := Form.Top;
    if M <> nil then
    begin
      Dec(L, M.Left);
      Dec(T, M.Top);
    end;
  end;
  Reg.WriteInteger(SectionName, ivLeft, L);
  Reg.WriteInteger(SectionName, ivTop, T);
  Reg.WriteInteger(SectionName, ivWidth, Form.Width);
  Reg.WriteInteger(SectionName, ivHeight, Form.Height);
  if M <> nil then
    Reg.WriteInteger(SectionName, ivMonitorIndex, M.MonitorNum)
  else
    Reg.DeleteKey(SectionName, ivMonitorIndex);
end;

constructor TDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  RegisterDesignNotification(Self);
end;

destructor TDesignWindow.Destroy;
begin
  FComponentDesigner := nil;
  UnregisterDesignNotification(Self);
  inherited Destroy;
end;

procedure TDesignWindow.Activated;
begin
end;

procedure TDesignWindow.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then
    Activated;
end;

procedure TDesignWindow.ActivateInspector(Ch: Char);
begin
  Designer.ModalEdit(Ch, Self);
end;

function TDesignWindow.ClipboardComponents: Boolean;
begin
  try
    Result := Clipboard.HasFormat(CF_COMPONENTS) or
      (Clipboard.HasFormat(CF_TEXT) and PossibleStream(Clipboard.AsText));
  except
    Result := False;
  end;
end;

procedure TDesignWindow.CopyComponents(Root: TComponent;
  const Components: IDesignerSelections);
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
begin
  S := TMemoryStream.Create;
  try
    W := TWriter.Create(S, 1024);
    try
      W.Root := Root;
      for I := 0 to Components.Count - 1 do
      begin
        W.WriteSignature;
        W.WriteComponent(TComponent(Components[I]));
      end;
      W.WriteListEnd;
    finally
      W.Free;
    end;
    CopyStreamToClipboard(S);
  finally
    S.Free;
  end;
end;

function TDesignWindow.GetEditState: TEditState;
begin
  Result := [];
end;

function TDesignWindow.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;

procedure TDesignWindow.WindowHide;
begin
  if Visible then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TDesignWindow.WindowShow;
const
  ShowCommands: array[TWindowState] of Word =
    (SW_SHOWNOACTIVATE, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if Visible then
    ShowWindow(Handle, ShowCommands[WindowState]);
end;

procedure TDesignWindow.ComponentRead(Component: TComponent);
begin
  FSelection.Add(Component);
end;

procedure TDesignWindow.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  if (Reader.Root = FOwner) and (FOwner.FindComponent(Name) <> nil) then
    Name := UniqueName(Component);
end;

procedure TDesignWindow.PasteComponents(AOwner, AParent: TComponent;
  const Components: IDesignerSelections);
var
  S: TStream;
  R: TReader;
begin
  S := GetClipboardStream;
  try
    R := TReader.Create(S, 1024);
    try
      R.OnSetName := ReaderSetName;
      FOwner := AOwner;
      FSelection := Components;
      R.ReadComponents(AOwner, AParent, ComponentRead);
    finally
      R.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TDesignWindow.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
end;

procedure TDesignWindow.SetSelection(const Components: IDesignerSelections);
begin
  ComponentDesigner.SetSelection(Designer, Self, Components);
end;

procedure TDesignWindow.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);
begin

end;

procedure TDesignWindow.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin

end;

procedure TDesignWindow.DesignerClosed(const Designer: IDesigner; AGoingDormant: Boolean);
begin

end;

procedure TDesignWindow.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin

end;

procedure TDesignWindow.ItemsModified(const Designer: IDesigner);
begin

end;

function TDesignWindow.UniqueName(Component: TComponent): string;
begin
  Result := Designer.UniqueName(Component.ClassName);
end;

procedure TDesignWindow.SetDesigner(const Value: IDesigner);
begin
  if FDesigner <> Value then
  begin
    FDesigner := Value;
    if (FDesigner <> nil) and (FComponentDesigner = nil) then
    begin
      FComponentDesigner := Designers.DesignerFromExtension(Designer.DesignerExtention);
      SetBounds(200, ComponentDesigner. Environment.GetMainWindowSize.Bottom + 2, Width, Height);
    end;
  end;
end;

end.
