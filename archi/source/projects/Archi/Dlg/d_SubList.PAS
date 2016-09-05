unit D_SubList;

{$Include l3Define.inc}

{ $Id: d_SubList.PAS,v 1.17 2016/06/16 05:38:44 lukyanets Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, OvcBase, OVCConst, vtlister,  vtHeader, vtCtrls;

type
  TSubListDlg = class(TvtPopupList)
    procedure RefListUserCommand(Sender: TObject; Command: Word);
    //procedure RefListActionElement(Sender: TObject; Index: Longint);
    procedure RefListCurrentChanged(Sender: TObject; aNewCurrent: Integer; 
        aOldCurrent: Integer);
    procedure AdjustPopUp(Sender: TObject);
   private
    //fFamily        : TdaFamilyID;
   public
    constructor Create(AOwner: TComponent); reintroduce;
    function    Execute(var aSubID : Integer) : Boolean;
  end;

implementation

{$INCLUDE ProjectDefine.inc}

//{$R *.DFM}
uses SysUtils,
     StrShop,
     EditWin,
     evEditor,
     evFacadeGUI;

constructor TSubListDlg.Create(aOwner: TComponent);
begin
 inherited Create(aOwner, TvtDStringLister, [vt_plShowFooter]);
 //fLister.OnUserCommand   := RefListUserCommand;
 fLister.OnCurrentChanged:= RefListCurrentChanged;
 OnAdjustCtrl := AdjustPopUp;
 fLister.MultiStrokeItem := True;
end;

function TSubListDlg.Execute(var aSubID : Integer) : Boolean;
var
 lIt : Integer;
begin
 //fFamily := aFamily;
 RefListCurrentChanged(Self, fLister.Current, fLister.Current);
 lIt := inherited Execute;
 Result := lIt >= 0;
 //Result := ShowModal = mrOk;
 if Result then
  aSubID := (fLister as TvtDStringLister).Items.DataInt[fLister.Current];
end;

procedure TSubListDlg.AdjustPopUp(Sender: TObject);
var
 l_Point : TPoint;
begin
 if Width < 260 then Width := 260;                
 l_Point := evMouseLP2DP(TDocEditorWindow(Owner).CurEditor);
 AdjustCtrl(Self, l_Point);
end;

procedure TSubListDlg.RefListUserCommand(Sender: TObject; Command: Word);
 begin
 (*
  case Command of
   ccDel :
    begin
     If fLister.Total = 1 then
     begin
      If TDocEditorWindow(Owner).RemoveReference then
       Close;
     end
     else
     begin
      If TDocEditorWindow(Owner).RemoveReference
          (Pointer(fLister.Items.Data[fLister.Current])) then
       fLister.Items.Delete(fLister.Current);
     end;
    end;
  end;
  *)
 end;

procedure TSubListDlg.RefListCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
begin
 if fLister.Total > 0 then
 begin
  fFooter.Sections[0].Caption := Format(scFmtFuterCounter, [Succ(aNewCurrent),fLister.Total]);
  fFooter.Sections[1].Caption := Format('SubID : %d', [(fLister as TvtDStringLister).Items.DataInt[aNewCurrent]]);
 end
 else
  begin
   fFooter.Sections[0].Caption := '';
   fFooter.Sections[1].Caption := '';
  end;
end;

end.
