unit bsConvert;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�.;                                                   }
{ �����      : 22.08.2005 18.37;                                               }
{ ������     : bsConvert                                                    }
{ ��������   : ������ �������� ������ ����������� ���������� ���������������   }
{              ��� ������ ������� ����� ������ ���������;                      }
{------------------------------------------------------------------------------}

// $Id: bsConvert.pas,v 1.3 2010/11/01 13:20:41 lulin Exp $
// $Log: bsConvert.pas,v $
// Revision 1.3  2010/11/01 13:20:41  lulin
// {RequestLink:237994238}.
//
// Revision 1.2  2010/03/22 14:42:30  lulin
// {RequestLink:198672893}.
//
// Revision 1.1  2009/09/14 11:28:52  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.28  2009/02/09 19:17:21  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.27  2008/11/14 10:34:46  lulin
// - <K>: 122675356.
//
// Revision 1.26  2008/08/15 06:51:16  mmorozov
// - bugfix: ��������� �������� ������������, �� �� ������ ����������� ����� (<K>: 104434904);
//
// Revision 1.25  2008/07/14 04:09:40  mmorozov
// - new:  ������ ����, ����������� ������� ������ ������� (K<100008396>);
//
// Revision 1.24  2008/07/02 10:36:23  mmorozov
// - bugfix: ��������� �� �����������������.
//
// Revision 1.23  2008/07/02 08:03:31  mmorozov
// - change: ��������� ������������ ����� ���������� (K<97354368>).
//
// Revision 1.22  2008/07/01 05:50:56  oman
// - fix: ����� ��������� ���������� (�96484702)
//
// Revision 1.21  2008/04/17 05:53:49  mmorozov
// - new: "�������������� � �������� ������ ��� ���������" ������������� ��� ���������� � ����������.
//
// Revision 1.20  2008/01/10 07:23:00  oman
// ������� �� ����� �������
//
// Revision 1.17.2.5  2007/12/21 09:45:39  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.17.2.4  2007/12/07 08:23:55  oman
// Warning fix
//
// Revision 1.17.2.3  2007/12/07 08:21:56  oman
// Warning fix
//
// Revision 1.17.2.2  2007/12/04 11:19:09  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.17.2.1  2007/11/20 11:39:13  oman
// ������������ �� ����� �������
//
// Revision 1.18  2007/11/15 12:05:50  mmorozov
// - � ������ ������ ��� "�� ��������� � ���������� � ������" (CQ: OIT5-19586);
//
// Revision 1.19  2007/12/21 08:05:03  mmorozov
// - warning fix;
//
// Revision 1.17  2007/10/20 14:11:33  mmorozov
// - ����������� ������ � �������������� ���� ����������� ��� ���������� ������ ��������� bs_csPaymentRefusalOldFormat;
// - ����� ��������� (� ����������) IdeConsultation, �� ���� �������� ����������� _IbsConsultation;
// - cleanup;
//
// Revision 1.16  2007/08/14 19:31:42  lulin
// - ������������ ������� ������.
//
// Revision 1.15  2007/08/14 07:32:38  mmorozov
// - new: ��������� ������ � ��������� ������������ (CQ: OIT5-25868);
//
// Revision 1.14  2007/07/17 13:26:52  mmorozov
// - new: �������� ���������� ����������� ������� (� ������ CQ: OIT5-25852);
//
// Revision 1.13  2007/06/07 09:25:28  oman
// - new: ��� ������ ������ ����� ��������� ����������
//  �������� � ������ ������� ������ �������� (cq25445)
//
// Revision 1.12  2007/06/05 13:04:10  oman
// - new: ��� ���������� ������ � EVD ������ ��������
//  ������������ (cq25445)
//
// Revision 1.11  2007/05/17 12:04:09  oman
// cleanup
//
// Revision 1.10  2007/01/30 15:24:07  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.9  2006/09/27 13:53:59  mmorozov
// � ������ ������ ��� CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. � ������ ���� �� ��������������, � ������������ ����� ��� ������ ��������������, ����� ���� �������� _IAttributeInfo;
// - remove: �������������� �������� � enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo ������� �������;
//
// Revision 1.8  2006/07/27 09:58:29  mmorozov
// - bugfix: ����������� ���������� ����;
//
// Revision 1.7  2006/06/30 14:59:03  mmorozov
// - new: ��������� �������� "���������� � ������������" ���������� �� ���������� shortcut-�. �������� ��������� �������� ������ ����������� ��� ���������� � ������������;
// - change: ������� ��� �� ������ � mailto (���������� � nsUtils);
// - change: ������������� ������� ������ bsConvert;
//
// Revision 1.6  2006/06/01 11:05:04  mmorozov
// - new: ��� ������ � ������ � ����������� � ��������� ����������� ���������� �������� CP_WHOLE_WORD (CQ: OIT500021150);
//
// Revision 1.5  2006/04/21 11:12:04  mmorozov
// - new: �������� ������ �� ������������;
//
// Revision 1.4  2006/03/15 14:12:58  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr � DebugStr)
//
// Revision 1.3  2005/10/28 13:37:58  mmorozov
// - ���������� �������� �� ����������� � ���������;
//
// Revision 1.2  2005/10/27 10:35:40  mmorozov
// - ������ ��� �������� ��������;
//
// Revision 1.1  2005/08/22 15:41:44  mmorozov
// new: ������� ��� ����������� ����� �������� � ���� ������ ����;
//

