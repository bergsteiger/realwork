unit adArchiveList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwInputControl, vtLister, StdCtrls;

type
  TArchiveList = class(TForm)
    lstArchives: TvtLister;
    btnRestore: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    constructor Create(const aArchiveFolder: AnsiString);
    { Public declarations }
    
  end;

var
  ArchiveList: TArchiveList;

implementation

{$R *.dfm}

constructor TArchiveList.Create(const aArchiveFolder: AnsiString);
begin
 inherited Create(nil);

end;

end.
