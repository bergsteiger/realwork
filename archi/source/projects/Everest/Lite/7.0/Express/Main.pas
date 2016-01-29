unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainLiteExpress, StdActns, ActnList, evAction, dxBar,
  l3ProgressComponent, l3Filer, k2Reader, evEvdRd, k2TagGen, k2DocumentGenerator,
  evdWriter, ImgList, OvcBase, evSubPn, l3InterfacedComponent,
  evSaveDocumentManager, DdeMan, evdReader, k2StackGenerator,
  k2FileGenerator, evLoadDocumentManager, Tabs, ComCtrls;

type
  TMainForm = class(TMainLiteExpressForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
