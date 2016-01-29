unit hcDeleteQueryOptionsForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls
  ;

type
  TfrmDeleteQueryOptions = class(TForm)
    rgKindDelete: TRadioGroup;
    pnlButton: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    function pm_GetForceDelete: Boolean;
    { Private declarations }
  public
    property ForceDelete: Boolean
      read pm_GetForceDelete;
      {-}
  end;

implementation

{$R *.dfm}

{ TfrmDeleteQueryOptions }

function TfrmDeleteQueryOptions.pm_GetForceDelete: Boolean;
begin
 Assert(rgKindDelete.ItemIndex <> -1);
 Result := rgKindDelete.ItemIndex = 1;
end;

end.
