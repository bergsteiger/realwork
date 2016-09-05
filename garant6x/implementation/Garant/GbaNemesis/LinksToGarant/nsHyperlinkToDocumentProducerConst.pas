unit nsHyperlinkToDocumentProducerConst;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\nsHyperlinkToDocumentProducerConst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsHyperlinkToDocumentProducerConst" MUID: (4CDD778501AA)

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
 //#UC START# *4CDD778501AAimpl_uses*
 //#UC END# *4CDD778501AAimpl_uses*
;

initialization
 str_HyperlinkToDocumentProducerAppInfo.Init;
 {* Инициализация str_HyperlinkToDocumentProducerAppInfo }

end.
