unit Converters;
 {* ������ ����������� ����� }

// ������: "w:\shared\tie\Garant\GCI\Converters.pas"
// ���������: "UtilityPack"
// ������� ������: "Converters" MUID: (4869FC3401AE)

interface

uses
 l3IntfUses
;

function CpToUtf16(const in: AnsiString): a-wstring; stdcall;
 {* ��������� ������ � UTF-16, ��������� ������� ������ }
function Utf16ToCp(const in: a-wstring): AnsiString; stdcall;
 {* ��������� ������ � ������������ ���������, ��������� ������� ������ }

implementation

uses
 l3ImplUses
;

function CpToUtf16(const in: AnsiString): a-wstring;
 {* ��������� ������ � UTF-16, ��������� ������� ������ }
//#UC START# *4869FCA503BC_4869FC3401AE_var*
//#UC END# *4869FCA503BC_4869FC3401AE_var*
begin
//#UC START# *4869FCA503BC_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCA503BC_4869FC3401AE_impl*
end;//CpToUtf16

function Utf16ToCp(const in: a-wstring): AnsiString;
 {* ��������� ������ � ������������ ���������, ��������� ������� ������ }
//#UC START# *4869FCAA0279_4869FC3401AE_var*
//#UC END# *4869FCAA0279_4869FC3401AE_var*
begin
//#UC START# *4869FCAA0279_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCAA0279_4869FC3401AE_impl*
end;//Utf16ToCp

end.
