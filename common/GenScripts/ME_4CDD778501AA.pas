unit nsHyperlinkToDocumentProducerConst;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\nsHyperlinkToDocumentProducerConst.pas"
// ���������: "UtilityPack"

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
 , l3MessageID
;

initialization
 str_HyperlinkToDocumentProducerAppInfo.Init;
 {* ������������� str_HyperlinkToDocumentProducerAppInfo }

end.
