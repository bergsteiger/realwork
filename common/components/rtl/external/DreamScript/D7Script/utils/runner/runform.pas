{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit runform;
{$I dc.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dccommon,dcsystem, StdCtrls, dcedit
  {$IFDEF D3}
  ,dcpload
  {$ENDIF};

type
  TFrmRun = class(TForm)
    DCFileNameEdit1: TDCFileNameEdit;
    RunBut: TButton;
    PackBut: TButton;
    CloseBut: TButton;
    VerbDispatcher1: TVerbDispatcher;
    Label1: TLabel;
    procedure DCFileNameEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    {$IFDEF D3}
    DCPackageLoader:TDCPackageLoader;
    {$ENDIF}

    { Public declarations }
  end;

var
  FrmRun: TFrmRun;

implementation

{$R *.DFM}


procedure TFrmRun.DCFileNameEdit1Change(Sender: TObject);
begin
  RunBut.Enabled := DCFileNameEdit1.FileName <>''; 
end;

procedure TFrmRun.FormCreate(Sender: TObject);
begin
  {$IFDEF D3}
//  If CompiledWithPackages then
//    DCPackageLoader:=CreateDefaultPackageLoader(Self);
  {$ENDIF}
end;

end.
