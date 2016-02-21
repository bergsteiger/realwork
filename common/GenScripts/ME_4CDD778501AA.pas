unit nsHyperlinkToDocumentProducerConst;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\nsHyperlinkToDocumentProducerConst.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_HyperlinkToDocumentProducerAppInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'HyperlinkToDocumentProducerAppInfo'; rValue : ', (ссылка на систему ГАРАНТ)');
  {* ', (ссылка на систему ГАРАНТ)' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_HyperlinkToDocumentProducerAppInfo.Init;
 {* Инициализация str_HyperlinkToDocumentProducerAppInfo }

end.
