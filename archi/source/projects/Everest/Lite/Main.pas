unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainLite, evSubPn, k2DocumentGenerator, evdWriter, k2TagGen,
  k2Reader, evEvdRd, evTextSource, evEditorWindow, OvcBase,
  l3InterfacedComponent, l3ProgressComponent, l3Filer, ExtCtrls, 
  Menus, evMenu, ImgList, Tabs, StdCtrls, vtSpin, vtCtrls, TB97Ctls,
  evButton, TB97, TB97Tlbr,  W95Meter, vtHeader,
  evSaveDocumentManager;

type
  TMainForm = class(TMainFormLite)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
