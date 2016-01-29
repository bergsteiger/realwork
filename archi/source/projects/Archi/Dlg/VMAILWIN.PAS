unit VMailWin;

{$Include l3Define.inc}

{ $Id: VMAILWIN.PAS,v 1.1 2015/05/06 08:24:26 dinishev Exp $ }

interface

uses
  SysUtils, 
  WinTypes, 
  WinProcs, 
  Messages, 
  Classes, 
  Graphics, 
  Controls, 
  Menus,
  Forms, 
  Dialogs, 
  Buttons, 
  ExtCtrls, 
  StdCtrls, 
  ComCtrls,

  OvcBase,

  vtlister, 
  vtCtrls,
  vtForm,
  vtStatusBar, 

  MailWin,

  l3Types,

  DT_Const, 
  DT_Types, 
  DT_Mail, 
  DT_Doc, 

  evEditorWindow, 
  evEditor, 
  evMemo, 
  evMultiSelectEditorWindow, 
  evCustomEditor, 
  evEditorWithOperations, 

  TB97ctls,
  tb97GraphicControl,
  
  afwControl, 
  afwInputControl, evCustomMemo, nevControl, afwControlPrim, afwBaseControl,
  evCustomEditorWindowModelPart, evCustomEditorWindowPrim,
  evCustomEditorModelPart, l3WinControlCanvas, evCustomEditorWindow;

type
  TViewMailWin = class(TvtForm)
    edtFrom: TEdit;
    edtName: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    memMessage: TevMemo;
    pnlButton: TPanel;
    sbDelete: TToolbarButton97;
    sbPrev: TToolbarButton97;
    sbNext: TToolbarButton97;
    Splitter1: TvtSplitter;
    lstLinkObj: TvtLister;
    PopupMenu1: TPopupMenu;
    miInsertDocToObjList: TMenuItem;
    sbReplay: TToolbarButton97;
    sbForward: TToolbarButton97;
    FooterPanel: TvtStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    function lstLinkObjGetItemImageIndex(Sender: TObject;Index: Integer): Integer;
    procedure lstLinkObjGetPCharItem(Sender: TObject; Index: Longint; var ItemString: PAnsiChar);
    procedure FormCreate(Sender: TObject);
    procedure lstLinkObjActionElement(Sender: TObject; Index: Longint);
    procedure lstLinkObjCurrentChanged(Sender: TObject; aNewCurrent: Integer;
        aOldCurrent: Integer);
    procedure FormShow(Sender: TObject);
    procedure miInsertDocToObjListClick(Sender: TObject);
    procedure sbReplayClick(Sender: TObject);
    procedure sbForwardClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    CurrMessageID : Longint;
    //CurrType    : TMailType;
    {CurrData     : Pointer;}
    DocStorage    : TDocumentSabList;
    TempNameStr   : PAnsiChar;
    fFromUserID   : TUserID;
    function CreateLetterCopy : TSendMailWin;
  protected
    function  Print : Boolean; override;
    procedure SetSpeedButton(Enabled : Boolean); override;
  public
    function  Execute : Boolean;
    procedure SetMessage(Value : Longint; Mode : Byte = 0); {0 - This, 1 - Prev, 2 - Next}
  end;

implementation

{$R *.DFM}

{$INCLUDE ProjectDefine.inc}

uses 
  ObjExpl,

  l3Interfaces,
  l3Base, 
  l3String, 
  l3Chars,
  l3InternalInterfaces, 
  l3Stream,

  ResShop,
  DT_User, 
  dt_LinkServ,
  ObjList,
  Main,
  SrchWin {, ObjExWin},

  k2Base,

  nevBase,
  nevTools,

 {$IFDEF InsiderTest}
 kwPrintDataSaver,
 {$ENDIF InsiderTest}

  evOp,
  evTypes,
  evTextSource,
  evRange,
  evExtFormat,                 
  evDocumentPreview,
  evCustomTextSource,
  evEditorInterfaces
  ;

procedure TViewMailWin.FormCreate(Sender: TObject);
begin
 TempNameStr := l3StrAlloc(SizeOf(TFullNameStr) + 1);
 memMessage.TextSource.HasDocument;
end;

procedure TViewMailWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TViewMailWin.FormDestroy(Sender: TObject);
var
 l_DocStorage: Il3ChangeNotifier;
 l_lstLinkObj: Il3ChangeRecipient;
