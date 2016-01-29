unit fcOutlookBar;
{
//
// Components : TfcOutlookBar
//
// Copyright (c) 1999 by Woll2Woll Software
//
// 5/12/99 - RSW - Repaint current selection if its a non-rectangular button
}

interface

uses Messages, Windows, Graphics, Classes, Forms, Controls, SysUtils, fcCommon, fcButtonGroup,
  ExtCtrls, fcCollection, Dialogs, fcClearPanel, ComCtrls, fcOutlookList, fcImgBtn, fcButton,
  fcImager, fcChangeLink, fcShapeBtn;

{$i fcIfDef.pas}

type
  TfcOutlookPage = class;

  TfcCustomOutlookBar = class;

  TfcAnimation = class(TPersistent)
  private
    FEnabled: Boolean;
    FInterval: Integer;
    FSteps: Integer;
  public
    constructor Create;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Interval: Integer read FInterval write FInterval;
    property Steps: Integer read FSteps write FSteps;
  end;

  TfcOutlookPage = class(TfcButtonGroupItem)
  private
    FPanel: TfcOutlookPanel;
    FOutlookList: TfcOutlookList;
  protected
    function GetOutlookBar: TfcCustomOutlookBar; virtual;
    procedure SetIndex(Value: Integer); override;
    procedure Loaded; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure CreateOutlookList; virtual;
    procedure GotSelected; override;

    property OutlookBar: TfcCustomOutlookBar read GetOutlookBar;
    property OutlookList: TfcOutlookList read FOutlookList;
    property Panel: TfcOutlookPanel read FPanel write FPanel;
  end;

  TfcOutlookPages = class(TfcButtonGroupItems)
  protected
    function GetOutlookBar: TfcCustomOutlookBar; virtual;
    function GetItems(Index: Integer): TfcOutlookPage;
    procedure AnimateSetBounds(Control: TWinControl; Rect: TRect); virtual;
  public
    constructor Create(AButtonGroup: TfcCustomButtonGroup; ACollectionItemClass: TfcButtonGroupItemClass); override;
    procedure ArrangeControls; override;
    function Add: TfcOutlookPage;
    function AddItem: TfcCollectionItem; override;

    property OutlookBar: TfcCustomOutlookBar read GetOutlookBar;
    property Items[Index: Integer]: TfcOutlookPage read GetItems; default;
  end;

  TfcCustomOutlookBarOption = (cboAutoCreateOutlookList, cboTransparentPanels);
  TfcCustomOutlookBarOptions = set of TfcCustomOutlookBarOption;

  TfcPanelAlignment = (paDynamic, paTop, paBottom);

  TfcCustomOutlookBar = class(TfcCustomButtonGroup)
  private
    // Property Storage Variables
    FAnimation: TfcAnimation;
    FAnimatingControls: Boolean;
    FAnimationLock: Integer;
    FButtonSize: Integer;
    FImager: TfcCustomImager;
    FOptions: TfcCustomOutlookBarOptions;
    FPanelAlignment: TfcPanelAlignment;
    FShowButtons: Boolean;

    FChangeLink: TfcChangeLink;

    // Property Access Methods
    function GetActivePage: TfcCustomBitBtn;
    function GetItems: TfcOutlookPages;
    procedure SetActivePage(Value: TfcCustomBitBtn);
    procedure SetAnimatingControls(Value: Boolean);
    procedure SetButtonSize(Value: Integer);
    procedure SetImager(Value: TfcCustomImager);
    procedure SetItems(Value: TfcOutlookPages);
    procedure SetOptions(Value: TfcCustomOutlookBarOptions); virtual;
    procedure SetPanelAlignment(Value: TfcPanelAlignment); virtual;
    procedure SetShowButtons(Value: Boolean);
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND; { 3/12/99 RSW - Need to prevent flicker }
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    function GetCollectionClass: TfcButtonGroupItemsClass; override;
    procedure WndProc(var Message: TMessage); override;

    // Overridden methods
    function ResizeToControl(Control: TControl; DoResize: Boolean): TSize; override;
    procedure ButtonPressed(Sender: TObject); override;
    procedure CreateWnd; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ImagerChange(Sender: TObject);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Paint; override;

    // Overridden property access methods
    procedure SetName(const NewName: TComponentName); override;
    function IsNonRectangularButton(Control: TControl): boolean; virtual;
  public
    Patch: Variant;
