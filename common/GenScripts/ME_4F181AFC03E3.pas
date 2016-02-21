unit nsStringValueMapFactoryRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStringValueMapFactoryRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_cpClassCaptionReview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpClassCaptionReview'; rValue : 'Раздел/Тема в ОИЗ');
  {* 'Раздел/Тема в ОИЗ' }
 str_cpSourceCaptionReview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpSourceCaptionReview'; rValue : 'Орган/Источник в ОИЗ');
  {* 'Орган/Источник в ОИЗ' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_cpClassCaptionReview.Init;
 {* Инициализация str_cpClassCaptionReview }
 str_cpSourceCaptionReview.Init;
 {* Инициализация str_cpSourceCaptionReview }

end.
