{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}
{$I gtPTKDefines.inc}

unit gtPDFSearchPanel;                                

interface

uses
  Classes, Controls, ExtCtrls, Graphics, Windows, gtCstPDFDoc, gtPDFViewer, SysUtils,
  gtExProPDFDoc, StdCtrls, gtPDFUtils, Forms, gtPDFConsts {$IFDEF gtDelphi6up}, StrUtils {$ENDIF};

type

  TgtSearchList = class(TListBox)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TgtSearchResultDisplay = class(TCustomPanel)
  private
    FedtResult: TLabel;
    FedtSearchInstances: TEdit;
    FedtSearchText: TEdit;
    FNewSearch: TButton;
    FlblSearchInstances: TLabel;
    FlblSearchText: TLabel;
    property btnNewSearch: TButton read FNewSearch write FNewSearch;
    property lblSearchText: TLabel read FlblSearchText write FlblSearchText;
    property lblSearchInstances: TLabel read FlblSearchInstances write FlblSearchInstances;
    property edtSearchText: TEdit read FedtSearchText write FedtSearchText;
    property edtSearchInstances: TEdit read FedtSearchInstances write FedtSearchInstances;
    property edtResult: TLabel read FedtResult write FedtResult;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TgtSearchDisplay = class(TCustomPanel)
  private
    FbtnSearch: TButton;
    FchkWholeSearch: TCheckBox;
    FchkCaseSearch: TCheckBox;
    FedtSearch: TEdit;
    FlblSearch: TLabel;
    procedure SetbtnSearch(const Value: TButton);
    procedure SetchkCaseSearch(const Value: TCheckBox);
    procedure SetchkWholeSearch(const Value: TCheckBox);
    procedure SetedtSearch(const Value: TEdit);
    procedure SetlblSearch(const Value: TLabel);

  public
    constructor Create(AOwner: TComponent); override;
    property edtSearch: TEdit read FedtSearch write SetedtSearch;
    property btnSearch: TButton read FbtnSearch write SetbtnSearch;
    property chkCaseSearch: TCheckBox read FchkCaseSearch write SetchkCaseSearch;
    property chkWholeSearch: TCheckBox read FchkWholeSearch write SetchkWholeSearch;
    property lblSearch: TLabel read FlblSearch write SetlblSearch;
  end;

  TgtPDFSearchPanel = class(TCustomPanel)
  private
    FSearchPanelDoc: TgtCustomPDFDocument;
    FAbout: string;
    FVersion: string;
    FPDFDocument: TgtCustomPDFDocument;
    FPDFViewer: TgtPDFViewer;
    SearchResult: TgtSearchList;
    SearchDisplay: TgtSearchDisplay;
    SearchResultDisplay: TgtSearchResultDisplay;
    FActive: Boolean;
    FUserSearchFlag: Boolean;
    procedure SetAbout(const Value: string);
    procedure SetPDFDocument(const Value: TgtCustomPDFDocument);
    procedure SetPDFViewer(const Value: TgtPDFViewer);
    procedure SetVersion(const Value: string);
    procedure PopulateListBox;
    procedure SetActive(const Value: Boolean);
    procedure HighLightList;
    procedure SetSearchbtnEnable;
    procedure Refresh;
    procedure SetSearchPanelDoc(const Value: TgtCustomPDFDocument);
    procedure SearchEvent(Sender: TObject; List: TStrings; PageNum: Integer;
      var Continue: Boolean);
    property SearchPanelDoc: TgtCustomPDFDocument read FSearchPanelDoc write SetSearchPanelDoc;
  protected
    procedure OnBtnSearchClick(Sender: TObject);
    procedure OnSearchResultListClick(Sender: TObject);
    procedure OnEditChange(Sender: TObject);
    procedure OnBtnNewSearchClick(Sender: TObject);
    procedure OnSearchPanelResize(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Search(const Asearchtext: string; CaseSearch: Boolean;
      WholeWord: Boolean);
  published
    property About: string read FAbout write SetAbout;
    property Active: Boolean read FActive write SetActive;
    property Align;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Constraints;
    property Ctl3D;
    property Color;
    property UseDockManager default True;
    property DockSite;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PDFDocument: TgtCustomPDFDocument read FPDFDocument write SetPDFDocument;
    property PDFViewer: TgtPDFViewer read FPDFViewer write SetPDFViewer;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Version: string read FVersion write SetVersion;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses
  Contnrs;

{ TgtPDFSearchPanel }

constructor TgtPDFSearchPanel.Create(AOwner: TComponent);
begin
  inherited;
  FAbout := SProductName;
  FVersion := CVersion;
  Height := 528;
  Width := 262;
  Caption := '';
  BorderStyle := bsNone;
  Color := clWhite;
  Constraints.MinHeight := 160;
  Constraints.MinWidth := 262;

  SearchDisplay := TgtSearchDisplay.Create(Self);
  SearchDisplay.Parent := Self;
  SearchDisplay.Left := 0;
  SearchDisplay.Top := 0;
  SearchDisplay.Height := 160;
  SearchDisplay.Align := alTop;
  SearchDisplay.Caption := '';
  SearchDisplay.BorderStyle := bsNone;
  SearchDisplay.BevelOuter := bvNone;
  SearchDisplay.ParentColor := True;
  SearchDisplay.FbtnSearch.OnClick := OnBtnSearchClick;
  SearchDisplay.FedtSearch.OnChange := OnEditChange;

  SearchResultDisplay := TgtSearchResultDisplay.Create(Self);
  SearchResultDisplay.Parent := Self;
  SearchResultDisplay.Left := 0;
  SearchResultDisplay.Top := 0;
  SearchResultDisplay.Height := 160;
  SearchResultDisplay.Align := alTop;
  SearchResultDisplay.Caption := '';
  SearchResultDisplay.BorderStyle := bsNone;
  SearchResultDisplay.BevelOuter := bvNone;
  SearchResultDisplay.ParentColor := True;
  SearchResultDisplay.btnNewSearch.OnClick := OnBtnNewSearchClick;

  SearchResult := TgtSearchList.Create(Self);
  SearchResult.Parent := Self;
  SearchResult.Left := 8;
  SearchResult.Top := 160;
  SearchResult.Height := Height - 8;
  SearchResult.Width := Width - 16;
  SearchResult.ParentColor := True;
  SearchResult.OnClick := OnSearchResultListClick;

  SearchDisplay.TabOrder := 1;
  SearchDisplay.edtSearch.TabOrder := 2;
  SearchDisplay.chkCaseSearch.TabOrder := 3;
  SearchDisplay.chkWholeSearch.TabOrder := 4;
  SearchDisplay.btnSearch.TabOrder := 5;

  SearchResultDisplay.TabOrder := 1;
  SearchResultDisplay.btnNewSearch.TabOrder := 2;

  SearchResult.TabOrder := 6;
  SearchResultDisplay.Hide;
  OnResize := OnSearchPanelResize;
  FUserSearchFlag := False;
end;

procedure TgtPDFSearchPanel.HighLightList;
var
  LSearchElement: TgtSearchElement;
begin
  if (FUserSearchFlag) then
  begin
    SearchResult.Selected[0] := true;
    FUserSearchFlag := False;
    Visible := True;
  end;

  if Assigned(PDFViewer) and (PDFViewer.PDFDocument.IsLoaded) then
    PDFViewer.Refresh;

  LSearchElement := TgtSearchElement(SearchResult.Items.Objects[SearchResult.ItemIndex]);

  if Assigned(PDFViewer) and (PDFViewer.PDFDocument.IsLoaded) then
  begin
    PDFViewer.SearchHighlightColor := RGB(153, 193, 218);
    PDFViewer.InternalHighlightRegion(LSearchElement.BoundingRect, LSearchElement.PageNum);
  end;
end;

procedure TgtPDFSearchPanel.OnBtnNewSearchClick(Sender: TObject);
begin
  Refresh;
end;

procedure TgtPDFSearchPanel.OnBtnSearchClick(Sender: TObject);
begin
  FUserSearchFlag := False;
  if Active then
  begin
    SearchResult.Clear;
    if Assigned(PDFViewer) then
    begin
      if Assigned(PDFViewer.PDFDocument) and PDFViewer.PDFDocument.IsLoaded then
      begin
        SearchPanelDoc := PDFViewer.PDFDocument;
        PopulateListBox;
        SearchDisplay.Hide;
        SearchResultDisplay.Show;
      end;
    end
    else if Assigned(PDFDocument) and PDFDocument.IsLoaded then
    begin
      SearchPanelDoc := PDFDocument;
      PopulateListBox;
      SearchDisplay.Hide;
      SearchResultDisplay.Show;
    end;
  end;
end;

procedure TgtPDFSearchPanel.OnEditChange(Sender: TObject);
begin
  if (FSearchPanelDoc <> nil) and (FSearchPanelDoc.IsLoaded) then
    SetSearchbtnEnable;
end;

procedure TgtPDFSearchPanel.OnSearchPanelResize(Sender: TObject);
begin
  SearchResult.Width := Width - 16;
  SearchResult.Height := Height - 168;
end;

procedure TgtPDFSearchPanel.OnSearchResultListClick(Sender: TObject);
begin
  HighLightList;
end;

procedure TgtPDFSearchPanel.PopulateListBox;
var
  Li, J: Integer;
  SearchType: TgtSearchTypes;
  LList: TStringList;
begin
  SearchType := [];
  if (SearchDisplay.chkCaseSearch.Checked) then
    SearchType := [stCaseSensitive];

  if (SearchDisplay.chkWholeSearch.Checked) then
    SearchType := SearchType + [stWholeWord];

  TgtExProPDFDocument(SearchPanelDoc).SearchAll(Trim(SearchDisplay.FedtSearch.Text),
    SearchType, SearchEvent);

  {$IFDEF gtDelphi6up}
  SearchResultDisplay.edtSearchInstances.Text := IntToStr(SearchResult.Count);
  {$ENDIF}
  SearchResultDisplay.edtSearchText.Text := Trim(SearchDisplay.FedtSearch.Text);
end;

procedure TgtPDFSearchPanel.Refresh;
begin
  { Refesh the search panel }
  SearchResultDisplay.Hide;
  SearchDisplay.Show;
  SearchResult.Clear;
  if Assigned(PDFViewer) and (PDFViewer.PDFDocument.IsLoaded) then
    PDFViewer.Refresh;
end;

procedure TgtPDFSearchPanel.Search(const Asearchtext: string; CaseSearch,
  WholeWord: Boolean);
begin
  {To be implemented}
end;

procedure TgtPDFSearchPanel.SearchEvent(Sender: TObject; List: TStrings;
  PageNum: Integer; var Continue: Boolean);
var
  I: Integer;
begin
  if Assigned(List) then
  begin
    for I := 0 to List.Count - 1 do
    begin
      SearchResult.Items.AddObject(List.Strings[I], TgtSearchElement(List.Objects[I]).Copy);
    end;
  end;
  SearchResult.Refresh;
  Application.ProcessMessages;
end;

procedure TgtPDFSearchPanel.SetAbout(const Value: string);
begin
  FAbout := Value;
end;

procedure TgtPDFSearchPanel.SetActive(const Value: Boolean);
begin
  FActive := Value;
  SearchDisplay.FedtSearch.Enabled := Value;
  SearchDisplay.FchkWholeSearch.Enabled := Value;
  SearchDisplay.FchkCaseSearch.Enabled := Value;
  if not Value then
    SearchDisplay.FbtnSearch.Enabled := Value
  else
  begin
    if Assigned(SearchPanelDoc) then
    begin
      if SearchPanelDoc.IsLoaded and (Trim(SearchDisplay.FedtSearch.Text) <> '') then
        SearchDisplay.FbtnSearch.Enabled := Value
      else
        SearchDisplay.FbtnSearch.Enabled := False;
    end
    else
      SearchDisplay.FbtnSearch.Enabled := False;
  end;
end;

procedure TgtPDFSearchPanel.SetPDFDocument(const Value: TgtCustomPDFDocument);
begin
  FPDFDocument := Value;
  SearchPanelDoc := Value;
  { Enable the "Search" button }
  SetSearchbtnEnable;
end;

procedure TgtPDFSearchPanel.SetPDFViewer(const Value: TgtPDFViewer);
begin
  FPDFViewer := Value;
  if Assigned(FPDFViewer.PDFDocument) then
    SearchPanelDoc := FPDFViewer.PDFDocument;
  { Enable the "Search" button }
  SetSearchbtnEnable;
end;

procedure TgtPDFSearchPanel.SetSearchbtnEnable;
begin
  { Enable the search button }
  if Active then
    SearchDisplay.FbtnSearch.Enabled := (Trim(SearchDisplay.FedtSearch.Text) <> '');
end;

procedure TgtPDFSearchPanel.SetSearchPanelDoc(
  const Value: TgtCustomPDFDocument);
begin
  FSearchPanelDoc := Value;
  Refresh;
end;

procedure TgtPDFSearchPanel.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

{ TgtSearchList }

constructor TgtSearchList.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TgtSearchList.Destroy;
var
  I: Integer;
begin
//  for I := 0 to Items.Count - 1 do
//  begin
//    if Assigned(Items.Objects[I]) and (Items.Objects[I] is TgtSearchElement) then
//      TgtSearchElement(Items.Objects[I]).Free;
//  end;

  inherited;
end;

{ TgtSearchResultDisplay }

constructor TgtSearchResultDisplay.Create(AOwner: TComponent);
begin
  inherited;
  FNewSearch := TButton.Create(Self);
  FNewSearch.Parent := Self;
  FNewSearch.Caption := 'New Search';
  FNewSearch.Height := 20;
  FNewSearch.Width := 70;
  FNewSearch.Top := 100;
  FNewSearch.Left := 8;

  FlblSearchText := TLabel.Create(Self);
  FlblSearchText.Parent := Self;
  lblSearchText.Caption := 'Finished searching for:';
  FlblSearchText.Height := 13;
  FlblSearchText.Width := 115;
  FlblSearchText.Top := 8;
  FlblSearchText.Left := 8;
  FlblSearchText.ParentColor := True;

  FlblSearchInstances := TLabel.Create(Self);
  FlblSearchInstances.Parent := Self;
  lblSearchInstances.Caption := 'Total instances found:';
  FlblSearchInstances.Height := 13;
  FlblSearchInstances.Width := 110;
  FlblSearchInstances.Top := 48;
  FlblSearchInstances.Left := 8;
  FlblSearchInstances.ParentColor := True;

  FedtSearchText := TEdit.Create(Self);
  FedtSearchText.Parent := Self;
  FedtSearchText.Text := '';
  FedtSearchText.Height := 21;
  FedtSearchText.Width := 240;
  FedtSearchText.Top := 28;
  FedtSearchText.Left := 8;
  FedtSearchText.BorderStyle := bsNone;
  FedtSearchText.ReadOnly := True;
  FedtSearchText.TabStop := False;
  FedtSearchText.Font.Style := [fsBold];
  FedtSearchText.ParentColor := True;

  FedtSearchInstances := TEdit.Create(Self);
  FedtSearchInstances.Parent := Self;
  FedtSearchInstances.Text := '';
  FedtSearchInstances.Height := 21;
  FedtSearchInstances.Width := 61;
  FedtSearchInstances.Top := 68;
  FedtSearchInstances.Left := 8;
  FedtSearchInstances.BorderStyle := bsNone;
  FedtSearchInstances.ReadOnly := True;
  FedtSearchInstances.TabStop := False;
  FedtSearchInstances.Font.Style := [fsBold];
  FedtSearchInstances.ParentColor := True;

  FedtResult := TLabel.Create(Self);
  FedtResult.Parent := Self;
  FedtResult.Height := 21;
  FedtResult.Width := 240;
  FedtResult.Top := 135;
  FedtResult.Left := 8;
//  FedtResult.BorderStyle := bsNone;
//  FedtResult.ReadOnly := True;
//  FedtResult.TabStop := False;
  FedtResult.Caption := 'Results:';
  FedtResult.ParentColor := True;
end;

{ TgtSearchDisplay }

constructor TgtSearchDisplay.Create(AOwner: TComponent);
begin
  inherited;
  FbtnSearch := TButton.Create(Self);
  FbtnSearch.Parent := Self;
  FbtnSearch.Caption := 'Search';
  FbtnSearch.Height := 20;
  FbtnSearch.Width := 60;
  FbtnSearch.Top := 112;
  FbtnSearch.Left := 188;

  FedtSearch := TEdit.Create(Self);
  FedtSearch.Parent := Self;
  FedtSearch.Text := '';
  FedtSearch.Height := 21;
  FedtSearch.Width := 240;
  FedtSearch.Top := 40;
  FedtSearch.Left := 8;
  FedtSearch.ParentColor := True;

  FchkCaseSearch := TCheckBox.Create(Self);
  FchkCaseSearch.Parent := Self;
  FchkCaseSearch.Caption := 'Case-Sensitive';
  FchkCaseSearch.Width := 105;
  FchkCaseSearch.Top := 86;
  FchkCaseSearch.Left := 8;
  FchkCaseSearch.Alignment := taRightJustify;
  FchkCaseSearch.ParentColor := True;

  FchkWholeSearch := TCheckBox.Create(Self);
  FchkWholeSearch.Parent := Self;
  FchkWholeSearch.Caption := 'Whole words only';
  FchkWholeSearch.Width := 121;
  FchkWholeSearch.Top := 112;
  FchkWholeSearch.Left := 8;
  FchkWholeSearch.Alignment := taRightJustify;
  FchkWholeSearch.ParentColor := True;

  FlblSearch := TLabel.Create(Self);
  FlblSearch.Parent := Self;
  FlblSearch.Caption := 'What word or phrase would you like to search for?';
  FlblSearch.Height := 13;
  FlblSearch.Width := 240;
  FlblSearch.Top := 14;
  FlblSearch.Left := 8;
  FlblSearch.ParentColor := True;
end;

procedure TgtSearchDisplay.SetbtnSearch(const Value: TButton);
begin
  FbtnSearch := Value;
end;

procedure TgtSearchDisplay.SetchkCaseSearch(const Value: TCheckBox);
begin
  FchkCaseSearch := Value;
end;

procedure TgtSearchDisplay.SetchkWholeSearch(const Value: TCheckBox);
begin
  FchkWholeSearch := Value
end;

procedure TgtSearchDisplay.SetedtSearch(const Value: TEdit);
begin
  FedtSearch := Value;
end;

procedure TgtSearchDisplay.SetlblSearch(const Value: TLabel);
begin
  FlblSearch := Value;
end;

end.
