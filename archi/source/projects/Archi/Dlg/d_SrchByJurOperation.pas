unit d_SrchByJurOperation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, d_SrchByAction, StdCtrls, Mask, vtCombo, vtDateEdit, Buttons,
  ExtCtrls, OvcBase,  vtLister,
  DT_Types, afwControl, afwInputControl, afwControlPrim, afwBaseControl;

type
  TSrchByJurOperationDlg = class(TSrchByActionDlg)
    lstJurOperation: TvtDStringLister;
    lblJurOperation: TLabel;
    cbUser: TComboBox;
    cbxJurOp: TCheckBox;
    cbxSysOp: TCheckBox;
    procedure cbxJurOpClick(Sender: TObject);
    procedure cbxSysOpClick(Sender: TObject);
    procedure FillOpList;
  private
    { Private declarations }
  public
    constructor Create(aOwner : TComponent); reintroduce;
    { Public declarations }
    function GetOperationSet : TLogActionSet;
  end;

implementation

{$R *.dfm}

uses
 l3Base,
 l3String,

 daDataProvider,

 DT_Const,

 DictsSup;

constructor TSrchByJurOperationDlg.Create(aOwner : TComponent);
begin
 //lIsFull := l3System.Keyboard.Key[VK_SHIFT].Down and
 //           l3System.Keyboard.Key[VK_CONTROL].Down;

 Inherited Create(aOwner, 'Поиск по журналам');

 GlobalDataProvider.UserManager.GetFiltredUserList(cbUser.Items);
 cbUser.Items.Insert(0, '[ВСЕ]');
 cbUser.ItemIndex := 0;

 FillOpList;
end;

function TSrchByJurOperationDlg.GetOperationSet : TLogActionSet;
var
 I : Integer;
begin
 Result := [];
 with lstJurOperation.Items do
 for I := 0 to Pred(Count) do
  if lstJurOperation.Selected[I] then
   Result := Result + [PLogActionType(Data[I])^];
end;

procedure TSrchByJurOperationDlg.FillOpList;
var
 LASet : TLogActionSet;
 lAction : TLogActionType;
begin
 if cbxJurOp.Checked then
  LASet := cJurLogActions
 else
  LASet := [];

  if cbxSysOp.Checked then
  LASet := LASet + cOrdLogActions;

 with lstJurOperation.Items do
 begin
  Clear;
  DataSize := SizeOf(lAction);
  NeedAllocStr   := True;
  NeedDisposeStr := True;

  for lAction := Succ(Low(TLogActionType)) to High(TLogActionType) do
   if (lAction in LASet) then
    AddStr(GetLogJrnlName(lAction), @lAction);
 end;
end;

procedure TSrchByJurOperationDlg.cbxJurOpClick(Sender: TObject);
begin
 FillOpList;
end;

procedure TSrchByJurOperationDlg.cbxSysOpClick(Sender: TObject);
begin
 FillOpList;
end;

end.


