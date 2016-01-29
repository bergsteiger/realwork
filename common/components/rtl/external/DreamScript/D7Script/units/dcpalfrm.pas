{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcpalfrm;
{$I dc.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dcpalet, dcgen, dccommon, dcsystem,dcconsts, Menus, dcdreamlib,dcstdctl,
  dcenvopt, DCPalette, dcPalettePropUnit;

type
  TCompPalFrm = class(TForm)
    Palette: TDCCompPalette;
    PaletteMenu: TPopupMenu;
    PopupComponents: TMenuItem;
    VerbDispatcher: TVerbDispatcher;
    Properties1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Properties1Click(Sender: TObject);
  private
    fUseActiveX : boolean;

    procedure SetUseActiveX(val : boolean);
  protected
    procedure cmToolBarForm(Var M:TMessage) ;message cm_ToolBarForm;
    procedure cmHidePalette(Var Message:TMessage);message cm_HidePalette;
  public
    property UseActiveX : boolean read fUseActiveX write SetUseActiveX;
    { Public declarations }
  end;

  TCompPalFrmClass = class of TCompPalFrm;

var
  CompPalFrm: TCompPalFrm;
  PalMessageAnswer : TMessageAnswer; // call UnregisterNotifier(PalMessageAnswer) to unregister message answer.

const
  DefaultCompPalFrmClass: TCompPalFrmClass = TCompPalFrm;

function GetPalForm : TCompPalFrm;
function GetPalette : TDCCompPalette;

implementation

{$R *.DFM}
var
  PalForm : TCompPalFrm = nil;

function GetPalForm : TCompPalFrm;
begin
  if not Assigned(PalForm) then
    PalForm := DefaultCompPalFrmClass.Create(nil);
  Result:=PalForm;
end;

{------------------------------------------------------------------}

function GetPalette : TDCCompPalette;
begin
  if Assigned(PalForm) then
    result := PalForm.Palette
  else
    result := nil;
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.SetUseActiveX(val : boolean);
const
  VerbNames : array[boolean] of string = (SVerbCfgPackages, SVerbCfgPackagesActivex);
begin
  if val <> fUseActiveX then
    begin
      fUseActiveX := val;
      with VerbDispatcher do
        if VerbList.Count > 0 then
          VerbList[0].VerbName := VerbNames[val];
    end;
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.cmToolBarForm(Var M:TMessage) ;
begin
  M.Result:=1;
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.cmHidePalette(Var Message:TMessage);
begin
  Hide;
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.FormCreate(Sender: TObject);
begin
  fUseActiveX := true;
  SetFormFont(self);
  RegisterNotifier(Self);
  ClientHeight:=CPaletteButtonSize*2+5;
  ReadWinPosFromReg(Self,Self.Name);
  Caption := SComPal;
  AssignPalettePages(Palette.PredefinedPages);
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.FormDestroy(Sender: TObject);
begin
  UnRegisterNotifier(Self);
  WriteWinPosToReg(Self,Self.Name);
  if Self = PalForm then
    PalForm := nil;
end;

{------------------------------------------------------------------}

procedure TCompPalFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesignerInsertClass := '';
  Palette.SelectMouseButton;
end;

{------------------------------------------------------------------}

type
  TPalMessageAnswer=class(TMessageAnswer)
  public
    procedure cmShowPalette(Var Message:TMessage);message cm_ShowPalette;
  end;

{------------------------------------------------------------------}

procedure TPalMessageAnswer.cmShowPalette(Var Message:TMessage);
var
  pform : TCompPalFrm;
begin
  pform := GetPalForm;

  if not pform.Visible {or (Boolean(Message.wParam))} then
    begin
      pform.FormStyle := ToolsFormStyle;
      pform.Show;
    end;
end;

procedure TCompPalFrm.Properties1Click(Sender: TObject);
var
  EnvOpts : TList;
begin
  EnvOpts:= TList.Create;
  try
    EnvOpts.Add(TDCPalettePropForm);
    ShowEnvOptions(EnvOpts);
  finally
    EnvOpts.Free;
  end;
end;

initialization
  PalMessageAnswer:=TPalMessageAnswer.Create;
  OptionFormCaptions.AddObject(SDCPaletteSheetCaption, TObject(TDCPalettePropForm));
finalization
  PalMessageAnswer.Free;
  FreeObject(PalForm,PalForm);
end.
