unit adErrorBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase, afwControlPrim, afwBaseControl, afwControl,
  afwInputControl, vtLister, StdCtrls, ExtCtrls, l3StringList, l3Interfaces;

type
  TErrorBox = class(TForm)
    lstErrors: TvtLister;
    Image1: TImage;
    txtText: TStaticText;
    btnOne: TButton;
    btnTwo: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure lstErrorsGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
  private
    f_ErrorList: Tl3StringList;
    f_IsYesNo: Boolean;
    procedure pm_SetIsYesNo(const Value: Boolean);
    { Private declarations }
  public
    constructor Create(const aTitle, aText: AnsiString; const ErrList: Tl3StringList);
    property IsYesNo: Boolean read f_IsYesNo write pm_SetIsYesNo;
    { Public declarations }
  end;

var
  ErrorBox: TErrorBox;

implementation

uses l3StringListPrim;

{$R *.dfm}

constructor TErrorBox.Create(const aTitle, aText: AnsiString; const ErrList: Tl3StringList);
begin
 inherited Create(nil);
 Caption := aTitle;
 txtText.Caption := aText;
 ErrList.SetRefTo(f_ErrorList);
 if f_ErrorList <> nil then
  lstErrors.Total := f_ErrorList.Count;
 IsYesNo := False; 
end;

procedure TErrorBox.FormDestroy(Sender: TObject);
begin
 FreeAndNil(f_ErrorList);
end;

procedure TErrorBox.lstErrorsGetStrItem(Sender: TObject; Index: Integer; var ItemString: Il3CString);
begin
 ItemString := f_ErrorList.ItemC[Index];
end;

procedure TErrorBox.pm_SetIsYesNo(const Value: Boolean);
begin
 f_IsYesNo := Value;
 btnOne.Visible := f_IsYesNo;
 if f_IsYesNo then
  btnTwo.Caption := 'Нет'
 else
  btnTwo.Caption := 'OK';
end;

end.
