unit D_GetDS;

{ $Id: D_GETDS.PAS,v 1.20 2014/06/03 10:17:46 dinishev Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics,
     Forms, Controls, Buttons, Dialogs, vtDialogs,
     StdCtrls, OvcBase, vtlister, ExtCtrls, vtStringLister, afwControl,
  afwInputControl, afwControlPrim, afwBaseControl, vtForm;

type
  TGetDocSetDlg = class(TvtForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    lstDocSet: TvtStringlister;
  private
    { Private declarations }
  public
    Function Execute(CallWin : TForm) : Boolean;
  end;

implementation

{$R *.DFM}

Uses
 SysUtils,
 Main, ObjExWin,
 l3TreeInterfaces, l3Tree_TLB,
 l3Tree, l3Nodes, l3String, l3Base;

function TGetDocSetDlg.Execute(CallWin : TForm) : Boolean;
var
 PN : Il3Node;
begin
 with MainForm.OEWin.ObjectExplorer.TreeStruct do
 begin
  PN := MainForm.OEWin.BaseExplorerNode[eotDocSet].ChildNode;
  if PN <> nil then
   repeat
    if not (MainForm.OEWin.BaseExplorerNode[eotSaveDocSet]).IsSame(PN) and
       (Pointer((PN as Il3HandleNode).Handle) <> CallWin) then
     lstDocSet.Items.AddObject(PChar(l3PCharLen2String(PN.Text)), TObject((PN as Il3HandleNode).Handle));
    if PN.IsLast then
     Break
    else
     PN := PN.NextNode;
   until false;
 end;
 if lstDocSet.Items.Count = 0 then
 begin
  vtMessageDlg(l3CStr('Нет открытых выборок.'), mtWarning, [mbOK], 0 {HelpCtx});
  Result := False;
 end
 else
  Result := ShowModal = mrOk;
end;

end.
