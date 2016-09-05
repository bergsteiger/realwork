unit ddAppConfigTypesRes;

// ������: "w:\common\components\rtl\Garant\dd\ddAppConfigTypesRes.pas"
// ���������: "UtilityPack"
// ������� ������: "ddAppConfigTypesRes" MUID: (4B9E68040166)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_ddcmInvalidIntegerValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidIntegerValue'; rValue : '��������� ���� �������� ''%s'' �� �������� ������.');
  {* '��������� ���� �������� ''%s'' �� �������� ������.' }
 str_ddcmErrorIntegerRange: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmErrorIntegerRange'; rValue : '��������� ���� ����� ''%d'' ��������� ��� ��������� ''%d-%d''.');
  {* '��������� ���� ����� ''%d'' ��������� ��� ��������� ''%d-%d''.' }
 str_ddcmInvalidMaxValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMaxValue'; rValue : '������������ �������� %d �� ����� ��������� %d');
  {* '������������ �������� %d �� ����� ��������� %d' }
 str_ddcmInvalidMinValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMinValue'; rValue : '����������� �������� %d �� ����� ���� ������ %d');
  {* '����������� �������� %d �� ����� ���� ������ %d' }
 str_ddcmSelectButton: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSelectButton'; rValue : '�������');
  {* '�������' }
 str_ddcmFontExample: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmFontExample'; rValue : '������ ������');
  {* '������ ������' }
 str_ddcmInvalidMapValue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMapValue'; rValue : '��������� �������� �� ������� � ������ ����������');
  {* '��������� �������� �� ������� � ������ ����������' }

implementation

uses
 l3ImplUses
 //#UC START# *4B9E68040166impl_uses*
 //#UC END# *4B9E68040166impl_uses*
;

initialization
 str_ddcmInvalidIntegerValue.Init;
 {* ������������� str_ddcmInvalidIntegerValue }
 str_ddcmErrorIntegerRange.Init;
 {* ������������� str_ddcmErrorIntegerRange }
 str_ddcmInvalidMaxValue.Init;
 {* ������������� str_ddcmInvalidMaxValue }
 str_ddcmInvalidMinValue.Init;
 {* ������������� str_ddcmInvalidMinValue }
 str_ddcmSelectButton.Init;
 {* ������������� str_ddcmSelectButton }
 str_ddcmFontExample.Init;
 {* ������������� str_ddcmFontExample }
 str_ddcmInvalidMapValue.Init;
 {* ������������� str_ddcmInvalidMapValue }

end.
