unit vtHideFieldUtils;

// Модуль: "w:\common\components\gui\Garant\VT\vtHideFieldUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtHideFieldUtils" MUID: (5110ED94010E)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

function MakeName(const aName: AnsiString): AnsiString;

var g_HideFieldCount: Integer;
 {* для присвоения уникальных имен компонентам, для назначения обработчиков событий на форме }

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *5110ED94010Eimpl_uses*
 //#UC END# *5110ED94010Eimpl_uses*
;

function MakeName(const aName: AnsiString): AnsiString;
//#UC START# *5110EDE70381_5110ED94010E_var*
//#UC END# *5110EDE70381_5110ED94010E_var*
begin
//#UC START# *5110EDE70381_5110ED94010E_impl*
 Result := aName + IntToStr(g_HideFieldCount);
//#UC END# *5110EDE70381_5110ED94010E_impl*
end;//MakeName

end.
