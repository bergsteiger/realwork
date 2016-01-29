{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcinpfrm;

interface
{$I dc.inc}
uses
  {$IFNDEF CLX}
  Windows, Messages,Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  {$ELSE}
  QForms, QControls, QStdCtrls, QExtCtrls,
  {$ENDIF}
  SysUtils, Classes, dccommon, dcedit, dcsystem, dcdreamlib, dcconsts, consts;

type
  TInputLineForm = class(TForm)
    Panel1: TPanel;
    InputLabel: TLabel;
    PropEdit: TEdit;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormCreate(Sender: TObject);
  end;

var
  InputLineForm: TInputLineForm;

function ReadInteger(Const FormCaption,InputCaption:String;HelpCtx:Integer;
           Var IntValue:Integer):boolean;
function CreateInputForm(const FormCaption,InputCaption:String;
           HelpCtx:Integer):TInputLineForm;

function ReadString(Const FormCaption,InputCaption:String;HelpCtx:Integer;
           Var StrValue:String):boolean;

function ReadScaleFactor(Var ScaleFactor:Extended):boolean;

implementation
{$R *.DFM}

function ReadScaleFactor(Var ScaleFactor:Extended):boolean;
begin
  ScaleFactor:=1;
  with CreateInputForm(SCapScale,SCapScalingFactor,0) do
  begin
    PropEdit.Text:='100'; //don't resource
    try
      Result:=ShowModal = mrOK;
      if Result then
        ScaleFactor := StrtoInt(PropEdit.Text) / 100;
    finally
      Free;
    end;
  end;
end;

{---------------------------------------------------}

function CreateInputForm(const FormCaption,InputCaption:String;HelpCtx:Integer):TInputLineForm;
begin
  Result:=TInputLineForm.Create(Application);
  With Result do
  begin
    Caption:=FormCaption;
    InputLabel.Caption:=InputCaption;
    HelpContext:=HelpCtx;
  end;
end;

{---------------------------------------------------}

function ReadString(Const FormCaption,InputCaption:String;HelpCtx:Integer;
           Var StrValue:String):boolean;
begin
  With CreateInputForm(FormCaption,InputCaption,HelpCtx) do
  begin
    PropEdit.Text:=StrValue;
    Try
      Result:=ShowModal=mrOk;
      If Result then
        StrValue:=PropEdit.Text;
    finally
      Free;
    end;
  end;
end;

{---------------------------------------------------}

function ReadInteger(Const FormCaption,InputCaption:String;HelpCtx:Integer;
           Var IntValue:Integer):boolean;
begin
  With CreateInputForm(FormCaption,InputCaption,HelpCtx) do
  begin
    PropEdit.Text:=IntToStr(IntValue);
    Try
      Result:=ShowModal=mrOk;
      If Result then
        IntValue:=StrToInt(PropEdit.Text);
    finally
      Free;
    end;
  end;
end;

procedure TInputLineForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption := SCapGotoLineNumber;
  InputLabel.Caption := SCapEnterNewLine;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

end.
