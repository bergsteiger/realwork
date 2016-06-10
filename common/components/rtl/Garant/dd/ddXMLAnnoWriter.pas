//..........................................................................................................................................................................................................................................................
unit ddXMLAnnoWriter;
{* ����������� ������� ������� � HTML }


//$Id: ddXMLAnnoWriter.pas,v 1.18 2016/05/12 10:34:20 dinishev Exp $

// $Log: ddXMLAnnoWriter.pas,v $
// Revision 1.18  2016/05/12 10:34:20  dinishev
// �������� �����������.
//
// Revision 1.17  2014/07/11 11:01:38  dinishev
// {Requestlink:553914086}. ������ �� ������� ������ - ���������� ����������� rtf.
//
// Revision 1.16  2014/03/28 06:53:30  dinishev
// Bug fix: �� ���������� ������ ������.
//
// Revision 1.15  2014/01/10 11:14:36  dinishev
// {Requestlink:510621098}. ������� TddCellProperty �� ������.
//
// Revision 1.14  2013/10/21 15:43:16  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.13  2013/10/21 10:31:05  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.12  2013/10/18 16:01:26  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.11  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.10  2013/01/24 06:55:32  narry
// ��������� ������������ ������� (���� �� ��������)
//
// Revision 1.9  2009/04/09 15:08:19  lulin
// [$140280550]. ���������� �����.
//
// Revision 1.8  2009/03/13 15:12:13  narry
// - �����������
//
// Revision 1.7  2008/06/23 08:27:57  narry
// - �� ����������
//
// Revision 1.6  2008/03/21 14:09:22  lulin
// - cleanup.
//
// Revision 1.5  2008/02/12 13:05:30  voba
// - LongintList ��������
//
// Revision 1.4  2007/08/22 13:27:27  narry
// - �� ���������������
//
// Revision 1.3  2007/08/09 18:05:21  lulin
// - ����������� �� ��������� ������������� �����������, �.�. ������������� ����� ���� ���������� ������� ��������.
//
// Revision 1.2  2007/01/10 14:44:44  narry
// - ���������� ������ ���������� ����� ������ ����������
//
// Revision 1.1  2006/11/29 07:23:41  narry
// - ������ ���������� � XML
//
// Revision 1.50  2006/11/17 14:15:13  lulin
// - cleanup.
//
// Revision 1.49  2006/11/17 14:07:03  lulin
// - cleanup.
//
// Revision 1.48  2006/11/17 13:36:11  lulin
// - ������� ������ ��� ������������ ��������.
//
// Revision 1.47  2006/10/11 12:54:18  narry
// - ����������� ����� � ��������
//
// Revision 1.46  2006/09/04 13:49:28  narry
// - ��������� �������� ������
//
// Revision 1.45  2006/07/28 12:30:00  narry
// - ��������� ����� ������� ���������
//
// Revision 1.44  2006/07/20 06:24:15  narry
// - ������ ������ ����������� ��� pre
//
// Revision 1.43  2006/07/20 06:12:42  narry
// - ����������
//
// Revision 1.42  2006/07/18 14:08:42  narry
// - �����������: �� ����������� ������ � ����������
//
// Revision 1.41  2006/05/06 13:37:09  narry
// - ������� ��� �����, ������� ������
//
// Revision 1.40  2006/04/25 12:47:47  lulin
// - cleanup.
//
// Revision 1.39  2006/04/12 10:59:08  narry
// - ���������: ������������ ����� ����������� ���������� ��� ������ �� ���������
//
// Revision 1.38  2006/02/26 11:04:49  narry
// - �����������: ��������� ���������� ������� ������
//
// Revision 1.37  2006/02/22 08:58:11  narry
// - �����������: ������ �������� �������
//
// Revision 1.36  2006/02/13 14:12:46  narry
// - ����������: ���������� ������ �������
//
// Revision 1.35  2006/02/11 11:12:33  narry
// - �����������: ����������� �������������� ����� "��������� ������"
//
// Revision 1.34  2006/02/10 10:08:07  narry
// - �����������: ������ �� �������� ����� ������ ������� ������
//
// Revision 1.33  2006/02/09 14:18:03  narry
// - �����������: ���������� ������� �������� <>
//
// Revision 1.32  2005/12/09 15:28:50  narry
// - ������: ������������ ���������� �������������� �������
//
// Revision 1.31  2005/12/01 11:43:30  narry
// - �����������: ����������� ������������ � �������� ������
//
// Revision 1.30  2005/10/03 14:05:43  narry
// - �����������: ��������� ����� ����� �������� �� �������� ���� � �����
//
// Revision 1.29  2005/07/14 15:49:10  narry
// - new property: NeedStyleSheet
//
// Revision 1.28  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.27  2004/10/19 12:06:44  narry
// - update: ��������� �������������� ������
//
// Revision 1.26  2004/10/12 10:51:29  narry
// - bug fix: �������� ������� ������ ��������� � ������������ ����������
//
// Revision 1.25  2004/10/08 14:44:52  narry
// - update: ��������� "���������" SBS-�������
//
// Revision 1.24  2004/09/24 13:29:06  narry
// - update: �������������� ����� �� ��� ����� ������
//
// Revision 1.23  2004/09/21 15:19:10  fireton
// - bug fix: ������ ��� ������������ ����� � �����
//
// Revision 1.22  2004/09/21 12:21:04  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.21  2004/09/16 12:22:09  narry
// - bug fix: "�����������" ����������
// - bug fix: �������� ������ ������� ������� �� �������������
//
// Revision 1.20  2004/09/16 10:19:27  narry
// - update: ������� ��������� ���������� ������� ������ �� ������
//
// Revision 1.19  2004/06/01 16:51:23  law
// - ������ ����������� Tl3VList.MakePersistent - ����������� _Tl3ObjectRefList.
//
// Revision 1.18  2004/04/16 13:48:46  narry
// - bug fix: ���������� �� ���������� ';'
//
// Revision 1.17  2004/04/15 14:38:39  narry
// - new property: _OneStep - ��������� ������� �������� � ���� ������
//
// Revision 1.16  2004/04/09 12:18:07  narry
// - new: �������������� �������� ��������, �� �������������� HTML � jpg
//
// Revision 1.15  2004/03/19 11:18:04  narry
// - bug fix: AV ��� �������������� �������
//
// Revision 1.14  2004/01/21 16:13:43  narry
// - bug fix: ������ �������������, ������������ ������������, "�������" ������
// - update
//
// Revision 1.13  2004/01/16 10:12:06  narry
// - change: ������ ���������� ������ �� �������� � �������� ����������� ���� ��������
//
// Revision 1.12  2004/01/12 09:23:02  narry
// - bug fix: ���������� ������ ��������� (0) � ������ ���������  ������� �������� ���������
// - bug fix: ������� ������������� ��� ����� ��� ������������� ������
//
// Revision 1.11  2004/01/09 15:01:31  narry
// - bug fix
//
// Revision 1.10  2003/12/30 11:01:23  narry
// - new: ���������� ��������, ��������� � ��������, � ��������� ����� � �������� ������ �� ���
// - fixed: ��������, ����������� ������ ������, �������� ���������� �����, � �� ������ �� ����
//
// Revision 1.9  2003/12/29 12:07:45  narry
// - change: ��� ���������� �������� ������������� ������ ������� � ��������� �� ������� �������
//
// Revision 1.8  2003/12/23 17:01:16  narry
// - update: ��������� ��������� ������������ ������
// - add: ���������� ������������� ������������ ����� �������
//
// Revision 1.7  2003/11/06 15:16:49  narry
// - new: ������ ��� � ������� ���������� "������������"
//
// Revision 1.6  2003/11/06 11:53:46  narry
// - new: �������� �������� ��������� ����������� ��� <TITLE>
//
// Revision 1.5  2003/09/16 12:04:24  narry
// - bug fix: Index of bounds ��� �������������� ������ � �������
//
// Revision 1.4  2003/04/19 12:30:37  law
// - new file: ddDefine.inc.
//
// Revision 1.3  2002/07/03 09:00:57  narry
// - update, cleanup � new behavior
//
// Revision 1.2.2.1  2002/06/21 09:28:08  narry
// - not ready
//
// Revision 1.2  2002/06/06 11:10:45  narry
// - update: ��������� ����� $Id � $Log
//

