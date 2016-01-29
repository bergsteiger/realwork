{$IfNDef Navigator_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$EditorUsers"
// Модуль: "w:/common/components/gui/Garant/Everest/EditorUsers/Navigator.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::Navigator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Navigator_imp}
{$If not defined(NoScripts)}
 _Navigator_ = {mixin} class(_Navigator_Parent_)
 protected
 // protected methods
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); virtual; abstract;
     {* Устанавливает курсор или выделение }
 end;//_Navigator_
{$Else}

 _Navigator_ = _Navigator_Parent_;

{$IfEnd} //not NoScripts

{$Else Navigator_imp}

{$If not defined(NoScripts)}


{$IfEnd} //not NoScripts

{$EndIf Navigator_imp}
