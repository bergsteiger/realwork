unit evCommonRes;
 {* ����� ������� ��� �������� � ����. }

// ������: "w:\archi\source\projects\Common\Utils\evCommonRes.pas"
// ���������: "UtilityPack"
// ������� ������: "evCommonRes" MUID: (52E79910011F)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ DialogCaptions }
 str_sidChangeSubToBlock: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidChangeSubToBlock'; rValue : '������ �������� ����� ����� �����'^M+'��������� �������� � ��� ���������� �� ����?');
  {* '������ �������� ����� ����� �����'^M+'��������� �������� � ��� ���������� �� ����?' }
 str_sidNonValidSubNumber: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonValidSubNumber'; rValue : '����� ����� ������ ���� ������ ����.');
  {* '����� ����� ������ ���� ������ ����.' }
 str_sidNonUniqSubNumberQst: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumberQst'; rValue : '�� ���������� ����� �����.'^M+'��������� ����� � ���� ������� �� ������� �����?');
  {* '�� ���������� ����� �����.'^M+'��������� ����� � ���� ������� �� ������� �����?' }
 str_sidNonUniqSubNumber: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumber'; rValue : '�� ���������� ����� �����.');
  {* '�� ���������� ����� �����.' }
 str_sidBlockAlreadyExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidBlockAlreadyExists'; rValue : '���� � ����� ����� ��� ���� � ���������.');
  {* '���� � ����� ����� ��� ���� � ���������.' }
 str_sidIEmtyFormula: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidIEmtyFormula'; rValue : '������� ������� ������ �������.');
  {* '������� ������� ������ �������.' }
 str_sidTableNotFound: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidTableNotFound'; rValue : '������� �� �������.');
  {* '������� �� �������.' }
 str_sidNoTextSelection: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNoTextSelection'; rValue : '������� �������� �����.');
  {* '������� �������� �����.' }
 str_sidEWSpellCheckDone: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEWSpellCheckDone'; rValue : '�������� ������������ � ��������� ���������.');
  {* '�������� ������������ � ��������� ���������.' }
 str_sidSaveAsk: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidSaveAsk'; rValue : '�������� "%S" ��� ��������������.'^M'��������?');
  {* '�������� "%S" ��� ��������������.'^M'��������?' }
 str_sidEmptyViborka: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEmptyViborka'; rValue : '��������� ������� ������');
  {* '��������� ������� ������' }
 str_sidSpellCheckFragmentAsk: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidSpellCheckFragmentAsk'; rValue : '��������� ������������ ������ � ���������� ���������?');
  {* '��������� ������������ ������ � ���������� ���������?' }

implementation

uses
 l3ImplUses
;

initialization
 str_sidChangeSubToBlock.Init;
 {* ������������� str_sidChangeSubToBlock }
 str_sidNonValidSubNumber.Init;
 {* ������������� str_sidNonValidSubNumber }
 str_sidNonUniqSubNumberQst.Init;
 {* ������������� str_sidNonUniqSubNumberQst }
 str_sidNonUniqSubNumber.Init;
 {* ������������� str_sidNonUniqSubNumber }
 str_sidBlockAlreadyExists.Init;
 {* ������������� str_sidBlockAlreadyExists }
 str_sidIEmtyFormula.Init;
 {* ������������� str_sidIEmtyFormula }
 str_sidTableNotFound.Init;
 {* ������������� str_sidTableNotFound }
 str_sidNoTextSelection.Init;
 {* ������������� str_sidNoTextSelection }
 str_sidEWSpellCheckDone.Init;
 {* ������������� str_sidEWSpellCheckDone }
 str_sidSaveAsk.Init;
 {* ������������� str_sidSaveAsk }
 str_sidEmptyViborka.Init;
 {* ������������� str_sidEmptyViborka }
 str_sidSpellCheckFragmentAsk.Init;
 {* ������������� str_sidSpellCheckFragmentAsk }

end.
