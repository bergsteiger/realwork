{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgPageProps;

interface

uses
  System.Classes, Vcl.Controls, Vcl.Dialogs, DSAzDlgBlockProps, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.StdCtrls;

type
  TAzPageProps = class(TAzBlockProps)
    lbeLength: TLabeledEdit;
    lbeNumber: TLabeledEdit;
    Label1: TLabel;
    cbxAction: TComboBox;
  private
    { Private declarations }
    function GetLength: String;
    procedure SetLength(const Data: string);

    function GetNumberAction: String;
    procedure SetNumberAction(const Data: string);

    function GetSequence: string;
    procedure SetSequence(const Data: string);
  public
    { Public declarations }
    property Length: string read GetLength write SetLength;
    property Action: string read GetNumberAction write SetNumberAction;
    property Sequence: string read GetSequence write SetSequence;
  end;

implementation

{$R *.dfm}

{ TAzPageProps }

function TAzPageProps.GetNumberAction: String;
begin
  Result := cbxAction.Text;
end;

function TAzPageProps.GetLength: String;
begin
  Result := lbeLength.Text;
end;

function TAzPageProps.GetSequence: string;
begin
  Result := '';
  if 'increment' <> Action then
    Result := lbeNumber.Text;
end;

procedure TAzPageProps.SetNumberAction(const Data: string);
begin
  cbxAction.Text := Data;
end;

procedure TAzPageProps.SetLength(const Data: string);
begin
  lbeLength.Text := Data;
end;

procedure TAzPageProps.SetSequence(const Data: string);
begin
  lbeNumber.Text := Data;
end;

end.