begin
 if (TempNameStr <> nil) then
  l3StrDispose(TempNameStr);
 try
  if DocStorage <> nil then
  begin
   l_DocStorage := DocStorage as Il3ChangeNotifier;
   l_lstLinkObj := lstLinkObj as Il3ChangeRecipient;
   try
    l_DocStorage.Unsubscribe(l_lstLinkObj);
   finally
    l_DocStorage := nil;
    l_lstLinkObj := nil;
   end;
  end;

  l3Free(DocStorage);
 except
 end;
end;

procedure TViewMailWin.SetMessage(Value : Longint; Mode : Byte = 0);
var
 aMessage     : PAnsiChar;
 lIndex       : Integer;
 lMailData    : PMailRec;
 l_DocStorage : Il3ChangeNotifier;
 l_lstLinkObj : Il3ChangeRecipient;
begin
 CurrMessageID := Value;
 lIndex := MailServer.IndexByID(Value);
 if lIndex < 0 then Exit;

 case Mode of
  1 : Dec(lIndex);
  2 : Inc(lIndex);
 end;

 if (lIndex < 0) or (lIndex >= MailServer.Count) then Exit;

 lMailData := PMailRec(MailServer.ItemSlot(lIndex));

 CurrMessageID := lMailData^.rID;
 fFromUserID   := lMailData^.rFromUser;

 if (lMailData^.rMType and mlWasRead) = 0 then
  MailServer.MarkRead(lIndex);

 sbPrev.Enabled := (lIndex > 0);
 sbNext.Enabled := (lIndex < Pred(MailServer.Count));

 if DocStorage <> nil then
 begin
  l_DocStorage := DocStorage as Il3ChangeNotifier;
  l_lstLinkObj := lstLinkObj as Il3ChangeRecipient;
  try
   l_DocStorage.Unsubscribe(l_lstLinkObj);
  finally
   l_DocStorage := nil;
   l_lstLinkObj := nil;
  end;
 end;

 l3Free(DocStorage);
 MailServer.LoadMail(lIndex, aMessage, Pointer(DocStorage));

 if DocStorage <> nil then
 begin
  l_DocStorage := DocStorage as Il3ChangeNotifier;
  l_lstLinkObj := lstLinkObj as Il3ChangeRecipient;
  try
   l_DocStorage.Subscribe(l_lstLinkObj);
  finally
   l_DocStorage := nil;
   l_lstLinkObj := nil;
  end;
 end;

 edtFrom.Text := UserManager.UserTbl.GetNameStr(fFromUserID);
 edtName.Text := l3PCharLen2String(lMailData.rName.AsWStr);
 memMessage.Buffer := l3PCharLen(aMessage);
 l3StrDispose(aMessage);
 if DocStorage <> nil then
  lstLinkObj.Total := DocStorage.Count
 else
  lstLinkObj.Total := 0;
 lstLinkObj.Current := 0;
 lstLinkObj.ItemSourceChanged;
end;

procedure TViewMailWin.FormResize(Sender: TObject);
begin
 edtFrom.Width := Width - 100;
 edtName.Width := Width - 100;
end;

function TViewMailWin.Execute : Boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TViewMailWin.sbDeleteClick(Sender: TObject);
var
 lIndex : Integer;
begin
 lIndex := MailServer.IndexByID(CurrMessageID);
 if lIndex >= 0 then
  MailServer.Delete(lIndex);
 Close;
end;

procedure TViewMailWin.sbPrevClick(Sender: TObject);
begin
 SetMessage(CurrMessageID, 1);
end;

procedure TViewMailWin.sbNextClick(Sender: TObject);
begin
 SetMessage(CurrMessageID, 2);
end;

function TViewMailWin.lstLinkObjGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 Result := picText;
end;

procedure TViewMailWin.lstLinkObjGetPCharItem(Sender: TObject; Index: Longint; var ItemString: PAnsiChar);
var
 SpPChar : PAnsiChar;
 lDoc    : TDocReadRec;
begin
 try
  lDoc := DocStorage.GetDoc(Index);
  l3ArrayToPChar(lDoc.Name, SizeOf(TFullNameStr), TempNameStr);
  ItemString:=TempNameStr;
  SpPChar := StrScan(ItemString,'"');
  if (SpPChar <> Nil) and (SpPChar <> ItemString) then
  begin
   SpPChar:=SpPChar-1;
   if SpPChar[0] = #32 then 
    SpPChar[0] := #13;
  end;
 except
  ItemString := nil;
 end;
end;

procedure TViewMailWin.lstLinkObjActionElement(Sender: TObject; Index: Longint);
var
 lDoc : TDocReadRec;
begin
 lDoc := DocStorage.GetDoc(Index);
 MainForm.RunTextEditor(CurrentFamily, lDoc.ID);
end;

