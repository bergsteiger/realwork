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
{$I dcprod.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dcedit,  ExtCtrls, DBGrids, Db, DBTables, Grids, oinspect, dbinsp,
  DBCtrls, StdCtrls, Mask, dcstdctl,dcreg,dcgen, dcsystem;

type
  TForm1 = class(TForm)
    DataSetInspector1: TDataSetInspector;
    DataSource1: TDataSource;
    Table1: TTable;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DCSplitter1: TDCSplitter;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  CallPropertyEdit(DBGrid1,'Columns');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CallPropertyEdit(DataSetInspector1,'Items');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFNDEF DREAMTREE}
    Button1.Visible := false;
    Button2.Visible := false;
  {$ENDIF}
end;

end.
