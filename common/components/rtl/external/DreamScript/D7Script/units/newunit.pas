{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit newunit;

interface
{$I dc.inc}
uses
  dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcapp,StdCtrls, ExtCtrls, dcconsts, consts,ComCtrls, dcpalet, dcstdctl, dcgen, dccommon,
  dcdreamlib;

type
  TNewFrm = class(TForm)
    Panel1: TPanel;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    Panel2: TPanel;
    PageControl: TNewFormPageControl;
    procedure FormCreate(Sender: TObject);
    procedure PageControlDblClick(Sender: TObject);
  private
  end;

var
  NewFrm: TNewFrm;

function GetNewIDEObjectData:TObjectParamListItem;
function CreateNewIDEObject:TIDEObject;

implementation

{$R *.DFM}

{-------------------------------------------------------------------------}

function CreateNewIDEObject:TIDEObject;
begin
  Result:=MainIDEObject.NewIDEObject(GetNewIDEObjectData,True);
end;

{-------------------------------------------------------------------------}

procedure FileNew;
begin
  CreateNewIDEObject;
end;

{-------------------------------------------------------------------------}

procedure TNewFrm.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  Caption := SNewItem;
  AssignNewFormPages(PageControl.PredefinedPages);
  If PageControl.PageCount>0 then
    ActiveControl := TWinControl(PageControl.Pages[0].Controls[0]);
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

{-------------------------------------------------------------------------}

function GetNewIDEObjectData:TObjectParamListItem;
begin
  Result:=nil;
  with TNewFrm.Create(Application) do
  try
    If PageControl.PageCount=0 then
    begin
      ShowMessage(SErrNoNewExtensions);
      exit;
    end;
    if (ShowModal= mrOk) then
      With TListView(PageControl.ActivePage.Controls[0]) do
        if Selected<>nil then
          Result:=Selected.Data;
  finally
    Free;
  end;
end;

{-------------------------------------------------------------------------}

procedure TNewFrm.PageControlDblClick(Sender: TObject);
begin
  If TListView(PageControl.ActivePage.Controls[0]).Selected<>nil then
    Modalresult:=mrOk;
end;

{-------------------------------------------------------------------------}

procedure _Register;
begin
  RegisterVerb(SVerbFileNew,nil,FileNew);
end;

{-------------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
end;

{-------------------------------------------------------------------------}

initialization
  RunRegister;
end.
