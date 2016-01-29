{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}

unit gtPDFOutlineViewer;

interface

uses
  Classes, ComCtrls, Controls, gtCstPDFDoc, gtPDFViewer, gtPDFConsts, Dialogs,
  SysUtils;

type

  TgtPDFOutlineViewer = class(TCustomTreeView)
  private
    FPDFDocument: TgtCustomPDFDocument;
    FPDFViewer: TgtPDFViewer;
    FActive: Boolean;
    FAbout: string;
    FVersion: string;
    procedure SetActive(const Value: Boolean);
    procedure LoadOutlines;
    procedure ClearOutlines;
    procedure BuildOutlineChild(aNode: TTreeNode; aOutline: TgtPDFOutline);
    procedure BuildOutlineNext(aNode: TTreeNode; aOutline: TgtPDFOutline);
    procedure SetPDFDocument(const Value: TgtCustomPDFDocument);
    procedure SetAbout(const Value: string);
    procedure SetVersion(const Value: string);

  protected
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure Click; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);

  published
    property About: string read FAbout write SetAbout;
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ReadOnly;
    property RowSelect;
    property ShowButtons;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property Active: Boolean read FActive write SetActive;
    property PDFDocument: TgtCustomPDFDocument read FPDFDocument write SetPDFDocument;
    property PDFViewer: TgtPDFViewer read FPDFViewer write FPDFViewer;
    property Version: string read FVersion write SetVersion;
  end;

implementation

uses
  forms;

{ TgtPDFOutlineViewer }

constructor TgtPDFOutlineViewer.Create(AOwner: TComponent);
begin
  inherited;
  FAbout := SProductName;
  FVersion := CVersion;
  Height := 528;
  BorderStyle := TBorderStyle(bsNone);
end;

destructor TgtPDFOutlineViewer.Destroy;
var
  LI: Integer;
begin
  for LI := 0 to Items.Count - 1 do  //Free all the TgtPDFOutline objects
  begin
    Items[LI].Free;
  end;
  Items.Clear; 
  inherited;
end;

procedure TgtPDFOutlineViewer.SetActive(const Value: Boolean);
begin
  FActive := Value;
  LoadOutlines;
end;

procedure TgtPDFOutlineViewer.LoadOutlines;
var
  LOutline, LChild: TgtPDFOutline;
  LNode: TTreeNode;
begin
  ClearOutlines;
  if (PDFDocument <> nil) and (PDFDocument.IsLoaded) and (Active) then
  begin
    LOutline := PDFDocument.GetBookmarkRoot;
    if Assigned(LOutline) then
    begin
    // Obtain the first child of the root.
      LChild := LOutline.GetFirstChild;
      if Assigned(LChild) then
      begin
        // Add the Child node to the TreeView, and attach the pointer to it to that node.
        LNode := Items.AddObject(nil, LChild.Title, LChild);
        if LChild.Child <> nil then
          BuildOutlineChild(LNode, LChild.Child);
        if LChild.Next <> nil then
          BuildOutlineNext(LNode, LChild.Next);
      end;
    end;
  end;
end;

procedure TgtPDFOutlineViewer.BuildOutlineChild(aNode: TTreeNode;
  aOutline: TgtPDFOutline);
var
  LNode: TTreeNode;
begin
// Add aOutline as Child to aNode in the TreeView.
  LNode := Items.AddChildObject(aNode, aOutline.Title, aOutline);

  if aOutline.Child <> nil then
    BuildOutlineChild(LNode, aOutline.Child);
  if aOutline.Next <> nil then
    BuildOutlineNext(LNode, aOutline.Next);
end;

procedure TgtPDFOutlineViewer.BuildOutlineNext(aNode: TTreeNode;
  aOutline: TgtPDFOutline);
var
  LNode: TTreeNode;
begin
// Add aOutline as sibling to aNode in the TreeView.
  LNode := Items.AddObject(aNode, aOutline.Title, aOutline);
  if aOutline.Child <> nil then
    BuildOutlineChild(LNode, aOutline.Child);
  if aOutline.Next <> nil then
    BuildOutlineNext(LNode, aOutline.Next);
end;

procedure TgtPDFOutlineViewer.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LNode: TTreeNode;
  LDest: TgtPDFDestination;
begin
  if (PDFViewer <> nil) and (PDFDocument <> nil) and (PDFDocument.IsLoaded) then
  begin
    LNode := GetNodeAt(x, y);
    if LNode <> nil then
    begin
      LDest := TgtPDFOutline(LNode.Data).Destination;
      if LDest <> nil then
        PDFViewer.GoToPage(LDest.PageNo);
    end;
  end;
  inherited;
end;

procedure TgtPDFOutlineViewer.KeyPress(var Key: char);
var
  LNode: TTreeNode;
  LDest: TgtPDFDestination;
begin
  if (PDFViewer <> nil) and (PDFDocument <> nil) and (PDFDocument.IsLoaded) then
  begin
    if (Key = '13') or (key = '32') then
    begin
      LNode := Selected;
      if LNode <> nil then
      begin
        LDest := TgtPDFOutline(LNode.Data).Destination;
        if LDest <> nil then
          PDFViewer.GoToPage(LDest.PageNo);
      end;
    end;
  end;
  inherited;
end;

procedure TgtPDFOutlineViewer.KeyUp(var Key: Word; Shift: TShiftState);
var
  LNode: TTreeNode;
  LDest: TgtPDFDestination;
begin
  if (PDFViewer <> nil) and (PDFDocument <> nil) and (PDFDocument.IsLoaded) then
  begin
    if (Key = 13) or (key = 32) then
    begin
      LNode := Selected;
      if LNode <> nil then
      begin
        LDest := TgtPDFOutline(LNode.Data).Destination;
        if LDest <> nil then
          PDFViewer.GoToPage(LDest.PageNo);
      end;
    end;
  end;
  inherited;
end;

procedure TgtPDFOutlineViewer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FPDFDocument) and (Operation = opRemove) then
    FPDFDocument := nil;

  if (AComponent = FPDFViewer) and (Operation = opRemove) then
    FPDFViewer := nil;
end;

procedure TgtPDFOutlineViewer.LoadFromFile(const FileName: string);
begin
//  inherited;
end;

procedure TgtPDFOutlineViewer.LoadFromStream(Stream: TStream);
begin
//  inherited;
end;

procedure TgtPDFOutlineViewer.SaveToFile(const FileName: string);
begin
//  inherited;
end;

procedure TgtPDFOutlineViewer.SaveToStream(Stream: TStream);
begin
//  inherited;
end;

procedure TgtPDFOutlineViewer.SetPDFDocument(
  const Value: TgtCustomPDFDocument);
begin
  FPDFDocument := Value;
 // LoadOutlines;
end;

procedure TgtPDFOutlineViewer.ClearOutlines;
begin
  Items.Clear;
end;

procedure TgtPDFOutlineViewer.Click;
var
  LNode: TTreeNode;
  LDest: TgtPDFDestination;
begin
  if (PDFViewer <> nil) and (PDFDocument <> nil) and (PDFDocument.IsLoaded) then
  begin
    LNode := Selected;
    if LNode <> nil then
    begin
      LDest := TgtPDFOutline(LNode.Data).Destination;
      if LDest <> nil then
        PDFViewer.GoToPage(LDest.PageNo);
    end;
  end;
  inherited;
end;

procedure TgtPDFOutlineViewer.SetAbout(const Value: string);
begin
//  FAbout := Value;
end;

procedure TgtPDFOutlineViewer.SetVersion(const Value: string);
begin
//  FVersion := Value;
end;

end.
