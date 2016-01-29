unit nsHAFPainterPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsHAFPainterPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TnsHAFPainterPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  evHAFPainterEx
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TnsHAFPainterPrim = class(TevHAFPainterEx)
 protected
 // overridden protected methods
   function GetAppTitle: AnsiString; override;
 end;//TnsHAFPainterPrim
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  nsAppTitleData
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TnsHAFPainterPrim

function TnsHAFPainterPrim.GetAppTitle: AnsiString;
//#UC START# *53EDC0B8024A_540E9DE4024C_var*
//#UC END# *53EDC0B8024A_540E9DE4024C_var*
begin
//#UC START# *53EDC0B8024A_540E9DE4024C_impl*
 Result := TnsAppTitleData.Instance.Title;
//#UC END# *53EDC0B8024A_540E9DE4024C_impl*
end;//TnsHAFPainterPrim.GetAppTitle

{$IfEnd} //not Admin

end.