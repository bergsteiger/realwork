unit ClosingWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Animate, GIFCtrl;

type
  TClosingForm = class(TForm)
    Label1: TLabel;
    lblDbgInfo: TLabel;
    RxGIFAnimator1: TRxGIFAnimator;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; aMode : byte); reintroduce; //aMode = 1 - load 2 - save
    procedure OutDebugInfo(aDbgStr : String);
  end;

implementation

{$R *.DFM}
 procedure TClosingForm.OutDebugInfo(aDbgStr : String);
  begin
   lblDbgInfo.Caption := aDbgStr;
   Application.ProcessMessages;
  end;

 constructor TClosingForm.Create(AOwner: TComponent; aMode : byte); //aMode = 1 - load 2 - save
  begin
   inherited Create(aOwner);
   Caption := Application.Title;
   Case aMode of
    1 : begin
         Label1.Caption := 'Ждите'^M'Идет подключение к базе';
        end;

    2 : begin
         Label1.Caption := 'Потерпите'^M'Идет сохранение данных';
        end;
   end;
  end;

end.
