unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FlexCompress;

type
  TfmMain = class(TForm)
    Archiver: TFlexCompress;
    bnStart: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}

end.
