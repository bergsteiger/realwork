unit ddAppConfigTFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls,
  vtOutliner, OvcBase, afwControl, vtPanel, afwControlPrim,
  afwBaseControl, afwTextControlPrim, afwTextControl
  ;

type
  TTreeFrame = class(TFrame)
    pnlConfTree: TvtPanel;
    procedure ConfigTreeChange(Sender: TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
(*    procedure ConfigTreeStyle(Sender : TObject; aItemIndex : Integer;
                                 const aFont    : Il3Font;
                                 var aTextBackColor : TColor;
                                 var aItemBackColor : TColor;
                                 var aVJustify  : TvtVJustify);*)
  private
    fConfigTree : TvtCustomOutliner;
  public
    WorkFrame: TFrame;
    constructor Create(AOwner : TComponent);
      override;
      {-}
    property ConfigTree : TvtCustomOutliner
      read fConfigTree;
  end;//TTreeFrame

implementation

{$R *.dfm}

uses
  ddAppConfigWFrame,

  l3Tree_TLB,
  l3Base,
  l3String
  ;

procedure TTreeFrame.ConfigTreeChange(Sender: TObject; aNewCurrent : Longint;  aOldCurrent : Longint);
var
 l_Node  : Il3Node;
 l_Index : Integer;
begin
  { перерисовать панель свойств. ƒл€ начала - заголовок }
 if (WorkFrame <> nil) then
 begin
  with (WorkFrame as TWorkFrame) do
  begin
   if (aOldCurrent >= 0) then
   begin
    l_Node := fConfigTree.GetNode(aOldCurrent) As Il3Node;
    l_Index := fConfigTree.CTree.GetAbsIndex(l_Node) - 1;
    if (l_Index >= 0) then
     ComponentsPanel.Controls[l_Index].Visible:= False;
   end;//aOldCurrent >= 0
   if (aNewCurrent >= 0) then
   begin
    l_Node := fConfigTree.GetNode(aNewCurrent) As Il3Node;
    l_Index := fConfigTree.CTree.GetAbsIndex(l_Node) - 1;
    CaptionPanel.CCaption:= l3CStr(l_Node.Text);
    if (l_Index >= 0) then
    begin
     ComponentsPanel.Controls[l_Index].Visible:= True;
     ComponentsPanel.Controls[l_Index].Refresh;
    end;//l_Index >= 0
   end;//aNewCurrent >= 0
  end;//WorkFrame as TWorkFrame
 end//WorkFrame <> nil
end;

constructor TTreeFrame.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 BevelInner := bvNone;
 BevelOuter := bvNone;
 fConfigTree := TvtCustomOutliner.Create(Self);
 fConfigTree.BorderStyle := bsSingle;
 fConfigTree.Parent := pnlConfTree;
 fConfigTree.ReadOnly := True;
 fConfigTree.Align := alClient;
// fConfigTree.HideSelection:= False; // <stub>
 fConfigTree.OnCurrentChanged := ConfigTreeChange;
end;

end.