//    InPaste: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function InAnimation: Boolean; virtual; { Button presses so begin animation, include 1 step }
    procedure EnableAnimation;
    procedure DisableAnimation;

    property ActivePage: TfcCustomBitBtn read GetActivePage write SetActivePage;
    property Animation: TfcAnimation read FAnimation write FAnimation;
    property AnimatingControls: Boolean read FAnimatingControls write SetAnimatingControls;
    property ButtonSize: Integer read FButtonSize write SetButtonSize;
    property Canvas;
    property Color;
    property Imager: TfcCustomImager read FImager write SetImager;
    property OutlookItems: TfcOutlookPages read GetItems write SetItems stored False;
    property Options: TfcCustomOutlookBarOptions read FOptions write SetOptions;
    property PanelAlignment: TfcPanelAlignment read FPanelAlignment write SetPanelAlignment;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons;
  end;

  TfcOutlookBar = class(TfcCustomOutlookBar)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}

    property ActivePage;
    property Align;
    property Animation;
    property AutoBold;
    property BevelInner;
    property BevelOuter;
    property BorderStyle nodefault;
    property ButtonSize;
    property ButtonClassName;
    property Color;
    property Font;
    property ParentFont;
    property Imager;
    property OutlookItems;
    property Layout;
    property Options;
    property PanelAlignment;
    property ShowButtons;
    property TabOrder;
    property TabStop default True;  //7/30/99 - Support TabStop = False
    property Visible;
//    property Transparent; { 3/13/99 - RSW - Not supported}

    property OnChange;
    property OnChanging;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
  end;

implementation

constructor TfcAnimation.Create;
begin
  inherited;
  FEnabled := True;
  FInterval := 1;
  FSteps := 7;
end;

constructor TfcOutlookPage.Create(Collection: TCollection);
begin
  inherited;
  if not (csLoading in ButtonGroup.ComponentState) then
  begin
    ButtonGroup.ButtonItems.ArrangingControls := True;
    FPanel := TfcOutlookPanel.Create(ButtonGroup);
//    FPanel.Name := fcGenerateName(FPanel.Owner, ButtonGroup.Name + 'Panel');
    FPanel.Parent := ButtonGroup;
    FPanel.Visible := False;
    FPanel.SendToBack;
    FPanel.Top := -FPanel.Height - 10;
    FPanel.OutlookPage := self;
//    FPanel.BevelOuter := bvNone;
    if cboAutoCreateOutlookList in OutlookBar.Options then
      CreateOutlookList;
    ButtonGroup.ButtonItems.ArrangingControls := False;
  end;
end;

destructor TfcOutlookPage.Destroy;
begin
  OutlookBar.FItems.DeletingControl := True;
  FPanel.Free;
  OutlookBar.FItems.DeletingControl := False;
  inherited;
end;

procedure TfcOutlookPage.SetIndex(Value: Integer);
begin
  inherited;
  if not (csLoading in ButtonGroup.ComponentState) then OutlookBar.SetChildOrder(Panel, Value);
end;

function TfcOutlookPage.GetOutlookBar: TfcCustomOutlookBar;
begin
  result := TfcCustomOutlookBar(ButtonGroup);
end;

procedure TfcOutlookPage.Loaded;
begin
  Panel.Owner.RemoveComponent(Panel);
  ButtonGroup.InsertComponent(Panel);
  Panel.OutlookPage := self;
  if FOutlookList <> nil then FOutlookList.OutlookPage := self;
end;

procedure TfcOutlookPage.CreateOutlookList;
begin
  if FOutlookList <> nil then Exit;
  FOutlookList := TfcOutlookList.Create(GetParentForm(OutlookBar));
  with FOutlookList do
  begin
    Parent := FPanel;
    Align := alClient;
    BorderStyle := bsNone;
    Name := fcGenerateName(GetParentForm(self.OutlookBar), self.OutlookBar.Name + 'OutlookList');
    OutlookPage := self;
  end;
end;

procedure TfcOutlookPage.GotSelected;
begin
  Selected := True;
  TfcButtonGroupItems(Collection).ArrangeControls;
