{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Design.Path;

interface

uses
  System.SysUtils, System.Types, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.StdCtrls,
  FMX.Dialogs, FMX.Layouts, FMX.Objects, FMX.Memo, FmxDesignWindows;

type
  TPathDataDesigner = class(TFmxDesignWindow)
    previewLayout: TLayout;
    Label1: TLabel;
    PreviewPath: TPath;
    Layout2: TLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LabelMemo: TLabel;
    PathData: TMemo;
    procedure PathDataChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PathDataDesigner: TPathDataDesigner;

implementation

uses System.UITypes;

{$R *.fmx}

procedure TPathDataDesigner.Button1Click(Sender: TObject);
begin
  pathData.SelectAll;
  pathData.DeleteSelection;
  pathData.PasteFromClipboard;
end;

procedure TPathDataDesigner.Button2Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPathDataDesigner.Button3Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TPathDataDesigner.PathDataChange(Sender: TObject);
begin
  if previewLayout.Visible then
    previewPath.Data.Data:= PathData.Text;
end;

end.
