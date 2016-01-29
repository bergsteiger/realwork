unit DateTranslator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DateTranslator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::DateTranslator
//
// трансляция адаптерных и серверных дат
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit
  ;

procedure Translate(const date: TDate;
  var srv_date); overload; 
procedure Translate(date;
  var adapter_date: TDate); overload; 
procedure TranslateDate(const adapter_date: TDate;
  var server_date); overload; 
procedure TranslateDate(server_date;
  var adapter_date: TDate); overload; 
procedure TranslateDate(const adapter_date: TDate;
  var server_date); overload; 
procedure TranslateDate(server_date;
  var adapter_date: TDate); overload; 

implementation

// unit methods

procedure Translate(const date: TDate;
  var srv_date);
//#UC START# *460CEEAD0128_460B9047035B_var*
//#UC END# *460CEEAD0128_460B9047035B_var*
begin
//#UC START# *460CEEAD0128_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CEEAD0128_460B9047035B_impl*
end;//Translate

procedure Translate(date;
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

procedure TranslateDate(server_date;
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

procedure TranslateDate(server_date;
  var adapter_date: TDate);
//#UC START# *4E0A05DB036B_460B9047035B_var*
//#UC END# *4E0A05DB036B_460B9047035B_var*
begin
//#UC START# *4E0A05DB036B_460B9047035B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0A05DB036B_460B9047035B_impl*
end;//TranslateDate

end.