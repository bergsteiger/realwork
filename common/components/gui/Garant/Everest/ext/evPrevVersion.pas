unit evPrevVersion;

{* ������� � ���������� ������ ��������� }

// $Id: evPrevVersion.pas,v 1.38 2015/06/19 12:17:16 dinishev Exp $

// $Log: evPrevVersion.pas,v $
// Revision 1.38  2015/06/19 12:17:16  dinishev
// {Requestlink:601992178}
//
// Revision 1.37  2015/05/20 16:28:42  lulin
// - ������ ���.
//
// Revision 1.36  2015/05/19 11:14:35  lulin
// - ������ ���.
//
// Revision 1.35  2015/05/13 13:18:50  lulin
// {RequestLink:588034502}. �������������.
//
// Revision 1.34  2015/05/13 13:14:24  lulin
// {RequestLink:588034502}. �������������.
//
// Revision 1.32  2015/05/13 12:49:29  lulin
// {RequestLink:588034502}. �������������.
//
// Revision 1.31  2015/05/12 15:16:00  lulin
// {RequestLink:588034502}. ���������� ��������� ����� ������� (���������) ������.
//
// Revision 1.30  2015/05/12 14:26:14  lulin
// {RequestLink:588034502}.
//
// Revision 1.29  2015/04/28 10:45:12  lulin
// - ����������.
//
// Revision 1.28  2015/04/27 10:52:13  lulin
// - ����������.
//
// Revision 1.27  2015/04/22 06:01:25  dinishev
// Bug fix: �� �������������� �������� ����.
//
// Revision 1.26  2015/04/21 15:53:10  voba
// - ��������� evPrevVersion ��� �������� �� ���� ������������
//
// Revision 1.25  2015/04/16 07:30:33  fireton
// - �� ����������
//
// Revision 1.24  2015/04/15 15:30:56  voba
// -bf
//
// Revision 1.23  2015/04/03 15:03:12  voba
// -bf
//
// Revision 1.22  2015/03/17 11:16:19  lulin
// - ������������� �����������.
//
// Revision 1.21  2015/03/13 11:55:45  voba
// - ��������� �������������� ����������
//
// Revision 1.20  2014/09/16 15:13:10  lulin
// - �������� ������ ��� ������ � ����������� � ��������� �����.
//
// Revision 1.19  2014/09/11 12:25:42  lulin
// - ��������� � ����������� ������ � �����.
//
// Revision 1.18  2014/08/06 14:21:33  voba
// - ��������� ����� � ����������� ������
//
// Revision 1.17  2013/01/22 15:52:01  kostitsin
// [$424399029]
//
// Revision 1.16  2012/11/30 15:13:28  voba
// - tune
//
// Revision 1.15  2012/02/17 14:16:50  dinishev
// ������ ��� ���������� ������� _afwAnswer
//
// Revision 1.14  2012/01/17 06:08:06  dinishev
// {Requestlink:327812385}
//
// Revision 1.13  2009/07/20 12:39:20  voba
// - ������� renum � ��������
//
// Revision 1.12  2009/03/17 14:07:41  lulin
// - ���������� ��������� ��������� � ���������� ����� ������� �� ������.
//
// Revision 1.11  2009/01/16 10:19:40  narry
// - �� �������� ������ ������ ���������
//
// Revision 1.10  2008/05/20 12:03:57  lulin
// - <K>: 90448469.
//
// Revision 1.9  2008/05/08 10:00:07  dinishev
// Merge ����������� � �����
//
// Revision 1.8  2008/04/23 09:52:55  lulin
// - <K>: 89105866.
//
// Revision 1.7  2007/12/04 12:47:41  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.3  2007/06/19 08:50:41  dinishev
// bug fix: �� ���������������
//
// Revision 1.1.2.2  2006/12/05 14:15:34  lulin
// - ������� �������� � ���������� ����������.
//
// Revision 1.1.2.1  2006/02/09 13:54:26  lulin
// - ���� ����������� ������� ������� Archi � ��������� �� �����.
//
// Revision 1.31  2005/10/06 09:38:10  lulin
// - ������� ����� ������� �������� � ����� ���������� �����.
//
// Revision 1.30  2005/05/27 15:36:50  lulin
// - ������� ������� �������� � ���������� L3.
//
// Revision 1.29  2005/04/06 16:08:20  voba
// - bug fix: �� ����������������� ����� ������ ������ ����� ���������� ���������
//
// Revision 1.28  2005/04/05 15:17:26  voba
// - bug fix
//
// Revision 1.27  2005/04/05 10:06:40  narry
// - update
//
// Revision 1.26  2005/03/31 11:55:08  narry
// - Update: ��� ����� ���������� ��������� �� ������������ ����� ������ ������
//
// Revision 1.25  2005/03/30 13:48:34  narry
// - update: �������� ������ �� ��������� ���������
//
// Revision 1.24  2005/03/17 15:58:35  lulin
// - ����� ������ ��������/������� ��������� ����� ����������, � �� ������ Boolean'��.
//
// Revision 1.23  2005/02/18 14:26:38  voba
// - ���� DOCID � Family � ����� ����� DocInfo
//
// Revision 1.22  2005/02/14 16:41:23  lulin
// - � ����������� ������� ����������� ������� � ����� ������� ��������� ��������.
//
// Revision 1.21  2005/02/14 15:33:59  lulin
// - bug fix: �� ���������������.
//
// Revision 1.20  2004/12/11 12:02:40  lulin
// - � uses �����, ��������������� Delphi.
//
// Revision 1.19  2004/11/25 09:29:21  lulin
// - ��������� ����.
// - ���������� ������ - �� ���������������.
//
// Revision 1.18  2004/09/21 11:22:23  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.17  2004/09/02 15:55:20  law
// - cleanup: ������ ������ m3BackupFiler.
//
// Revision 1.16  2004/08/30 14:43:09  law
// - cleanup.
//
// Revision 1.15  2004/08/27 15:13:30  voba
// - merge with B_New_Text_Base
//
// Revision 1.14.6.1  2004/08/25 16:36:24  law
// - ���������� ������������ �� ������� ������������� ������� ���������.
//
// Revision 1.14  2004/05/06 16:11:49  law
// - new method: Tm3BackupFiler.Make.
//
// Revision 1.13  2003/11/06 09:29:10  voba
// no message
//
// Revision 1.12  2003/07/16 16:04:55  voba
// - bug fix: ��������� ������ �������� ������ ���������
// - new: ��������� ������ �����, ���� �������� ����������� ���������������
//
// Revision 1.11  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.10  2003/02/11 10:05:33  voba
// - change: IUnknown ������ TObject.
//
// Revision 1.9  2002/10/18 09:35:24  narry
// - bug fix: ��� ��������� � ����� ������������ ����������, ��� ����������� ���
//
// Revision 1.8  2002/10/17 13:56:47  narry
// - update: ��������������, ���� � ��������� ��� ���������
//
// Revision 1.7  2002/10/17 12:32:43  voba
// - new design
//
// Revision 1.6  2002/10/16 14:42:09  narry
// - update: ��������� ������ ���������� ������ ������ ������, ������������ ������ � ��������� ����������� ������
//
// Revision 1.5  2002/10/16 14:15:52  narry
// - bug fix: �� ��������� ����� ������� ������.
//
// Revision 1.4  2002/10/16 12:15:07  narry
// - new behavior: ����� ���� � ������� �������� �����
//
// Revision 1.3  2002/10/16 11:49:17  narry
// - update: ����� ���������� ��������� ������������� ������ ������
//
// Revision 1.2  2002/10/16 11:10:30  voba
// - new behavior: ��������� ��������� ������ ������ � ���� ���������
//
// Revision 1.1  2002/10/16 09:10:57  narry
// - ����� �� ���������� ������ ���������
//

