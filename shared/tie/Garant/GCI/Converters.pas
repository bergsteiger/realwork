unit Converters;
 {* ������ ����������� ����� }

// ������: "w:\shared\tie\Garant\GCI\Converters.pas"
// ���������: "UtilityPack"
// ������� ������: "Converters" MUID: (4869FC3401AE)

interface

uses
 l3IntfUses
;

procedure CpToUtf16(const in: AnsiString;
 out aRet
 {* a-wstring }); stdcall;
 {* ��������� ������ � UTF-16, ��������� ������� ������ }
procedure Utf16ToCp(const in: a-wstring;
 out aRet
 {* AnsiString }); stdcall;
 {* ��������� ������ � ������������ ���������, ��������� ������� ������ }

implementation

uses
 l3ImplUses
;

procedure CpToUtf16(const in: AnsiString;
 out aRet
 {* a-wstring });
 {* ��������� ������ � UTF-16, ��������� ������� ������ }
//#UC START# *4869FCA503BC_4869FC3401AE_var*
//#UC END# *4869FCA503BC_4869FC3401AE_var*
begin
//#UC START# *4869FCA503BC_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCA503BC_4869FC3401AE_impl*
end;//CpToUtf16

procedure Utf16ToCp(const in: a-wstring;
 out aRet
 {* AnsiString });
 {* ��������� ������ � ������������ ���������, ��������� ������� ������ }
//#UC START# *4869FCAA0279_4869FC3401AE_var*
//#UC END# *4869FCAA0279_4869FC3401AE_var*
begin
//#UC START# *4869FCAA0279_4869FC3401AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4869FCAA0279_4869FC3401AE_impl*
end;//Utf16ToCp

end.
