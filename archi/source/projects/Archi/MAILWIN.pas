unit MailWin;

{ $Id: MAILWIN.pas,v 1.33 2016/05/18 06:02:40 lukyanets Exp $ }

interface

uses
  SysUtils, WinTypes, WinProcs, Messages,
  Classes, Graphics, Controls, Forms, Dialogs, vtDialogs,
  Buttons, ExtCtrls, StdCtrls, OvcBase,
  vtlister, vtCtrls,
  evEditorWindow, evEditor, evMemo, 
  DragData, ObjList,
  TB97, TB97Ctls,
  DT_Const, DT_Types, DT_Doc, evMultiSelectEditorWindow, ComCtrls,
  vtStatusBar, tb97GraphicControl, evCustomEditor, evEditorWithOperations,
  afwControl, afwInputControl, afwControlPrim, afwBaseControl, nevControl,
  evCustomMemo, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, evCustomEditorWindow;

type
  TSendMailWin = class(TForm)
    edtTo: TComboBox;
    edtName: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    memMessage: TevMemo;
    pnlButton: TPanel;
    sbSend: TToolbarButton97;
    Splitter1: TvtSplitter;
    lstLinkObj: TvtLister;
    sbAddObject: TToolbarButton97;
    sbDelObject: TToolbarButton97;
    FooterPanel: TvtStatusBar;
    procedure FormResize(Sender: TObject);
    procedure sbSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function  lstLinkObjGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
    procedure lstLinkObjGetPCharItem(Sender: TObject; Index: Longint; var ItemString: PAnsiChar);
    procedure lstLinkObjActionElement(Sender: TObject; Index: Longint);
    procedure sbDelObjectClick(Sender: TObject);
    procedure lstLinkObjCurrentChanged(Sender: TObject; aNewCurrent: Integer;
        aOldCurrent: Integer);
    procedure FormShow(Sender: TObject);
    procedure sbAddObjectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    //FReceiverID : Longint;
    DocStorage  : TDocumentSabList;
    TempNameStr : PAnsiChar;
    procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;
    procedure SetReceiverID(aValue : Longint);
    function  GetReceiverID : Longint;
    procedure SendMsg;
  public
    {Function Execute : Boolean;}
    procedure SetDocStorage(aDocStorage  : TDocumentSabList);

    Property ReceiverID : Longint read GetReceiverID write SetReceiverID;
  end;

implementation

{$R *.DFM}

Uses Main, DT_Mail, DT_User,
     l3Interfaces, l3String, l3Base,
     l3InternalInterfaces, 
     ResShop, StrShop,
     DocIntf,
     SrchWin;

procedure TSendMailWin.FormCreate(Sender: TObject);
var
 l_DocStorage: Il3ChangeNotifier;
 l_lstLinkObj: Il3ChangeRecipient;
Begin
 DocStorage := TDocumentSabList.CreateEmpty(1 {Family});

 l_DocStorage := DocStorage as Il3ChangeNotifier;
 l_lstLinkObj := lstLinkObj as Il3ChangeRecipient;
 try
  l_DocStorage.Subscribe(l_lstLinkObj);
 finally
  l_DocStorage := nil;
  l_lstLinkObj := nil;
 end;

 TempNameStr := l3StrAlloc(SizeOf(TFullNameStr)+1);
 UserManager.GetFiltredUserList(edtTo.Items);
 memMessage.TextSource.HasDocument;
end;

function  TSendMailWin.GetReceiverID : Longint;
 begin
  Result := Integer(edtTo.Items.Objects[edtTo.ItemIndex]);
 end;

procedure TSendMailWin.SetReceiverID(aValue : Longint);
 var
  lReceiverIndex : Integer;
 begin
  lReceiverIndex := edtTo.Items.IndexOfObject(TObject(aValue));
  edtTo.ItemIndex := lReceiverIndex;

  //fReceiverID := aValue;
  //GlobalDataProvider.UserManager.GetUserInfo(fReceiverID, lUserName, lLoginName, lActFlag);
  //edtTo.Text := lUserName;
 end;

{procedure TSendMailWin.SetReceiverID(aValue : Longint);
 var
  lActFlag    : Byte;
  lUserName,
  lLoginName  : ShortString;
 begin
  IndexOfObject()
  fReceiverID := aValue;
  GlobalDataProvider.UserManager.GetUserInfo(fReceiverID, lUserName, lLoginName, lActFlag);
  edtTo.Text := lUserName;
 end;}

procedure TSendMailWin.FormResize(Sender: TObject);
 begin
  edtTo.Width := Width - 100;
  edtName.Width := Width - 100;
 end;

procedure TSendMailWin.sbSendClick(Sender: TObject);
 begin
  If ReceiverID <= 0 then
  begin
   vtMessageDlg(l3Fmt(sidFieldEmptyErr, ['"Кому"']), mtError);
   ActiveControl := edtTo;
  end
  else
  begin
   SendMsg;
   Close;
  end;
 end;

