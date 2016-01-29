unit alcuMDP;
{ ���������� � MDP ��� ������-������ ���������� }

{ $Id: alcuMDP.pas,v 1.1 2015/09/09 13:26:28 lukyanets Exp $ }

// $Log: alcuMDP.pas,v $
// Revision 1.1  2015/09/09 13:26:28  lukyanets
// ��������� ������� ����������
//
// Revision 1.4  2015/03/04 12:09:19  lukyanets
// ������� ����������
//
// Revision 1.3  2015/03/02 08:46:09  lukyanets
// ���������� ������
//
// Revision 1.2  2015/02/27 13:30:38  lukyanets
// ����� � ���
//
// Revision 1.1  2015/02/25 08:48:35  lukyanets
// MDPSync ���������� ����� ����� ������.
//
// Revision 1.24  2015/01/27 08:40:37  fireton
// - ����������� �������� �������� ������ ��� �������
//
// Revision 1.23  2014/08/19 14:29:53  lukyanets
// {Requestlink:558466572}. ���������� alcuMDP � ������
//
// Revision 1.6  2014/07/21 09:26:38  lulin
// - ��������� ������.
//
// Revision 1.5  2014/07/14 12:20:55  fireton
// - ����� �� �������� ������
//
// Revision 1.4  2014/07/08 12:36:53  lulin
// - ��������� ����������� ��� �������.
//
// Revision 1.3  2014/06/09 10:31:20  fireton
// - �� ����������
//
// Revision 1.2  2014/05/27 12:04:00  lulin
// - ������ ����.
//
// Revision 1.21  2014/02/20 06:48:02  fireton
// - ���������� ������
//
// Revision 1.20  2013/09/23 09:03:53  fireton
// - ����� �� ������� � ��������� ����������
//
// Revision 1.19  2013/09/20 10:27:18  fireton
// - ������� � ��������� ���������
//
// Revision 1.18  2013/04/16 13:10:52  narry
// ����������
//
// Revision 1.17  2012/10/02 07:40:33  narry
// ��� ���� ������� - ������ � ������ ������
//
// Revision 1.16  2012/02/01 08:45:48  narry
// �� ������������������� �� �������
//
// Revision 1.15  2012/01/12 08:13:28  narry
// ������� ��� �� ������ ��� ������������ (307790632)
//
// Revision 1.14  2011/12/26 05:30:08  narry
// ������� ��� �� ������ ��� ������������ (307790632)
//
// Revision 1.13  2011/12/21 12:50:59  narry
// ������ ����������
//
// Revision 1.12  2011/12/21 09:52:52  narry
// ����������
//
// Revision 1.11  2011/12/15 13:02:07  narry
// ���������� �� ����� (319488062)
//
// Revision 1.10  2011/12/08 09:57:40  narry
// ���� ������ ���, �� ������ � ������ ����� ������ ������ (317260640)
//
// Revision 1.9  2011/12/08 09:55:33  narry
// ���� ������ ���, �� ������ � ������ ����� ������ ������ (317260640)
//
// Revision 1.8  2011/12/08 09:52:26  narry
// ���� ������ ���, �� ������ � ������ ����� ������ ������ (317260640)
//
// Revision 1.7  2011/12/07 13:02:07  fireton
// - ������ ����� ������ ���������� �� ������������� ���������� �� ����� ������� (315261974)
//
// Revision 1.6  2011/12/07 11:28:00  narry
// �������� ������ ������� (316113254)
//
// Revision 1.5  2011/11/24 08:32:43  narry
// ��� ����� � �������� (303530024)
//
// Revision 1.4  2011/11/23 12:47:10  fireton
// - ������ ������ �� ��������� �������� ���������� ������� �� MDP
//
// Revision 1.3  2011/11/16 13:17:48  narry
// ����������� � ��������� ����� ���������� (288786332)
//
// Revision 1.2  2011/11/16 10:49:22  narry
// ���������� ������� �� � � ������ ������������� (298682480)
//
// Revision 1.1  2011/11/16 10:17:36  narry
// ���������� ������� �� � � ������ ������������� (298682480)
//

interface

uses
  ddProgressObj,
  ddMDPIntegration,
  Classes,
  DT_Types,
  l3ProtoObject,
  l3RecList,
  l3ProtoObjectRefList,
  l3ObjectRefList,
  csMessageManager,

  k2Base
  ;

type
 TalcuMDPSyncronizer = class(Tl3ProtoObject)
 private
  f_Errors: TStrings;
  f_BatchDocs: Tl3ObjectRefList;
  f_GoodDocs: Tl3ObjectRefList;
  f_Tool: TddMDPImporter;
  procedure ErrorReaction(const aDescription: String; aCategory: Integer);
  procedure SendReport(aOnlyErrors: Boolean; const aMail, aErrorMail: String);
  procedure DocumentReaction(const aResult: TddMDPImportResultObj);
  procedure BatchStart(aBatch: TddMDPDocBatchType);
  procedure BatchSuccess(aBatch: TddMDPDocBatchType);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure Execute(const aProgressor: TddProgressObject; aMaxCount: Integer; const aMail, aErrorMail: String);
  procedure AbortImport;
 end;


implementation

uses
  l3Base,
  SysUtils,
  CsTaskTypes,
  alcuMailServer,
  StrUtils,
  alcuTypes,
  l3Types
  ;

