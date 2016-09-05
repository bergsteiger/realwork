unit LinkHistoWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  daTypes,
  DT_Types, Dt_Const, dt_AttrSchema,
  DT_Dict, DT_LinkServ,
  l3DatLst, l3Tree_TLB, l3Nodes,
  vtForm, OvcBase,  vtlister, Menus, AdvMenus, ComCtrls,
  vtStatusBar,
  afwControl, afwInputControl, afwControlPrim, afwBaseControl;

type
  TLinkHistoForm = class(TvtForm)
    lstHisto   : TvtDStringlister;
    ListPopUpMenu: TPopupMenu;
    miInsertClassToObjList: TMenuItem;
    ListFooter: TvtStatusBar;
    procedure lstHistoCurrentChanged(Sender: TObject; aNewCurrent: Integer; 
        aOldCurrent: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miInsertClassToObjListClick(Sender: TObject);
  private
    fFamily   : TdaFamilyID;
    fDictID   : TdaDictionaryType;

    fHistList : Tl3DataList;
    procedure LoadList;
    function evntOnCompareItems(I, J : Longint) : Longint;

  protected
    procedure SetSpeedButton(Enabled : Boolean); override;
    function  Copy  : boolean; override;
  public
    constructor Create(aOwner : TComponent;
                       aFamily : TdaFamilyID;
                       aDictID : TdaDictionaryType); reintroduce;

    procedure Cleanup; override;
  end;

implementation

{$R *.dfm}

Uses
 l3Base, l3Clipboard, l3Parser,
 l3Filer, l3Types, l3Stream,
 ObjList,
 StrShop, Main;

constructor TLinkHistoForm.Create(aOwner : TComponent;
                                  aFamily : TdaFamilyID;
                                  aDictID : TdaDictionaryType);
begin
 inherited Create(aOwner);
 fFamily := aFamily;
 fDictID := aDictID;
 LoadList;
end;

procedure TLinkHistoForm.Cleanup; 
begin
 l3Free(fHistList);
 inherited;
end;

procedure TLinkHistoForm.SetSpeedButton(Enabled : Boolean);
begin
 If Application.Terminated then Exit;
 MainForm.acCopy  .Enabled := Enabled;
 inherited;
end;


function TLinkHistoForm.evntOnCompareItems(I, J : Longint) : Longint;
begin
 with fHistList do
  Result := PDictHistogramRec(Data[J])^.Count - PDictHistogramRec(Data[I])^.Count;
end;

procedure TLinkHistoForm.LoadList;
var
 I : Integer;
 lRootNode : Il3Node;
 lCNode : Il3Node;
 lHistRec : PDictHistogramRec;
 lCurIdx : Integer;
begin
 fHistList := Tl3DataList.Create;
 LinkServer(fFamily).GetHistogramOfDictElementUsing(fDictID, fHistList, 500);
 fHistList.OnCompareItems := evntOnCompareItems;
 fHistList.Sort;
 lstHisto.Items.HostDataList := fHistList;
 lstHisto.Items.NeedAllocStr := True;                                        
 lRootNode := DictServer(fFamily).DictRootNode[fDictID];
 for I := 0 to pred(lstHisto.Items.Count) do
 begin
  lHistRec := PDictHistogramRec(fHistList.Data[I]);
  DictServer(ffamily).DictTbl[fDictID].ItemList.FindData(lHistRec^.ID,lCurIdx);
  lCNode := TDictItem(DictServer(fFamily).DictTbl[fDictID].ItemList.Items[lCurIdx]).LinkNode;
  lstHisto.Items.Strings[I] := PansiChar(Format('[%d] %s',
                         [lHistRec^.Count,
                         l3GetFullPathStr(lRootNode, lCNode,
                         #13, '  ')]));
 end;
end;

procedure TLinkHistoForm.lstHistoCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
 begin
  If lstHisto.Total > 0 then
  begin
   ListFooter.Panels[0].Text:=Format(scFmtFuterCounter,[Succ(aNewCurrent),lstHisto.Total]);
   ListFooter.Panels[1].Text:=Format(scFmtFuterID,[PDictHistogramRec(lstHisto.Items.Data[aNewCurrent])^.ID]);
  end
  else
  begin
   ListFooter.Panels[0].Text:='';
   ListFooter.Panels[1].Text:='';
  end;
 end;

procedure TLinkHistoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TLinkHistoForm.miInsertClassToObjListClick(Sender: TObject);
var
 ItDataRec   : TDictItemAddr;
begin
 if lstHisto.Current = -1 then Exit;
 with ItDataRec do
 begin
  FamID  := fFamily;
  DictID := Ord(fDictID);
  ItemID := PDictHistogramRec(lstHisto.Items.Data[lstHisto.Current])^.ID;
 end; // with ItDataRec do
 ArchiObjectList.AddObjRec(lstHisto.Items.Strings[lstHisto.Current], ddDictItem, @ItDataRec);
end;

function  TLinkHistoForm.Copy  : boolean;
var
 lStream     : Tl3ClipboardStream;
 lTextStream : Tl3TextStream;
 I           : Longint;
 lString     : AnsiString;
begin
 lStream := Tl3ClipboardStream.Create(l3_fmWrite);
 try
  lTextStream := Tl3TextStream.Create(lStream);
  try
   with lTextStream do
    begin
     for I := 0 to Pred(lstHisto.Total) do
     begin
      lString := lstHisto.Items.Strings[I]+#13#10;
      Write(lString[1], Length(lString));
     end;
    lString := #0;
    Write(lString[1], Length(lString));
   end;
  finally
   l3Free(lTextStream);
  end;
 finally
  l3Free(lStream);
 end;
end;


end.
