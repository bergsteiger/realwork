unit daDataProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daDataProvider.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DA::Provider::daDataProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  daInterfaces
  ;

function GlobalDataProvider: IdaDataProvider;
procedure SetGlobalDataProvider(const aProvider: IdaDataProvider);

implementation

var g_GlobalDataProvider : Pointer;

// unit methods

function GlobalDataProvider: IdaDataProvider;
//#UC START# *551A7D9602DC_551A7D7402B4_var*
//#UC END# *551A7D9602DC_551A7D7402B4_var*
begin
//#UC START# *551A7D9602DC_551A7D7402B4_impl*
 Result := IdaDataProvider(g_GlobalDataProvider);
//#UC END# *551A7D9602DC_551A7D7402B4_impl*
end;//GlobalDataProvider

procedure SetGlobalDataProvider(const aProvider: IdaDataProvider);
//#UC START# *551A7DB8018C_551A7D7402B4_var*
//#UC END# *551A7DB8018C_551A7D7402B4_var*
begin
//#UC START# *551A7DB8018C_551A7D7402B4_impl*
 g_GlobalDataProvider := Pointer(aProvider);
//#UC END# *551A7DB8018C_551A7D7402B4_impl*
end;//SetGlobalDataProvider

end.