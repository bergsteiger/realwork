unit ddAppConfigBFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls;

type
  TButtonsFrame = class(TFrame)
    Bevel1: TBevel;
    HelpButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
    ApplyButton: TButton;
    textVersion: TStaticText;
    procedure ApplyButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TButtonsFrame.ApplyButtonClick(Sender: TObject);
begin
 { Вызвать сохранение данных }
end;

end.
