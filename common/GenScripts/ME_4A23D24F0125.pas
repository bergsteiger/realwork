unit evdDOM;

interface

uses
 l3IntfUses
 , evdTypes
 , l3Types
;

type
 TevdPaperSize = (
  {* ������ ������ }
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
  {* �������� ������� ��������� }
 end;//IevdSection
 
 TevdLanguage = (
  {* ���� }
  evd_lgRussian
   {* ������� }
  , evd_lgEnglish
   {* ���������� }
  , evd_lgGerman
   {* �������� }
  , evd_lgFrench
   {* ����������� }
  , evd_lgItalian
   {* ����������� }
  , evd_lgSpanish
   {* ��������� }
 );//TevdLanguage
 
 IevdDictEntry = interface
  {* ��������� ��������� ������� }
 end;//IevdDictEntry
 
implementation

uses
 l3ImplUses
;

end.