{$I ddDefine.inc }

interface

Uses
 Classes,
 ddDocument, ddBase, ddRTFProperties,
 l3Base, l3Types, l3LongintList, l3Variant,

 k2Prim,
 
 k2TagGen, ddTextParagraph;

type
  TddXMLAnnoWriter = class(TddDocumentGenerator)
  private
    f_DivPreOpened: Boolean;
    f_IsComplexTable: Boolean;
    f_IsEtalonRow: Boolean;
    f_IsDoc: Boolean;
    f_Link: AnsiString;
    f_ListLevel: Integer;
    f_MLFileName: AnsiString;
    f_MLNumber: Integer;
    f_PictureNumber: Integer;
    f_TopicList: Tl3LongintList;
  protected
    procedure Cleanup; override;
        {-}
    procedure OpenStream; override;
    procedure WriteDocumentBody; override;
    procedure WriteDocumentEnd; override;
    procedure WriteDocumentStart; override;
    procedure WriteDocumentHeader; override;
    procedure WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False); override;
  public
    constructor Create;
    reintroduce;
    procedure StartChild(TypeID: Tl3VariantDef); override;
    property TopicList: Tl3LongintList read f_TopicList;
  end;
  
implementation
Uses
 RTFTypes,
 ddTypes,
 {$IFDEF Envision}
 ddPictDetector,
 {$ELSE}
 imageenio,
 {$ENDIF}
 SysUtils, Graphics, Math, StrUtils,
 k2Interfaces, k2Tags, k2Base,
 l3Chars, l3Stream, l3FileUtils, l3Filer, l3Const,
 evdStyles, k2FileGenerator, AnnoTopic_Const, Document_Const;


