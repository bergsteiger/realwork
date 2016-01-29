unit ddAboutDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TddAboutDialog = class(TForm)
    imgIcon: TImage;
    lblAppTitle: TLabel;
    lblVersion: TLabel;
    lblDescription: TLabel;
    lblCompany: TLabel;
    Button1: TButton;
    memAdditional: TMemo;
  private
    { Private declarations }
  public
    procedure Execute(aAdditionalInfo: AnsiString; aBitmap: TBitmap);
    { Public declarations }
  end;

procedure ddAboutDialog(aAdditionalInfo: AnsiString; aBitmap: TBitmap = nil);

implementation

{$R *.dfm}

Uses
 vtVerInf,
 l3ShellUtils;

procedure ddAboutDialog(aAdditionalInfo: AnsiString; aBitmap: TBitmap = nil);
begin
 with TddAboutDialog.Create(nil) do
 try
  Execute(aAdditionalInfo, aBitmap);
 finally
  Free;
 end;
end;

procedure TddAboutDialog.Execute(aAdditionalInfo: AnsiString; aBitmap: TBitmap);
begin
 with TVersionInfo.Create(Application.ExeName) do
 try
  if aBitmap = nil then
   imgIcon.Picture.Bitmap:= ExtractIcon(Application.ExeName, 0, clBtnFace, 64)
  else
   imgIcon.Picture.Bitmap:= aBitmap;
  lblAppTitle.Caption:= Application.Title;
  lblVersion.Caption:= Format('Версия %d.%d (сборка %d)', [FileLongVersion.All[2], FileLongVersion.All[1], FileLongVersion.All[3]]);
  lblCompany.Caption:= CompanyName;
  lblDescription.Caption:= FileDescription;
  if aAdditionalInfo = '' then
   ClientHeight:= Button1.Top + Button1.Height + 4
  else
   memAdditional.Lines.Text:= aAdditionalInfo;
 finally
  Free;
 end;
 ShowModal;
end;

end.
