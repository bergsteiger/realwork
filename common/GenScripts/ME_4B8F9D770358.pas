unit vcmHistoryRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmHistoryRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmHistoryRes" MUID: (4B8F9D770358)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_vcmWrongHistoryElement: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmWrongHistoryElement'; rValue : '��������� ������� �������');
  {* '��������� ������� �������' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

initialization
 str_vcmWrongHistoryElement.Init;
 {* ������������� str_vcmWrongHistoryElement }
{$IfEnd} // NOT Defined(NoVCM)

end.
