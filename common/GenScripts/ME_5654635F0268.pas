unit daSchemeConsts;

// ������: "w:\common\components\rtl\Garant\DA\daSchemeConsts.pas"
// ���������: "UtilityPack"
// ������� ������: "daSchemeConsts" MUID: (5654635F0268)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* Free Table Names }
 ftnDocIDExternal = 'DOCIDEXT';
 ftnDocIDForLists = 'DOCIDLST';
  {* ��� ��������� DocID ��� ��������� ������� (�:119473985) }
 ftnDocIDLawCase = 'LAWCASE';
  {* �������� ������� ��� ������������� �� }
 ftnDocIDVAS = 'VASCASE';
  {* ������������� ��� }
 ftnDocID1st = 'SPBDOC';
  {* ��������� ����� ������ ��������� }
 ftnDocIDFAS1 = 'FAS1';
  {* ��� ��� }
 ftnDocIDFAS2 = 'FAS2';
  {* ��� ��� }
 ftnDocIDFAS3 = 'FAS3';
  {* ��� ��� }
 ftnDocIDFAS4 = 'FAS4';
  {* ��� ��� }
 ftnDocIDFAS5 = 'FAS5';
  {* ��� �� }
 ftnDocIDFAS6 = 'FAS6';
  {* ��� ��� }
 ftnDocIDFAS7 = 'FAS7';
  {* ��� �� }
 ftnDocIDFAS8 = 'FAS8';
  {* ��� ��� }
 ftnDocIDFAS9 = 'FAS9';
  {* ��� ��� }
 ftnDocIDFAS10 = 'FAS10';
  {* ��� �� }
 ftnImgHandle = 'HIMAGE';
  {* ��� ��������� ID ����������� function GlobalDataProvider.GetFreeExtObjID(aFamily : TFamilyID): TDocID; }
 NameDictExternalNumber = 'DictExtN';
 MainTblsFamily = 0;
 CurrentFamily = 1;

implementation

uses
 l3ImplUses
;

end.
