{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit unit1;

interface
{$I dcprod.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcscript, dcPascal, StdCtrls, ExtCtrls, impreg, ComCtrls, dcedit, dcapp,
  dcsystem, vclstdreg, vcldbreg, dcCommon, dcDBCtl;

type
  TForm1 = class(TForm)
    DCScripter1: TDCScripter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    FontBut: TButton;
    Memo: TMemo;
    LabelX: TLabel;
    LabelY: TLabel;
    LabelRes: TLabel;
    EditX: TEdit;
    EditY: TEdit;
    EditRes: TEdit;
    CalcBut: TButton;
    Memo1: TMemo;
    TabSheet3: TTabSheet;
    ClickEventBut: TButton;
    EditEventBut: TButton;
    Memo2: TMemo;
    TabSheet4: TTabSheet;
    RunBut: TButton;
    Label4: TLabel;
    ScriptFileEdit: TDCFileNameEdit;
    ModalRunCheck: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    procedure FontButClick(Sender: TObject);
    procedure CalcButClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RunButClick(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure EditEventButClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    HScript: THandle;
  end;

var
  Form1: TForm1;

implementation

{$IFDEF DREAMINSPECTOR}
uses InspUnit;
{$ENDIF}

{$R *.DFM}

procedure TForm1.FontButClick(Sender: TObject);
begin
  with DCScripter1 do
  begin
    Script := Memo.Lines;
    Language := 'JavaScript';
    CallNoParamsMethod('ChangeFont');
  end;
end;

procedure TForm1.CalcButClick(Sender: TObject);
var
  x: extended;
  y: extended;
  Result: extended;
begin
  x := StrToFloat(EditX.Text);
  y := StrToFloat(EditY.Text);
  with DCScripter1 do
  begin
    Script := Memo1.Lines;
    Language := 'VBScript';
    Result := DispatchMethod('Calculate', [y, x]);
  end;
  EditRes.Text := FloatToStr(Result);
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  with PageControl1 do
    if ActivePage = TabSheet3 then
      with DCScripter1 do
      begin
        Script := Memo2.Lines;
        Language := 'VBScript';
      end;
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin
  DCScripter1.Script := Memo2.Lines;
end;

procedure TForm1.RunButClick(Sender: TObject);
begin
  with ScriptFileEdit do
    if FileName <> '' then
    begin
      ResetRunningModule(HScript);
      if FileCanBeExecuted(FileName) then
      begin
        if ModalRunCheck.Checked then
          HScript := RunUnitModal(FileName)
        else
          HScript := RunUnit(FileName);
      end
      else
        with TIDEProject.CreateFrom(FileName, '') do
        try
          if ProjectItems.Count > 0 then
            HScript := RunObjectList(ProjectItems)
          else
            HScript := 0;
        finally
          Free;
        end;
    end;
end;

procedure TForm1.EditEventButClick(Sender: TObject);
begin
  CallPropertyEdit(DcScripter1, 'Events');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
  RecreateWnd;
end;

initialization
  dcEdit.Register;
  dcCommon.Register;
  dcDBCtl.Register;
end.
