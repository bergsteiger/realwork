{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit AligUnit;
{$I dc.inc}
interface

uses
  dcsystem, dcconsts, consts, Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Buttons, Menus, dcdreamlib, dcGen, dccommon;

type
  TAlignForm = class(TForm)
    LeftEdges: TSpeedButton;
    VertCenters: TSpeedButton;
    BottomEdges: TSpeedButton;
    RightEdges: TSpeedButton;
    CenterHinWindow: TSpeedButton;
    CenterVertinForm: TSpeedButton;
    SpaceEquallyHor: TSpeedButton;
    VSpaceequal: TSpeedButton;
    HorzCenters: TSpeedButton;
    TopEdges: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Stayontop1: TMenuItem;
    Hide1: TMenuItem;
    Help1: TMenuItem;
    VerbDispatcher1: TVerbDispatcher;
    procedure Hide1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Stayontop1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  protected
    procedure cmToolBarForm(Var M:TMessage) ;message cm_ToolBarForm;
    procedure cmHideAlignPalette(Var Message:TMessage);message cm_HideAlignPalette;
  public
  end;


var
  AlignForm: TAlignForm=nil;
  AlignPalMessageAnswer : TMessageAnswer; // call UnregisterNotifier(AlignPalMessageAnswer) to unregister message answer.   

procedure Register;
function  GetAlignForm : TAlignForm;

implementation
{$R *.DFM}
var
  _AlignForm : TAlignForm = nil;

{------------------------------------------------------------------}

procedure TAlignForm.cmToolBarForm(Var M:TMessage) ;
begin
  M.Result:=1;
end;

{------------------------------------------------------------------}

procedure TAlignForm.cmHideAlignPalette(Var Message:TMessage);
begin
  Hide;
end;

{------------------------------------------------------------------}

procedure TAlignForm.Hide1Click(Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------}

procedure TAlignForm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  RegisterNotifier(Self);
  SetFlatProp([LeftEdges, VertCenters, BottomEdges, RightEdges, CenterHinWindow,
    CenterVertinForm, SpaceEquallyHor, VSpaceequal, HorzCenters, TopEdges],True);
  ReadWinPosFromReg(self, 'AlignPalette');//don't resource

  Caption := SAlignmentpalette;
  LeftEdges.Hint := SAlignleft;
  VertCenters.Hint := SAlignvert;
  BottomEdges.Hint := SAlignbottom;
  RightEdges.Hint := SAlignright;
  CenterHinWindow.Hint := SCenterHor;
  CenterVertinForm.Hint := SCentervert;
  SpaceEquallyHor.Hint := SSpaceeqHor;
  VSpaceequal.Hint := SSpaceeqVert;
  HorzCenters.Hint := SAlignhor;
  TopEdges.Hint := SAligntops;
  Stayontop1.Caption := SVerbStayOnTop;
  Hide1.Caption := SVerbHide;
  Help1.Caption := ResStr(SHelpButton);

end;

{------------------------------------------------------------------}

procedure TAlignForm.PopupMenu1Popup(Sender: TObject);
begin
  StayOnTop1.Checked:=FormStyle=fsStayOnTop;
end;

{------------------------------------------------------------------}

procedure TAlignForm.Stayontop1Click(Sender: TObject);
begin
  StayOnTop1.Checked:= not StayOnTop1.Checked;

  If StayOnTop1.Checked=False
  then
    FormStyle:=fsNormal
  else
    FormStyle:=fsStayOnTop;
end;

{------------------------------------------------------------------}

procedure TAlignForm.FormDestroy(Sender: TObject);
begin
  UnRegisterNotifier(Self);
  WriteWinPosToReg(self, 'AlignPalette'); //don't resource
end;

{------------------------------------------------------------------}

function  GetAlignForm : TAlignForm;
begin
  If _AlignForm=nil then
    _AlignForm:=TAlignForm.Create(nil);
  result := _AlignForm;
end;

{------------------------------------------------------------------}

type
  TAlignPalMessageAnswer=class(TMessageAnswer)
  public
    procedure cmShowAlignPalette(Var Message:TMessage);message cm_ShowAlignPalette;
  end;

procedure TAlignPalMessageAnswer.cmShowAlignPalette(Var Message:TMessage);
var
  aform : TAlignForm;
begin
  aform := GetAlignForm;
  if not aform.Visible or Boolean(Message.wParam) then
    begin
      aform.FormStyle := ToolsFormStyle;
      aform.Show;
    end;
end;

{------------------------------------------------------------------}

procedure ViewAlignPalette;
begin
  GetAlignForm.Show;
end;

{------------------------------------------------------------------}

procedure _Register;
begin
  RegisterVerb('View.AlignmentPalette',nil,ViewAlignPalette);//don't resource
end;

procedure Register;
begin
  RegisterForDelphi(_Register);
//  RegisterInitProc(_InstantRegister,True);
end;

initialization
  AlignPalMessageAnswer:=TAlignPalMessageAnswer.Create;
  register;
finalization
  AlignPalMessageAnswer.Free;
  FreeObject(_AlignForm,_AlignForm);
end.

