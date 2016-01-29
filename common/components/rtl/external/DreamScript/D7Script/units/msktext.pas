{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit MskText;
{$I dc.inc}
interface

uses
  {$IFDEF D6}
  MaskUtils,
  {$ENDIF}
  dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts,consts,dcgen, dccommon, dcdreamlib;

type
  TDCMaskTextForm = class(TForm)
    TextEdit: TMaskEdit;
    LInputText: TLabel;
    LEditMask: TLabel;
    EditMaskLabel: TLabel;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dcMaskTextForm: TdcMaskTextForm;

Function EnterMaskedText(Const AEditMask:String;Var AText:String):Boolean;

type
  TMaskEditTextPropEdit = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

{******************************************************************}

implementation
{$R *.DFM}

{------------------------------------------------------------------}

procedure TMaskEditTextPropEdit.Edit;
var
  atext : string;
begin
  atext := GetStrValue;
  if EnterMaskedText(TMaskEdit(GetComponent(0)).EditMask, AText) then
    begin
      SetStrValue(AText);
      Designer.Modified;
    end;
end;

{------------------------------------------------------------------}

function TMaskEditTextPropEdit.GetAttributes : TPropertyAttributes;
begin
  result := [paDialog];
end;

{------------------------------------------------------------------}

Function EnterMaskedText(Const AEditMask:String;Var AText:String):Boolean;
begin
  With TdcMaskTextForm.Create(Application) do
  begin
    EditMaskLabel.Caption:=AEditMask;

    With TextEdit do
    begin
      EditMask:=AEditMask;
      Text:=AText;
    end;

    Result:=(ShowModal=mrOk);
    If Result then
    begin
      AText:=TextEdit.Text;
    end;
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
  {$IFDEF D6}
  RegisterPropertyEditor(TypeInfo(TMaskedText), TMaskEdit, 'Text', TMaskEditTextPropEdit); //don't resource
  {$ELSE}
  RegisterPropertyEditor(TypeInfo(String), TMaskEdit, 'Text', TMaskEditTextPropEdit); //don't resource
  {$ENDIF}
  RegisterVisualProperty(SVerbMaskedTextEditor,TMaskEdit,'Text'); //don't resource
end;

{------------------------------------------------------------------}

procedure TdcMaskTextForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption := RemoveCharSet(['&','.'], SVerbMaskedTextEditor);
  LInputText.Caption := SInputText;
  LEditMask.Caption := SEditMask;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}

initialization
  RunRegister;
end.
