unit bsUtilsConst;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\bsUtilsConst.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_wgReferenceHyperlinkSearchText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkSearchText'; rValue : ' см. в справке к документу');
  {* ' см. в справке к документу' }
 str_wgReferenceHyperlinkReplaceText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : ' [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]');
  {* ' [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_wgReferenceHyperlinkSearchText.Init;
 {* Инициализация str_wgReferenceHyperlinkSearchText }
 str_wgReferenceHyperlinkReplaceText.Init;
 {* Инициализация str_wgReferenceHyperlinkReplaceText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