{$I ddDefine.inc }

interface

uses
  Windows, 
  Messages, 
  SysUtils, 
  Variants, 
  Classes, 
  Graphics, 
  Controls, 
  Forms,
  ActiveX,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Buttons,

  OvcBase,

  m3DBInterfaces,

  evCustomEditor,
  evEditorWindow,
  evEditor,
  evMemo,
  evSubPn,
  evToolPanel,
  evLinkedToolPanel,
  evRuler,
  evTextSource,
  evMultiSelectEditorWindow,
  evEditorWithOperations,
  evTunedEditor,
  evEditorWindowTextSource,

  l3InterfacedComponent,
  l3ProgressComponent,

  DocIntf,
  BottomBtnDlg,
  Main,

  vtPanel,

  afwControl, evCustomTextSource, afwTextControlPrim, afwTextControl,
  afwControlPrim, afwBaseControl, nevControl, evCustomEditorWindowPrim,
  evCustomEditorWindow, evCustomEditorWindowModelPart,
  evCustomEditorModelPart, afwInputControl, vtLister, vtOutliner,
  evSubPanel;

type
  TddDocumentVersionForm = class(TBottomBtnDlg)
    evEditor1: TevEditor;
    evTextSource1: TevTextSource;
    evSubPanel1: TevSubPanel;
    otlVersionList: TvtOutliner;
    Splitter1: TSplitter;
    //procedure PrevVersionButtonClick(Sender: TObject);
    //procedure NextVersionButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure otlVersionListCurrentChanged(Sender: TObject; aNewCurrent,aOldCurrent: Integer);
  private
    { Private declarations }
   //f_DocID: Longint;
   //f_UserDocID: Longint;
   //f_Version: Longint;
   f_DocumentStream : Tm3DocPartSelector;
   //f_MaxVersion: Longint;
   //f_BaseName: String;


   fStgSel : TStgSelector;
   fVer    : integer;
   fDocument : TarCustomDocument;

   //procedure SetDocID(Value: Longint);
   procedure LoadVerList;
   function LoadVersion(aStg : TStgSelector; aVersion : Integer): Boolean;
  protected
  public
    { Public declarations }
   //procedure SetDocument(aDoc : TarCustomDocument);
   procedure Execute(aDoc : TarCustomDocument);

   //property Version: Longint
   // read f_Version;

  // property MaxVersion: Longint
   // read f_MaxVersion;

    {-}
   property DocumentStream: Tm3DocPartSelector
     read f_DocumentStream
     write f_DocumentStream;
     {-}
  end;

