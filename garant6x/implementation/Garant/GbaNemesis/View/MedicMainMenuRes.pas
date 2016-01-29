unit MedicMainMenuRes;

interface

uses
  SysUtils, Classes, ImgList, vtPngImgList;

type
  TdmMedicMainMenuRes = class(TDataModule)
    ilMedicMainMenu: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cimgMedicReferences = 0;
  cimgMedicAdditional = 1;
  cimgMedicOperations = 2;

var
 dmMedicMainMenuRes: TdmMedicMainMenuRes;

implementation

{$R *.dfm}

end.