constructor TalcuMDPSyncronizer.Create;
begin
 inherited Create;
 f_GoodDocs := Tl3ObjectRefList.MakeSorted(l3_dupAccept);
 f_BatchDocs := Tl3ObjectRefList.MakeSorted(l3_dupAccept);
 f_Errors := TStringList.Create;
end;

procedure TalcuMDPSyncronizer.Cleanup;
begin
 inherited Cleanup;
 FreeAndNil(f_GoodDocs);
 FreeAndNil(f_BatchDocs);
 FreeAndNil(f_Errors);
end;

procedure TalcuMDPSyncronizer.ErrorReaction(const aDescription: String; aCategory:
    Integer);
begin
 // �������� ������ �� ����� ���������
 f_Errors.Add(aDescription);
 l3System.Msg2Log('������ "%s"', [aDescription]);
end;

procedure TalcuMDPSyncronizer.DocumentReaction(const aResult: TddMDPImportResultObj);
begin
 f_BatchDocs.Add(aResult);
// f_GoodDocs.Add(aResult);
end;

procedure TalcuMDPSyncronizer.SendReport(aOnlyErrors: Boolean; const aMail, aErrorMail: String);
var
 l_Msg,
 l_ListMsg, l_ErrorMsg,
 l_Subj: String;
 l_NeedSend: Boolean;
 i: Integer;
 l_TopDocs: Boolean;
begin
 if (aMail <> '') then
 begin
  l_ErrorMsg:= '';
  l_ListMsg:= '';
  l_Subj:= '������������� � MDP';
  l_NeedSend:= False;

  if not aOnlyErrors then
  begin
   if f_GoodDocs.Count > 0 then
   begin
    l_ListMsg:= '������ ��������������� ����������:'#13#10#13#10;
    l_NeedSend:= True;

    if TddMDPImportResultObj(f_GoodDocs[0]).rIsTop then
    begin
     l_ListMsg:= l_ListMsg + '�������:'#13#10#13#10;
     l_TopDocs := True;
    end
    else
     l_TopDocs := False;

    for i:= 0 to f_GoodDocs.Hi do
     with TddMDPImportResultObj(f_GoodDocs[i]) do
     begin
      if l_TopDocs and not rIsTop then
      begin
       l_ListMsg:= l_ListMsg + #13#10'�������:'#13#10#13#10;
       l_TopDocs := False;
      end;
      l_Msg:= Format('%d'#9'%s; %s (%s)', [rDocID, rComment, rName, IfThen(rIsNew, '�����', '����������')]);
      //l3System.Msg2Log('%3d %s', [Succ(i), l_Msg]);
      l_ListMsg:= l_ListMsg + l_Msg + #13#10#13#10;
     end;
   end
   else
   begin
    l_Subj:= l_Subj + ' - ���������� ���';
    l_ListMsg:= '����� ��� ������������ ���������� �� ��������';
   end;
  end; // not aOnlyErrors

  if f_Errors.Count > 0 then
  begin
   l_Subj:= l_Subj + ' (������)';
   l_ErrorMsg:= Format('������ ������:'#13#10'%s', [f_Errors.Text]);
   l_NeedSend:= True;
  end;

  if l_NeedSend then
  begin
   if aOnlyErrors then
    l_Msg:= l_ErrorMsg
   else
    l_Msg:= l_ListMsg + #13#10#13#10 + l_ErrorMsg;
   try
    if aOnlyErrors then
     l3System.Msg2Log('�������� ������ �� �������')
    else
     l3System.Msg2Log('�������� ������');
    if not alcuMail.SendEmail(IfThen(aOnlyErrors, aErrorMail,
                                           aMail), l_Msg, l_Subj) then
    begin
      raise Exception.Create('�������� �����������');
    end;
    l3System.Msg2Log('����� ��������� �������');
   except
    on E: Exception do
    begin
     l3System.Msg2Log('������ �������� ������ (%s: %s). ��������� � ���.', [E.ClassName, E.Message]);
     l3System.Str2Log(l_Msg);
     l3System.Exception2Log(E);
    end;
   end;
  end; // l_NeedSend
 end;
end;

procedure TalcuMDPSyncronizer.Execute(const aProgressor: TddProgressObject; aMaxCount: Integer; const aMail, aErrorMail: String);
begin
 try
  try
   f_Tool := TddMDPImporter.Create;
   try
    f_Tool.OnError := ErrorReaction;
    f_Tool.Import(ErrorReaction, DocumentReaction, BatchStart, BatchSuccess, aProgressor, aMaxCount);
   finally
    FreeAndNil(f_Tool);
   end;
  finally
   {$IFNDEF MDP_TEST}
   SendReport(False, aMail, aErrorMail);
   SendReport(True, aMail, aErrorMail);
   {$ENDIF}
  end; 
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   // �����������?
   //alcuMail.SendEmailNotify(eventMDPSync, True, E.Message, dd_apsMDPSync);
  end;
 end;
end;

procedure TalcuMDPSyncronizer.BatchStart(aBatch: TddMDPDocBatchType);
begin
 f_BatchDocs.Clear;
end;

procedure TalcuMDPSyncronizer.BatchSuccess(aBatch: TddMDPDocBatchType);
var
 l_IDX: Integer;
begin
 for l_IDX := 0 to f_BatchDocs.Count - 1 do
  f_GoodDocs.Add(f_BatchDocs[l_IDX]);
 f_BatchDocs.Clear;
end;

procedure TalcuMDPSyncronizer.AbortImport;
begin
 if Assigned(f_Tool) then
  f_Tool.AbortImport;
end;

end.
