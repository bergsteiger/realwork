{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit HCtlEdit;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  THeaderControlEditor = class(TForm)
    GroupBox1: TGroupBox;
    SectionList: TListBox;
    NewButton: TButton;
    DeleteButton: TButton;
    GroupBox2: TGroupBox;
    SectionText: TEdit;
    SectionWidth: TEdit;
    SectionMinWidth: TEdit;
    SectionMaxWidth: TEdit;
    SectionStyle: TComboBox;
    SectionAlignment: TComboBox;
    SectionAllowClick: TCheckBox;
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
    procedure SectionListClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure SectionListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SectionListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SectionListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SectionControlExit(Sender: TObject);
    procedure SectionEditChange(Sender: TObject);
    procedure SectionComboChange(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    HeaderControl: THeaderControl;
    TargetSections: THeaderSections;
    FocusIndex: Integer;
    UpdatingControls: Boolean;
    Modified: Boolean;
    procedure UpdateControls;
    procedure UpdateSection;
    procedure UpdateSectionList;
  end;

function EditHeaderSections(HeaderSections: THeaderSections): Boolean;

implementation

uses DsnConst;

{$R *.dfm}

function EditHeaderSections(HeaderSections: THeaderSections): Boolean;
begin
  with THeaderControlEditor.Create(Application) do
    try
      TargetSections := HeaderSections;
      HeaderControl.Sections.Assign(TargetSections);
      UpdateSectionList;
      if SectionList.Items.Count > 0 then SectionList.ItemIndex := 0;
      UpdateControls;
      ShowModal;
      Result := Modified;
    finally
      Free;
    end;
end;

function GetIntValue(Edit: TEdit): Integer;
begin
  try
    Result := StrToInt(Edit.Text);
  except
    Edit.SelectAll;
    Edit.SetFocus;
    raise;
  end;
end;

procedure THeaderControlEditor.FormCreate(Sender: TObject);
begin
  HeaderControl := THeaderControl.Create(Self);
end;

procedure THeaderControlEditor.UpdateControls;
var
  Index: Integer;
  Section: THeaderSection;
  SectionSelected: Boolean;
begin
  Index := SectionList.ItemIndex;
  SectionSelected := Index >= 0;
  UpdatingControls := True;
  if SectionSelected then
  begin
    Section := TargetSections[Index];
    SectionText.Text := Section.Text;
    SectionWidth.Text := IntToStr(Section.Width);
    SectionMinWidth.Text := IntToStr(Section.MinWidth);
    SectionMaxWidth.Text := IntToStr(Section.MaxWidth);
    SectionStyle.ItemIndex := Ord(Section.Style);
    SectionAlignment.ItemIndex := Ord(Section.Alignment);
    SectionAllowClick.Checked := Section.AllowClick;
  end else
  begin
    SectionText.Text := '';
    SectionWidth.Text := '';
    SectionMinWidth.Text := '';
    SectionMaxWidth.Text := '';
    SectionStyle.ItemIndex := -1;
    SectionAlignment.ItemIndex := -1;
    SectionAllowClick.Checked := False;
  end;
  UpdatingControls := False;
  SectionText.Enabled := SectionSelected;
  SectionWidth.Enabled := SectionSelected;
  SectionMinWidth.Enabled := SectionSelected;
  SectionMaxWidth.Enabled := SectionSelected;
  SectionStyle.Enabled := SectionSelected;
  SectionAlignment.Enabled := SectionSelected;
  SectionAllowClick.Enabled := SectionSelected;
end;

procedure THeaderControlEditor.UpdateSection;
var
  I: Integer;
  Section: THeaderSection;
begin
  I := SectionList.ItemIndex;
  if I >= 0 then
  begin
    Section := TargetSections[SectionList.ItemIndex];
    if Section.Text <> SectionText.Text then
    begin
      Section.Text := SectionText.Text;
      UpdateSectionList;
      SectionList.ItemIndex := I;
    end;
    Section.Width := GetIntValue(SectionWidth);
    Section.MinWidth := GetIntValue(SectionMinWidth);
    Section.MaxWidth := GetIntValue(SectionMaxWidth);
    Section.Style := THeaderSectionStyle(SectionStyle.ItemIndex);
    Section.Alignment := TAlignment(SectionAlignment.ItemIndex);
    Section.AllowClick := SectionAllowClick.Checked;
    UpdateControls;
    ApplyButton.Enabled := False;
    ApplyButton.Default := False;
    OkButton.Default := True;
  end;
end;

procedure THeaderControlEditor.UpdateSectionList;
var
  I: Integer;
  S: string;
begin
  SectionList.Items.BeginUpdate;
  try
    SectionList.Items.Clear;
    for I := 0 to TargetSections.Count - 1 do
    begin
      S := TargetSections[I].Text;
      if S = '' then S := SUntitled;
      SectionList.Items.Add(Format('%d - %s', [I, S]));
    end;
  finally
    SectionList.Items.EndUpdate;
  end;
  DeleteButton.Enabled := SectionList.Items.Count > 0;
end;

procedure THeaderControlEditor.SectionListClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure THeaderControlEditor.NewButtonClick(Sender: TObject);
begin
  UpdateSection;
  TargetSections.Add;
  UpdateSectionList;
  SectionList.ItemIndex := TargetSections.Count - 1;
  UpdateControls;
  SectionText.SetFocus;
  Modified := True;
end;

procedure THeaderControlEditor.DeleteButtonClick(Sender: TObject);
var
  I: Integer;
begin
  I := SectionList.ItemIndex;
  if I >= 0 then
  begin
    TargetSections[I].Free;
    UpdateSectionList;
    if I >= SectionList.Items.Count then Dec(I);
    SectionList.ItemIndex := I;
    UpdateControls;
    SectionList.SetFocus;
    Modified := True;
  end;
end;

procedure THeaderControlEditor.SectionListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with SectionList do
    if ItemIndex >= 0 then BeginDrag(False);
end;

procedure THeaderControlEditor.SectionListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  NewIndex: Integer;
begin
  if Source = SectionList then
    with SectionList do
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

procedure THeaderControlEditor.SectionListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index: Integer;
begin
  if Sender = SectionList then
    with SectionList do
    begin
      Index := ItemAtPos(Point(X, Y), True);
      if Index >= 0 then
      begin
        TargetSections[ItemIndex].Index := Index;
        UpdateSectionList;
        ItemIndex := Index;
        Modified := True;
      end;
    end;
end;

procedure THeaderControlEditor.SectionControlExit(Sender: TObject);
begin
  UpdateSection;
end;

procedure THeaderControlEditor.SectionEditChange(Sender: TObject);
begin
  if not UpdatingControls then
  begin
    OkButton.Default := False;
    ApplyButton.Default := True;
    ApplyButton.Enabled := True;
    Modified := True;
  end;
end;

procedure THeaderControlEditor.SectionComboChange(Sender: TObject);
begin
  if not UpdatingControls then
  begin
    UpdateSection;
    Modified := True;
  end;
end;

procedure THeaderControlEditor.OkButtonClick(Sender: TObject);
begin
  UpdateSection;
  ModalResult := mrOk;
end;

procedure THeaderControlEditor.CancelButtonClick(Sender: TObject);
begin
  TargetSections.Assign(HeaderControl.Sections);
  Modified := False;
  ModalResult := mrCancel;
end;

procedure THeaderControlEditor.ApplyButtonClick(Sender: TObject);
begin
  UpdateSection;
  if ActiveControl is TEdit then TEdit(ActiveControl).SelectAll;
end;

procedure THeaderControlEditor.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
