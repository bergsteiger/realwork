unit nsHyperlinkToDocumentProducerConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\nsHyperlinkToDocumentProducerConst.pas"
// ���������: "UtilityPack"
// ������� ������: "nsHyperlinkToDocumentProducerConst" MUID: (4CDD778501AA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_HyperlinkToDocumentProducerAppInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'HyperlinkToDocumentProducerAppInfo'; rValue : ', (������ �� ������� ������)');
  {* ', (������ �� ������� ������)' }

implementation

uses
 l3ImplUses
 //#UC START# *4CDD778501AAimpl_uses*
 //#UC END# *4CDD778501AAimpl_uses*
;

initialization
 str_HyperlinkToDocumentProducerAppInfo.Init;
 {* ������������� str_HyperlinkToDocumentProducerAppInfo }

end.
