unit ConfigurationListRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList;

const
 cimgStandart             = 0;
 cimgStandartActive       = 1;
 cimgStandartChange       = 2;
 cimgStandartChangeActive = 3;
 cimgGarant5x             = 4;
 cimgGarant5xActive       = 5;
 cimgGarant5xChange       = 6;
 cimgGarant5xChangeActive = 7;
 cimgUser                 = 8;
 cimgUserActive           = 9;
 cimgUserChange           = 10;
 cimgUserChangeActive     = 11;

type
  TdmConfigurationList = class(TDataModule)
    ilConfs: TvtNonFixedPngImageList;
  private
  public         
  end;

function dmConfigurationList: TdmConfigurationList;

implementation

uses
  Forms,
  vtPngImgListUtils
  ;

var
  g_dmConfigurationList: TdmConfigurationList = nil;

function dmConfigurationList: TdmConfigurationList;
begin
 if (g_dmConfigurationList = nil) then
  Application.CreateForm(TdmConfigurationList, g_dmConfigurationList);
 Result := g_dmConfigurationList; 
end;

{$R *.dfm}

initialization
 AddImageListCreator(@dmConfigurationList);
 
end.
