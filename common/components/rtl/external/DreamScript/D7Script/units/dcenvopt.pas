{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcenvopt;

interface
{$I dc.inc}
uses
  Messages, Forms, StdCtrls, Controls, ExtCtrls, Classes, ComCtrls;

const
  CM_PAGEUPDATED = WM_USER + 1;

type
  TEnvForm = class(TForm)
    PageProps: TPageControl;
    pnlButtons: TPanel;
    Panel2: TPanel;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OkButClick(Sender: TObject);
    procedure CancelButClick(Sender: TObject);
  Private
    Procedure SendMessageToPages(MessageID:Integer);
  public
    procedure CMPAGEUPDATED(var Msg: TMessage); message CM_PAGEUPDATED;
  end;

var
  EnvForm: TEnvForm;

function ShowEnvOptions(OptForms: TList): Boolean;
procedure ShowEnvOptionsExcept(ExceptForms: TList);
procedure ShowEnvironmentOptions;
procedure FillPages(PageControl: TPageControl; Forms: TList);

function PageControlGetActivePageIndex(PageControl:TPageControl): Integer;
procedure PageControlSetActivePageIndex(PageControl:TPageControl;
  const Value: Integer);

const
  SelectLastPage : boolean = false;

implementation

uses
  Windows, dcStdCtl, dcSystem, dcCommon, dcdreamLib, dcConsts;

{$R *.DFM}

{-------------------------------------}

function PageControlGetActivePageIndex(PageControl:TPageControl): Integer;
begin
  {$IFDEF D5}
  Result:=PageControl.ActivePageIndex;
  {$ELSE}
  With PageControl do
    if ActivePage <> nil then
      Result := ActivePage.PageIndex
    else
      Result := -1;
  {$ENDIF}
end;

{-------------------------------------}

procedure PageControlSetActivePageIndex(PageControl:TPageControl;
  const Value: Integer);
begin
  {$IFDEF D5}
  PageControl.ActivePageIndex:=Value;
  {$ELSE}
  With PageControl do
    if (Value > -1) and (Value < PageCount) then
      ActivePage := Pages[Value]
    else
      ActivePage := nil;
  {$ENDIF}
end;

{-------------------------------------}

procedure TEnvForm.CMPAGEUPDATED(var Msg: TMessage);
var
  pageform : TCustomForm;
  w: integer;
  h: integer;
begin
  pageform := TCustomForm(Msg.LParam);


  with PageProps do
    begin
      W := pageform.Width + Width - Pages[0].ClientWidth;
      H := pageform.Height + Height - Pages[0].ClientHeight;
    end;

  if ClientHeight < H + pnlButtons.Height then
    ClientHeight := H + pnlButtons.Height;
    
  if ClientWidth < W then
    ClientWidth := W;
end;

type
  TDCFormTabSheet2 = class(TDCFormTabSheet)
  protected
    procedure CreateHandle; override;
  public
    EnvFormClass: TCustomFormClass;

    destructor Destroy; override;
  end;

{------------------------------------------------------------------}

destructor TDCFormTabSheet2.Destroy;
begin
  Form.Free;
  Form := nil;
  inherited;
end;

procedure TDCFormTabSheet2.CreateHandle;
var
  msg: TMessage;
  f  : TCustomForm;
begin
  inherited;
  f := EnvFormClass.Create(nil);
  msg.Msg := CM_PAGEUPDATED;
  msg.wParam := integer(self);
  msg.lParam := integer(f);
  GetParentForm(self).Dispatch(msg);
  Form := f;
end;

{------------------------------------------------------------------}

function CreateFormTabSheet(PageControl: TPageControl): TDCFormTabSheet2;
begin
  result := TDCFormTabSheet2.Create(PageControl.Owner);
  try
    result.PageControl := PageControl;
  except
    result.Free;
    raise;
  end;
end;

{------------------------------------------------------------------}

procedure FillPages(PageControl: TPageControl; Forms: TList);
var
  i: integer;
begin
  for i := 0 to Forms.Count - 1 do
    with CreateFormTabSheet(PageControl) do
    begin
      EnvFormClass := Forms[i];
      Caption := GetOptionsFormCaption(TCustomFormClass(Forms[i]));
    end;
end;

{------------------------------------------------------------------}

function ShowEnvOptionsForm(Form: TCustomForm; PageProps: TPageControl;
  OptForms: TList): boolean;
var
  i: integer;
  M: TMessage;
  H, W: integer;
begin
  with TEnvForm(Form) do
  begin
    FillPages(PageProps, OptForms);
    with PageProps do
      if PageCount > 0 then
      begin
        W := TDCFormTabSheet(Pages[0]).Width + Width - Pages[0].ClientWidth;
        H := TDCFormTabSheet(Pages[0]).Height + Height - Pages[0].ClientHeight;

        ClientHeight := H + pnlButtons.Height; // added for bottom buttons
        ClientWidth := W;
      end;

    if SelectLastPage then
      with PageProps do
        if PageCount > 0 then
          PageControlSetActivePageIndex(PageProps,PageCount - 1);
          
    result := ShowModal = idOk;

    M.Msg := CM_CANCELOPTIONS;
    if result then
      M.Msg := CM_APPLYOPTIONS;

    with PageProps do
      for i := 0 to PageCount - 1 do
        if TDCFormTabSheet(Pages[i]).Form <> nil then
          TDCFormTabSheet(Pages[i]).Form.Dispatch(M);
  end;
end;

{------------------------------------------------------------------}

function ShowEnvOptions(OptForms: TList): boolean;
var
  optform: TEnvForm;
begin
  optform := TEnvForm.Create(nil);
  try
    result := ShowEnvOptionsForm(optform, optform.PageProps, OptForms);
  finally
    optform.Free;
  end;
end;

{------------------------------------------------------------------}

var
  EnvLock: Boolean = False;

procedure ShowEnvOptionsExcept(ExceptForms: TList);
var
  i: integer;
  forms: TList;
  formclass : TCustomFormClass;
begin
  if EnvLock then
    exit;

  EnvLock := true;
  try
    forms := TList.Create;

    try
      for i := 0 to OptionFormClasses.Count - 1 do
        begin
          formclass := OptionFormClass(i);
          if ExceptForms.IndexOf(formclass) < 0 then
            forms.Add(formclass);
        end;
      ShowEnvOptions(forms);
    finally
      forms.Free;
    end;
  finally
    EnvLock := false;
  end;
end;

{------------------------------------------------------------------}

procedure ShowEnvironmentOptions;
var
  i: integer;
  forms: TList;
begin
  if EnvLock then
    exit;

  EnvLock := true;
  try
    forms := TList.Create;

    try
      for i := 0 to OptionFormClasses.Count - 1 do
        forms.Add(OptionFormClass(i));
      //forms.Add(TCustomFormClass(Objects[i]).Create(nil));

      ShowEnvOptions(forms);
    finally
      {for i := 0 to forms.Count - 1 do
        TCustomForm(forms[i]).Free;}

      forms.Free;
    end;
  finally
    EnvLock := false;
  end;
end;

{------------------------------------------------------------------}

Procedure TEnvForm.SendMessageToPages(MessageID:Integer);
Var
  M: TMessage;
  I: Integer;
Begin
  M.Msg:=MessageID;
  with PageProps do
    for i := 0 to PageCount - 1 do
      if TDCFormTabSheet(Pages[i]).Form <> nil then
        TDCFormTabSheet(Pages[i]).Form.Dispatch(M);
End;

{------------------------------------------------------------------}

procedure TEnvForm.FormCreate(Sender: TObject);
begin
  Caption := SProperties;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

procedure TEnvForm.OkButClick(Sender: TObject);
begin
  SendMessageToPages(CM_APPLYOPTIONS);
  ModalResult:=mrOK;
end;

procedure TEnvForm.CancelButClick(Sender: TObject);
begin
  SendMessageToPages(CM_CANCELOPTIONS);
  ModalResult:=mrCancel;
end;

initialization
  RegisterVerb('Tools.EnvironOptions', nil, ShowEnvironmentOptions); //don't resource
end.
