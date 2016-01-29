unit ImgLoader;

{ $Id: ImgLoader.pas,v 1.13 2010/02/04 10:29:46 narry Exp $ }
// $Log: ImgLoader.pas,v $
// Revision 1.13  2010/02/04 10:29:46  narry
// - ������ ��� 131 ������ ����
//
// Revision 1.12  2008/10/20 07:02:54  fireton
// - ����������� ������������� �������-����������
//
// Revision 1.11  2007/09/10 08:36:33  fireton
// - ����������� �� ������� �������� � ID ���������� �������������
//
// Revision 1.10  2007/06/19 09:46:38  fireton
// - bug fix
//
// Revision 1.9  2007/03/15 14:10:19  fireton
// - bugfix: ���� �� ��������� ������ ���� 0
//
// Revision 1.8  2007/03/06 14:54:43  fireton
// - ���������� ������� ������������� �������
// - ���������� ������ �������� �����
//
// Revision 1.7  2007/01/29 08:12:30  fireton
// - �����������
//
// Revision 1.6  2006/12/14 10:11:09  fireton
// - ��������� "��������������" � �������
// - ������� "������� �� ���������"
// - ������ ��������������
// - ������ ����
//
// Revision 1.5  2006/12/13 13:50:57  fireton
// - ��������� ������ � ���������
// - ���� "�������� �� ��������" ��� ����, ����������� ��� "�������� �� �������� 2"
// - ������ ������� ������ � ��� ���������
// - ����������� ������ � ���� ���������
//
// Revision 1.4  2005/10/27 13:18:29  step
// ��������� ����������� ��������� �������� �������������
//
// Revision 1.3  2005/03/21 15:09:32  step
// �����������
//
// Revision 1.2  2005/03/21 14:26:47  step
// ��������� �����������
//
// Revision 1.1  2005/03/15 17:16:14  step
// �������� � CVS
//

interface

uses
 Controls, StdCtrls, ComCtrls, Forms, Classes,
 l3Base,
 Dt_Types, Dt_Link, Dt_DocImages;

type
 TImgLoader = class(Tl3Base)
 private
  f_Terminated: Boolean;
  function CheckFiles: Boolean;
  procedure pm_SetTerminated(const Value: Boolean);
  procedure ProcessSrcFile;
 protected
  procedure CleanUp; override;
 public
  SrcFile: string;
  LogFile: string;
  ByMail : Boolean;
  DocSourceId: TDictId;
  DocSourceId2: TDictId;
  ProgressLabel: TLabel;
  ProgressBar: TProgressBar;
  constructor Create;
  procedure Execute;
  property Terminated: Boolean read f_Terminated write pm_SetTerminated;
 end;

implementation

uses
 Dialogs, SysUtils,
 Dt_Doc,
 Dt_Log,
 dt_Renum,
 DT_Serv,
 DT_Const,
 DT_Err,
 Dt_LinkServ,
 l3Types,
 l3Chars,
 l3Date,
 l3DateSt,
 l3String,
 l3Stream,
 l3Parser, l3Filer;

{ TImgLoader }

function TImgLoader.CheckFiles: Boolean;
begin
 Result := False;
 SrcFile := Trim(SrcFile);
 LogFile := Trim(LogFile);
 if SrcFile = '' then
  MessageDlg('���� � ���������� ������� �� ������.',
             mtError, [mbOK], 0)
 else if not FileExists(SrcFile) then
  MessageDlg(Format('���� � ���������� ������� %s �� ������.', [SrcFile]),
             mtError, [mbOK], 0) 
 else
  Result := True;
end;

procedure TImgLoader.CleanUp;
begin
 inherited;
end;

constructor TImgLoader.Create;
begin
 inherited Create;
 ByMail := False;
 DocSourceId := 0; // �� ���������
 DocSourceId2 := 0; // �� ���������
 DocumentServer.Family := CurrentFamily;
end;

procedure TImgLoader.Execute;
var
 D1, D2: TStDate;
begin
 Screen.Cursor := crHourGlass;
 try
  if CheckFiles then
   ProcessSrcFile;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TImgLoader.pm_SetTerminated(const Value: Boolean);
begin
 f_Terminated := Value;
 if f_Terminated then
  l3System.Msg2Log('������� ������� � ������� ����������');
end;

procedure TImgLoader.ProcessSrcFile;
const
 c_Delim = #9;
