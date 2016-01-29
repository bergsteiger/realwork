{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCNBKP0.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcNbkP0;
  {-Notebook property editor}

{$I l3Define.inc }  

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Graphics, Forms, Controls, Dialogs, Grids, ExtCtrls,
  Buttons, StdCtrls,
  {$IfDef Delphi6}
  DesignIntf,
  DesignEditors,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  SysUtils,
  OvcData, OvcConst, OvcHelp, OvcNbkP1;

type
  TOvcfrmTabEditor = class(TForm)
    Header1      : THeader;
    Grid         : TDrawGrid;
    EditButton   : TButton;
    AddButton    : TButton;
    DeleteButton : TButton;
    UpButton     : TBitBtn;
    DownButton   : TBitBtn;
    OkButton     : TBitBtn;
    btnHelp      : TBitBtn;
    procedure DrawCell(Sender : TObject; Col, Row : Longint; Rect : TRect;
      State : TGridDrawState);
    procedure FormCreate(Sender : TObject);
    procedure MoveClick(Sender : TObject);
    procedure EditClick(Sender : TObject);
    procedure AddClick(Sender : TObject);
    procedure DeleteClick(Sender : TObject);
    procedure HeaderSized(Sender : TObject; ASection, AWidth : Integer);
    procedure btnHelpClick(Sender : TObject);
  protected
    { Private declarations }
  public
    { Public declarations }
    PageList : TStrings;
    Modified : Boolean;
    procedure SetPageList(Value : TStrings);
  end;

type
  TOvcTabPageNameProperty = class(TPropertyEditor)
  public
    function GetAttributes : TPropertyAttributes;
      override;
    procedure GetValues(Proc : TGetStrProc);
      override;
    function GetValue : AnsiString;
      override;
    procedure SetValue(const AValue : AnsiString);
      override;
  end;

type
  TOvcTabPageListProperty = class(TPropertyEditor)
  public
    function GetAttributes : TPropertyAttributes;
      override;
    function GetValue : AnsiString;
      override;
    procedure Edit;
      override;
  end;

type
  {component editor for the notebook pages}
  TOvcNotebookEditor = class(TDefaultEditor)
  protected
    {$IfDef Delphi6}
    procedure EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
      override;
    {$Else  Delphi6}
    procedure EditProperty(PropertyEditor : TPropertyEditor;
              var Continue, FreeEditor : Boolean);
      override;
    {$EndIf Delphi6}
  public
    procedure ExecuteVerb(Index : Integer);
      override;
    function GetVerb(Index : Integer) : AnsiString;
      override;
    function GetVerbCount : Integer;
      override;
  end;


implementation


uses
  //OvcWebP0,  {turbopower web componenteditor class}
  OvcNbk;

{$R *.DFM}


{*** TOvcTabPageNameProperty ***}

function TOvcTabPageNameProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TOvcTabPageNameProperty.GetValues(Proc : TGetStrProc);
var
  I        : Integer;
  Notebook : TOvcNotebook;
  Pages    : TStrings;
  Page     : TOvcNotebookPage;
begin
  Notebook := GetComponent(0) as TOvcNotebook;
  Pages := Notebook.Pages;
  for I := 0 to Pages.Count-1 do begin
    Page := Pages.Objects[i] as TOvcNotebookPage;
    Proc(Page.Caption);
  end;
end;

function TOvcTabPageNameProperty.GetValue : AnsiString;
begin
  Result := GetStrValue;
end;

procedure TOvcTabPageNameProperty.SetValue(const AValue : AnsiString);
begin
  SetStrValue(AValue);
end;


{*** TOvcTabPageListProperty ***}

function TOvcTabPageListProperty.GetAttributes : TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TOvcTabPageListProperty.GetValue : AnsiString;
begin
  Result := '(TOvcNotebookPage)';
end;

procedure TOvcTabPageListProperty.Edit;
var
  D        : TOvcfrmTabEditor;
  Notebook : TOvcNotebook;
begin
  NoteBook := GetComponent(0) as TOvcNotebook;

  {force the top page invisible in case page order changes}
  if Notebook.PageIndex > -1 then
    (Notebook.Pages.Objects[Notebook.PageIndex] as
      TOvcNotebookPage).Visible := False;

  D := TOvcfrmTabEditor.Create(Application);
  try
    D.SetPageList(TStringList(GetOrdValue));
    D.ShowModal;
    if D.Modified then begin
      Designer.Modified;
      {redraw the notebook display}
      Notebook.Refresh;
    end;
  finally
    D.Free;
  end;

  {make the top page visible}
  if (Notebook.Pages.Count > 0) and (Notebook.PageIndex > -1) then with
    (Notebook.Pages.Objects[Notebook.PageIndex] as TOvcNotebookPage) do begin
    Visible := True;
    BringToFront;
  end;
end;

{*** TOvcNbk0 Form ***}

procedure TOvcfrmTabEditor.SetPageList(Value : TStrings);
begin
  PageList := Value;
  Grid.RowCount := PageList.Count;
end;

procedure TOvcfrmTabEditor.DrawCell(Sender : TObject; Col, Row : LongInt;
  Rect : TRect; State : TGridDrawState);
var
  R : TRect;
  W : TOvcNoteBookPage;
  S : string;

  procedure DrawIt(St : AnsiString);
  var
    L : Integer;
  begin
    L := Length(St);
    if L = 255 then Dec(L);
    if (L > 0) and (L < 255) then begin
      {make length-byte string look like a null-terminated string}
      if St[L+1] <> #0 then St[L+1] := #0;
      ExtTextOut(Grid.Canvas.Handle, Rect.Left + 2, Rect.Top + 2, 0,
                 @Rect, @St[1], Length(St), nil);
    end;
  end;

begin
  if Row < PageList.Count then begin
    W := PageList.Objects[Row] as TOvcNoteBookPage;
    R := Rect;

    {page name}
    Rect.Right := Rect.Left + Header1.SectionWidth[0];
    DrawIt(PageList[Row]);

    {page enabled status}
    Rect.Left := Rect.Right + 1;
    Rect.Right := Rect.Left + Header1.SectionWidth[1];
    if W.PageEnabled then
      S := ' Y'
    else
      S := ' N';
    DrawIt(S);

    {page hint}
    Rect.Left := Rect.Right + 1;
    Rect.Right := Rect.Left + Header1.SectionWidth[2];
    DrawIt(W.Hint);

    {help context}
    Rect.Left := Rect.Right + 1;
    Rect.Right := R.Right;
    try
      S := IntToStr(W.HelpContext);
    except
      S := '0';
    end;
    DrawIt(S);
  end;
end;

procedure TOvcfrmTabEditor.FormCreate(Sender : TObject);
begin
  Grid.DefaultRowHeight := Grid.Canvas.TextHeight(GetOrphStr(SCTallLowChars)) + 4;
  Grid.DefaultColWidth := Grid.ClientWidth; {one column}
end;

procedure TOvcfrmTabEditor.MoveClick(Sender : TObject);
var
  NewIndex : Integer;
begin
  NewIndex := Grid.Row;
  if Sender = UpButton then Dec(NewIndex)
  else Inc(NewIndex);
  if (NewIndex >= 0) and (NewIndex < PageList.Count) then begin
    PageList.Move(Grid.Row, NewIndex);
    Grid.Row := NewIndex;
    Grid.Invalidate;
  end;
  Grid.SetFocus;
  Modified := True;
end;

procedure TOvcfrmTabEditor.EditClick(Sender : TObject);
  {-edit the current entry}
var
  D : TOvcfrmTabPageInfo;
  W : TOvcNoteBookPage;
begin
  D := TOvcfrmTabPageInfo.Create(Application);
  try
    W := PageList.Objects[Grid.Row] as TOvcNoteBookPage;
    D.PageName := PageList[Grid.Row];
    D.PageContext := W.HelpContext;
    D.PageEnabled := W.PageEnabled;
    D.PageHint := W.Hint;
    if D.ShowModal = mrOK then begin
      PageList[Grid.Row] := D.PageName;
      W.HelpContext := D.PageContext;
      W.PageEnabled := D.PageEnabled;
      W.Hint := D.PageHint;
      Grid.Invalidate;
      Modified := True;
    end;
  finally
    D.Free;
  end;
end;

procedure TOvcfrmTabEditor.AddClick(Sender : TObject);
  {-add a new entry}
var
  D : TOvcfrmTabPageInfo;
  W : TOvcNoteBookPage;
begin
  D := TOvcfrmTabPageInfo.Create(Application);
  try
    D.PageName := '';
    D.PageContext := 0;
    D.PageEnabled := True;
    D.PageHint := '';
    if D.ShowModal = mrOK then begin
      PageList.Add(D.PageName);
      W := PageList.Objects[PageList.Count - 1] as TOvcNoteBookPage;
      W.HelpContext := D.PageContext;
      W.PageEnabled := D.PageEnabled;
      W.Hint := D.PageHint;
      Grid.RowCount := PageList.Count;
      Grid.DefaultColWidth := Grid.ClientWidth; {in case scrollbar appears}
      Grid.Invalidate;
      Modified := True;
    end;
  finally
    D.Free;
  end;
end;

procedure TOvcfrmTabEditor.DeleteClick(Sender : TObject);
  {-delete the current entry}
begin
  if Grid.RowCount = 1 then begin
    MessageDlg('Unable to delete last notebook tab. '+
               'Notebooks must have at least one tab.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if MessageDlg(Format('Delete notebook page: ''%s''?', [PageList[Grid.Row]]), mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    PageList.Delete(Grid.Row);
    Grid.RowCount := PageList.Count;
    Grid.DefaultColWidth := Grid.ClientWidth; {in case scrollbar disappears}
    Grid.Invalidate;
    Modified := True;
  end;
end;

procedure TOvcfrmTabEditor.HeaderSized(Sender : TObject; ASection,
  AWidth : Integer);
begin
  Grid.Repaint;
end;


{*** TOvcNotebookEditor ***}

const
  NotebookVerbs : array[0..2{4}] of PAnsiChar = ('Next Page', 'Previous Page', 'Page Editor'{,
    WebText, MailText});

{$IfDef Delphi6}
procedure TOvcNotebookEditor.EditProperty(const PropertyEditor: IProperty; var Continue: Boolean);
  //override;
{$Else  Delphi6}
procedure TOvcNotebookEditor.EditProperty(PropertyEditor : TPropertyEditor;
          var Continue, FreeEditor : Boolean);
  //override;
{$EndIf Delphi6}
var
  PropName : AnsiString;
begin
  PropName := PropertyEditor.GetName;
  if CompareText(PropName, 'ONPAGECHANGE') = 0 then begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;

procedure TOvcNotebookEditor.ExecuteVerb(Index : Integer);
var
  NewPage  : Integer;
  D        : TOvcfrmTabEditor;
  Notebook : TOvcNotebook;
begin
  if Index = 2 then begin
    NoteBook := TOvcNotebook(Component);

    {force the top page invisible in case page order changes}
    if Notebook.PageIndex > -1 then
      (Notebook.Pages.Objects[Notebook.PageIndex] as
        TOvcNotebookPage).Visible := False;

    D := TOvcfrmTabEditor.Create(Application);
    try
      D.SetPageList(Notebook.Pages);
      D.ShowModal;
      if D.Modified then begin
        Designer.Modified;
        {redraw the notebook display}
        Notebook.Refresh;
      end;
    finally
      D.Free;
    end;

    {make the top page visible}
    if (Notebook.Pages.Count > 0) and (Notebook.PageIndex > -1) then with
      (Notebook.Pages.Objects[Notebook.PageIndex] as TOvcNotebookPage) do begin
      Visible := True;
      BringToFront;
    end;
  end {else if (Index = 3) then
    ShellWebCall
  else if (Index = 4) then
    ShellMailCall}
  else begin
    with TOvcNotebook(Component) do begin
      NewPage := PageIndex;
      if Index = 0 then
        Inc(NewPage)
      else
        Dec(NewPage);
      if NewPage < 0 then
        NewPage := Pages.Count-1
      else if NewPage >= Pages.Count then
        NewPage := 0;
      if NewPage <> PageIndex then begin
        PageIndex := NewPage;
        Designer.Modified;
      end;
    end;
  end;
end;

function TOvcNotebookEditor.GetVerb(Index : Integer) : AnsiString;
begin
  Result := StrPas(NotebookVerbs[Index]);
end;

function TOvcNotebookEditor.GetVerbCount : Integer;
begin
  Result := High(NotebookVerbs) + 1;
end;

procedure TOvcfrmTabEditor.btnHelpClick(Sender : TObject);
begin
  ShowHelpContext(hcNotebookPage);
end;

end.