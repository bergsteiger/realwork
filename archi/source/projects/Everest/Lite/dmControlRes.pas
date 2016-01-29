unit dmControlRes;

interface

uses
  SysUtils, Classes, ImgList, Controls, vtPngImgList, Menus;

type
  TdmCtrlRes = class(TDataModule)
    BtnImageList: TImageList;
    PNGImageList: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCtrlRes: TdmCtrlRes;

implementation

{$R *.dfm}

end.
