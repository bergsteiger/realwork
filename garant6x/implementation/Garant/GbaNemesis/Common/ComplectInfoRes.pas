unit ComplectInfoRes;

interface

uses
  SysUtils, Classes, ImgList, vtPngImgList;

type
  TnsComplectInfoRes = class(TDataModule)
    ComplectInfoItemImages: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsComplectInfoRes: TnsComplectInfoRes;

const
 ciMainInfo = 0;
 ciBlocks = 1;
 ciBlockFolder = 2;
 ciBlockInfo = 3;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_nsComplectInfoRes: TnsComplectInfoRes = nil;

function nsComplectInfoRes: TnsComplectInfoRes;
begin
 if (g_nsComplectInfoRes = nil) then
  Application.CreateForm(TnsComplectInfoRes, g_nsComplectInfoRes);
 Result := g_nsComplectInfoRes; 
end;    

{$R *.dfm}

initialization
 AddImageListCreator(@nsComplectInfoRes);
 
end.