var
 I: Integer;
 l_ProcessedAmount: Integer;
 l_SrcStream: Tl3FileStream;
 l_Parser   : Tl3Parser;
 l_ImageFile: string;
 l_Pages    : string;
 l_DocId: TDocId;
 l_IssueNum: string;
 l_StartDate, l_EndDate: TStDate;
 l_DelimPos: Integer;
 l_FieldNum: Integer;
 l_LineNum: Integer;
 l_BadRecords: Integer;
 l_Log: TLogBookTbl;
 l_TmpStr: string;

 procedure ClearFields();
 begin
  l_ImageFile := '';
  l_DocId := 0;
  l_Pages := '';
  l_FieldNum := 0;
  l_IssueNum := '';
  l_StartDate := 0;
  l_EndDate := 0;
 end;

 procedure BadRecord(const aStr: string);
 begin
  Inc(l_BadRecords);
  Inc(l_ProcessedAmount);
  l3System.Msg2Log(aStr);
 end;

begin
 try
  f_Terminated := False;
  l3System.Str2Log(' ');
  l3System.Msg2Log('������ �������� ���������. �������� ����: %s', [SrcFile]);
  l_Log := LinkServer(CurrentFamily).LogBook; //Attribute[atLogRecords];
  l_Log.Table.StartCaching;
  try
   l_SrcStream := Tl3FileStream.Create(SrcFile, l3_fmRead);
   try
    //LinkServer.Family := CurrentFamily;
    DocImageServer.StartBatch;
    try
     ProgressBar.Min := 0;
     ProgressBar.Max := l_SrcStream.Size;
     ProgressBar.Step := 1;

     l_ProcessedAmount := 0;
     l_BadRecords := 0;
     l_Parser := Tl3Parser.Make(l_SrcStream, [], [#32..#255], [cc_Tab]);
     try
      ClearFields;
      l_LineNum := 0;
      repeat
       l_Parser.NextTokenSp;
       case l_Parser.TokenType of
        l3_ttSymbol:
         begin
          Inc(l_FieldNum);
          case l_FieldNum of
           1 : l_ImageFile := l3OEM2ANSI(Trim(l_Parser.TokenString));
           2 : l_DocId := StrToIntDef(l_Parser.TokenString, -1);
           3 : l_Pages := Trim(l_Parser.TokenString);
           4 : l_IssueNum := l_Parser.TokenString;
           5 : l3StrToDateInterval(l_Parser.TokenString, l_StartDate, l_EndDate);
          end;
         end;
        l3_ttEOL, l3_ttEOF:
         begin
          Inc(l_LineNum);
          if l_FieldNum > 1 then
          begin
           if l_DocId > -1 then
           begin
            // ����������� �������� l_ImageFile
            ProgressLabel.Caption := SysUtils.Format('�������������� �������� %d', [l_DocId]);
            ProgressBar.Position := l_Parser.Filer.Pos;
            Application.ProcessMessages;
            l_DocId := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_DocId);

            if DocumentServer.FileTbl.HasUniqRec(l_DocId) then
            begin
             // ���� ��� ����� ������, �� ���� ������ ���������� �� ����, �� ��� ����.
             // ���� ������ �������� ������.
             if (l_ImageFile = '.') or FileExists(l_ImageFile) then
             begin
              try
               if l_ImageFile = '.' then
                l_ImageFile := '';
               DocImageServer.Add(l_DocId, l_ImageFile, [DocSourceId, DocSourceId2], l_Pages,
                    l_IssueNum, l_StartDate, l_EndDate, True, ByMail);
               l_Log.PutLogRec(l_DocId, acPublInWork);
               Inc(l_ProcessedAmount);
              except
               on E: Exception do
                BadRecord(Format('������ (������ %d): ', [l_LineNum]) + E.Message);
              end;
             end
             else
              BadRecord(Format('������ (������ %d): ���� ������ (%s) �� ������', [l_LineNum, l_ImageFile]));
            end
            else
             BadRecord(Format('������ (������ %d): �������� ����� ���������', [l_LineNum]));
           end
           else
            BadRecord(Format('������ (������ %d): ����� ��������� �� �������� ������', [l_LineNum]));
          end
          else
           if l_FieldNum > 0 then // ������ ������ ����������
            BadRecord(Format('������ (������ %d): �� ������ ����� ���������', [l_LineNum]));
          ClearFields;
         end;
       end;
      until f_Terminated or (l_Parser.TokenType = l3_ttEOF);
     finally
      l3Free(l_Parser);
      l_TmpStr := SysUtils.Format('����� ���������� %d ����������.  �� ��� ���������� %d.',
                                               [l_ProcessedAmount, l_BadRecords]);
      ProgressLabel.Caption :=  l_TmpStr;
      l3System.Msg2Log(l_TmpStr);
     end;
    finally
     DocImageServer.StopBatch;
    end;
   finally
    FreeAndNil(l_SrcStream);
   end;
  finally
   l_Log.Table.StopCaching;
  end;
 except
  // ����� ������ � ���������� (����� ��� �� �������� � ���)
  on E: EHtErrors do
   if E.ErrorValue <> -25 then
    raise;
  else
   raise;    
 end;
end;

end.

