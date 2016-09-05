unit nsHAFPainterPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainterPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsHAFPainterPrim" MUID: (540E9DE4024C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , evHAFPainterEx
;

type
 TnsHAFPainterPrim = class(TevHAFPainterEx)
  protected
   function GetAppTitle: AnsiString; override;
 end;//TnsHAFPainterPrim
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsAppTitleData
 //#UC START# *540E9DE4024Cimpl_uses*
 //#UC END# *540E9DE4024Cimpl_uses*
;

function TnsHAFPainterPrim.GetAppTitle: AnsiString;
//#UC START# *53EDC0B8024A_540E9DE4024C_var*
//#UC END# *53EDC0B8024A_540E9DE4024C_var*
begin
//#UC START# *53EDC0B8024A_540E9DE4024C_impl*
 Result := TnsAppTitleData.Instance.Title;
//#UC END# *53EDC0B8024A_540E9DE4024C_impl*
end;//TnsHAFPainterPrim.GetAppTitle
{$IfEnd} // NOT Defined(Admin)

end.
