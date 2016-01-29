unit DataModule;

interface

uses
  SysUtils, Classes, vcmModule, l3InterfacedComponent, vcmComponent,
  vcmBaseEntities, vcmEntities;

type
  TmoDocument = class(TvcmModule)
    Entities: TvcmEntities;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  moDocument: TmoDocument;

implementation

{$R *.dfm}

end.
