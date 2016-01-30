unit DateTranslator;
 {* трансляция адаптерных и серверных дат }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DateTranslator.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

procedure translate(const date: TDate;
 var srv_date); overload;
procedure translate(date;
 var adapter_date: TDate); overload;
procedure translate_date(const adapter_date: TDate;
 var server_date); overload;
procedure translate_date(server_date;
 var adapter_date: TDate); overload;
procedure translate_date(const adapter_date: TDate;
 var server_date); overload;
procedure translate_date(server_date;
 var adapter_date: TDate); overload;

implementation

uses
 l3ImplUses
;

procedure translate(const date: TDate;
 var srv_date);
//#UC START# *460CEEAD0128_460B9047035B_var*
//#UC END# *460CEEAD0128_460B9047035B_var*
begin
//#UC START# *460CEEAD0128_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CEEAD0128_460B9047035B_impl*
end;//translate

procedure translate(date;
 var adapter_date: TDate);
//#UC START# *460CF2850251_460B9047035B_var*
//#UC END# *460CF2850251_460B9047035B_var*
begin
//#UC START# *460CF2850251_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CF2850251_460B9047035B_impl*
end;//translate

procedure translate_date(const adapter_date: TDate;
 var server_date);
//#UC START# *4746E2ED0090_460B9047035B_var*
//#UC END# *4746E2ED0090_460B9047035B_var*
begin
//#UC START# *4746E2ED0090_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746E2ED0090_460B9047035B_impl*
end;//translate_date

procedure translate_date(server_date;
 var adapter_date: TDate);
//#UC START# *4746E32E0040_460B9047035B_var*
//#UC END# *4746E32E0040_460B9047035B_var*
begin
//#UC START# *4746E32E0040_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746E32E0040_460B9047035B_impl*
end;//translate_date

procedure translate_date(const adapter_date: TDate;
 var server_date);
//#UC START# *4E0A05D90068_460B9047035B_var*
//#UC END# *4E0A05D90068_460B9047035B_var*
begin
//#UC START# *4E0A05D90068_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0A05D90068_460B9047035B_impl*
end;//translate_date

procedure translate_date(server_date;
 var adapter_date: TDate);
//#UC START# *4E0A05DB036B_460B9047035B_var*
//#UC END# *4E0A05DB036B_460B9047035B_var*
begin
//#UC START# *4E0A05DB036B_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0A05DB036B_460B9047035B_impl*
end;//translate_date

end.