procedure TViewMailWin.lstLinkObjCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
begin
 if (lstLinkObj.Total > 0) then
  FooterPanel.Panels[0].Text := Format('%d из %d',[Succ(aNewCurrent),lstLinkObj.Total])
 else
  FooterPanel.Panels[0].Text:='';
end;

procedure TViewMailWin.FormShow(Sender: TObject);
begin
 memMessage.Height := Height - 220;
end;

procedure TViewMailWin.miInsertDocToObjListClick(Sender: TObject);
var
 I             : Longint;
 ItDataRec     : TGlobalCoordinateRec;
 SaveAllocFlag : Boolean;
 lDoc          : TDocReadRec;
begin
 if lstLinkObj.Total = 0 then Exit;
 for I := 0 to Pred(lstLinkObj.Total) do
  if lstLinkObj.Selected[I] then
   with ItDataRec do
   begin
    lDoc   := DocStorage.GetDoc(I);
    Family := Family;
    Doc    := lDoc.ID;
    Sub    := 0;
    SaveAllocFlag := ArchiObjectList.NeedAllocStr;
    ArchiObjectList.NeedAllocStr := False;
    try
     ArchiObjectList.AddObjRec(l3AllocPChar(lDoc.Name, SizeOf(lDoc.Name)), ddDoc, @ItDataRec);
    finally
     ArchiObjectList.NeedAllocStr := SaveAllocFlag;
    end;
   end;
end;

function TViewMailWin.CreateLetterCopy : TSendMailWin;
begin
 Result := TSendMailWin.Create(Application.MainForm);
 Result.edtName.Text := '>>: ' + edtName.Text;
 Result.memMessage.Buffer := memMessage.Buffer;
end;

procedure TViewMailWin.sbReplayClick(Sender: TObject);
begin
 with CreateLetterCopy do
  ReceiverID := fFromUserID;
end;

procedure TViewMailWin.sbForwardClick(Sender: TObject);
begin
 with CreateLetterCopy do
  if Self.DocStorage <> nil then 
   SetDocStorage(Self.DocStorage);
end;

procedure TViewMailWin.SetSpeedButton(Enabled : Boolean);
begin
 MainForm.acPrint.Enabled := Enabled;
end;

function  TViewMailWin.Print : Boolean;
var
 l_PrintSource : TevCustomTextSource;
 l_Range       : IedRange;
 I             : Longint;
 l_Doc         : TDocReadRec;
 l_Cursor      : InevPoint;
begin
 l_PrintSource := TevCustomTextSource.Create;
 try
  l_PrintSource.InsertBuf(nil, l3PCharLen);
  l_PrintSource.Document.QT(InevPoint, l_Cursor);
  l_Cursor.Move(nil, ev_ocBottomRight);
  l_Range := TedRange.Make(nil, l_Cursor, l_PrintSource.Processor);
  try
   IedRange(l_Range).InsertString('<table>' +
                         '<tr>' +
                          '<td width=20%>' +
                           '<p>Тема:</p>' +
                          '</td>' +
                          '<td width=80%>' +
                           '<p>' + edtName.Text + '</p>' +
                          '</td>' +
                          '</tr>' +
                          '<tr>' +
                           '<td width=20%>' +
                           '<p>От:</p>' +
                           '</td width=80%>' +
                           '<td>' +
                            '<p>' + edtFrom.Text + '</p>' +
                           '</td>' +
                          '</tr>' +
                         '</table>' +
                         '<p></p>',
                         cf_HTML);


   l_Range.InsertString(#13#10#13#10);
   l_Range.InsertString(memMessage.Buffer);
   if lstLinkObj.Total > 0 then
   begin
    l_Range.InsertString(#13#10);
    for I := 0 to Pred(lstLinkObj.Total) do
    begin
     l_Doc := DocStorage.GetDoc(I);
     l_Range.InsertString(Format(#13#10'[%d]' + cc_SoftSpace + cc_SoftSpace + cc_SoftSpace +'%s',
                           [LinkServer(CurrentFamily).Renum.GetExtDocID(l_Doc.Id),
                            l3ArrayToString(l_Doc.Name, SizeOf(TFullNameStr))]));
    end;
   end;
  finally
   l_Range := nil;
  end;//try..finally
  {$IFDEF InsiderTest}
  if TkwPrintDataSaver.Instance.IsWaitingPrint then
   TevDocumentPreview.Make(l_PrintSource.Document.AsObject, evDefaultPreviewCacheKey).Update(nil)
  else
  {$ENDIF InsiderTest}
  TevDocumentPreview.Make(l_PrintSource.Document.AsObject, evDefaultPreviewCacheKey).Print;
 finally
  l3Free(l_PrintSource);
 end;//try..finally
end;

end.
