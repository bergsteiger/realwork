{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SBarEdit;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TStatusBarEditor = class(TForm)
    GroupBox1: TGroupBox;
    PanelList: TListBox;
    NewButton: TButton;
    DeleteButton: TButton;
    GroupBox2: TGroupBox;
    PanelText: TEdit;
    PanelWidth: TEdit;
    PanelStyle: TComboBox;
    PanelBevel: TComboBox;
    PanelAlignment: TComboBox;
    OkButton: TButton;
    CancelButton: TButton;
    ApplyButton: TButton;
    HelpButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure PanelListClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure PanelListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PanelListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PanelControlExit(Sender: TObject);
    procedure PanelEditChange(Sender: TObject);
    procedure PanelComboChange(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    StatusBar: TStatusBar;
    TargetPanels: TStatusPanels;
    FocusIndex: Integer;
    UpdatingControls: Boolean;
    Modified: Boolean;
    procedure UpdateControls;
    procedure UpdatePanel;
    procedure UpdatePanelList;
  end;

function EditStatusPanels(StatusPanels: TStatusPanels): Boolean;

implementation

{$R *.dfm}

uses DsnConst;

function EditStatusPanels(StatusPanels: TStatusPanels): Boolean;
begin
  with TStatusBarEditor.Create(Application) do
    try
      TargetPanels := StatusPanels;
      StatusBar.Panels.Assign(TargetPanels);
      UpdatePanelList;
      if PanelList.Items.Count > 0 then PanelList.ItemIndex := 0;
      UpdateControls;
      ShowModal;
      Result := Modified;
    finally
      Free;
    end;
end;

procedure TStatusBarEditor.FormCreate(Sender: TObject);
begin
  StatusBar := TStatusBar.Create(Self);
end;

procedure TStatusBarEditor.UpdateControls;
var
  Index: Integer;
  Panel: TStatusPanel;
  PanelSelected: Boolean;
begin
  Index := PanelList.ItemIndex;
  PanelSelected := Index >= 0;
  UpdatingControls := True;
  if PanelSelected then
  begin
    Panel := TargetPanels[Index];
    PanelText.Text := Panel.Text;
    PanelWidth.Text := IntToStr(Panel.Width);
    PanelStyle.ItemIndex := Ord(Panel.Style);
    PanelBevel.ItemIndex := Ord(Panel.Bevel);
    PanelAlignment.ItemIndex := Ord(Panel.Alignment);
  end else
  begin
    PanelText.Text := '';
    PanelWidth.Text := '';
    PanelStyle.ItemIndex := -1;
    PanelBevel.ItemIndex := -1;
    PanelAlignment.ItemIndex := -1;
  end;
  UpdatingControls := False;
  PanelText.Enabled := PanelSelected;
  PanelWidth.Enabled := PanelSelected;
  PanelStyle.Enabled := PanelSelected;
  PanelBevel.Enabled := PanelSelected;
  PanelAlignment.Enabled := PanelSelected;
end;

procedure TStatusBarEditor.UpdatePanel;
var
  I: Integer;
  Panel: TStatusPanel;
begin
  I := PanelList.ItemIndex;
  if I >= 0 then
  begin
    Panel := TargetPanels[PanelList.ItemIndex];
    if Panel.Text <> PanelText.Text then
    begin
      Panel.Text := PanelText.Text;
      UpdatePanelList;
      PanelList.ItemIndex := I;
    end;
    try
      Panel.Width := StrToInt(PanelWidth.Text);
    except
      PanelWidth.SelectAll;
      PanelWidth.SetFocus;
      raise;
    end;
    Panel.Style := TStatusPanelStyle(PanelStyle.ItemIndex);
    Panel.Bevel := TStatusPanelBevel(PanelBevel.ItemIndex);
    Panel.Alignment := TAlignment(PanelAlignment.ItemIndex);
    ApplyButton.Enabled := False;
    ApplyButton.Default := False;
    OkButton.Default := True;
  end;
end;

procedure TStatusBarEditor.UpdatePanelList;
var
  I: Integer;
  S: string;
begin
  PanelList.Items.BeginUpdate;
  try
    PanelList.Items.Clear;
    for I := 0 to TargetPanels.Count - 1 do
    begin
      S := TargetPanels[I].Text;
      if S = '' then S := SUntitled;
      PanelList.Items.Add(Format('%d - %s', [I, S]));
    end;
  finally
    PanelList.Items.EndUpdate;
  end;
  DeleteButton.Enabled := PanelList.Items.Count > 0;
end;

procedure TStatusBarEditor.PanelListClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TStatusBarEditor.NewButtonClick(Sender: TObject);
begin
  UpdatePanel;
  TargetPanels.Add;
  UpdatePanelList;
  PanelList.ItemIndex := TargetPanels.Count - 1;
  UpdateControls;
  PanelText.SetFocus;
  Modified := True;
end;

procedure TStatusBarEditor.DeleteButtonClick(Sender: TObject);
var
  I: Integer;
begin
  I := PanelList.ItemIndex;
  if I >= 0 then
  begin
    TargetPanels[I].Free;
    UpdatePanelList;
    if I >= PanelList.Items.Count then Dec(I);
    PanelList.ItemIndex := I;
    UpdateControls;
    PanelList.SetFocus;
    Modified := True;
  end;
end;

procedure TStatusBarEditor.PanelListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with PanelList do
    if ItemIndex >= 0 then BeginDrag(False);
end;

procedure TStatusBarEditor.PanelListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  NewIndex: Integer;
begin
  if Source = PanelList then
    with PanelList do
    begin
      NewIndex := ItemAtPos(Point(X, Y), True);
      Accept := (NewIndex >= 0) and (NewIndex <> ItemIndex);
      if NewIndex = ItemIndex then NewIndex := -1;
      if State = dsDragEnter then FocusIndex := -1;
      if State = dsDragLeave then NewIndex := -1;
      if FocusIndex <> NewIndex then
      begin
        Canvas.DrawFocusRect(ItemRect(FocusIndex));
        Canvas.DrawFocusRect(ItemRect(NewIndex));
      end;
      FocusIndex := NewIndex;
    end else
      Accept := False;
end;

procedure TStatusBarEditor.PanelListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index: Integer;
begin
  if Sender = PanelList then
    with PanelList do
    begin
      Index := ItemAtPos(Point(X, Y), True);
      if Index >= 0 then
      begin
        TargetPanels[ItemIndex].Index := Index;
        UpdatePanelList;
        ItemIndex := Index;
        Modified := True;
      end;
    end;
end;

procedure TStatusBarEditor.PanelControlExit(Sender: TObject);
begin
  UpdatePanel;
end;

procedure TStatusBarEditor.PanelEditChange(Sender: TObject);
begin
  if not UpdatingControls then
  begin
    OkButton.Default := False;
    ApplyButton.Default := True;
    ApplyButton.Enabled := True;
    Modified := True;
  end;
end;

procedure TStatusBarEditor.PanelComboChange(Sender: TObject);
begin
  if not UpdatingControls then
  begin
    UpdatePanel;
    Modified := True;
  end;
end;

procedure TStatusBarEditor.OkButtonClick(Sender: TObject);
begin
  UpdatePanel;
  ModalResult := mrOk;
end;

procedure TStatusBarEditor.CancelButtonClick(Sender: TObject);
begin
  TargetPanels.Assign(StatusBar.Panels);
  Modified := False;
  ModalResult := mrCancel;
end;

procedure TStatusBarEditor.ApplyButtonClick(Sender: TObject);
begin
  UpdatePanel;
  if ActiveControl is TEdit then TEdit(ActiveControl).SelectAll;
end;

procedure TStatusBarEditor.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
