
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Dataset Designer Associate Attributes Dialog    }
{                                                       }
{  Copyright (c) 1997-2001 Borland Software Corp.       }
{                                                       }
{*******************************************************}

unit DSAttrA;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls,
  StdCtrls, Buttons, ExtCtrls, DRIntf, LibHelp;

type
  TAssociateAttributes = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    GroupBox1: TGroupBox;
    AttributeNamesList: TListBox;
    Edit: TEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBoxClick(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
  private
    procedure AddToList(const Value: string);
  public
    function Execute(var AttrID: TAttrID; var Continue: Boolean): Boolean;
  end;

function GetAssociateAttributes(var AttrID: TAttrID; var Continue: Boolean): Boolean;

implementation

uses DsnDBCst;

{$R *.dfm}

function GetAssociateAttributes(var AttrID: TAttrID; var Continue: Boolean): Boolean;
var
  AssociateAttributes: TAssociateAttributes;
begin
  AssociateAttributes := TAssociateAttributes.Create(Application);
  try
    Result := AssociateAttributes.Execute(AttrID, Continue);
  finally
    AssociateAttributes.Free;
  end;
end;

procedure TAssociateAttributes.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TAssociateAttributes.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAssociateAttributes.AddToList(const Value: string);
begin
  AttributeNamesList.Items.Add(Value);
end;

procedure TAssociateAttributes.FormCreate(Sender: TObject);
begin
  GetAttrNames(AddToList);
  HelpContext := hcDAssociateAttributes;
  if AttributeNamesList.Items.Count > 0 then
    Edit.Text := AttributeNamesList.Items[0] else
    raise Exception.CreateRes(@SDSNoAttrs);
end;

procedure TAssociateAttributes.EditChange(Sender: TObject);
var
  I, L, C, Count: Integer;
  S: string;
begin
  Count := AttributeNamesList.Items.Count;
  if Count > 0 then
  begin
    S := Edit.Text;
    L := Length(S);
    C := -1;
    I := 0;
    if L > 0 then
    begin
      while I < Count do
      begin
        C := AnsiCompareText(Copy(AttributeNamesList.Items[I], 1, L), S);
        if C >= 0 then Break;
        Inc(I);
      end;
    end;
    if C = 0 then
    begin
      if AttributeNamesList.ItemIndex <> I then
      begin
        AttributeNamesList.ItemIndex := -1;
        AttributeNamesList.TopIndex := I;
        AttributeNamesList.ItemIndex := I;
      end;
      OKBtn.Enabled := True;
    end else
    begin
      AttributeNamesList.ItemIndex := -1;
      if L = 0 then AttributeNamesList.TopIndex := 0;
      OKBtn.Enabled := False;
    end;
  end;
end;

procedure TAssociateAttributes.ListBoxClick(Sender: TObject);
begin
  if AttributeNamesList.ItemIndex >= 0 then
  begin
    Edit.Text := AttributeNamesList.Items[AttributeNamesList.ItemIndex];
    Edit.SelectAll;
  end;
end;

procedure TAssociateAttributes.ListBoxDblClick(Sender: TObject);
begin
  if OKBtn.Enabled then OKBtn.Click;
end;

procedure TAssociateAttributes.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (ssAlt in Shift) and (Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) then
  begin
    SendMessage(AttributeNamesList.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

function TAssociateAttributes.Execute(var AttrID: TAttrID; var Continue: Boolean): Boolean;
var
  ModalResult: Integer;
begin
  if not IsNullID(AttrID) then Edit.Text := GetAttrName(AttrID);
  Edit.SelectAll;
  AttributeNamesList.ItemIndex := AttributeNamesList.Items.IndexOf(Edit.Text);
  OKBtn.Enabled := AttributeNamesList.ItemIndex >= 0;
  ModalResult := ShowModal;
  Result := ModalResult = mrOk;
  Continue := ModalREsult <> mrCancel;
  if Result and (AttributeNamesList.ItemIndex >= 0) then
    AttrID := FindAttrID(AttributeNamesList.Items[AttributeNamesList.ItemIndex]);
end;

procedure TAssociateAttributes.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
