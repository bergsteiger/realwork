unit F_TextEditor;

{$Include l3Define.inc}

interface

{$INCLUDE ProjectDefine.inc}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  TypInfo,
  StdCtrls,
  Menus,
  ComCtrls,

  vtForm,
  vtScrollBar,                             
  vtStatusBar,
  vtPanel,

  Main,
  W95Meter,
  
  OvcBase, 
  
  evEditorWindow, 
  evCustomEditor,
  evEditor,
  evSubPn,
  evInternalInterfaces,
  evTypes,
  evToolPanel,
  evLinkedToolPanel,
  evRuler,
  evEditorWindowTextSource,
  evTextSource,
  evMultiSelectEditorWindow,
  evEditorWithOperations,
  evTunedEditor,
  evCustomTextSource,
  nevNavigation,

  l3ProgressComponent,
  l3InterfacedComponent,

  afwControl, afwControlPrim, afwBaseControl, afwTextControlPrim,
  afwTextControl, nevControl,
  nevTools, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, l3WinControlCanvas, evCustomEditorWindow,
  vtPanelPrim, evSubPanel;

type
 TEditorElements = (eveHRuller,eveVRuller,eveSubPanel,eveFooter);
 TEditorVisibleElementSet = Set of TEditorElements;

 TTextEditorWin = class;
 TCursorInReference = procedure(aSender : TTextEditorWin; const aHyperlink : IevHyperlink) of object;

 TTextEditorWin = class(TvtFrame)
   HRuler: TevRuler;
   VRuler: TevRuler;
   SubShowPanel: TevSubPanel;
   DocEditor: TevEditor;
   pmRuller: TPopupMenu;
   miInch: TMenuItem;
   miCm: TMenuItem;
   miChar: TMenuItem;
   FooterPanel: TvtStatusBar;
   PercentMeter: TW95Meter;
    ScrollerPanel: TPanel;

   procedure TextSourceChangeModified(Sender: TObject);
   procedure PercentMeterSetStr(const aStr: string);
   procedure DocEditorResize(Sender: TObject);
   procedure DocEditorCursorChange(Sender: TObject);
   procedure miUnitsClick(Sender: TObject);
   function  GetTextSource : TevEditorWindowTextSource;
   function  IsTextModified : Boolean;
   procedure SetTextSource(aValue : TevEditorWindowTextSource);
   procedure evntCheckFocusedInPaint(aSender: TObject; var aFocused: Boolean);
   procedure pmRullerPopup(Sender: TObject);
   procedure DocEditorTextSourceChanged(aSender: TObject);
   procedure SetOnTextSourceTune(aEvent : TNotifyEvent);
   //procedure DocEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
    procedure DocEditorMakeTextSource(aSender: TObject;
      out theTextSource: TevCustomTextSource);
 private
  f_HScroll: TvtScrollBar;
  procedure InitHScroll;
 protected
   fReadOnly                : Boolean;
   fOnCursorInReference     : TCursorInReference;
   fOnTextSourceTune        : TNotifyEvent;
   fOnMakeTextSource        : TevMakeTextSourceEvent;
   fLastHyperLinkIDByCursor : Integer;

   procedure SetReadOnly(aValue : Boolean);
   procedure SetVisibleElements(Value : TEditorVisibleElementSet);
   function  GetVisibleElements : TEditorVisibleElementSet;

   procedure TuneTextSource;
 public
   procedure UpdateHRuler;
    {* - Обновить горизонтальную линейку. }
   constructor Create(AOwner: TComponent); override;
    {-}
   property VisibleElements : TEditorVisibleElementSet
    read  GetVisibleElements
    write SetVisibleElements;

   property OnCursorInReference : TCursorInReference
    read  fOnCursorInReference
    write fOnCursorInReference;

   property TextSource: TevEditorWindowTextSource
    read  GetTextSource
    write SetTextSource;

   property OnTextSourceTune : TNotifyEvent
    read  fOnTextSourceTune
    write SetOnTextSourceTune;

   property OnMakeTextSource: TevMakeTextSourceEvent
    read  fOnMakeTextSource
    write fOnMakeTextSource;

   property ReadOnly : Boolean
    read  fReadOnly
    write SetReadOnly;
 end;

