unit enNoEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities, StdCtrls,
  vcmComponent, vcmBaseEntities;

type
  TenNoEditForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    Label1: TLabel;
    private
      { Private declarations }
    public
      { Public declarations }
  end;

implementation

{$R *.DFM}

end.
