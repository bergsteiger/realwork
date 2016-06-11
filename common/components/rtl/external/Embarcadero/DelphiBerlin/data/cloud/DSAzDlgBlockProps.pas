{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgBlockProps;

interface

uses Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls;

type
  TAzBlockProps = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    lbeCache: TLabeledEdit;
    lbeType: TLabeledEdit;
    lbeMD5: TLabeledEdit;
    lbeEncoding: TLabeledEdit;
    lbeLanguage: TLabeledEdit;
    procedure lbeCacheChange(Sender: TObject);
  private
    { Private declarations }
    function GetCache: string;
    procedure SetCache(const Data: string);

    function GetType: string;
    procedure SetType(const Data: string);

    function GetMD5: string;
    procedure SetMD5(const Data: string);

    function GetEncoding: string;
    procedure SetEncoding(const Data: string);

    function GetLanguage: string;
    procedure SetLanguage(const Data: string);
  public
    { Public declarations }
    procedure SetBaseline;

    property Cache: string read GetCache write SetCache;
    property ContentType: string read GetType write SetType;
    property MD5: string read GetMD5 write SetMD5;
    property Encoding: string read GetEncoding write SetEncoding;
    property Language: string read GetLanguage write SetLanguage;
  end;

implementation

{$R *.dfm}

function TAzBlockProps.GetCache: string;
begin
  Result := lbeCache.Text;
end;

function TAzBlockProps.GetEncoding: string;
begin
  Result := lbeEncoding.Text;
end;

function TAzBlockProps.GetLanguage: string;
begin
  Result := lbeLanguage.Text;
end;

function TAzBlockProps.GetMD5: string;
begin
  Result := lbeMD5.Text;
end;

function TAzBlockProps.GetType: string;
begin
  Result := lbeType.Text;
end;

procedure TAzBlockProps.lbeCacheChange(Sender: TObject);
begin
  OKBtn.Enabled := true;
end;

procedure TAzBlockProps.SetBaseline;
begin
  OKBtn.Enabled := false;
end;

procedure TAzBlockProps.SetCache(const Data: string);
begin
  lbeCache.Text := Data;
end;

procedure TAzBlockProps.SetEncoding(const Data: string);
begin
  lbeEncoding.Text := Data;
end;

procedure TAzBlockProps.SetLanguage(const Data: string);
begin
  lbeLanguage.Text := Data;
end;

procedure TAzBlockProps.SetMD5(const Data: string);
begin
  lbeMD5.Text := Data;
end;

procedure TAzBlockProps.SetType(const Data: string);
begin
  lbeType.Text := Data;
end;

end.