interface

uses
  l3Interfaces,
  l3Types,

  bsTypes,
  nsTypes,

  BaseTypesUnit,
  ConsultingUnit,
  DocumentUnit,
  DynamicTreeUnit,
  DynamicDocListUnit,
  SearchUnit,

  SearchDomainInterfaces
  ;
{------------------------------------------------------------------------------}
{ �� �������� � ��������.                                                      }
{------------------------------------------------------------------------------}
function bsAdapterToBusiness(const aValue : TDynListContent) : TbsListType;
  overload;
  {-}
function bsAdapterToBusiness(const aValue : TQueryLogicOperation) : TLogicOperation;
  overload;
  {* - TQueryLogicOperation -> TLogicOperation. }
function bsAdapterToBusiness(const aPosType: TPositionType): TDocumentPositionType;
  overload;
  {* - ������������ ���������� ��� � ��� ������ ����. }
function bsBusinessToAdapter(const aRefType: TDocumentPositionType): TPositionType;
  overload;
  {* - ������������ ��� ������ ���� � ���������� ���. }
function bsAdapterToBusiness(const aLanguage: Word): TbsLanguage;
  overload;
  {* - ������������ ���������� ������������� ����� � ������������ � ������ ����. }
function bsAdapterToBusiness(const aDateTime: BaseTypesUnit.TDateTime): System.TDateTime;
  overload;
  {-}
function bsAdapterToBusiness(const aDate: BaseTypesUnit.TDate): System.TDateTime;
  overload;
  {-}
function bsAdapterToBusiness(const aStatus: TConsultationStatus): TbsConsultationStatuses;
  overload;
  {-}
{------------------------------------------------------------------------------}
{ �� �������� � �������.                                                       }
{------------------------------------------------------------------------------}
function bsBusinessToAdapter(const aStatus: TbsConsultationStatuses): TConsultationStatus;
  overload;
  {-}
function bsBusinessToAdapter(const aLanguage: TbsLanguage): Word;
  overload;
  {* - ������������ ������������� ����� � ������������ � ������ ���� � ����������. }
function bsBusinessToAdapter(const aMark: TbsConsultationMark): TEstimationValue;
  overload;
  {-}
function bsBusinessToAdapter(const aWordOrder : Tl3WordOrder) : TFindOrder;
  overload;
  {* - ������������ ��� ����������. }
function bsBusinessToAdapter(const aTreeLevelDist : Tl3TreeLevelDist) : TSearchArea;
  overload;
  {* - ������������ ��� ����������. }
function bsBusinessToAdapter(const aSaveListKind: TbsSaveListKind): TEVDGeneratorStyle;
  overload;
  {* - ��� ������� ������ � ��� }
function bsBusinessToAdapter(const aOnlyFirstLevel: Boolean): TEVDGeneratorStyle;
  overload;
  {* - ��� ������� ������ � ��� (���� �� ����������)}
function bsBusinessToAdapter(const aDateTime: System.TDateTime): BaseTypesUnit.TDate;
  overload;
  {-}
function bsBusinessToAdapter(const aOperation: TLogicOperation): Word;
  overload;
  {-}
{------------------------------------------------------------------------------}

