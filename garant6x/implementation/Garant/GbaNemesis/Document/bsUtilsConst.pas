unit bsUtilsConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Document\bsUtilsConst.pas"
// ���������: "UtilityPack"
// ������� ������: "bsUtilsConst" MUID: (4E283FC201DC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_wgReferenceHyperlinkSearchText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkSearchText'; rValue : '��������� ��. � ������� � ���������');
  {* '��������� ��. � ������� � ���������' }
 str_wgReferenceHyperlinkReplaceText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : '��������� [��. � ������� � ���������|script:op::enDocument_opGetRelatedDocFrmAct|������ �� ������� � ���������]');
  {* '��������� [��. � ������� � ���������|script:op::enDocument_opGetRelatedDocFrmAct|������ �� ������� � ���������]' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4E283FC201DCimpl_uses*
 //#UC END# *4E283FC201DCimpl_uses*
;

initialization
 str_wgReferenceHyperlinkSearchText.Init;
 {* ������������� str_wgReferenceHyperlinkSearchText }
 str_wgReferenceHyperlinkReplaceText.Init;
 {* ������������� str_wgReferenceHyperlinkReplaceText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
