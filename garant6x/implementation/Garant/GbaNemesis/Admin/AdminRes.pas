unit AdminRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

const
 { Image indexes }
 ciiGroup         = 0;
 ciiUser          = 1;
 ciiAdmin         = 2;
 ciiUser_NA       = 3;
 ciiAdmin_NA      = 4;
 ciiExiting       = 5;
 ciiPriveleged    = 6;
 ciiPriveleged_NA = 7;
 ciiSystemGroup   = 8;

type
  TdmAdmin = class(TDataModule)
    ilUsers: TvtPngImageList;
  private
  public
  end;

function dmAdmin: TdmAdmin;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_dmAdmin: TdmAdmin = nil;

function dmAdmin: TdmAdmin;
begin
 if (g_dmAdmin = nil) then
  Application.CreateForm(TdmAdmin, g_dmAdmin);
 Result := g_dmAdmin; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@dmAdmin);

end.
