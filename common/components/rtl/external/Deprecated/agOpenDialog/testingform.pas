(************************************************************
Author: Deepak Shenoy
        shenoy@agnisoft.com
Copyright (C) 2000 Agni Software Pvt. Ltd.
All Rights Reserved.
http://www.agnisoft.com

This form tests the functionality of TAgOpenDialog and TAgSaveDialog
********************************************************)
unit testingform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, AgOpenDialog;

type
  TForm1 = class(TForm)
    Button1: TButton;
    AgOpenDialog1: TAgOpenDialog;
    AgSaveDialog1: TAgSaveDialog;
    Button2: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with AgOpenDialog1 do
  try
    Execute;
  finally
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  with AgSaveDialog1 do
  try
    Execute;
  finally
  end;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  AgOpenDialog1.ShowPlacesBar := (Sender as TCheckBox).Checked;
  AgSaveDialog1.ShowPlacesBar := (Sender as TCheckBox).Checked;
end;

end.