{
******************************* TddXMLAnnoWriter *******************************
}
constructor TddXMLAnnoWriter.Create;
begin
 inherited Create;
 OneStep := False;
 f_TopicList:= Tl3LongintList.Make;
end;

procedure TddXMLAnnoWriter.Cleanup;
begin
 l3Free(f_TopicList);
 inherited;
end;

// start class Tk2CustomFileGenerator 

procedure TddXMLAnnoWriter.OpenStream;
  {override;}
  {-}
begin
 inherited;
 f_TopicList.Clear;
end;

procedure TddXMLAnnoWriter.StartChild(TypeID: Tl3VariantDef);
var
  TT        : Tk2Type;
begin
  inherited;
  TT:= CurrentType;
  if TT.IsKindOf(k2_typAnnoTopic) then
   f_isDoc := False
  else
  if TT.IsKindOf(k2_typDocument) then
   f_IsDoc := True;
end;

procedure TddXMLAnnoWriter.WriteDocumentBody;
begin
 if not f_IsDoc then
 begin
  OutString('<TEXT><![CDATA[');
  inherited;
  OutStringLn(']]></TEXT>');
 end;
end;

procedure TddXMLAnnoWriter.WriteDocumentEnd;
begin
 if not f_IsDoc then
  OutStringLn('</items>');
end;

procedure TddXMLAnnoWriter.WriteDocumentStart;
begin
 if not f_IsDoc then
 begin
  f_TopicList.Add(ExtNumber);
  OutStringLn(Format('<items ID="%d" YEAR="%d">', [ExtNumber, Document.Info.CreateTime.Year]));
 end;
end;

procedure TddXMLAnnoWriter.WriteDocumentHeader;
begin
 if not f_IsDoc then
  OutStringLn(Format('<TOPIC><![CDATA[%s]]></TOPIC>', [Document.Info.FullName.AsString]));
end;

procedure TddXMLAnnoWriter.WriteTextParagraph(const Para: TddTextParagraph; anOutEOL: Boolean = False);
var
  i, LinkIndex: LongInt;
  St, l_Link: AnsiString;
  l_LStart, l_LStop: Boolean;
  l_Written: AnsiString;
  l_Text: Tl3String;
begin
 if not f_IsDoc then
 begin
  OutString('<p>');

  l_Text:= Para.Text;
  if l_Text.Empty then
   OutString(' ')
  else
   l_Text.CodePage:= cp_ANSI;

  for i := 0 to Pred(l_Text.Len) do
  begin
    l_Written:= l_Written + l_Text.Ch[i];
    case l_Text.Ch[i] of
     #9: OutString('&#9;');
     #10:
       begin
         OutString(' ');
       end;
     '<' : OutString('&lt;');
     '>' : OutString('&gt;');
     '&' : OutString('&amp;');
     cc_SingleQuote : OutString('&quot;');         {* - ��������� �������. }
     cc_DoubleQuote : OutString('&quot;');         {* - ������� �������. }
     cc_LSingleQuote: OutString('&quot;');         {* - ������������� ��������� �������. }
     cc_RSingleQuote: OutString('&quot;');         {* - ������������� ��������� �������. }
     cc_LDoubleQuote: OutString('&ldquo;');         {* - ������������� ������� �������. }
     cc_RDoubleQuote: OutString('&rdquo;');         {* - ������������� ������� �������. }
     cc_LTDoubleQuote: OutString('&laquo;');        {* - ������������� ������� ����������� �������. }
     cc_RTDoubleQuote: OutString('&raquo;');        {* - ������������� ������� ����������� �������. }
    else
     begin
      if (Para.PAP.Just <> justP) and (l_Text.Ch[i] = ' ') and
         ((i = 0) or (l_Text.Ch[Pred(i)] = ' ')) then
       OutString('&nbsp;')
      else
       OutString(l_Text.Ch[i]);
     end;
    end;
  end; //for i
  OutStringLn('</p>')
 end; 
end;

end.