end;

constructor TfcOutlookPages.Create(AButtonGroup: TfcCustomButtonGroup; ACollectionItemClass: TfcButtonGroupItemClass);
begin
  inherited Create(AButtonGroup, TfcOutlookPage);
end;

function TfcOutlookPages.GetOutlookBar: TfcCustomOutlookBar;
begin
  result := TfcCustomOutlookBar(ButtonGroup);
end;

function TfcOutlookPages.GetItems(Index: Integer): TfcOutlookPage;
begin
  result := TfcOutlookPage(inherited Items[Index]);
end;

procedure TfcOutlookPages.AnimateSetBounds(Control: TWinControl; Rect: TRect);
begin
  if Control is TfcOutlookPanel then
  begin
    if Control is TfcOutlookPanel then TfcOutlookPanel(Control).FPreventUpdate := True;
    Control.BoundsRect := Rect;
    if Control is TfcOutlookPanel then TfcOutlookPanel(Control).FPreventUpdate := False;
  end else begin
    with Rect do SetWindowPos(Control.Handle, 0, Left, Top, Right - Left, Bottom - Top, SWP_NOZORDER or SWP_NOREDRAW);
    InvalidateRect(Control.Handle, nil, False);
  end;
end;

type TfcOutlookButton = class(TfcCustomBitBtn);

procedure TfcOutlookPages.ArrangeControls;
var i: Integer;
    ControlTop: Integer;
    List: TList;
    Item: TfcGroupAnimateItem;
    CurItem: TfcOutlookPage;
    PanelHeight: Integer;
    OldPanel: TfcOutlookPanel;
    OldPanelIndex: integer;
    ASteps, AInterval: Integer;
    ButtonRect: TRect;
    InvalidButton: TWinControl;
  //4/15/99 - PYW - Check to see if any child of one of the Outlookpages has a control with the
  //                align property not set to alNone.
  function ChildHasAlignmentSet: boolean;
  var alignset:boolean;
      i,j:integer;
  begin
    alignset := False;
    for i := 0 to Count - 1 do
       with TfcOutlookPage(Items[i]), Panel do
       begin
         if OutlookList = nil then
         begin
            for j:=0 to ControlCount - 1 do
            begin
               if Controls[j].Align <> alNone then begin
                  alignset := True;
                  break;
               end;
            end;
         end;
       end;
       result := alignset;
  end;

{  function IsNonRectangularButton(Control: TControl): boolean;
  var button: TfcCustomImageBtn;
  begin
     result:= False;
     if (Control is TfcCustomImageBtn) then
     begin
        button:= TfcCustomImageBtn(control);
         if ((Control is TfcCustomShapeBtn) and
            ((Control as TfcCustomShapeBtn).Shape <> bsRect)) then result:= True
         else if (not (Control is TfcCustomShapeBtn) and
            (button.TransparentColor <> clNullColor)) then result:= True
     end
  end;
}
  procedure CleanUp;
  var i:integer;
  begin
    ArrangingControls := False;
    OutlookBar.AnimatingControls := False;
    List.Free;
    for i := 0 to Count - 1 do
      with TfcOutlookPage(Items[i]) do
        if OutlookList <> nil then OutlookList.ScrollButtonsVisible := True;
  end;

begin
  if ArrangingControls or AddingControls then Exit;
  ArrangingControls := True;
