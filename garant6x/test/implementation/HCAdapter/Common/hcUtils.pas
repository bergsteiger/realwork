unit hcUtils;

// ���������� : �������� ����;
// �����      : ������� �.�.;
// �����      : 26.03.2006 16.48;
// ������     : hcUtils;
// ��������   : ��������� ������� �������;
// ������     : $Id: hcUtils.pas,v 1.10 2010/06/09 11:29:22 oman Exp $

(*-------------------------------------------------------------------------------
  $Log: hcUtils.pas,v $
  Revision 1.10  2010/06/09 11:29:22  oman
  - fix: {RequestLink:217680883}

  Revision 1.9  2010/06/09 11:28:28  oman
  - fix: {RequestLink:217680883}

  Revision 1.8  2008/02/27 06:10:06  mmorozov
  - new: � �� ���� �������� ����������� �������� � ������� ������������ (CQ: OIT5-28426);

  Revision 1.7  2008/02/26 13:15:46  mmorozov
  - new: ���������� �������� �������� (CQ: OIT5-28426);

  Revision 1.6  2007/08/16 11:28:44  mmorozov
  - new behaviour: � ������� ��������� ������� ������������ ��������� ������ ������� F1 (CQ: OIT5-26349);

  Revision 1.5  2007/08/15 06:27:03  mmorozov
  - new: ������������� l3FillChar;

  Revision 1.4  2007/08/13 07:06:33  mmorozov
  - new: ��������� �������� "������" ��� ������ � xml-��;
  - change: ������������� ������ �������, ��� ������������ �������������� ������� (CQ: OIT5-25922);

  Revision 1.3  2007/06/29 06:05:18  mmorozov
  - bugfix: �������� �� ��� ����� � ������ ������� ��������� ������ � ������ (CQ: OIT5-25586);

  �����������:
  - ������ ��������������� �������� ��� ������ � ���������� ���������� XMLDocument;
  - ��������� ��������� ������� ��� ������ ��������, ������/������ ��� ��������;
  - �������������� ����� ������������ ����� ��� ������ � ���������� ������������;
  - ������������� ������������ ���� ���������;
  - ������������ ������������ ������������ ���� ��� �� ������� ����������, � �� ������ ��� ��� ������;
  - �������� �������� ������ "������" � "���������" ���������, � �������� ��������� �������� ���������� 'jrn', 'sts'. ����� �������, � ����� ����, ��� ��������� ������ ����� ������� ����� ��� � � �������;

  Revision 1.2  2007/01/24 09:20:40  mmorozov
  - MERGE WITH B_NEMESIS_6_4 (CQ: OIT5-24141);

  Revision 1.1.4.1  2007/01/24 08:52:17  mmorozov
  - ����� �������� ������������ (CQ: OIT5-24141);

-------------------------------------------------------------------------------*)

interface

uses
  Classes,
  Controls,
  SHDocVw,
  XMLDoc,

  hcInterfaces
  ;

function hcReplaceConsultationId(const aDocument : TXMLDocument;
                                 const aFileName : String;
                                 const aId       : ThcConsultationId): Boolean;
  {* - ��������� ������������� ������������ � �������. }
function hcXMLReadAttributeValue(const aDocument : TXMLDocument;
                                 const aTagName  : String;
                                 const aAttrName : String): String;
  {* - �������� �������� �������� ����. }
function hcXMLWriteAttributeValue(const aDocument : TXMLDocument;
                                  const aTagName  : String;
                                  const aAttrName : String;
                                  const aValue    : String): Boolean;
  {* - �������� �������� �������� ����. }
function hcStatusStrToEnum(const aStatus: String): ThcQueryStatus;
  {* - �������� ������ ������������. }
function hcMakeWebBrowser(const aParent: TWinControl): TWebBrowser;
  {* - ������� ������������ � ���������� ���������. }
procedure hcLoadToBrowser(const aBrowser : TWebBrowser;
                          const aData    : String;
                          const aXML     : Boolean = True);
  {* - �������� XML ��� HTML. }
function hcIsSame(const aValue1, aValue2: ThcConsultationId): Boolean;
  {-}
function hcIsNil(const aValue: ThcConsultationId): Boolean;
  {-}
function hcNilConsultationId: ThcConsultationId;
  {-}
procedure hcCopyConsultationId(const aSource : ThcConsultationId;
                                 var aDest   : ThcConsultationId);
  {* - �������� ������������� ������������ �� ��������� � �������. }

implementation

uses
  StrUtils,
  SysUtils,
  xmldom,
  XMLIntf,
  msxmldom,
  Variants,
  Math,

  l3Base,

  hcConst
  ;

procedure hcCopyConsultationId(const aSource : ThcConsultationId;
                                 var aDest   : ThcConsultationId);
  {* - �������� ������������� ������������ �� ��������� � �������. }
begin
 aDest.rQueryId    := aSource.rQueryId;
 aDest.rVersion    := aSource.rVersion;
end;//hcCopyConsultationId

function hcNilConsultationId: ThcConsultationId;
  {-}
begin
 l3FillChar(Result, SizeOf(Result), 0);
end;//hcNilConsultationId

function hcIsNil(const aValue: ThcConsultationId): Boolean;
  {-}
begin
 Result := (aValue.rQueryId = '');
end;//hcIsNil

