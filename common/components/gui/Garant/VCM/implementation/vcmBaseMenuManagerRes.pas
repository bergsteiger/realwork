unit vcmBaseMenuManagerRes;

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmBaseMenuManagerRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmBaseMenuManagerRes" MUID: (4B8F8EA1013C)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_vcmShowTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmShowTab'; rValue : '�������� ������� "%s"');
  {* '�������� ������� "%s"' }
 str_vcmHideTab: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmHideTab'; rValue : '������ ������� "%s"');
  {* '������ ������� "%s"' }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_vcmShowTab.Init;
 {* ������������� str_vcmShowTab }
 str_vcmHideTab.Init;
 {* ������������� str_vcmHideTab }
{$IfEnd} // NOT Defined(NoVCM)

end.
