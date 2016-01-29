unit ddAppConfigSimpleBFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TSimpleButtonsFrame = class(TFrame)
    Bevel1: TBevel;
    HelpButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
