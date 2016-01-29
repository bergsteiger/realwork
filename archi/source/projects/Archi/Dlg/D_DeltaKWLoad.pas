unit D_DeltaKWLoad;
{
  ���� ��� ����������� �������� ��������� �������� ����.
  ����� ��������� ������� �������� ����.
}

{ $Id: D_DeltaKWLoad.pas,v 1.24 2015/07/02 11:41:02 lukyanets Exp $ }

// $Log: D_DeltaKWLoad.pas,v $
// Revision 1.24  2015/07/02 11:41:02  lukyanets
// ��������� �������
//
// Revision 1.23  2015/07/02 07:34:41  lukyanets
// ��������� �������
//
// Revision 1.22  2014/02/14 15:33:18  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.21  2013/01/17 10:20:24  voba
// - ������� ���������� � ��������� ������
//
// Revision 1.20  2010/09/24 12:15:44  voba
// - k : 235046326
//
// Revision 1.19  2010/09/21 11:08:51  fireton
// - ��������� ������� � PChar �� Tl3WString
//
// Revision 1.18  2010/08/04 08:32:23  voba
// - k: 229672814
//
// Revision 1.17  2009/07/22 11:29:12  narry
// - ��������� ������� � DictServer
//
// Revision 1.16  2009/04/13 08:55:51  narry
// - ���������� ����������� ����� � ����������
//
// Revision 1.15  2009/01/26 08:07:27  fireton
// - ������� � ������ b_archi_NewSrch2 (����� ��-������)
//
// Revision 1.14.4.1  2008/12/22 11:11:00  fireton
// - ������� ������� �� TdtQuery
//
// Revision 1.14  2008/09/15 15:23:36  narry
// - ���������� ������ ������ � ����
//
// Revision 1.13  2008/07/07 10:06:55  voba
// - refact. ������� ������ ��� ������ �� �������� (TDictionary)
//
// Revision 1.12  2008/04/07 11:42:08  voba
// - �������� delete �� ����
//
// Revision 1.11  2008/03/24 13:37:17  narry
// - ���� �����������, ���� �� ����� ������������� ��������
//
// Revision 1.10  2008/02/07 14:43:45  lulin
// - ����� Tl3LongintList �������� � ����������� ������.
//
// Revision 1.9  2008/01/31 20:37:55  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.8  2008/01/21 12:27:39  narry
// - range check error ����� ������ BlankID �� cUndefDictID
//
// Revision 1.7  2007/12/18 07:48:21  voba
// no message
//
// Revision 1.6  2007/12/13 08:57:48  narry
// - Range check error
//
// Revision 1.5  2007/11/26 12:10:59  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.4  2007/08/14 20:25:04  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.3  2007/06/05 13:29:41  narry
// - ������ ������ �������� �����
//
// Revision 1.2  2005/11/07 16:08:21  narry
// - �����: ����������� ������������� ������ �������� ����
//
// Revision 1.1  2005/07/21 14:18:51  narry
// - new: ��������� ������� ������ �������� ����
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, vtForm, F_DocList, StdCtrls,
  dt_Query, Menus, dt_Types;

type
  TDeltaKWDialog = class(TForm)
    ListPanel: TPanel;
    DocumentPanel: TPanel;
    DocumentList1: TDocumentList;
    KeywordsList: TListBox;
    procedure KeywordsListClick(Sender: TObject);
    procedure KeywordsListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
   f_Query : TdtQuery;
   function CheckItem(aItemID: TDictID): Boolean;
   // ����� �� ������� ���� � ��������������� aItemID
    { Private declarations }
  public
    { Public declarations }
   procedure Execute(aDeltaKWFileName, aKillKWFileName: String);
  end;

var
  DeltaKWDialog: TDeltaKWDialog;

implementation

{$R *.dfm}

Uses
 l3Base,
 l3TreeInterfaces,
 l3LongintList,
 l3String,
 l3Tree_TLB,
 l3FileUtils,

 daTypes,

 dt_DictTypes, dt_Const, dt_AttrSchema,
 dt_DictConst, dt_DictIntf,
 dt_Dict,

 ddKW_r,

 TreeDWin,
 DictMetaForm,
 D_DictItemRequest,

 Math;

function TDeltaKWDialog.CheckItem(aItemID: TDictID): Boolean;
var
 l_DictIDList: Tl3LongintList;
begin
 l3Free(f_Query);
 if aItemID <> cUndefDictID then
 begin
  l_DictIDList := Tl3LongintList.Make;
  try
   l_DictIDList.Add(aItemID);
   f_Query := TdtDictQuery.Create(da_dlKeyWords, l_DictIDList, False, True {aWithSubTree});
  finally
   l3Free(l_DictIDList);
  end;
  Result := f_Query.IsEmpty;
 end
 else
  Result := True;