implementation

{$R *.DFM}
uses
 IniShop,

 evFacadeCursor,
 evFacadTextSource
 ;

constructor TTextEditorWin.Create(AOwner: TComponent);
var
 l_EditorElem : TEditorVisibleElementSet;
begin
 inherited Create(AOwner);
 l_EditorElem := [eveSubPanel, eveFooter];
 if IniRec.ShowHRuller then
  l_EditorElem := l_EditorElem + [eveHRuller];
 SetVisibleElements(l_EditorElem);
 //TevCustomProgressIndicator(TextSource.Indicator).OnProgressProc := PercentMeter.ProgressProc_ev;
 SubShowPanel.SubDescriptors := MainForm.SubDescriptors;
 //TextSource.PrintDialog := MainForm.PrintDialog;
 DocEditor.OnCheckFocusedInPaint := evntCheckFocusedInPaint;
 DocEditor.OnTextSourceChanged := DocEditorTextSourceChanged;
 InitHScroll;
end;

procedure TTextEditorWin.SetVisibleElements(Value : TEditorVisibleElementSet);
 begin  
  HRuler.Visible       := (eveHRuller  in Value);
  VRuler.Visible       := eveVRuller  in Value;
  SubShowPanel.Visible := eveSubPanel in Value;
  FooterPanel.Visible  := eveFooter   in Value;
 end;

function  TTextEditorWin.GetVisibleElements : TEditorVisibleElementSet;
 begin
  Result := [];
  If HRuler.Visible then Include(Result, eveHRuller);
  If VRuler.Visible then Include(Result, eveVRuller);
  If SubShowPanel.Visible then Include(Result, eveSubPanel);
  If FooterPanel.Visible then Include(Result, eveFooter);
 end;

procedure TTextEditorWin.TextSourceChangeModified(Sender: TObject);
 begin
 if TextSource.Modified then 
  FooterPanel.Panels[1].Text := '*'
 else 
  FooterPanel.Panels[1].Text := ' ';
 end;

procedure TTextEditorWin.PercentMeterSetStr(const aStr: string);
 begin
  if (FooterPanel <> nil)
   then FooterPanel.Panels[2].Text := aStr;
 end;

procedure TTextEditorWin.DocEditorResize(Sender: TObject);
begin
 ScrollerPanel.Left := FooterPanel.Width - ScrollerPanel.Width;
end;

procedure TTextEditorWin.DocEditorCursorChange(Sender: TObject);
var
 I             : Integer;
 l_Hyperlink   : IevHyperlink;
 l_HyperlinkID : Integer;
begin
 if DocEditor = nil then Exit;
 I := evGetMostInnerPos(DocEditor);
 if I = MaxInt then
  I := 0
 else
  Inc(I);

 FooterPanel.Panels[0].Text := Format('Поз: %d',[I]);

 l_Hyperlink := DocEditor.Range.Hyperlink;
 if l_Hyperlink <> nil then
  l_HyperlinkID := l_Hyperlink.ID
 else
  l_HyperlinkID := 0;

 if fLastHyperlinkIDByCursor <> l_HyperlinkID then
 begin
  fLastHyperlinkIDByCursor := l_HyperlinkID;
  If Assigned(fOnCursorInReference) then
   fOnCursorInReference(Self, l_Hyperlink);
 end;           
 
end;

procedure TTextEditorWin.miUnitsClick(Sender: TObject);
var
 S          : string;
 l_Ruler    : TevRuler;
 l_SelUnits : TevUnits;
begin
 S := TComponent(Sender).Name;
 S := 'ev_un' + System.Copy(S, 3, Length(S) - 2);
 l_Ruler := ((Sender as TMenuItem).Parent.Owner as TPopupMenu).PopupComponent as TevRuler;
 l_SelUnits := TevUnits(GetEnumValue(TypeInfo(TevUnits), S));
 l_Ruler.Units := l_SelUnits;
 if l_Ruler.Units = l_SelUnits then
  TMenuItem(Sender).Checked := True;
end;

function  TTextEditorWin.GetTextSource : TevEditorWindowTextSource;
begin
 Result := DocEditor.TextSource as TevEditorWindowTextSource;
end;

