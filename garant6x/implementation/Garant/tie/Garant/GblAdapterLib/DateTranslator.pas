unit DateTranslator;
 {* ���������� ���������� � ��������� ��� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DateTranslator.pas"
// ���������: "UtilityPack"
// ������� ������: "DateTranslator" MUID: (460B9047035B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

procedure Translate(const date: TDate;
 var srv_date); overload; stdcall;
procedure Translate(const date;
 var adapter_date: TDate); overload; stdcall;
procedure TranslateDate(const adapter_date: TDate;
 var server_date); overload; stdcall;
procedure TranslateDate(const server_date;
 var adapter_date: TDate); overload; stdcall;
procedure TranslateDate(const adapter_date: TDate;
 var server_date); overload; stdcall;
procedure TranslateDate(const server_date;
 var adapter_date: TDate); overload; stdcall;

implementation

uses
 l3ImplUses
;

procedure Translate(const date: TDate;
 var srv_date);
//#UC START# *460CEEAD0128_460B9047035B_var*
//#UC END# *460CEEAD0128_460B9047035B_var*
begin
//#UC START# *460CEEAD0128_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CEEAD0128_460B9047035B_impl*
end;//Translate

procedure Translate(const date;
 var adapter_date: TDate);
//#UC START# *460CF2850251_460B9047035B_var*
//#UC END# *460CF2850251_460B9047035B_var*
begin
//#UC START# *460CF2850251_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CF2850251_460B9047035B_impl*
end;//Translate

procedure TranslateDate(const adapter_date: TDate;
 var server_date);
//#UC START# *4746E2ED0090_460B9047035B_var*
//#UC END# *4746E2ED0090_460B9047035B_var*
begin
//#UC START# *4746E2ED0090_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746E2ED0090_460B9047035B_impl*
end;//TranslateDate

procedure TranslateDate(const server_date;
 var adapter_date: TDate);
//#UC START# *4746E32E0040_460B9047035B_var*
//#UC END# *4746E32E0040_460B9047035B_var*
begin
//#UC START# *4746E32E0040_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746E32E0040_460B9047035B_impl*
end;//TranslateDate

procedure TranslateDate(const adapter_date: TDate;
 var server_date);
//#UC START# *4E0A05D90068_460B9047035B_var*
//#UC END# *4E0A05D90068_460B9047035B_var*
begin
//#UC START# *4E0A05D90068_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0A05D90068_460B9047035B_impl*
end;//TranslateDate

procedure TranslateDate(const server_date;
 var adapter_date: TDate);
//#UC START# *4E0A05DB036B_460B9047035B_var*
//#UC END# *4E0A05DB036B_460B9047035B_var*
begin
//#UC START# *4E0A05DB036B_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0A05DB036B_460B9047035B_impl*
end;//TranslateDate

end.