procedure TSendMailWin.SendMsg;
 begin
  If lstLinkObj.Total = 0 then
   MailServer.SendMail(mlNone, ReceiverID, edtName.Text,
                        memMessage.Buffer.S, nil)
  else
   MailServer.SendMail(mlDocList, ReceiverID, edtName.Text,
                        memMessage.Buffer.S, DocStorage);
 end;

procedure TSendMailWin.SetDocStorage(aDocStorage  : TDocumentSabList);
 begin
  DocStorage.CurSab := aDocStorage.CurSab;
  lstLinkObj.Total := DocStorage.Count;
  lstLinkObj.Current := 0;
 end;

procedure TSendMailWin.WMDropAccept(var Message: TMessage);
 var
  ItData : PAnsiChar;
  I      : Longint;
  AddCnt : Longint;
 begin
  Message.Result:=0;
  AddCnt := 0;
  If (TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
     (TDragDataSupport.Instance.DragDataType = Ord(ddDoc))
   then
    begin
     With TArchiObjectList(TDragDataSupport.Instance.DragData) do
      begin
       For I := 0 to Pred(Count) do
        Begin
         ItData := Data[I];
         If (TDragDataType(ItData[0]) = ddDoc) then
          begin
           DocStorage.AddDoc(PGlobalCoordinateRec(ItData+1)^.Doc);
           Inc(AddCnt);
          end;

         {If (TObjListRecType(ItData[0]) = rtSrchObj) then
          Begin
           lstLinkObj.Items.AddData(Strings[I],ItData);
           LinkObjType := 2;
           Inc(AddCnt);
          end; }
        end;
      end;

     If AddCnt = 0
      then vtMessageDlg(l3CStr('Несовместимые типы данных.'),mtError)
      else
       begin
        TDragDataSupport.Instance.Stop(True);
        {vtMessageDlg(Format('Добавлено %d элементов.',[AddCnt]),mtInformation);}
        Message.Result:=1;
        lstLinkObj.Total := DocStorage.Count;
        lstLinkObj.Current := 0;
       end;
    end;
 end;

function TSendMailWin.lstLinkObjGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
 begin
  Result := picText;
 end;

procedure TSendMailWin.lstLinkObjGetPCharItem(Sender: TObject;
  Index: Longint; var ItemString: PAnsiChar);
 var
  SpPChar : PAnsiChar;
  lDoc        : TDocReadRec;
 begin
  Try
   lDoc := DocStorage.GetDoc(Index);
   l3ArrayToPChar(lDoc.Name, SizeOf(TFullNameStr), TempNameStr);
   ItemString:=TempNameStr;
   SpPChar := StrScan(ItemString,'"');
   If (SpPChar <> Nil) and (SpPChar <> ItemString)
    then
     Begin
      SpPChar:=SpPChar-1;
      If SpPChar[0]=#32 then SpPChar[0]:=#13;
     end;
  except
   ItemString:=Nil;
  end;
 end;

procedure TSendMailWin.lstLinkObjActionElement(Sender: TObject; Index: Longint);
 begin
  {tDoc := DocStorage.GetDoc(Index);}
 end;

procedure TSendMailWin.sbDelObjectClick(Sender: TObject);
 begin
  If lstLinkObj.Total > 0
   then
    begin
     DocStorage.DelDoc(lstLinkObj.Current);
     lstLinkObj.Total := DocStorage.Count;
     lstLinkObj.ItemSourceChanged;
    end;
 end;

procedure TSendMailWin.lstLinkObjCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
 begin
  If (lstLinkObj.Total > 0)
   then FooterPanel.Panels[0].Text:=Format('%d из %d',[Succ(aNewCurrent),lstLinkObj.Total])
   else FooterPanel.Panels[0].Text:='';
 end;

procedure TSendMailWin.FormShow(Sender: TObject);
 begin
  memMessage.Height := Height - 220;
 end;

procedure TSendMailWin.sbAddObjectClick(Sender: TObject);
 begin
  With TDragDataSupport.Instance do
   Begin
    DragDataType  := Ord(ddMailDocLink);
    DragData      := nil;
    If Execute(Self) then
      Begin
       DocStorage.AddDoc(PGlobalCoordinateRec(AnswerData)^.Doc);
       lstLinkObj.Total := DocStorage.Count;
       lstLinkObj.Current := 0;
      end;
  end;
 end;
procedure TSendMailWin.FormDestroy(Sender: TObject);
var
 l_DocStorage: Il3ChangeNotifier;
 l_lstLinkObj: Il3ChangeRecipient;
Begin
 if (TempNameStr <> Nil) then
  l3StrDispose(TempNameStr);

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
end;

procedure TSendMailWin.FormClose(Sender: TObject;
                                 var Action: TCloseAction);
begin
 Action := caFree;
end;

end.