//  OutlookBar.AnimatingControls := True; { Don't use this flag, RSW }

  if OutlookBar.Layout = loVertical then PanelHeight := ButtonGroup.ClientHeight
  else PanelHeight := ButtonGroup.ClientWidth;
  PanelHeight := PanelHeight - VisibleCount * OutlookBar.ButtonSize;

  List := TList.Create;

  ControlTop := 0;
  if OutlookBar.PanelAlignment = paTop then inc(ControlTop, PanelHeight);

  OldPanel := nil;
  OldPanelIndex:= -1;
  for i := 0 to Count - 1 do
    with TfcOutlookPage(Items[i]), Panel do
    begin
      if OutlookList <> nil then OutlookList.ScrollButtonsVisible := False;
      if Visible then begin
        OldPanel := TfcOutlookPage(Items[i]).Panel;
        OldPanelIndex:= i;
      end
      else begin
        Visible := False;
        Top := -Height;
      end;
    end;

  if not OutlookBar.ShowButtons then
  begin
    if OldPanel <> nil then OldPanel.Visible := False;
    if OutlookBar.Selected <> nil then with (OutlookBar.Selected as TfcOutlookPage).Panel do
    begin
      BoundsRect := OutlookBar.ClientRect;
      Visible := True;
    end;
    CleanUp;
    exit;
  end;

  for i := 0 to VisibleCount - 1 do with OutlookBar do
  begin
    CurItem := TfcOutlookPage(VisibleItems[i]);
    Item := TfcGroupAnimateItem.Create;
    Item.MainItem := TfcAnimateListItem.Create;
    Item.MainItem.Control := CurItem.Button;
    Item.MainItem.OrigRect := CurItem.Button.BoundsRect;
    Item.SecondItem := nil;
    if Layout = loVertical then
      Item.MainItem.FinalRect := Rect(0, ControlTop, ClientWidth, ControlTop + ButtonSize)
    else Item.MainItem.FinalRect := Rect(ControlTop, 0, ControlTop + ButtonSize, ClientHeight);

    if CurItem.Selected or ((OldPanel <> nil) and (OldPanel = CurItem.Panel)) then
    begin
      with CurItem.Button.BoundsRect do
        if CurItem.Selected then case PanelAlignment of
          paDynamic: if Layout = loVertical then CurItem.Panel.BoundsRect := Rect(Left, Bottom, Right, Bottom)
                 else CurItem.Panel.BoundsRect := Rect(Right, Top, Right, Bottom);
          paTop: if Layout = loVertical then CurItem.Panel.BoundsRect := Rect(Left, 0, Right, 0)
                 else CurItem.Panel.BoundsRect := Rect(0, Top, 0, Bottom);
          paBottom: if Layout= loVertical then CurItem.Panel.BoundsRect := Rect(Left, ClientHeight - PanelHeight, Right, ClientHeight - PanelHeight)
                 else CurItem.Panel.BoundsRect := Rect(ClientWidth - PanelHeight, Top, ClientWidth - PanelHeight, Bottom);
        end;
      CurItem.Panel.Visible := True;

      Item.SecondItem := TfcAnimateListItem.Create;
      Item.SecondItem.Control := CurItem.Panel;
      Item.SecondItem.OrigRect := CurItem.Panel.BoundsRect;

      if CurItem.Selected then
      begin
        with Item.MainItem.FinalRect do case OutlookBar.PanelAlignment of
          paDynamic: begin
            if Layout = loVertical then Item.SecondItem.FinalRect := Rect(Left, Bottom, Right, Bottom + PanelHeight)
            else Item.SecondItem.FinalRect := Rect(Right, Top, Right + PanelHeight, Bottom);
            inc(ControlTop, PanelHeight);
          end;
          paTop: if Layout = loVertical then Item.SecondItem.FinalRect := Rect(Left, 0, Right, PanelHeight)
            else Item.SecondItem.FinalRect := Rect(0, Top, PanelHeight, Bottom);
          paBottom: if Layout = loVertical then Item.SecondItem.FinalRect := Rect(Left, OutlookBar.ClientHeight - PanelHeight, Right, OutlookBar.ClientHeight)
            else Item.SecondItem.FinalRect := Rect(OutlookBar.ClientWidth - PanelHeight, Top, OutlookBar.ClientWidth, Bottom);
        end;
      end else with Item.MainItem.FinalRect do begin
        if Layout = loVertical then Item.SecondItem.FinalRect := Rect(Left, Bottom, Right, Bottom)
        else Item.SecondItem.FinalRect := Rect(Right, Top, Right, Bottom);
      end;
    end;

    inc(ControlTop, OutlookBar.ButtonSize);

    List.Add(Item);
  end;

  ASteps := OutlookBar.Animation.Steps;
  AInterval := OutlookBar.Animation.Interval;
  //4/15/99 - PYW - Check to see if any child of one of the Outlookpages has a control with the
  //                align property not set to alNone.
  if not OutlookBar.InAnimation or (csDesigning in OutlookBar.ComponentState) or
     not OutlookBar.Animation.Enabled or ChildHasAlignmentSet then
  begin
    OutlookBar.AnimatingControls := False;
    ASteps := 1;
    AInterval := 0;
  end;

  for i:= 0 to count-1 do
     TfcOutlookButton(Items[i].Button).DisableButton:= True;

  fcAnimateControls(OutlookBar, OutlookBar.Canvas, List, AInterval, ASteps, AnimateSetBounds);

  if (OldPanel <> nil) and (OutlookBar.Selected <> nil) and ((OutlookBar.Selected as TfcOutlookPage).Panel <> OldPanel) then
  begin
    OldPanel.Visible := False;
    OldPanel.Top := -OutlookBar.Height;
  end;

  for i := 0 to List.Count - 1 do
    with TfcGroupAnimateItem(List[i]) do
    begin
      if SecondItem <> nil then
      begin
{         if SecondItem.Control.Visible then with SecondItem.Control do
         begin
           for j := 0 to ControlCount - 1 do
             if IsNonRectangularButton(Controls[j]) then
             begin
               r := SecondItem.Control.Controls[j].BoundsRect;
               InvalidateRect(SecondItem.Control.Handle, @r, False);
             end;
         end;}
         SecondItem.Free;
      end;
      MainItem.Free;
      Free;
    end;

  CleanUp;
  for i:= 0 to count-1 do
     TfcOutlookButton(Items[i].Button).DisableButton:= False;

