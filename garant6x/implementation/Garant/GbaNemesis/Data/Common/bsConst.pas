unit bsConst;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�;                                                    }
{ �����      : 28.09.2005 22.24;                                               }
{ ������     : bsConst                                                         }
{ ��������   : ����� ����� ��������� ������ ����.                              }
{------------------------------------------------------------------------------}

// $Id: bsConst.pas,v 1.5 2012/10/03 10:37:50 kostitsin Exp $
// $Log: bsConst.pas,v $
// Revision 1.5  2012/10/03 10:37:50  kostitsin
// [$398276179]
//
// Revision 1.4  2012/09/11 14:31:17  kostitsin
// [$388859236] - ������ �� � �������
//
// Revision 1.3  2012/08/28 09:34:17  lulin
// - ����������� �� ���������.
//
// Revision 1.2  2011/02/08 14:24:38  lulin
// {RequestLink:252522068}.
//
// Revision 1.1  2009/09/14 11:28:52  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.23  2009/07/31 17:29:53  lulin
// - ������� �����.
//
// Revision 1.22  2008/03/24 08:43:18  oman
// - new: ��������� ��� ��������� ����� ������ ���. ����������
//
// Revision 1.21  2008/03/21 08:42:16  oman
// - new: ��������� ��� ��������� ����� ������ ������������� ����������
//
// Revision 1.20  2008/03/19 19:51:39  lulin
// - bug fix: �� ��������� F1.
//
// Revision 1.19  2008/01/10 07:23:00  oman
// ������� �� ����� �������
//
// Revision 1.17.4.3  2007/11/28 15:56:45  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.17.4.2  2007/11/26 09:03:55  oman
// ������������ �� ����� �������
//
// Revision 1.17.4.1  2007/11/21 10:26:15  oman
// ������������ �� ����� �������
//
// Revision 1.18  2007/11/28 15:49:40  mmorozov
// - bugfix: ����������� ���������� ���� ��������� (����� | �� �����) (CQ: OIT5-27615);
//
// Revision 1.17  2007/06/27 05:46:19  mmorozov
// - new: ������� ������ ������ ������� � ������������ ��� ����� ������ ���������� (CQ: OIT5-25413);
//
// Revision 1.16  2007/04/10 12:38:25  mmorozov
// - new: ������������� ����� ��������������� ��������� ���������� (CQ: OIT5-24602);
//
// Revision 1.15  2007/03/05 11:31:14  oman
// - fix: ������ �������� �� ����� (cq23879)
//
// Revision 1.14  2006/07/05 07:51:19  mmorozov
// - new: ���������� �����������;
//
// Revision 1.13  2006/06/23 11:31:29  mmorozov
// - new: ������ ������� �������� ���������;
//
// Revision 1.12  2006/05/02 13:56:38  mmorozov
// - ������ ��������� � ��������������� ��������;
//
// Revision 1.11  2006/04/17 07:18:42  oman
// - change: ��������� ������-������� (���� ������) �� ������������
//  ����������� (�����, imageindex)
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.10  2006/04/04 14:03:33  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.9  2006/03/15 14:12:58  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr � DebugStr)
//
// Revision 1.8  2005/11/24 16:50:39  mmorozov
// new: ���������� ������ ���������� ��� ��������� ������� (cq: 00012546);
//
// Revision 1.7  2005/11/23 13:24:07  demon
// - fix: �������� ������������ �������������� � ����������� ���
//
// Revision 1.6  2005/10/19 14:36:43  mmorozov
// cleanup: �������� �� ������������ ��������� ����/����������;
//
// Revision 1.5  2005/10/19 09:49:48  mmorozov
// - add comments;
//
// Revision 1.4  2005/10/19 09:28:10  mmorozov
// change: ������������� ���������� �� �������������;
// change: ��������� ��������� �� dsList � bsConst;
//
// Revision 1.3  2005/10/12 09:27:38  demon
// - new behavior: ������������� ��������������/����������� � ����������
//
// Revision 1.2  2005/09/29 10:12:31  mmorozov
// new: �������� ��������� � �����/������� ����;
//
// Revision 1.1  2005/09/28 18:33:08  mmorozov
// - ������ ��������� � ����������� ������;
//

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  
  bsTypes
  ;

const
///// ���� ������ //////////////////////////////////////////////////////////////
  bs_hidConsultationMark = 101;
    // - ������ �� ������ ������������
///// �������� ������� /////////////////////////////////////////////////////////
  c_LiteratureListForDictionary = 3984056;
    {* - �������� �� ������� ���������� ��� ��������� �������. }
///// ��������� ��� ������ �� ������� //////////////////////////////////////////
  cMin_CR_List_Count    = 5;
    {* - ���������� ����������, ��� ������� ���������� ������ ������� ����������
         � ������������� ������. }

  cDocumentSet: set of TbsListNodeType = [
  {* ���� ����������� � ���������. }
    lntDocActive,
    lntDocPreactive,
    lntDocAbolished,
    lntRedaction,
    lntBlock,
    lntDrugAnnuled,
    lntDrugNarcotic,
    lntDrugNoAnnuledNoNarcoric,
    lntFormAnnuled,
    lntFormRussianImportant,
    lntFormNoRussianImportant,
    lntFormRussianNoImportant,
    lntFormNoRussianNoImportant,
    lntAAC
  ];

  cbsListNodeTypeMap: array [TListNodeType] of TbsListNodeType = (
  {* ���� ������ }
    lntBlock,                   // LNT_SUB //
    lntBlock,                   // LNT_PARA //
    lntExternalObject,          // LNT_EXTERNAL_OBJECT //
    lntExternalLink,            // LNT_EXTERNAL_LINK //
    lntDocAbolished,            // LNT_DOCUMENT_ABOLISHED //
    lntDocActive,               // LNT_DOCUMENT_ACTIVE //
    lntDocPreActive,            // LNT_DOCUMENT_PREACTIVE //
    lntDocActive,               // LNT_DOCUMENT_UNKNOWN //
    lntRedaction,               // LNT_EDITION_ABOLISHED //
    lntRedaction,               // LNT_EDITION_ACTIVE //
    lntRedaction,               // LNT_EDITION_PREACTIVE //
    lntRedaction,               // LNT_EDITION_UNKNOWN //
    lntRedactions,              // LNT_EDITIONS_GROUP //
    lntBlock,                   // LNT_BLOCK //
    lntDrugAnnuled,             // LNT_DRUG_ANNULED // �������� �����������
    lntDrugNarcotic,            // LNT_DRUG_NARCOTIC // ������������� ��������
    lntDrugNoAnnuledNoNarcoric, // LNT_DRUG_NONANNULED_NONNARCOTIC // ����������� ��������������� ��������
    lntFormAnnuled,             // LNT_FORM_ANNULED // �������������� ����� ���������
    lntFormRussianImportant,    // LNT_FORM_RUSSIAN_IMPORTANT // �������������� ���������� ��������
    lntFormNoRussianImportant,  // LNT_FORM_NONRUSSIAN_IMPORTANT // �������������� ����������� ��������
    lntFormRussianNoImportant,  // LNT_FORM_RUSSIAN_NONIMPORTANT // ���������� ��������
    lntFormNoRussianNoImportant,// LNT_FORM_NONRUSSIAN_NONIMPORTANT // ����������� ��������
    lntMedicFirm,
    lntAAC                      // LNT_AAK // ������������ �������
  );

////////////////////////////////////////////////////////////////////////////////

implementation

end.