function  TTextEditorWin.IsTextModified : Boolean;
begin
 Result := DocEditor.HasTextSource and DocEditor.TextSource.Modified;
end;

procedure TTextEditorWin.TuneTextSource;
var
 lTextSource : TevCustomTextSource;
begin
 if not DocEditor.HasTextSource then Exit;
 lTextSource := DocEditor.TextSource;
 (lTextSource as TevEditorWindowTextSource).OnChangeModified := TextSourceChangeModified;
 TevCustomProgressIndicator(lTextSource.Indicator).NeedProgressProc := True;
 TevCustomProgressIndicator(lTextSource.Indicator).OnProgressProc := PercentMeter.ProgressProc_ev;
 lTextSource.PrintDialog := MainForm.PrintDialog;
 evSetShowDocumentParts(DocEditor, lTextSource, IniRec.ShowDocumentParts);
 //lTextSource.Processor.ReadOnly := fReadOnly;
end;

procedure TTextEditorWin.SetTextSource(aValue : TevEditorWindowTextSource);
begin
 if DocEditor.TextSource = aValue then Exit;
 DocEditor.TextSource := aValue;
 TuneTextSource;
end;

procedure TTextEditorWin.evntCheckFocusedInPaint(aSender: TObject; var aFocused: Boolean);
begin
 aFocused := aFocused or MainForm.IsEditorInFocus(aSender as TControl);
end;

procedure TTextEditorWin.SetReadOnly(aValue : Boolean);
begin
 if fReadOnly = aValue then Exit;
 fReadOnly := aValue;
 DocEditor.ReadOnly := fReadOnly;

 if aValue or not IniRec.ShowHRuller then
   VisibleElements := VisibleElements - [eveHRuller]
 else VisibleElements := VisibleElements + [eveHRuller];

end;

procedure TTextEditorWin.UpdateHRuler;
begin
 if not IniRec.ShowHRuller then
  VisibleElements := VisibleElements - [eveHRuller]
 else 
  if not ReadOnly then
   VisibleElements := VisibleElements + [eveHRuller];                
end;

procedure TTextEditorWin.pmRullerPopup(Sender: TObject);
var
 i           : Integer;
 l_Str       : string;
 l_Ruler     : TevRuler;
 l_MenuItem  : TComponent;
 l_PopupMenu : TPopupMenu;
begin
 l_PopupMenu := Sender as TPopupMenu;
 l_Ruler := l_PopupMenu.PopupComponent as TevRuler;
 l_Str := GetEnumName(TypeInfo(TevUnits), Ord(l_Ruler.Units));
 l_Str := 'mi' + System.Copy(l_Str, 6, Length(l_Str) - 5);
 l_MenuItem := nil;
 for i := 0 to l_PopupMenu.Items.Count - 1 do
  if l_PopupMenu.Items[i].Name = l_Str then
  begin
   l_MenuItem := l_PopupMenu.Items[i];
   Break;
  end;
 Assert(l_MenuItem <> nil);
 (l_MenuItem as TMenuItem).Checked := True;
end;

procedure TTextEditorWin.DocEditorMakeTextSource(aSender: TObject; out theTextSource: TevCustomTextSource);
begin
 if Assigned(fOnMakeTextSource) then
  fOnMakeTextSource(Self, theTextSource);
 TuneTextSource;
end;

procedure TTextEditorWin.DocEditorTextSourceChanged(aSender: TObject);
begin
 if Assigned(fOnTextSourceTune) then
  fOnTextSourceTune(Self);
 TuneTextSource;
end;

procedure TTextEditorWin.SetOnTextSourceTune(aEvent : TNotifyEvent);
begin
 fOnTextSourceTune := aEvent;
 if (DocEditor <> nil) and (DocEditor.HasTextSource) then
  fOnTextSourceTune(self);
end;

procedure TTextEditorWin.InitHScroll;
begin
 f_HScroll := TvtScrollBar.Create(ScrollerPanel);
 ScrollerPanel.InsertControl(f_HScroll);
 with f_HScroll do
 begin
  ScrollBarKind := sbHorizontal;
  Max := 0;
  PageSize := 0;
  SmallChange := 150;
  Visible := True;
 end; // with f_HScroll do
 DocEditor.HScrollBar := f_HScroll;
end;

end.

