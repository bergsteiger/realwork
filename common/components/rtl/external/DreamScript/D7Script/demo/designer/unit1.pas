{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit1;

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,  StdCtrls, dcddes,unit2,DCGen, dcreg,ComCtrls, ExtCtrls, dcfdes,
  dccommon;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DreamDesigner1: TDreamDesigner;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    DCPropStore1: TDCPropStore;
    EditStoredButton: TButton;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    Menuitem1: TMenuItem;
    Panel1: TPanel;
    Button3: TButton;
    Button2: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DreamDesigner1ActiveChanged(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditStoredButtonClick(Sender: TObject);
    procedure Menuitem1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFDEF DREAMTREE}
uses
  pstored;
{$ENDIF}

{$R *.DFM}


procedure TForm1.Button1Click(Sender: TObject);
begin
  with DreamDesigner1 do
  begin
    LimitControl := nil;
    Active := true;
  end;
end;

procedure TForm1.DreamDesigner1ActiveChanged(Sender: TObject);
begin
  with DreamDesigner1 do
    if  Active then
      Button1.Caption := 'Press Ctrl + F12 to stop designing'
    else
      Button1.Caption := 'Press Ctrl + F12 to start designing'
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  DataModule2.DreamDesigner1.Active := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DataModule2 := TDataModule2.Create(Application);
  {$IFNDEF DREAMTREE}
  EditStoredButton.Enabled:=false;
  {$ENDIF}
end;

procedure TForm1.EditStoredButtonClick(Sender: TObject);
begin
  {$IFDEF DREAMTREE}
  EditPropStore(DCPropStore1);
  {$ENDIF}
end;

procedure TForm1.Menuitem1Click(Sender: TObject);
begin
  Showmessage('Item clicked');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  with DreamDesigner1 do
  begin
    LimitControl := Panel1;
    Active := true;
  end;
end;

end.