var
  ddDocumentVersionForm: TddDocumentVersionForm;

procedure ReplaceVersionInEditor(aDocument : TarCustomDocument;
                                 aDocPart  : Tm3DocPartSelector;
                                 const aSubDescriptors: TevSubDescriptors);

implementation

{$R *.dfm}
Uses
 l3Base,
 l3Stream,
 l3Date,
 l3InterfacesMisc,

 ComObj,
 m3StorageInterfaces,
 m3BackupTools,
 m3StorageTools,
 m3DB,
 m3SimpleDB,

 evTypes,
 evInternalInterfaces,

 nevBase,
 nevTools,

 vtDialogs,

{$IFDEF InsiderTest}
 afwAnswer,
{$ENDIF InsiderTest}

 dt_Const,
 dt_Serv,
 dt_LinkServ,
 l3Tree, l3Nodes,
 l3Tree_TLB,
 l3TreeInterfaces,
 l3BatchService
 ;

type
 TPathStr = string;

procedure ReplaceVersionInEditor(aDocument : TarCustomDocument;
                                 aDocPart  : Tm3DocPartSelector;
                                 const aSubDescriptors: TevSubDescriptors);
var
 l_ShowModal : Integer;
 l_IStream   : IStream;
 l_Version   : Longint;
begin
 //if GetMaxVersionNumber(aDocument.GetGlobalStoragePath, aDocument.DocID) < 0 then
 //begin
 // vtMessageDlg(l3CStr('������ �������� �� ���������'), mtInformation);
 // Exit;
 //end;

 with TddDocumentVersionForm.Create(Application) do
 try
  //BaseName:= aBaseName;
  //DocID:= aDocument.DocID;
  //UserDocID:= aDocument.UserDocID;
  DocumentStream := aDocPart;
  evSubPanel1.SubDescriptors := aSubDescriptors;

  Execute(aDocument);
 finally
  Free;
 end // TddDocumentVersionForm
