unit D_FindAlarm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls,
  Mask, vtCombo, vtDateEdit,
  dt_Types,
  l3Date, d_SrchByAction, vtLabel, vtCtrls;

type
  TFindAlarmDlg = class(TSrchByActionDlg)
    cbMessageText: TvtComboBox;
    vtLabel1: TvtLabel;
  public
    { Public declarations }
  end;

 function GetAlarmFindData(var aStart : TstDate; var aFinish : TstDate; var aText : AnsiString) : boolean;

implementation

{$R *.dfm}

uses
  l3String,
  l3IniFile,
  InsDWin;

const
 cMessageHistorySectName = 'AlarmSrchHistory';

function GetAlarmFindData(var aStart : TstDate; var aFinish : TstDate; var aText : AnsiString) : boolean;
begin
 with TFindAlarmDlg.Create(nil, '') do
 try
//  edtDate.StDate  := aDate;
  UserConfig.Section := cMessageHistorySectName;
  UserConfig.ReadParamList(cMessageHistorySectName, cbMessageText.Items);

  Result := Execute;

  if Result then
  begin
   aStart := edtLowDate.StDate;
   aFinish := edtHighDate.StDate;
   aText := cbMessageText.Text;

   cbMessageText.AddToHistory;
   UserConfig.Section := cMessageHistorySectName;
   UserConfig.WriteParamList(cMessageHistorySectName, cbMessageText.Items);
  end;

 finally
  Free;
 end;
end;

end.