implementation

uses
  SysUtils,
  DateUtils,

  DebugStr,

  bsUtils,

  l3Base,

  bsTypesNew
  ;

function bsAdapterToBusiness(const aStatus: TConsultationStatus): TbsConsultationStatuses;
  // overload;
  {-}
begin
 Result := [];
 if bsHasFlag(aStatus, CS_SENT) then
   Include(Result, bs_csSent);
 if bsHasFlag(aStatus, CS_PAYMENT_REQUEST) then
  Include(Result, bs_csPaymentRequest);
 if bsHasFlag(aStatus, CS_ANSWER_RECEIVED) then
  Include(Result, bs_csAnswerReceived);
 if bsHasFlag(aStatus, CS_READ) then
  Include(Result, bs_csRead);
 if bsHasFlag(aStatus, CS_ESTIMATION_SENT) then
  Include(Result, bs_csEstimationSent);
 if bsHasFlag(aStatus, CS_DRAFTS) then
  Include(Result, bs_csDrafts);
 if bsHasFlag(aStatus, CS_PAYMENT_REFUSAL) then
  Include(Result, bs_csPaymentRefusal);
 if bsHasFlag(aStatus, CS_PAYMENT_CONFIRM) then
  Include(Result, bs_csPaymentConfirm);
 if bsHasFlag(aStatus, CS_VALIDATION_FAILED) then
  Include(Result, bs_csValidationFailed);
 if bsHasFlag(aStatus, CS_ANSWER_NOT_CONFIRM) then
  Include(Result, bs_csAnswerNotConfirm);
 if bsHasFlag(aStatus, CS_READ_NOT_CONFIRM) then
  Include(Result, bs_csReadNotConfirm);
 if Result = [] then
 begin
  Assert(False);
  Result := [bs_csNone];
 end;
end;//bsAdapterToBusiness

function bsBusinessToAdapter(const aStatus: TbsConsultationStatuses): TConsultationStatus;
  // overload;
  {-}
begin
 Result := 0;
 if bs_csSent in aStatus then
   Result := Result or CS_SENT;
 if bs_csPaymentRequest in aStatus then
   Result := Result or CS_PAYMENT_REQUEST;
 if bs_csAnswerReceived in aStatus then
  Result := Result or CS_ANSWER_RECEIVED;
 if bs_csRead in aStatus then
  Result := Result or CS_READ;
 if bs_csEstimationSent in aStatus then
  Result := Result or CS_ESTIMATION_SENT;
 if bs_csDrafts in aStatus then
  Result := Result or CS_DRAFTS;
 if aStatus * [bs_csPaymentRefusal, bs_csPaymentRefusalOldFormat] <> [] then
  Result := Result or CS_PAYMENT_REFUSAL;
 if bs_csPaymentConfirm in aStatus then
  Result := Result or CS_PAYMENT_CONFIRM;
 if bs_csValidationFailed in aStatus then
  Result := Result or CS_VALIDATION_FAILED;
 if bs_csAnswerNotConfirm in aStatus then
  Result := Result or CS_ANSWER_NOT_CONFIRM;
 if bs_csReadNotConfirm in aStatus then
  Result := Result or CS_READ_NOT_CONFIRM;
end;//bsBusinessToAdapter

function bsAdapterToBusiness(const aDate: BaseTypesUnit.TDate): System.TDateTime;
  overload;
  {-}
begin
 with aDate do
  Result := EncodeDate(rYear, rMonth, rDay);
end;

function bsAdapterToBusiness(const aDateTime: BaseTypesUnit.TDateTime): System.TDateTime;
  // overload;
  {-}
begin
 with aDateTime do
  Result := EncodeDateTime(rDate.rYear, rDate.rMonth, rDate.rDay, rTime.rHour,
   rTime.rMin, rTime.rSec, 0);
end;

function bsBusinessToAdapter(const aWordOrder : Tl3WordOrder) : TFindOrder;
begin
 Result := FO_ANY;
 case aWordOrder of
  woAsWrote:
   Result := FO_SEQUENCE;
 end;
end;

function bsBusinessToAdapter(const aTreeLevelDist : Tl3TreeLevelDist) : TSearchArea;
begin
 Result := SA_ALL_LEVEL;
 case aTreeLevelDist of
  tldOneLevel:
   Result := SA_ONE_LEVEL;
 end;