{  if (ASteps=1) and (Outlookbar.Selected<>nil) and
     (OldPanelIndex<OutlookBar.Selected.Index) then
  begin
     InvalidButton:= OutlookBar.Selected.Button;
     if (InvalidButton<>nil) and
        OutlookBar.IsNonRectangularButton(InvalidButton) then
     begin
        ButtonRect:= InvalidButton.BoundsRect;
        InvalidateRect(OutlookBar.Handle, @ButtonRect, True);
     end
  end;
}
  { 5/12/99 - RSW - Clear background for any background area of image shaped buttons,
    and execute code even for steps=1 }
  { Repaint current selection if its a non-rectangular button}
  if (ASteps>=1) and (OldPanelIndex>=0) and (OutlookBar.Selected<>nil) then
  begin
     { This button needs to be repainted if its a shape button }
     if OldPanelIndex<OutlookBar.Selected.index then
     begin
        { Repaint OldPanelIndex + 1 to Seleccted.Index }
        for i:= OldPanelIndex+1 to OutlookBar.Selected.Index do
        begin
           InvalidButton:= TfcOutlookPage(Items[i]).Button;
           if not OutlookBar.IsNonRectangularButton(InvalidButton) then continue;
           ButtonRect:= InvalidButton.BoundsRect;
           InvalidateRect(OutlookBar.Handle, @ButtonRect, True);
        end
     end
     else begin
        { Repaint SelectedIndex + 1 to OldPanelIndex }
        for i:= OutlookBar.Selected.Index+1 to OldPanelIndex do
        begin
           InvalidButton:= TfcOutlookPage(Items[i]).Button;
           if not OutlookBar.IsNonRectangularButton(InvalidButton) then continue;
           ButtonRect:= InvalidButton.BoundsRect;
           InvalidateRect(OutlookBar.Handle, @ButtonRect, True);
        end
     end
  end

end;

function TfcOutlookPages.Add: TfcOutlookPage;
begin
  result := TfcOutlookPage(inherited Add);
  if Count = 1 then result.GotSelected;
end;

function TfcOutlookPages.AddItem: TfcCollectionItem;
begin
  result := Add;
end;

constructor TfcCustomOutlookBar.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [cboAutoCreateOutlookList];
  FAnimation := TfcAnimation.Create;
  FButtonSize := 20;
  FShowButtons := True;
  FChangeLink := TfcChangeLink.Create;
  FChangeLink.OnChange := ImagerChange;
  AutoBold := False;
  BorderStyle := bsSingle;
end;

destructor TfcCustomOutlookBar.Destroy;
begin
  FAnimation.Free;
  FChangeLink.Free;
  inherited;
end;

procedure TfcCustomOutlookBar.EnableAnimation;
begin
  inc(FAnimationLock);
end;

procedure TfcCustomOutlookBar.DisableAnimation;
begin
  dec(FAnimationLock);
end;

