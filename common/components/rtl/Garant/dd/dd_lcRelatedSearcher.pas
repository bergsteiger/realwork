unit dd_lcRelatedSearcher;

interface

uses
 dtIntf, dt_Sab;

  function FindRelated(aStartDate, aFinishDate: TDateTime; aAccGroup: Integer): ISab;

implementation

uses
  l3Base,
  daTypes, daSchemeConsts,
  DT_Query, dt_SrchQueries, DT_Types, l3Date, SysUtils, DT_Link, DT_LinkServ, DT_Const,
  DT_attrSchema, DT_DictConst, dt_Dict, DT_Doc, HT_Const;

function FindRelated(aStartDate, aFinishDate: TDateTime; aAccGroup: Integer): ISab;
var
 lValue : Integer;
 lSab: ISab;
 l_Q1, l_Q: TdtQuery;
begin
 l3System.Msg2Log('����� ��������� ������� ��������� � %s �� %s (������ �������: %d)',
    [DateToStr(aStartDate), DateToStr(aFinishDate), aAccGroup]);
 Result := nil;
 // ������� ��������������� �� ������ (� ������������ ���������?)
 l_Q := TdtLogByActionQuery.Create(
          acWasImported,
          DateTimeToDtDate(aStartDate),  // FromDate
          DateTimeToDtDate(aFinishDate) // ToDate
          );
 try
  lSab:= l_Q.GetDocIdList;
 finally
  FreeAndNil(l_Q);
 end;
 // ������� �������� �� ������������
 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily)[atDateNums]);
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.RecordsByKey(dnIDFld, MakePhoto(DictServer(CurrentFamily).Tbl[da_dlDateNums]));
 lValue := ord(dnLawCaseNum);
 lSab.SubSelect(dnTypFld, lValue);
 lSab.ValuesOfKey(dnNumFld);
 lSab.RecordsByKey;
 // ������� ��� ��������� � ����� ����������
 lSab.ValuesOfKey(dnIDFld);
 lSab.RecordsByKey(lnkDictIDFld, MakePhoto(LinkServer(CurrentFamily).Attribute[atDateNums]));
 lSab.ValuesOfKey(lnkDocIDFld);
 lSab.RecordsByKey(fId_Fld, MakePhoto(DocumentServer.FileTbl));

 // ������� ��, � ������� ��� �������
 lValue := 0;
 lSab.SubSelect(fRelated_fld, lValue, Not_Equal);
 // ������� ���������, � ������� ���� ��� �������
 lSab.ValuesOfKey(fRelated_fld);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(fID_fld);
 // ����� ������ �������������� � �� ���������
 l_Q:= TdtIDListQuery.CreateFrom(lSab);
 try
  // ������������
  l_Q1:= TdtLogByActionQuery.Create(acIncluded,
          0,// FromDate
          0 // ToDate
          );
  SQAndF(l_Q, l_Q1);
  // ���������
  l_Q1:= TdtDictQuery.Create(da_dlAccGroups, aAccGroup);
  SQAndF(l_Q, l_Q1);
  // ����
  Result:= l_Q.GetDocIdList;
  Result.ValuesOfKey(fID_fld);
 finally
  FreeAndNil(l_Q);
 end;
 if Result <> nil then
  l3System.Msg2Log('  * �������: %d', [Result.Count])
 else
  l3System.Msg2Log('  * ������ �� �������');
end;

end.
