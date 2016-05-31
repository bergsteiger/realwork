unit bsUtilsConst;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\bsUtilsConst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "bsUtilsConst" MUID: (4E283FC201DC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_wgReferenceHyperlinkSearchText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkSearchText'; rValue : 'Подробнее см. в справке к документу');
  {* 'Подробнее см. в справке к документу' }
 str_wgReferenceHyperlinkReplaceText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHyperlinkReplaceText'; rValue : 'Подробнее [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]');
  {* 'Подробнее [см. в справке к документу|script:оп::Документ_Справка_к_документу|Ссылка на справку к документу]' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

initialization
 str_wgReferenceHyperlinkSearchText.Init;
 {* Инициализация str_wgReferenceHyperlinkSearchText }
 str_wgReferenceHyperlinkReplaceText.Init;
 {* Инициализация str_wgReferenceHyperlinkReplaceText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
