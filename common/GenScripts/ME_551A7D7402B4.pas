unit daDataProvider;

// Модуль: "w:\common\components\rtl\Garant\DA\daDataProvider.pas"
// Стереотип: "UtilityPack"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , daInterfaces
;

function GlobalDataProvider: IdaDataProvider;
procedure SetGlobalDataProvider(const aProvider: IdaDataProvider);

implementation

uses
 l3ImplUses
;

var g_GlobalDataProvider: Pointer;

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
