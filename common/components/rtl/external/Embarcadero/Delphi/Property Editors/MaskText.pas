{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MaskText;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, DesignIntf,
  DesignEditors, Mask;

type

{ TMaskTextProperty
  Property editor for the Caption and Text properties.  Removes auto-update
  feature of normal text property to allow validation. }

  TMaskTextProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

type
  TMaskTextForm = class(TForm)
    Label3:    TLabel;
    TestEdit:  TMaskEdit;
    Label1: TLabel;
    EditMask: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaskTextForm: TMaskTextForm;

function EditMaskText(const Mask: string; var MaskText: string): Boolean;

implementation

uses SysUtils, LibHelp;

{$R *.dfm}

function EditMaskText(const Mask: string; var MaskText: string): Boolean;
var
  Frm : TMaskTextForm;
begin
  Frm := TMaskTextForm.Create(Application);
  try
    Frm.TestEdit.EditMask := Mask;
    Frm.TestEdit.Text := MaskText;
    Frm.TestEdit.SelectAll;
    if Mask <> '' then Frm.EditMask.Caption := Mask;
    Result := Frm.ShowModal = mrOk;
    if Result then MaskText := Frm.TestEdit.Text;
  finally
    Frm.Free;
  end;
end;

{ TMaskTextForm }

procedure TMaskTextForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDMaskedTextEditor;
end;

procedure TMaskTextForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{ TMaskTextProperty }

function TMaskTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TMaskTextProperty.Edit;
var
  Ed: TMaskEdit;
  Text: string;
begin
  Ed := TMaskEdit(GetComponent(0));
  Text := Ed.Text;
  if EditMaskText(Ed.EditMask, Text) and (Text <> Ed.Text) then
  begin
    Ed.Text := Text;
    Modified;
  end;
end;

end.

