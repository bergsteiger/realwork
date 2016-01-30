unit evdDOM;
 {* Объектная модель документа EVD }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdDOM.pas"
// Стереотип: "Interfaces"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdTypes
 , l3Types
;

type
 TevdPaperSize = (
  {* Размер бумаги }
  evd_psCustom
  , evd_psA0
   {* 84   x 118.8 }
  , evd_psA1
   {* 59.4 x 84 }
  , evd_psA2
   {* 42   x 59.4 }
  , evd_psA3
   {* 29.7 x 42 }
  , evd_psA4
   {* 21   x 29.7 }
  , evd_psA5
   {* 14.8 x 21 }
 );//TevdPaperSize

 IevdSection = interface
  {* Свойства раздела документа }
  ['{200906F8-7E80-4FA3-B51F-628A5D751D6E}']
  function pm_GetPaperSize: TevdPaperSize;
  procedure pm_SetPaperSize(aValue: TevdPaperSize);
  function pm_GetOrientation: TevPageOrientation;
  procedure pm_SetOrientation(aValue: TevPageOrientation);
  property PaperSize: TevdPaperSize
   read pm_GetPaperSize
   write pm_SetPaperSize;
   {* Размер бумаги }
  property Orientation: TevPageOrientation
   read pm_GetOrientation
   write pm_SetOrientation;
   {* Ориентация страницы }
 end;//IevdSection

 TevdLanguage = (
  {* Язык }
  evd_lgRussian
   {* Русский }
  , evd_lgEnglish
   {* Английский }
  , evd_lgGerman
   {* Немецкий }
  , evd_lgFrench
   {* Французский }
  , evd_lgItalian
   {* Итальянский }
  , evd_lgSpanish
   {* Испанский }
 );//TevdLanguage

 IevdDictEntry = interface
  {* Вхождение толкового словаря }
  ['{70F7FC17-4C78-4917-A9D5-593B8889B4A5}']
  function pm_GetShortName(aLang: TevdLanguage): Tl3PCharLen;
  procedure pm_SetShortName(aLang: TevdLanguage;
   const aValue: Tl3PCharLen);
  property ShortName[aLang: TevdLanguage]: Tl3PCharLen
   read pm_GetShortName
   write pm_SetShortName;
   {* Короткие имена }
 end;//IevdDictEntry

implementation

uses
 l3ImplUses
;

end.
