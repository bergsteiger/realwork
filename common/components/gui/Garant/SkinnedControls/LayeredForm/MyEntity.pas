unit MyEntity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vcmEntityForm, l3InterfacedComponent, vcmComponent,
  vcmBaseEntities, vcmEntities;

type
  TMyEntityForm = class(TvcmEntityForm)
    Memo1: TMemo;
    Button1: TButton;
    Entities: TvcmEntities;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyEntityForm: TMyEntityForm;

implementation

{$R *.dfm}

end.
