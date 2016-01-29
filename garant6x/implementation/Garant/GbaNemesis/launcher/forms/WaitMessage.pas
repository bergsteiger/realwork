unit WaitMessage;

interface

uses
 Windows,
 Classes,
 Graphics,
 Controls,
 Forms,
 Dialogs,
 StdCtrls,
 ExtCtrls,

 vtGradientWaitbar;

type
 TWaitMessageForm = class(TForm)
  f_GradientWaitBar: TvtGradientWaitbar;
  f_GradientWaitBarPanel: TPanel;
  f_WaitMessageMemo: TMemo;
  //
  procedure FormCreate(a_Sender: TObject);
  procedure FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
 private
  procedure pm_SetText(const a_Value: string);
 public
  property Text: string write pm_SetText;
 end;

var
 WaitMessageForm: TWaitMessageForm;

implementation {$R *.DFM}

uses
 SysUtils
 , LocaleMessages
 ;

procedure TWaitMessageForm.FormCreate(a_Sender: TObject);
begin
 Caption := Application.Title;
end;

procedure TWaitMessageForm.FormCloseQuery(a_Sender: TObject; var a_CanClose: Boolean);
begin
 a_CanClose := False;
end;

procedure TWaitMessageForm.pm_SetText(const a_Value: string);
begin
 with f_WaitMessageMemo.Lines do
 begin
  Clear;
  //
  Add(Format(GetCurrentLocaleMessage(c_GarantWaitMessageFormOperationInProgress), [a_Value]));
 end;
end;

end.
