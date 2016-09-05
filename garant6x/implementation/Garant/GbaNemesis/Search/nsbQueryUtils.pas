unit nsbQueryUtils;

{ �����: ������ �������, ������� ������                       }
{ ������: lgQueryUtils -                                      }
{ �����: 21.01.2005 16:51                                     }
{ $Id: nsbQueryUtils.pas,v 1.2 2016/08/04 12:07:51 lulin Exp $ }

// $Log: nsbQueryUtils.pas,v $
// Revision 1.2  2016/08/04 12:07:51  lulin
// - �������������.
//
// Revision 1.1  2015/03/05 18:05:24  kostitsin
// {requestlink: 588808889 }
//
// Revision 1.4  2013/09/16 07:09:42  kostitsin
// [$239370589]
//
// Revision 1.3  2010/12/22 18:26:03  lulin
// {RequestLink:242845936}.
//
// Revision 1.2  2010/11/22 13:39:14  lulin
// [$242845500].
//
// Revision 1.1  2010/07/05 08:05:20  lulin
// {RequestLink:207389954}.
// - ��������� �� ������ ����� "SaveLoad".
//
// Revision 1.8  2009/09/03 18:49:16  lulin
// - ����������������� ������ � ������� ��������.
//
// Revision 1.7  2008/03/12 07:51:36  oman
// - new: ��������� ��� ������ �������������� ��������� (���)
//
// Revision 1.6  2008/01/10 07:23:52  oman
// ������� �� ����� �������
//
// Revision 1.5.4.1  2007/11/21 15:07:44  oman
// ������������ �� ����� �������
//
// Revision 1.5  2007/05/23 10:40:24  oman
// - new: ����� ��� �������� "������� �����" (cq25374)
//
// Revision 1.4  2006/04/07 08:25:26  mmorozov
// - ���������� � ������ ����������� ������ � �������� ����������, ������� �� ������������, ������������;
//
// Revision 1.3  2006/04/03 15:55:25  dinishev
// ����� ��
//
// Revision 1.2  2006/03/10 13:38:26  dinishev
// ����������� ����� ��
//
// Revision 1.1  2005/07/29 12:52:17  mmorozov
// - ��������� �� ������� ��������;
//
// Revision 1.1  2005/07/29 11:22:31  mmorozov
// - ���� ��������� �� ������� �����;
//
// Revision 1.2  2005/03/04 15:05:14  demon
// - new behavior: ����������� �������� "����� ����������������" (��������, ���� ���������� ������)
//
// Revision 1.1  2005/02/24 16:43:40  mmorozov
// new: ������ ������ ������ ��� ������ � Query;
//
// Revision 1.1  2005/02/24 14:54:53  dinishev
// new: ������ ��� ������ � ���������;
//

{.$I lgDefine.inc }

interface

uses
  SearchUnit,
  nsQueryInterfaces
  ;

function AdapterQueryToBusinessQuery(aQueryType : TQueryType) : TlgQueryType;
  {* - ��� �������������� ����������� ���� � ��� ������ ������. }
function BusinessQueryToAdapterQuery(aQueryType : TlgQueryType) : TQueryType;
  {* - ��� �������������� ����������� ���� � ��� ������ ������. }

implementation

function AdapterQueryToBusinessQuery(aQueryType : TQueryType) : TlgQueryType;
  {* - ��� �������������� ����������� ���� � ��� ������ ������. }
begin
 Result := lg_qtNone;
 case aQueryType of 
  QT_KEYWORD:
    Result := lg_qtKeyWord;
  QT_ATTRIBUTE:
    Result := lg_qtAttribute;
  QT_PUBLISHED_SOURCE:
    Result := lg_qtPublishedSource;
  QT_REVIEW:
    Result := lg_qtLegislationReview;
  QT_MAIL_LIST:
    Result := lg_qtPostingOrder;
  QT_CONSULT:
  begin
    Result := lg_qtNone;
    Assert(false);
  end;//QT_CONSULT
  QT_HANDYCRAFT_CONSULT:
    Result := lg_qtSendConsultation;
  QT_BASE_SEARCH:
    Result := lg_qtBaseSearch;
  QT_PHARM_SEARCH:
    Result := lg_qtInpharmSearch;
  else
   Assert(false);  
 end;
end;

function BusinessQueryToAdapterQuery(aQueryType : TlgQueryType) : TQueryType;
  {* - ��� �������������� ����������� ���� � ��� ������ ������. }
begin
 Result := QT_ATTRIBUTE; // ��� ����������� ����� �������, ��� ������ �� ���������
 case aQueryType of
  lg_qtKeyWord:
    Result := QT_KEYWORD;
  lg_qtAttribute:
    Result := QT_ATTRIBUTE;
  lg_qtPublishedSource:
    Result := QT_PUBLISHED_SOURCE;
  lg_qtPostingOrder:
    Result := QT_MAIL_LIST;
  lg_qtLegislationReview:
    Result := QT_REVIEW;
  lg_qtSendConsultation:
   Result := QT_HANDYCRAFT_CONSULT;  
  lg_qtBaseSearch:
    Result := QT_BASE_SEARCH;
  lg_qtInpharmSearch:
    Result := QT_PHARM_SEARCH;
  else
   Assert(false);  
 end;
end;

end.