end;

function bsBusinessToAdapter(const aMark: TbsConsultationMark): TEstimationValue;
  {-}
begin
 Result := EV_UNDEFINED;
 case aMark of
  bs_cmFive:
   Result := EV_VERY_GOOD;
  bs_cmFour:
   Result := EV_GOOD;
  bs_cmThree:
   Result := EV_NORMAL;
  bs_cmTwo:
   Result := EV_BAD;
  bs_cmNotSure :
   Result := EV_UNDEFINED;
  else
   Assert(False, caUnknownConsultationMark);
 end;//case aMark of
end;//BusinessToAdapter

function bsAdapterToBusiness(const aLanguage: Word): TbsLanguage;
  {* - ������������ ���������� ������������� ����� � ������������ � ������ ����. }
begin
 Assert(aLanguage > 0, caAdapterLanguageCHanged);
 Result := TbsLanguage(Pred(aLanguage));
end;

function bsBusinessToAdapter(const aLanguage: TbsLanguage): Word;
  {* - ������������ ������������� ����� � ������������ � ������ ���� � ����������. }
begin
 Result := Succ(Ord(aLanguage));
end;

function bsBusinessToAdapter(const aRefType: TDocumentPositionType): TPositionType;
  {* - ������������ ��� ������ ���� � ���������� ���. }
begin
 Result := PT_SUB;
 case aRefType of
  dptBookmark:
   Result := PT_BOOKMARK;
  dptPara:
   Result := PT_PARA;
 end;
end;

function bsAdapterToBusiness(const aValue : TDynListContent) : TbsListType;
  overload;
  {-}
begin
 case aValue of
  DLC_LEGAL_DOCUMENTS:
   Result := bs_ltDocument;
  DLC_MEDICAL_DOCUMENTS:
   Result := bs_ltDrug;
  else
  begin
   Assert(False);
   Result := Low(TbsListType);
  end;
 end;
end;

function bsAdapterToBusiness(const aValue : TQueryLogicOperation) : TLogicOperation;
  {* - TQueryLogicOperation -> TLogicOperation. }
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

function bsAdapterToBusiness(const aPosType: TPositionType): TDocumentPositionType;
  {* - ������������ ���������� ��� � ��� ������ ����. }
begin
 Result := dptNone;
 case aPosType of
  PT_BOOKMARK:
   Result := dptBookmark;
  PT_PARA:
   Result := dptPara;
  PT_SUB:
   Result := dptSub;
 end;
end;

function bsBusinessToAdapter(const aSaveListKind: TbsSaveListKind): TEVDGeneratorStyle;
//  overload;
  {* - ��� ������� ������ � ��� }
const
 cMap: array [TbsSaveListKind] of TEVDGeneratorStyle = (GS_DEFAULT, GS_FULL_TREE, GS_TOPIC_AS_NAME);
begin
 Result := cMap[aSaveListKind];
end;

function bsBusinessToAdapter(const aOperation: TLogicOperation): Word;
  // overload;
  {-}
const
 lc_Map: array [TLogicOperation] of Word = (
  0, //loNone,
  cOrBitFlag, //loOr,
  cAndBitFlag, //loAnd,
  cNotBitFlag //loNot
 );
begin
 Assert(aOperation <> loNone);
 Result := lc_Map[aOperation];
end;//bsBusinessToAdapter

function bsBusinessToAdapter(const aDateTime: System.TDateTime): BaseTypesUnit.TDate;
  // overload;
  {-}
var
 l_Year  : Word;
 l_Month : Word;
 l_Day   : Word;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 DecodeDate(aDateTime, l_Year, l_Month, l_Day);
 with Result do
 begin
  rYear := l_Year;
  rMonth := l_Month;
  rDay := l_Day;
 end;//with Result do
end;//bsBusinessToAdapter

function bsBusinessToAdapter(const aOnlyFirstLevel: Boolean): TEVDGeneratorStyle;
//  overload;
  {* - ��� ������� ������ � ��� (���� �� ����������)}
const
 cMap: array [Boolean] of TEVDGeneratorStyle = (GS_FULL_TREE, GS_DEFAULT);
begin
 Result := cMap[aOnlyFirstLevel];
end;

end.
