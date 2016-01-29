unit NOT_FINISHED_evDeadCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evDeadCursor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Cursors::evDeadCursor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
uses
  nevTools
  ;

type
 TevDeadCursor = class(, IevSavedCursor)
 protected
 // realized methods
   procedure Store(const Cursor: InevBasePoint);
   procedure Load(const Cursor: InevBasePoint);
   function Clone: IevSavedCursor;
 end;//TevDeadCursor

 TevDeadCursorParent = class(TevDeadCursor)
 end;//TevDeadCursorParent

 TevTextParaDeadCursor = class(TevDeadCursor)
 end;//TevTextParaDeadCursor
{$IfEnd} //evUseDeadCursor AND evUseVisibleCursors

implementation

{$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
// start class TevDeadCursor

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
{$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
end.