end;

(*function m3COMOpenStorage(const AStorage : Im3IndexedStorage;
                          anIndex        : Longint;
                          aStatStgMode   : Longint;
                          aTryCreate     : Boolean): Im3IndexedStorage;
begin
 OleCheck(m3COMSafeOpenStorage(aStorage, anIndex, aStatStgMode, aTryCreate, Result));
end;*)

function GetMaxVersionNumber(const aBase: Im3DB; aDocHandle: Integer): Integer;
var
 l_Storage  : Im3IndexedStorage;
 l_Stream   : IStream;
begin
 Result := -1;
  try
   l_Storage := aBase.GetVersionsStorage(m3_saRead);
   try
    l_Storage := m3COMOpenStorage(l_Storage,
                                  aDocHandle,
                                  m3_saRead,
                                  false);
    if (l_Storage = nil) then
     Exit;
    l_Stream :=  m3COMOpenStream(l_Storage,
                                 0,
                                 m3_saRead,
                                 false);
    try
     if (l_Stream.Read(@Result, SizeOf(Result), nil) = S_False) then begin
      Result := -1;
      Exit;
     end;
     Dec(Result);
    finally
     l_Stream := nil;
    end;//try..finally
   finally
    l_Storage := nil;
   end;//try..finally
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;//try..except
end;//GetMaxVersionNumber

function HasMainVersion(const aBase: Im3DB; aDocHandle: Integer; aDocPart: Tm3DocPartSelector): boolean;
var
 l_Stream   : IStream;
begin
 Result := false;
 try
  l_Stream := aBase.GetDocument(aDocHandle).GetConst.Open(m3_saRead, aDocPart);
  Result := (l_Stream <> nil);
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   l_Stream := nil;
  end;//on E: Exception
 end;//try..except
end;


(*procedure TddDocumentVersionForm.PrevVersionButtonClick(Sender: TObject);
begin
 Dec(f_Version);
 if f_Version >= 0 then
 begin
  NextVersionButton.Enabled:= True;
  LoadVersion;
 end;
 PrevVersionButton.Enabled:= Version > 0;
end;

procedure TddDocumentVersionForm.NextVersionButtonClick(Sender: TObject);
begin
 Inc(f_Version);
 if f_Version < f_MaxVersion then
 begin
  PrevVersionButton.Enabled:= True;                                                             l
  LoadVersion;
 end
 else
  LoadVersion(True);
 NextVersionButton.Enabled:= Version < f_MaxVersion;
end;
 *)
(*
procedure TddDocumentVersionForm.SetDocID(Value: Longint);
begin
 f_DocID:= Value;
 f_UserDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(f_DocID);
 f_Version:= 0;
 f_MaxVersion:= -1;
 PrevVersionButton.Enabled:= False;
 if BaseName <> '' then
 begin
  f_MaxVersion:= m3GetMaxVersionNumber(BaseName, DocID);
  LoadVersion(f_MaxVersion = 0);
 end; // BaseName <> ''
 NextVersionButton.Enabled:= f_MaxVersion > 0;
end;
*)

