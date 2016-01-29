{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcfdopt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcpedit,dcedit, StdCtrls, dcgen, dccommon, dcfdes, dcconsts, dcdreamlib;

type
  TDesOptForm = class(TForm)
    FormDesGroup: TGroupBox;
    GridStepXLbl: TLabel;
    GridStepYLbl: TLabel;
    DesignerOptions: TDCPropCheckBox;
    SnapToGridChk: TDCPropCheckBox;
    ShowCapChk: TDCPropCheckBox;
    StepXEdit: TDCPropEditor;
    StepYEdit: TDCPropEditor;
    DsgnHintsChk: TDCPropCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fDesOptions : TDesignerOptions;
  public
    procedure CMApplyOptions(var Msg : TMessage); message CM_APPLYOPTIONS;
  end;

var
  DesOptForm: TDesOptForm;

implementation

{$R *.DFM}

procedure TDesOptForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);

  GlobalDesignerOptions;

  fDesOptions := TDesignerOptions.Create;

  DesignerOptions.Component := fDesOptions;

  Caption                    := SDesignerOptions;
  FormDesGroup.Caption       := SFormDesigner;
  GridStepXLbl.Caption       := SGridStepX;
  GridStepYLbl.Caption       := SGridStepY;
  DesignerOptions.Caption    := SDisplayGrid;
  SnapToGridChk.Caption      := SSnapToGrid;
  ShowCapChk.Caption         := SShowCaptions;
  DsgnHintsChk.Caption       := SDsgnHints;
end;

procedure TDesOptForm.FormDestroy(Sender: TObject);
begin
  fDesOptions.Free;
end;

procedure TDesOptForm.CMApplyOptions(var Msg : TMessage);
begin
  fDesOptions.ApplyOptions;
end;

initialization
  RegisterOptionsFormOrder(TDesOptForm, 0, SDesignerOptions);
end.