function TfcCustomOutlookBar.GetCollectionClass: TfcButtonGroupItemsClass;
begin
  result := TfcOutlookPages;
end;

function TfcCustomOutlookBar.ResizeToControl(Control: TControl; DoResize: Boolean): TSize;
begin
  result := fcSize(Width, Height);
end;

procedure TfcCustomOutlookBar.ButtonPressed;
begin
  EnableAnimation;
  if FItems.ArrangingControls then
  begin
    if OldSelected <> nil then OldSelected.Button.Down := True;
  end else inherited;
  DisableAnimation;
end;

procedure TfcCustomOutlookBar.CreateWnd;
begin
  inherited;
end;

procedure TfcCustomOutlookBar.GetChildren(Proc: TGetChildProc; Root: TComponent);
var i: Integer;
begin
  inherited;
  for i := 0 to FItems.Count - 1 do
    Proc(TfcOutlookPage(FItems[i]).Panel);
end;

procedure TfcCustomOutlookBar.ImagerChange(Sender: TObject);
begin
  invalidate;
//  inherited;
end;

procedure TfcCustomOutlookBar.Loaded;
var i, j, k: Integer;
begin
  for i := 0 to ControlCount - 1 do
    if Controls[i] is TfcOutlookPanel then
      for j := 0 to FItems.Count - 1 do
        if TfcOutlookPage(FItems[j]).Panel = nil then
          with TfcOutlookPage(FItems[j]) do
        begin
          Panel := Controls[i] as TfcOutlookPanel;
          for k := 0 to Panel.ControlCount - 1 do
            if Panel.Controls[k] is TfcOutlookList then
            begin
              FOutlookList := Panel.Controls[k] as TfcOutlookList;
              Break;
            end;
          Break;
        end;

  inherited;

  FItems.ArrangingControls := True;
  for i := 0 to FItems.Count - 1 do OutlookItems[i].Panel.Visible := False;
  FItems.ArrangingControls := False;
  FItems.ArrangeControls;
end;

procedure TfcCustomOutlookBar.Notification(AComponent: TComponent; AOperation: TOperation);
var i: Integer;
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = FImager) then
  begin
     FImager := nil;
     if not (csDestroying in ComponentState) then Invalidate;
  end
  else if (AOperation = opRemove) and not (csDestroying in ComponentState) then
    for i := 0 to FItems.Count - 1 do
      if AComponent = OutlookItems[i].OutlookList then
      begin
        OutlookItems[i].FOutlookList := nil;
        Break;
      end;
end;

procedure TfcCustomOutlookBar.Paint;
var i, j: Integer;
    TmpRgn, ClipRgn: HRGN;
    ir, r, r1: TRect;
    curPanel: TfcOutlookPanel;

    function HaveNonRectangularOutlookButton: boolean;
    var i: integer;
    begin
       result:= False;
       for i := 0 to OutlookItems.Count - 1 do
       begin
           if IsNonRectangularButton(OutlookItems[i].Button) then
           begin
              result:= True;
              break;
           end
       end
    end;