function GetVersionForRead(const aBase: Im3DB;
  aDocHandle: Integer;
  aDocPart: Tm3DocPartSelector;
  //aIndex: Integer;
  aLevel: Integer): IStream;
   {* �������� ������ ��������� �� ����������� }

 procedure DoGetVersion;
 begin//DoGetVersion
  // - ��������, ����� ����� ��������� ���������
  Result := aBase.GetDocument(aDocHandle).GetVersion(aLevel).Open(m3_saRead, aDocPart, 0);
  //Result := m3GetVersionForRead(aBase.GetVersionsStorage(m3_saRead), aDocHandle, False, aDocPart, 0{aIndex}, aLevel);
 end;//DoGetVersion                                                                            k

begin
 DoGetVersion;
end;

function TddDocumentVersionForm.LoadVersion(aStg : TStgSelector; aVersion : Integer): Boolean;
var
 l_IStream: IStream;
 //l_VersionDateTime: TDateTime;
 //l_Template: string;
 //l_PrevStatus, l_NextStatus : Boolean;
 lStgPath : TPathStr;
begin
 Screen.Cursor := crHourGlass;

 case aStg of
  ssLocal:
   lStgPath := fDocument.GetLocalStoragePath;
  ssGlobal:
   lStgPath := fDocument.GetGlobalStoragePath;
 end;//case aStg

 try
  try
   if (aVersion = Cm3ConstVersion) then
   begin
    l_IStream := Tm3DB.Make(lStgPath).GetDocument(fDocument.DocID).GetConst.Open(m3_saRead, DocumentStream);
    //l_IStream := m3GetMain(lStgPath, false, fDocument.DocID);
    Assert(l_IStream <> nil);
(*    if l_IStream = nil then
     l_IStream:= GetVersionForRead(lStgPath, fDocument.DocID, DocumentStream, 0, Cm3ConstVersion{aVersion});*)
   end//aVersion = Cm3ConstVersion
   else
   begin
    case aStg of
     ssLocal:
      l_IStream:= GetVersionForRead(Tm3SimpleDB.Make(lStgPath), fDocument.DocID, DocumentStream, aVersion);
     ssGlobal:
      l_IStream:= GetVersionForRead(Tm3DB.Make(lStgPath), fDocument.DocID, DocumentStream, aVersion);
    end;//case aStg
   end;//aVersion = Cm3ConstVersion

   evTextSource1.New;
   evTextSource1.DocumentContainer.TagWriter.WriteTag(evEditor1.View, cf_EverestBin, l_IStream);

   (*
   try
    Result := l_IStream <> nil;
    if Result then
    begin
     l_VersionDateTime:= m3GetVersionDateTime(fDocument.GetGlobalStoragePath, fDocument.DocID, aVersion);
     if l_VersionDateTime = BadDateTime then
      l_Template:= '�������� � %d (������ %d)'
     else
      l_Template:= '�������� � %d (������ �� '+
                   FormatDateTime('h:nn:ss d/m/yy', l_VersionDateTime)+')';
     //Caption:= Format(l_Template, [f_UserDocID, f_Version]);

     evTextSource1.DocumentContainer.TagWriter.WriteTag(evEditor1.View, cf_EverestBin, l_IStream);
    end // Result
    else
    begin
     evTextSource1.New;
     Caption:= '���������� � ������ ��������� �����������'
    end;
    *)
    evTextSource1.Invalidate;
   finally
    l_IStream:= nil;
   end;
  //except
   //Result:= f_MaxVersion > 0;
  //end;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TddDocumentVersionForm.FormCreate(Sender: TObject);
begin
 evEditor1.ShowDocumentParts:= True;
 //otlVersionList.Visible := false;
 //Splitter1.Visible := false;
end;

