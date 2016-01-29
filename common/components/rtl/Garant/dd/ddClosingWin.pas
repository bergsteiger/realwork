unit ddClosingWin;

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Animate, GIFCtrl;

type
 TddWaitDialogType = (dd_cwtStart, dd_cwtStop);
  TddClosingForm = class(TForm)
    Label1: TLabel;
    lblDbgInfo: TLabel;
    RxGIFAnimator1: TRxGIFAnimator;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; aMode: TddWaitDialogType); reintroduce;
    procedure OutDebugInfo(aDbgStr : AnsiString);
  end;


implementation

{$R *.DFM}

Uses
 afwFacade;

 procedure TddClosingForm.OutDebugInfo(aDbgStr : AnsiString);
  begin
   lblDbgInfo.Caption := aDbgStr;
   afw.ProcessMessages;
  end;

 constructor TddClosingForm.Create(AOwner: TComponent; aMode: TddWaitDialogType);
  begin
   inherited Create(aOwner);
   Caption := Application.Title;
   Case aMode of
    dd_cwtStart :
        begin
         Label1.Caption := 'Ждите,'^M'идет загрузка данных';
        end;

     dd_cwtStop :
        begin
         Label1.Caption := 'Потерпите'^M'Идет сохранение данных';
        end;
   end;
  end;

end.
