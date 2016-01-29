unit d_GetJurOp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Mask, vtCombo, vtDateEdit, vtCtrls,
  Buttons, ExtCtrls, vtBndLabel,
  k2Interfaces, k2Tags,
  DT_Types, DT_Log, vtLabel,

  l3Variant
  ;

type
  TTGetJurOpDlg = class(TBottomBtnDlg)
    cbOperation: TvtComboBox;
    edtDate: TvtDateEdit;
    vtBoundedLabel1: TvtBoundedLabel;
    vtBoundedLabel2: TvtBoundedLabel;
    procedure FormCreate(Sender: TObject);
    procedure cbOperationChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetJurOperation(aRec : Tl3Tag; aRecEmpty : Boolean = False) : boolean;

implementation

{$R *.dfm}

uses
 stDate,

 DT_Const,

 IniShop,
 DictsSup;

procedure TTGetJurOpDlg.FormCreate(Sender: TObject);
var
 lActions : TLogActionType;
begin
 inherited;
 for lActions := Low(TLogActionType) to High(TLogActionType) do
  if lActions in (cJurLogActions{ - [acIncluded]}) then
   cbOperation.Items.AddObject(GetLogJrnlName(lActions), TObject(lActions));
end;

procedure TTGetJurOpDlg.cbOperationChange(Sender: TObject);
begin
 inherited;
 case TLogActionType(Byte(cbOperation.Items.Objects[cbOperation.ItemIndex])) of
  acAnonced :
   edtDate.StDate := DateTimeToStDate(IniRec.NextVersionDate);
  acAnnoDate :
   edtDate.Date := IniRec.AnnoDate;
 end;
end;

function GetJurOperation(aRec : Tl3Tag; aRecEmpty : Boolean = False) : boolean;
begin
 with TTGetJurOpDlg.Create(nil) do
 try
  with aRec do
  //Action  : Byte;
  //Date    : TStDate;
  //Time    : TStTime;
  //Author  : TUserNameStr;

  if aRecEmpty then
  begin
   cbOperation.ItemIndex := 0;
   edtDate.StDate := CurrentDate;
  end
  else
   with aRec do
   begin
    cbOperation.ItemIndex := cbOperation.Items.IndexOfObject(TObject(IntA[k2_tiType]));
    edtDate.StDate := IntA[k2_tiStart];
   end;

  Result := Execute;

  with aRec do
  begin
   AttrW[k2_tiName, nil] := nil;
   IntA[k2_tiType] := Byte(cbOperation.Items.Objects[cbOperation.ItemIndex]);
   IntA[k2_tiStart] := edtDate.StDate;
   IntA[k2_tiTime] := CurrentTime;
  end;
 finally
  Free;
 end;
end;

end.
