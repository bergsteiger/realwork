unit nsSearchClasses;

// $Id: nsSearchClasses.pas,v 1.4 2016/05/11 15:43:46 lulin Exp $

// $Log: nsSearchClasses.pas,v $
// Revision 1.4  2016/05/11 15:43:46  lulin
// - �������������.
//
// Revision 1.3  2014/09/24 12:59:26  kostitsin
// {requestlink: 235046973 }
//
// Revision 1.2  2013/04/24 09:35:56  lulin
// - ���������.
//
// Revision 1.1  2010/11/01 14:17:06  lulin
// {RequestLink:237994238}.
// - �������� ���������� ��������� ��������.
//
// Revision 1.23  2010/11/01 13:20:39  lulin
// {RequestLink:237994238}.
//
// Revision 1.22  2009/11/05 11:41:46  oman
// - new: {RequestLink:121160631}
//
// Revision 1.21  2009/02/09 19:17:18  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.20  2008/01/10 07:23:10  oman
// ������� �� ����� �������
//
// Revision 1.19.4.1  2007/11/16 14:03:35  oman
// ������������ �� ����� �������
//
// Revision 1.19  2007/06/19 08:00:00  lulin
// - ��������� ��������� ������ ��������� �������� � ���������� ������ �� �����-�������� ��� ����� (<K>-20218184).
//
// Revision 1.18  2007/05/31 13:25:47  lulin
// - ������� ����� (<K>-14517282).
//
// Revision 1.17  2007/05/31 13:08:59  lulin
// - cleanup.
//
// Revision 1.16  2007/05/31 12:54:40  lulin
// - �������� �������� (� ������ <K>-14516874).
//
// Revision 1.15  2007/03/20 11:37:39  lulin
// - �� ������ ��������� ��� ������������ ���������� ���� � ���������.
//
// Revision 1.14  2006/09/27 13:42:27  mmorozov
// � ������ ������ ��� CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. � ������ ���� �� ��������������, � ������������ ����� ��� ������ ��������������, ����� ���� �������� _IAttributeInfo;
// - remove: �������������� �������� � enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo ������� �������;
//
// Revision 1.13  2006/04/19 14:36:15  lulin
// - cleanup.
//
// Revision 1.12  2005/08/18 10:38:35  dinishev
// Bug fix: ������������� �������� ���������
//
// Revision 1.11  2005/07/22 08:43:44  mmorozov
// - ������� �� ����� ������;
//
// Revision 1.10  2004/12/23 08:41:32  lulin
// - ������� �������� ������.
//
// Revision 1.9  2004/09/07 16:22:03  law
// - ������� Nemesis �� ������������ �������.
//
// Revision 1.8  2004/08/05 10:34:39  mmorozov
// bugfix: ��������� ��������������;
//
// Revision 1.7  2004/07/23 08:40:43  mmorozov
// - bugfix;
//
// Revision 1.6  2004/07/22 09:54:38  mmorozov
// cleanup: ����� � ���;
//
// Revision 1.5  2004/07/22 09:26:18  mmorozov
// new: � TTagSearchList ��� �������� ������� ��� ��������� ��������� ������� ����� ��������;
// new: TAvailableTag ������ ���� ��������� ��������� ��������� (Name, _Caption);
//
// Revision 1.4  2004/06/16 10:32:37  am
// change: _TLogicSelection -> TLogicOperation
//
// Revision 1.3  2004/06/15 14:58:01  mmorozov
// - ������ TLogicOperation �� TLogicOperation;
//
// Revision 1.2  2004/03/24 15:00:55  mmorozov
// new: property TTagSearch.DefaultValue;
//
// Revision 1.1  2004/03/22 13:21:38  demon
// - new: ���� ���������� ������� TTagSearch � TTagSearchList
//

interface

uses
  Classes,

  vcmBase,

  FoldersUnit,
  SearchUnit,

  nsConst,
  nsTypes,

  SearchDomainInterfaces
  ;

type
  TQueryLogicOperations = Set of TQueryLogicOperation;

function LQOperationToLSelection(aValue: TQueryLogicOperation): TLogicOperation;

//{$IFDEF Monitorings}
const
 cChangableReqName = AT_THEMES_NAME;
//{$EndIF Monitorings}

const
 cReqWithoutDefText : array [0..2{$IFDEF Monitorings}+1{$ENDIF Monitorings}] of AnsiString =
  ({$IFDEF Monitorings}
   cChangableReqName,
   {$ENDIF Monitorings}
   AT_CONSULTATION_DESCRIPTION,
   AT_CONSULTATION_TEXT,
   AT_USER_NAME);

implementation

uses
  SysUtils,

  l3Types,
  l3Base,
  l3Bits,

  DataAdapter
  ;

function LQOperationToLSelection(aValue: TQueryLogicOperation): TLogicOperation;
begin
 Result := loNone;
 case aValue of
  QLO_AND:
   Result := loAnd;
  QLO_AND_NOT:
   Result := loNot;
  QLO_OR:
   Result := loOr;
 end;
end;

end.