procedure TddDocumentVersionForm.LoadVerList;

 function GetVerName(const aBase : Im3DB; aVersion : Integer) : AnsiString;
 var
  l_VersionDateTime: TDateTime;
 begin
  //case aStgSel of
  // ssLocal  : lStgPath := fDocument.GetLocalStoragePath;
  // ssGlobal : lStgPath := fDocument.GetGlobalStoragePath;
  //end;

  l_VersionDateTime:= aBase.GetDocument(fDocument.DocID).GetVersion(aVersion).DateTime;
  if l_VersionDateTime = BadDateTime then
   Result := format('������ #%d',[aVersion])
  else
   Result := '������ �� '+ FormatDateTime('h:nn:ss dd-mmm-yy', l_VersionDateTime);
 end;

var
 lNode : Il3Node;
 lHasMainVer : boolean;
 lVerCnt : integer;
 I : Integer;
 lStgPath : TPathStr;
 l_DB : Im3DB;

begin
 with otlVersionList.CTree do
 begin
  Changing;
  try
   lStgPath := fDocument.GetLocalStoragePath;
   l_DB := Tm3SimpleDB.Make(lStgPath);
   lVerCnt := GetMaxVersionNumber(l_DB, fDocument.DocID);
   if lVerCnt >=0 then
   begin
    lNode := InsertNode(CRootNode, MakeNode('���������'));
    for I := 0 to lVerCnt do
    begin
     InsertNode(lNode, MakeParamNodeStr(GetVerName(l_DB, I), -(I+1)));
    end;
    otlVersionList.ExpandNode(lNode, True);
   end;

   l_DB := nil;

   lStgPath := fDocument.GetGlobalStoragePath;
   
   l_DB := Tm3DB.Make(lStgPath);
   lHasMainVer := HasMainVersion(l_DB, fDocument.DocID, DocumentStream);

   lVerCnt := GetMaxVersionNumber(l_DB, fDocument.DocID);
   if lHasMainVer or (lVerCnt >=0) then
   begin
    lNode := InsertNode(CRootNode, MakeNode('�� �������'));
    for I := 0 to lVerCnt do
    begin
     InsertNode(lNode, MakeParamNodeStr(GetVerName(l_DB, I), I));
    end;

    if lHasMainVer then
     InsertNode(lNode, MakeParamNodeStr('�������� ������', Cm3ConstVersion));

    otlVersionList.ExpandNode(lNode, True);
   end;
   l_DB := nil;
  finally
   Changed;
  end;
 end;
end;

procedure TddDocumentVersionForm.Execute(aDoc : TarCustomDocument);
{$IFDEF InsiderTest}
var
 l_ShowModal : Integer;
{$ENDIF InsiderTest}
begin
 fDocument := aDoc;
 LoadVerList;
  {$IFDEF InsiderTest}
  if Tl3BatchService.Instance.IsBatchMode then
  begin
   Show;
   l_ShowModal := Tl3BatchService.Instance.PopAnswer;
   if l_ShowModal = mrOK then
    Tl3BatchService.Instance.SignalWasDialog;
  end // if g_BatchMode then
  else
   l_ShowModal := ShowModal;
  if l_ShowModal = mrOK then
  {$ELSE}
  if ShowModal = mrOK then
  {$ENDIF InsiderTest}
  begin
   fDocument.LoadPrevVersion(fStgSel, fVer, DocumentStream);
  end; //ShowModal = mrOK

 fDocument := nil;
end;

procedure TddDocumentVersionForm.otlVersionListCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
begin
  inherited;
  if otlVersionList.TreeStruct.Nodes[aNewCurrent].GetLevelFor(otlVersionList.CTree.CRootNode) < 2 then Exit;

  fVer := (otlVersionList.TreeStruct.Nodes[aNewCurrent] as Il3HandleNode).Handle;

  if fVer < 0 then
  begin
   fStgSel := ssLocal;
   fVer := - (fVer + 1);
  end
  else
   fStgSel := ssGlobal;


   OK.Enabled := True;
   LoadVersion(fStgSel, fVer);
end;

end.
