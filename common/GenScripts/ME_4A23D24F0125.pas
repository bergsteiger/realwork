unit evdDOM;

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
 end;//IevdDictEntry
 
implementation

uses
 l3ImplUses
;

end.
