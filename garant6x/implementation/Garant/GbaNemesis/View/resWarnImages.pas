unit resWarnImages;

interface

uses
  SysUtils, Classes, ImgList, vtPngImgList;

type
  TnsWarnImages = class(TDataModule)
    WarnImages: TvtNonFixedPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsWarnImages: TnsWarnImages;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_nsWarnImages: TnsWarnImages = nil;

function nsWarnImages: TnsWarnImages;
begin
 if (g_nsWarnImages = nil) then
  Application.CreateForm(TnsWarnImages, g_nsWarnImages);
 Result := g_nsWarnImages; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@nsWarnImages);
 
end.
