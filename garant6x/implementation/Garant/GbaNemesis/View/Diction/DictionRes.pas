unit DictionRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

type
  TnsDictRes = class(TDataModule)
    DictImages: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function nsDictRes: TnsDictRes;

const
  cDictItemIcon = 0;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_nsDictRes: TnsDictRes = nil;

function nsDictRes: TnsDictRes;
begin
 if (g_nsDictRes = nil) then
  Application.CreateForm(TnsDictRes, g_nsDictRes);
 Result := g_nsDictRes;
end;

{$R *.dfm}

initialization
 AddImageListCreator(@nsDictRes);
 
end.
