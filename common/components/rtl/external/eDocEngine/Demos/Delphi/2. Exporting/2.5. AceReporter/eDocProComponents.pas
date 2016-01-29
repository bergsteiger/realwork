unit eDocProComponents;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  gtTIFFEng, gtCstGfxEng, gtPNGEng, gtClasses3, gtCstDocEng, gtCstPlnEng,
  gtSVGEng;

type
  TfrmeDocProComponents = class(TForm)
    gtSVGEngine1: TgtSVGEngine;
    gtPNGEngine1: TgtPNGEngine;
    gtTIFFEngine1: TgtTIFFEngine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmeDocProComponents: TfrmeDocProComponents;

implementation

{$R *.DFM}

end.