end;

procedure TDeltaKWDialog.Execute(aDeltaKWFileName, aKillKWFileName: String);
var
 i: Integer;
 l_Node : Il3Node;
 l_ErrorsFile: String;
begin
  with TDeltaKWReader.Create do
  try
   DeltaFileName := aDeltaKWFileName;
   KillFileName := aKillKWFileName;
   if Execute then
   begin
    //DeletedKeys.SaveToFile('f:\buffer\delta_kw\deleted.txt');
    // ��������� �����, ������� ����� �������. ��, �� ������� ����� �� ���������, �������
    i:= Pred(DeletedKeys.Count);
    while i <> -1  do
    begin
     l_Node := DictServer(CurrentFamily).Dict[da_dlKeywords].FindNodeByFullPath(l3PCharLen(DeletedKeys.Strings[i]));
     if l_Node <> nil then
     begin
      if CheckItem((l_Node as Il3HandleNode).Handle) then
      begin
       l_Node.Delete;
       DeletedKeys.Delete(i);
      end; // CheckItem(l_ID)
     end;
     Dec(i);
    end; // while i <> -1
    // ���� ��������� �� �������
    if InRange(Errors.Count, 1, 10) then
     ShowMessage(Errors.Text)
    else
    if Errors.Count > 10 then
    begin
     l_ErrorsFile:= ConcatDirName(ExtractFilePath(Application.ExeName), 'Delta_kw_errors.txt');
     Errors.SaveToFile(l_ErrorsFile);
     ShowMessage(Format('������ ������ ���������� ������ �������� ���� �������� � %s', [l_ErrorsFile]));
    end;
    // �������� �����, �� ������� ���-�� ���������. ���������� ������������ �� � ���������
    MessageDlg(Format('������ ������ ��������:'#10+
                       '������ ��������� - %d'#10+
                       '������ ���������� - %d'#10+
                       '������ ����������� - %d', [KeysAdded, KeysEdited, KeysCopied]), mtInformation, [mbOk], 0);
    if DeletedKeys.Count > 0 then
    begin
     KeywordsList.Items := DeletedKeys;
     DocumentList1.Family := CurrentFamily;
     DocumentList1.Query := f_Query;
     KeywordsList.ItemIndex := 0;
     //ShowModal;
    end // DeletedKeys.Count > 0
   end; // Execute
  finally
   Free;
  end;
 if KeywordsList.Items.Count = 0 then
  Close;
end;

procedure TDeltaKWDialog.KeywordsListClick(Sender: TObject);
begin
 // ��������� ��� ������ �������� ��������� �����
 if KeywordsList.ItemIndex <> -1 then
 begin
 { TODO -o����� -c������ : �� ����������� ������ ���������� }
  CheckItem(DictServer(CurrentFamily).Dict[da_dlKeywords].FindIdByFullPath(l3PCharLen(KeywordsList.Items[KeywordsList.ItemIndex])));
  DocumentList1.Query := f_Query;
  //DocumentList1.SrchResultLister.Total := f_Query.ListCount; ���-�� ����� ����������
 end
 else
  DocumentList1.Query := nil;
end;

procedure TDeltaKWDialog.KeywordsListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
 l_FullPath : String;
 l_NewID, l_OldID : TDictID;
 l_Node : Il3Node;
begin
 if Key = VK_DELETE then
 begin
  if KeywordsList.ItemIndex <> -1 then
  begin
   l_FullPath := KeywordsList.Items[KeywordsList.ItemIndex];
   l_Node := DictServer(CurrentFamily).Dict[da_dlKeywords].FindNodeByFullPath(l3PCharLen(l_FullPath));
   l_OldID := (l_Node as Il3HandleNode).Handle;
   l_NewID := l_OldID;
   while l_NewID = l_OldID do
   begin
    if not DictItemRequest(Self, da_dlKeywords, TDictID(l_NewID), '�������� ����� ��������', '', l_FullPath) then
     exit;
   end; // while l_NewID = l_OldID

   (l_Node as IPersistentNode).DeleteEx(l_NewID);
   //DictServer.DelDictItem(da_dlKeywords, l_OldID, l_NewID);
   KeywordsList.DeleteSelected;
   KeywordsListClick(nil);
  // DocumentList1.SrchResultLister.Total := 0;
  // DocumentList1.RefreshDocItem(0);
  end; // KeywordsList.ItemIndex <> -1
 end; // Key = VK_DELETE
end;

procedure TDeltaKWDialog.FormCreate(Sender: TObject);
begin
 f_Query := nil;
end;

procedure TDeltaKWDialog.FormDestroy(Sender: TObject);
begin
  l3Free(f_Query);
end;

procedure TDeltaKWDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
end;

end.
