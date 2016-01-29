{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcinspopt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dcsystem,dcpedit,dcedit, dcconsts, dcgen, dccommon, oinspect,
  dcdreamlib;

type
  TInspOptForm = class(TForm)
    OInspectGroup: TGroupBox;
    InspectorOptions: TDCPropRadioButton;
    VbStyleRad: TDCPropRadioButton;
    SmartPopupChk: TDCPropCheckBox;
    ShowCatChk: TDCPropCheckBox;
    EditAlias: TButton;
    ShowHintsChk: TDCPropCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditAliasClick(Sender: TObject);
  private
    fInspOptions : TInspectorOptions;

  public
    procedure CMApplyOptions(var Msg : TMessage); message CM_APPLYOPTIONS;
  end;

var
  InspOptForm: TInspOptForm;

implementation

{$R *.DFM}

procedure TInspOptForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);

  GlobalInspectorOptions;

  fInspOptions := TInspectorOptions.Create;

  InspectorOptions.Component := fInspOptions;

  Caption                    := SInspectOptions;
  OInspectGroup.Caption      := SOInspector;
  InspectorOptions.Caption   := SDelphiStyle;
  VbStyleRad.Caption         := SVbStyle;
  SmartPopupChk.Caption      := SSmartPopup;
  ShowHintsChk.Caption       := SShowHints;
  ShowCatChk.Caption         := SShowCategory;
  EditAlias.Caption          := SEditAliases;
end;

procedure TInspOptForm.FormDestroy(Sender: TObject);
begin
  fInspOptions.Free;
end;

procedure TInspOptForm.CMApplyOptions(var Msg : TMessage);
begin
  fInspOptions.ApplyOptions;
end;

procedure TInspOptForm.EditAliasClick(Sender: TObject);
begin
  CallPropertyEdit(fInspOptions,'Aliases');//don't resource
end;

initialization
  RegisterOptionsFormOrder(TInspOptForm, 1, SInspectOptions);
end.
