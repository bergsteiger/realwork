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
 str_wgReferenceHyperlinkReplaceText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : '��������� [��. � ������� � ���������|script:��::��������_�������_�_���������|������ �� ������� � ���������]');
  {* '��������� [��. � ������� � ���������|script:��::��������_�������_�_���������|������ �� ������� � ���������]' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

initialization
 str_wgReferenceHyperlinkSearchText.Init;
 {* ������������� str_wgReferenceHyperlinkSearchText }
 str_wgReferenceHyperlinkReplaceText.Init;
 {* ������������� str_wgReferenceHyperlinkReplaceText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