function hcIsSame(const aValue1, aValue2: ThcConsultationId): Boolean;
  {-}
begin
 Result := (aValue1.rQueryId = aValue2.rQueryId);
end;//hsIsSame

procedure hcLoadToBrowser(const aBrowser : TWebBrowser;
                          const aData    : String;
                          const aXML     : Boolean = True);
  {* - �������� XML ��� HTML. }
const
 c_FileName: array [Boolean] of String = (
   'temp%d.html',
   'temp%d.xml');
var
 l_Stream   : TFileStream;
 l_FileName : String;
 l_Path     : String;
 l_Repeat   : Boolean;
 l_Index    : Integer;

begin
 if aData = '' then
  Exit;
 l_Repeat := True;
 l_FileName := c_FileName[aXML];
 l_Index := 1;
 while l_Repeat do
 begin
  try
   l_Path := ExtractFileDir(ParamStr(0)) + '\' + Format(l_FileName, [l_Index]);
   l_Stream := TFileStream.Create(l_Path, fmCreate);
   try
    l_Stream.WriteBuffer(Pointer(aData)^, Length(aData));
   finally
    FreeAndNil(l_Stream);
   end;{try..finally}
   l_Repeat := False;
  except
   on EFCreateError do
    Inc(l_Index);
  end;{try..except}
 end;//while l_Repeat do
 aBrowser.Navigate(l_Path);
end;//LoadToBrowser

function hcMakeWebBrowser(const aParent: TWinControl): TWebBrowser;
  {* - ������� ������������ � ���������� ���������. }
begin
 Result := TWebBrowser.Create(aParent);
 TWinControl(Result).Parent := aParent;
 Result.Align := alClient;
end;//hcMakeWebBrowser

function hcReplaceConsultationId(const aDocument : TXMLDocument;
                                 const aFileName : String;
                                 const aId       : ThcConsultationId): Boolean;
  {* - ��������� ������������� ������������ � �������. }

  function lp_WriteQueryId: Boolean;
  begin
   Result := hcXMLWriteAttributeValue(aDocument,
                                      c_tagConsultation,
                                      c_attrQueryId,
                                      aId.rQueryId);
  end;//lp_WriteQueryId

  function lp_WriteVersion: Boolean;
  begin
   Result := hcXMLWriteAttributeValue(aDocument,
                                      c_tagConsultation,
                                      c_attrVersion,
                                      aId.rVersion);
  end;//lp_WriteVersion

begin
 Result := False;
 if not hcIsNil(aId) then
 begin
  with aDocument do
  begin
   Active := False;
   XML.LoadFromFile(aFileName);
   Active := True;
   Result := lp_WriteQueryId and lp_WriteVersion;
   if Result then
    XML.SaveToFile(aFileName)
   else
    Assert(False, 'Document don`t have ComplectId or QueryId');
  end;//with aDocument do
 end;//if aConsultationId <> '' then
end;//hcReplaceConsultationId

function hcXMLFindAttribute(const aDocument : TXMLDocument;
                            const aTagName  : String;
                            const aAttrName : String): IXMLNode;
  {* - �������� �������� �������� ����. }
var
 l_Node: IXMLNode;
begin
 Result := nil;
 Assert(aDocument.DocumentElement <> nil);
 if aDocument.DocumentElement.NodeName = aTagName then
  l_Node := aDocument.DocumentElement
 else
  l_Node := aDocument.DocumentElement.ChildNodes.Nodes[aTagName];
 if l_Node <> nil then
  Result := l_Node.AttributeNodes.Nodes[aAttrName];
end;//hcXMLFindAttribute

function hcXMLWriteAttributeValue(const aDocument : TXMLDocument;
                                  const aTagName  : String;
                                  const aAttrName : String;
                                  const aValue    : String): Boolean;
  {* - �������� �������� �������� ����. }
var
 l_Attr: IXMLNode;
begin
 Result := False;
 l_Attr := hcXMLFindAttribute(aDocument, aTagName, aAttrName);
 if (l_Attr <> nil) then
 begin
  l_Attr.NodeValue := aValue;
  Result := True;
 end;//if (l_Attr <> nil) then
end;//hcXMLWriteAttributeValue

function hcXMLReadAttributeValue(const aDocument : TXMLDocument;
                                 const aTagName  : String;
                                 const aAttrName : String): String;
  {* - �������� �������� �������� ����. }
var
 l_Attr: IXMLNode;
begin
 Result := '';
 l_Attr := hcXMLFindAttribute(aDocument, aTagName, aAttrName);
 if (l_Attr <> nil) and not VarIsNull(l_Attr.NodeValue) then
  Result := l_Attr.NodeValue;
end;//hcXMLReadAttributeValue

function hcStatusStrToEnum(const aStatus: String): ThcQueryStatus;
  {* - �������� ������ ������������. }
var
 l_Status: ThcQueryStatus;
begin
 Result := qsNone;
 for l_Status := Low(ThcQueryStatus) to High(ThcQueryStatus) do
  if not (l_Status in [qsNone, qsMarkReceived]) and
   (AnsiCompareText(aStatus, c_QueryStatus[l_Status]) = 0) then
  begin
   Result := l_Status;
   Break;
  end;//if (l_Status <> qsNone) and...
 Assert(Result <> qsNone);
end;//hcStatusStrToEnum

end.
