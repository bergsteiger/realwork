unit dmStdResLite;

interface

uses
  SysUtils, Classes, ImgList, Controls, l3InterfacedComponent, evSubPn,
  evSubPanel;

type
  TdmStandardRes = class(TDataModule)
    ilOffice: TImageList;
    ilCommon: TImageList;
    SubDescriptors: TevSubDescriptors;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmStandardRes: TdmStandardRes;

implementation

{$R *.dfm}

end.