begin
  if (OutlookItems.Count = 0) and (Imager = nil) then
  begin
    inherited;
    Exit;
  end;

  if (FImager <> nil) or
     { 5/2/99 - RSW - Go into this path if contain non-rectangular outlook button
       Can likely go into this path even in rectangular case, but this would
       require more testing }
      HaveNonRectangularOutlookButton then
  begin
    if not AnimatingControls then
    begin
      { Clip out outlookbuttons and visible panel's child controls from imager's area to paint }
      ClipRgn := CreateRectRgn(0, 0, 0, 0);

      for i := 0 to OutlookItems.Count - 1 do
      begin
        // 4/19/99 Changed to get button's region, instead of just its rectangle
        with OutlookItems[i].Button do
        begin
          TmpRgn := TfcOutlookButton(OutlookItems[i].Button).CreateRegion(False, Down);
          OffsetRgn(TmpRgn, Left, Top);
        end;
        CombineRgn(ClipRgn, ClipRgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);

        with OutlookItems[i], Panel do
          if Visible then
          begin
             if FImager=nil then
             begin
               TmpRgn := CreateRectRgn(Panel.Left, Panel.Top, Panel.Left + Panel.Width, Panel.Top + Panel.Height);
               CombineRgn(ClipRgn, ClipRgn, TmpRgn, RGN_OR); { Only paint button area }
               DeleteObject(TmpRgn);
             end;
            fcGetChildRegions(Panel, False, ClipRgn, Point(Left, Top), RGN_OR);
          end;
      end;
      TmpRgn := CreateRectRgn(0, 0, ClientWidth, ClientHeight);
      CombineRgn(ClipRgn, TmpRgn, ClipRgn, RGN_DIFF);
      DeleteObject(TmpRgn);
      SelectClipRgn(Canvas.Handle, ClipRgn);
      DeleteObject(ClipRgn);  //4/2/99 - Does not seem neccesary

    end;

    if (FImager <> nil) then
    begin
       if FImager.WorkBitmap.Empty then FImager.UpdateWorkBitmap;

       if FImager.DrawStyle=dsTile then
          FImager.WorkBitmap.TileDraw(Canvas, ClientRect)
       else
          Canvas.StretchDraw(ClientRect, FImager.WorkBitmap);
    end
    else begin
       Canvas.Brush.Color:= Color;
       Canvas.FillRect(ClientRect);
    end;
    SelectClipRgn(Canvas.Handle, 0);
  end else if (csDesigning in ComponentState) then inherited;

  if (csDesigning in ComponentState) or (csDestroying in ComponentState) or (FItems = nil) then Exit;

  // Code in here to prevent the Child controls in the panel from going invisible
