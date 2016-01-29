
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Dataset Designer Save Attributes Dialog         }
{                                                       }
{ Copyright (c) 1997-2001 Borland Software Corporation  }
{                                                       }
{*******************************************************}

unit DSAttrS;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DRIntf, LibHelp;

type
  TSaveAttributesAs = class(TForm)
    BasedOnList: TComboBox;
    AttributeNameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    OKBtn: TButton;
    Bevel1: TBevel;
    CancelBtn: TButton;
    HelpBtn: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AddToList(const Value: string);
  public
    function Execute(const TableName, FieldName: string;
      var AttributesName: string; var BasedOnID: TAttrID): Boolean;
  end;

function SaveAttributesAsDlg(const TableName, FieldName: string; var Name: string;
  var BasedOnID: TAttrID): Boolean;

implementation

uses DsnDBCst;

function SaveAttributesAsDlg(const TableName, FieldName: string; var Name: string;
  var BasedOnID: TAttrID): Boolean;
var
  SaveAttributesAsForm: TSaveAttributesAs;
begin
  SaveAttributesAsForm := TSaveAttributesAs.Create(Application);
  try
    Result := SaveAttributesAsForm.Execute(TableName, FieldName, Name, BasedOnID);
  finally
    SaveAttributesAsForm.Free;
  end;
end;

{$R *.dfm}

procedure TSaveAttributesAs.OKBtnClick(Sender: TObject);
var
  AttrID: TAttrID;
begin
  AttrID := FindAttrID(AttributeNameEdit.Text);
  if not IsNullID(AttrID) then
    raise Exception.CreateResFmt(@SDSAttrExists, [AttributeNameEdit.Text]);
  ModalResult := mrOk;
end;

procedure TSaveAttributesAs.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSaveAttributesAs.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSaveAttributesAs.AddToList(const Value: string);
begin
  BasedOnList.Items.Add(Value);
end;

procedure TSaveAttributesAs.FormCreate(Sender: TObject);
begin
  BasedOnList.Items.Add(SDSNone);
  GetAttrNames(AddToList);
  HelpContext := hcDSaveAttributesAs;
end;

function TSaveAttributesAs.Execute(const TableName, FieldName: string;
  var AttributesName: string; var BasedOnID: TAttrID): Boolean;
var
  Index: Integer;

  function UniqueAttrName(const TableName, FieldName: string): string;
  var
    Template: string;
    I: Integer;
    AttrID: TAttrID;
  begin
    Template := TableName;
    I := Pos('.', Template);
    if I > 0 then Delete(Template, I, MaxInt);
    Template := Template + FieldName;
    for I := Length(Template) downto 1 do
      if Template[I] = ' ' then Delete(Template, I, 1);
    I := 0;
    Result := Template;
    while True do
    begin
      AttrID := FindAttrID(Result);
      if IsNullID(AttrID) then Exit;
      Inc(I);
      Result := Format('%s%d', [Template, I]);
    end;
  end;
  
begin
  Caption := Format(Caption, [FieldName]);
  Index := BasedOnList.Items.IndexOf(GetAttrName(BasedOnID));
  if Index < 0 then Index := 0;
  BasedOnList.ItemIndex := Index;
  AttributeNameEdit.Text := UniqueAttrName(TableName, FieldName);
  Result := ShowModal = mrOk;
  if Result then
  begin
    AttributesName := AttributeNameEdit.Text;
    BasedOnID := FindAttrID(BasedOnList.Text);
  end;
end;

end.
