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

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, ExtCtrls, dcmemo, Db, DBTables, dcstring, dcdbmemo, StdCtrls,
  Mask, dcparser, dcsystem, dcstdctl, dcedit, dccommon, PropCB;

type
  TForm1 = class(TForm)
    DBMemoSource1: TDBMemoSource;
    Table1: TTable;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Table1ID: TAutoIncField;
    Table1Extention: TStringField;
    Table1Memo: TMemoField;
    Panel2: TPanel;
    Panel3: TPanel;
    DBMemo1: TDBMemo;
    DCSplitter1: TDCSplitter;
    Panel4: TPanel;
    Panel5: TPanel;
    JavaScriptParser: TJavaScriptParser;
    DelphiParser: TDelphiParser;
    VBScriptParser: TVBScriptParser;
    ActiveProp: TDCPropCheck;
    Memo: TDCMemo;
    DCSplitter2: TDCSplitter;
    DCMemo1: TDCMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.Active:=True;
  ActiveProp.Checked := true;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  DBMemoSource1.AutoDisplay := CheckBox1.Checked;
  DBMemo1.AutoDisplay  :=CheckBox1.Checked;;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  DBMemoSource1.ReadOnly := CheckBox2.Checked;
  DBMemo1.ReadOnly :=CheckBox2.Checked;;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
var
  s:string;
begin
  If Field<>nil then
    exit;
  s:= UpperCase(Table1Extention.AsString);
  With DBMemoSource1 do
  if S  = 'PAS' then
    SyntaxParser := DelphiParser
  else
  if S = 'JS' then
    SyntaxParser := JavaScriptParser
  else
  if S = 'VBS' then
    SyntaxParser := VBScriptParser
  else
    SyntaxParser := nil;
end;

end.

