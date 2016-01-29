unit vtHideFieldUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtHideFieldUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::HideFields::vtHideFieldUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

var g_HideFieldCount : Integer;
 {* для присвоения уникальных имен компонентам, для назначения обработчиков событий на форме}
function MakeName(const aName: AnsiString): AnsiString;

implementation

uses
  SysUtils
  ;

// unit methods

function MakeName(const aName: AnsiString): AnsiString;
//#UC START# *5110EDE70381_5110ED94010E_var*
//#UC END# *5110EDE70381_5110ED94010E_var*
begin
//#UC START# *5110EDE70381_5110ED94010E_impl*
 Result := aName + IntToStr(g_HideFieldCount);
//#UC END# *5110EDE70381_5110ED94010E_impl*
end;//MakeName

end.