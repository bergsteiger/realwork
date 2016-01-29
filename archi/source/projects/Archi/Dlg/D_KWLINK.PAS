unit D_KWLink;

{ $Id: D_KWLINK.PAS,v 1.8 2005/05/27 15:23:28 lulin Exp $ }

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, OvcBase, vtlister, ExtCtrls;

type
  TKWLinkDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    KWLinkList: TvtStringlister;
    OvcController1: TOvcController;
    SpeedButton1: TSpeedButton;
    SingleModeBtn: TSpeedButton;
    AllKWList: TvtDStringlister;
    procedure SingleModeBtnClick(Sender: TObject);
    procedure AllKWListSelectChange(Sender: TObject; Index: Longint;
      var Selected: Boolean);
  private
    HandleSelect : Boolean;
    KW_ID        : Longint;

  public
   Constructor CreateParam(AOwner: TComponent; aKW_ID : Longint);
  end;

implementation

{$R *.DFM}

 Uses
  DT_Const, DT_Dict, DT_Link,
  l3DatLst;

Constructor TKWLinkDlg.CreateParam(AOwner: TComponent; aKW_ID : Longint);
 Var
  SL : TStrings; {DataList;}
 Begin
  Inherited Create(AOwner);
  SL:=KWLinkList.Items;
  TKWDesignerDlg(Owner).LinkServ.GetKeyWordListOnTheme(aKW_ID,SL);
  KW_ID:=aKW_ID;
 end;

procedure TKWLinkDlg.SingleModeBtnClick(Sender: TObject);
 Var
  I : Longint;
  SData : TObject;
  SL : TStrings;
  DSize : Word;
 begin
  If Not AllKWList.Visible
   then
    Begin
     If AllKWList.Total=0
      then
       Begin
        {Tl3StringDataList(AllKWList.Items).FullAssignStrList:=True;}
        {AllKWList.Items.DataSize:=4;}
        {AllKWList.Items.Assign(TKWDesignerDlg(Owner).DictServ[dlKeyWord]);}

        AllKWList.Items.HostDataList:=TKWDesignerDlg(Owner).KWList.Items.HostDataList;
       end;
     DSize:=TKWDesignerDlg(Owner).KWList.Items.HostDataList.DataSize;
     AllKWList.vlbClearAllItems;
     If KWLinkList.Total > 0 then
      For I:=0 to KWLinkList.Total-1 do
       Begin
        Try
         SData:=KWLinkList.Items.Objects[I];
         AllKWList.Selected[AllKWList.Items.IndexOfData(SData, DSize, 0)]:=True;
        except
        end;
       end;
     AllKWList.Visible:=True;
     KWLinkList.Visible:=False;
     HandleSelect:=False;
    end
   else
    Begin
     SL:=KWLinkList.Items;
     If HandleSelect then TKWDesignerDlg(Owner).LinkServ.SetThemeLinks(KW_ID,AllKWList.Items);
     TKWDesignerDlg(Owner).LinkServ.GetKeyWordListOnTheme(KW_ID,SL);
     AllKWList.Visible:=False;
     KWLinkList.Visible:=True;
    end;
 end;

procedure TKWLinkDlg.AllKWListSelectChange(Sender: TObject; Index: Longint; var Selected: Boolean);
 begin
  HandleSelect:=True;
  {If HandleSelect then Exit;}
 end;

end.
