unit StyleTableRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

type
  TnsStyleTableRes = class(TDataModule)
    StyleTreeImageList: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
 CParagraphImageIndex = 0;
 CSelectionImageIndex = 1;

function nsStyleTableRes: TnsStyleTableRes;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
 g_nsStyleTableRes: TnsStyleTableRes = nil;

function nsStyleTableRes: TnsStyleTableRes;
begin
 if (g_nsStyleTableRes = nil) then
  Application.CreateForm(TnsStyleTableRes, g_nsStyleTableRes);
 Result := g_nsStyleTableRes; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@nsStyleTableRes);
 
end.
