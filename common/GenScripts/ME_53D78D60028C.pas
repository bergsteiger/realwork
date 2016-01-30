unit NOT_FINISHED_evDeadCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evDeadCursor.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)}
uses
 l3IntfUses
 , nevTools
;

type
 TevDeadCursor = class(IevSavedCursor)
  protected
   procedure Store(const Cursor: InevBasePoint);
   procedure Load(const Cursor: InevBasePoint);
   function Clone: IevSavedCursor;
 end;//TevDeadCursor

 TevDeadCursorParent = class(TevDeadCursor)
 end;//TevDeadCursorParent

 TevTextParaDeadCursor = class(TevDeadCursor)
 end;//TevTextParaDeadCursor
{$IfEnd} // Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)

implementation

{$If Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)}
uses
 l3ImplUses
;

procedure TevDeadCursor.Store(const Cursor: InevBasePoint);
//#UC START# *47E3DFA000D6_53D8ED0600C6_var*
//#UC END# *47E3DFA000D6_53D8ED0600C6_var*
begin
//#UC START# *47E3DFA000D6_53D8ED0600C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E3DFA000D6_53D8ED0600C6_impl*
end;//TevDeadCursor.Store

procedure TevDeadCursor.Load(const Cursor: InevBasePoint);
//#UC START# *47E3DFAA0290_53D8ED0600C6_var*
//#UC END# *47E3DFAA0290_53D8ED0600C6_var*
begin
//#UC START# *47E3DFAA0290_53D8ED0600C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E3DFAA0290_53D8ED0600C6_impl*
end;//TevDeadCursor.Load

function TevDeadCursor.Clone: IevSavedCursor;
//#UC START# *47E3DFB500DE_53D8ED0600C6_var*
//#UC END# *47E3DFB500DE_53D8ED0600C6_var*
begin
//#UC START# *47E3DFB500DE_53D8ED0600C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E3DFB500DE_53D8ED0600C6_impl*
end;//TevDeadCursor.Clone
{$IfEnd} // Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)

end.
