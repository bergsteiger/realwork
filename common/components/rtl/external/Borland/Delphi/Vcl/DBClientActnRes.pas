unit DBClientActnRes;

interface

uses
  SysUtils, Classes, ActnList, DBClientActns, DBActns, ImgList, Controls;

type
  TClientDatasetActions = class(TDataModule)
    ActionList1: TActionList;
    ClientDataSetApply1: TClientDataSetApply;
    ClientDataSetRevert1: TClientDataSetRevert;
    ClientDataSetUndo1: TClientDataSetUndo;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClientDatasetActions: TClientDatasetActions;

implementation

{$IFDEF MSWINDOWS}
{$R *.dfm}
{$ENDIF}

end.
