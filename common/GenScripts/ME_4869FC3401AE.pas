unit Converters;
 {* методы конвертации строк }

// ћодуль: "w:\shared\tie\Garant\GCI\Converters.pas"
// —тереотип: "UtilityPack"
// Ёлемент модели: "Converters" MUID: (4869FC3401AE)

interface

uses
 l3IntfUses
;

function cp_to_utf16(const in: AnsiString): a-wstring;
 {* переводит строку в UTF-16, использу€ текущую локаль }
function utf16_to_cp(const in: a-wstring): AnsiString;
 {* переводит строку в однобайтовую кодировку, использу€ текущую локаль }

implementation

uses
 l3ImplUses
;

function cp_to_utf16(const in: AnsiString): a-wstring;
 {* переводит строку в UTF-16, использу€ текущую локаль }
//#UC START# *4869FCA503BC_4869FC3401AE_var*
//#UC END# *4869FCA503BC_4869FC3401AE_var*
begin
//#UC START# *4869FCA503BC_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCA503BC_4869FC3401AE_impl*
end;//cp_to_utf16

function utf16_to_cp(const in: a-wstring): AnsiString;
 {* переводит строку в однобайтовую кодировку, использу€ текущую локаль }
//#UC START# *4869FCAA0279_4869FC3401AE_var*
//#UC END# *4869FCAA0279_4869FC3401AE_var*
begin
//#UC START# *4869FCAA0279_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCAA0279_4869FC3401AE_impl*
end;//utf16_to_cp

end.
