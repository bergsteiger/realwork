unit F_MiscDocImgView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, vtForm, ExtCtrls;

type
  TfrmMiscDocImgView = class(TvtFrame)
    Panel1: TPanel;
    ImageView: TImage;
    procedure ImageViewDblClick(Sender: TObject);
    procedure vtFrameResize(Sender: TObject);
  private
    f_FileName: string;
    procedure CenterImage;
    { Private declarations }
  public
    procedure OpenFile(aFileName: string);
    { Public declarations }
  end;

implementation
uses
 ShellApi,
 arImageUtils;

{$R *.dfm}

procedure TfrmMiscDocImgView.CenterImage;
begin
 ImageView.Left := (ClientWidth-ImageView.Width) div 2;
 ImageView.Top  := (ClientHeight - ImageView.Height + Panel1.Height) div 2;
end;

procedure TfrmMiscDocImgView.OpenFile(aFileName: string);
begin
 f_FileName := aFileName;
 ImageView.Picture.Bitmap := BuildFileIcon(f_FileName);
 CenterImage;
end;

procedure TfrmMiscDocImgView.ImageViewDblClick(Sender: TObject);
begin
 if f_FileName <> '' then
  ShellExecute(0, 'open', PChar(f_FileName), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMiscDocImgView.vtFrameResize(Sender: TObject);
begin
 CenterImage;
end;

end.