//  exit;
  for i := 0 to FItems.Count - 1 do
    if TfcOutlookPage(FItems[i]).Panel.Visible then
    begin
      with TfcOutlookPage(FItems[i]).Panel do
      begin
        curPanel:= TfcOutlookPage(FItems[i]).Panel;
        for j := 0 to ControlCount - 1 do if Controls[j] is TWinControl then
        begin
          r := Controls[j].BoundsRect;
          offsetRect(r, left, top); { Adjust to outlookbar coordinates }

          with self.Canvas.ClipRect do
          begin
            r1:= self.canvas.cliprect;
            if IntersectRect(ir, r1, r) then {or
//          if fcRectInRect(r, self.Canvas.ClipRect) then
//            if PtInRect(r, TopLeft) or PtInRect(r, BottomRight) or
//               PtInRect(r, Point(Right, Top)) or PtInRect(r, Point(Left, Bottom)) then}
            begin
              IntersectRect(r, self.Canvas.ClipRect, r);
              offsetRect(r, -curPanel.left, -curPanel.top); { Adjust to outlookbar coordinates }
              offsetRect(r, -Controls[j].BoundsRect.Left, -Controls[j].BoundsRect.top);
              InvalidateRect((Controls[j] as TWinControl).Handle, @r, False);
            end
          end
        end;
      end;
      Break;
    end;
end;

function TfcCustomOutlookBar.InAnimation: Boolean;
begin
  result := not (FAnimationLock = 0);
end;

function TfcCustomOutlookBar.GetActivePage: TfcCustomBitBtn;
begin
  result := nil;
  if Selected <> nil then result := Selected.Button;
end;

function TfcCustomOutlookBar.GetItems: TfcOutlookPages;
begin
  result := TfcOutlookPages(inherited ButtonItems);
end;

procedure TfcCustomOutlookBar.SetActivePage(Value: TfcCustomBitBtn);
begin
  Selected := FItems.FindButton(Value);
end;

procedure TfcCustomOutlookBar.SetAnimatingControls(Value: Boolean);
var i: Integer;
begin
  FAnimatingControls := Value;
  for i := 0 to OutlookItems.Count - 1 do
    OutlookItems[i].Panel.Animating := Value;
end;

procedure TfcCustomOutlookBar.SetButtonSize(Value: Integer);
begin
  if FButtonSize <> Value then
  begin
    FButtonSize := Value;
    FItems.ArrangeControls;
  end;
end;

procedure TfcCustomOutlookBar.SetImager(Value: TfcCustomImager);
begin
  if FImager <> nil then FImager.UnRegisterChanges(FChangeLink);
  if Value<>FImager then
  begin
     FImager := Value;
     if Value <> nil then
     begin
       Value.FreeNotification(self);
       Value.RegisterChanges(FChangeLink);
       Value.Parent := self;
       Value.Align := alNone;
//       if Value.DrawStyle <> dsStretch then
          Value.DrawStyle := dsTile;
       Value.Left:= 0;
       Value.Top:= 0;
       Value.Width:= 25;
       Value.Height:= 25;
       Value.Transparent:= False; { 4/30/99 }

       Value.Visible := False;
     end;
     Invalidate; { 4/20/99 RSW }
  end
end;

procedure TfcCustomOutlookBar.SetItems(Value: TfcOutlookPages);
begin
  inherited ButtonItems := Value;
end;

procedure TfcCustomOutlookBar.SetName(const NewName: TComponentName);
var i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    if Copy(OutlookItems[i].Panel.Name, 1, Length(Name)) = Name then
      OutlookItems[i].Panel.Name := NewName + fcSubstring(OutlookItems[i].Panel.Name, Length(Name) + 1, 0);
    if (cboAutoCreateOutlookList in Options) and
       (OutlookItems[i].Panel.ControlCount > 0) and (OutlookItems[i].Panel.Controls[0] is TListView) and
       (Copy(OutlookItems[i].Panel.Controls[0].Name, 1, Length(Name)) = Name) then
      OutlookItems[i].Panel.Controls[0].Name := NewName + fcSubstring(OutlookItems[i].Panel.Controls[0].Name, Length(Name) + 1, 0);
  end;
  inherited;
end;

procedure TfcCustomOutlookBar.SetOptions(Value: TfcCustomOutlookBarOptions);
var ChangedOptions: TfcCustomOutlookBarOptions;
begin
  if FOptions <> Value then
  begin
    ChangedOptions := (FOptions - Value) + (Value - FOptions);
    FOptions := Value;
{    if not (csLoading in ComponentState) and (cboTransparentPanels in ChangedOptions) then
      for i := 0 to FItems.Count - 1 do OutlookItems[i].Panel.Transparent := cboTransparentPanels in FOptions;}
  end;
end;

procedure TfcCustomOutlookBar.SetPanelAlignment(Value: TfcPanelAlignment);
begin
  if FPanelAlignment <> Value then
  begin
    FPanelAlignment := Value;
    if not (csLoading in ComponentState) then FItems.ArrangeControls;
  end;
end;

procedure TfcCustomOutlookBar.SetShowButtons(Value: Boolean);
var i: Integer;
begin
  if FShowButtons <> Value then
  begin
    FShowButtons := Value;
    if not (csLoading in ComponentState) then
      for i := 0 to FItems.Count - 1 do with FItems[i].Button do
    begin
      Visible := Value;
      if Value then BringToFront else SendToBack;
    end;
    if not (csLoading in ComponentState) then
    begin
      FItems.ArrangingControls := False;
      FItems.ArrangeControls;
    end;
  end;
end;

procedure TfcCustomOutlookBar.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
end;

procedure TfcCustomOutlookBar.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  if Message.Control is TfcCustomImager then
  begin
    if Message.Inserting then
    begin
       if Imager<>FImager then { RSW }
          Imager := Message.Control as TfcCustomImager;
    end
    else Imager := nil;
  end;
end;

{ 3/12/99 - RSW - Prevent flicker }
procedure TfcCustomOutlookBar.WMEraseBkgnd(var Message: TWMEraseBkGnd);
begin
  Message.result := 1;
end;

procedure TfcCustomOutlookBar.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

procedure TfcCustomOutlookBar.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;  { 4/27/99 }
  Update;
end;

function TfcCustomOutlookBar.IsNonRectangularButton(Control: TControl): boolean;
var button: TfcCustomImageBtn;
begin
   result:= False;
   if (Control is TfcCustomImageBtn) then
   begin
      button:= TfcCustomImageBtn(control);
      if ((Control is TfcCustomShapeBtn) and
         ((Control as TfcCustomShapeBtn).Shape <> bsRect)) then result:= True
      else if (not (Control is TfcCustomShapeBtn) and
         (button.TransparentColor <> clNullColor)) then result:= True
   end
end;

procedure TfcCustomOutlookBar.WndProc(var Message: TMessage);
begin
  inherited;
end;

initialization
  RegisterClasses([TfcOutlookPanel]);
end.

