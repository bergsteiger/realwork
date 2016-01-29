unit eeSubPanel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeSubPanel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::eeSubPanel::TeeSubPanel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  eeInterfaces,
  eeSubPanelExport
  ;

type
 TeeCustomSubPanel = class(TeeSubPanelExport)
 protected
 // property methods
   function pm_GetSubPanel: IeeSubPanel;
 public
 // public properties
   property SubPanel: IeeSubPanel
     read pm_GetSubPanel;
 end;//TeeCustomSubPanel

//#UC START# *4C7F948C03BDci*
//#UC END# *4C7F948C03BDci*
//#UC START# *4C7F948C03BDcit*
//#UC END# *4C7F948C03BDcit*
 TeeSubPanel = class(TeeCustomSubPanel)
//#UC START# *4C7F948C03BDpubl*
    public
    // public properties
      property Color;
        {-}
    published
    // published properties
      property Align;
        {-}
      property TabOrder;
        {-}
      property PopupMenu;
        {-}
      property SubDescriptors;
        {-}
    published
    // published events
      property OnMouseOverSub;
        {-}
      property OnClickSub;
        {-}
//#UC END# *4C7F948C03BDpubl*
 end;//TeeSubPanel

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeCustomSubPanel

function TeeCustomSubPanel.pm_GetSubPanel: IeeSubPanel;
//#UC START# *5481CD0A031C_5481CCAE029Dget_var*
//#UC END# *5481CD0A031C_5481CCAE029Dget_var*
begin
//#UC START# *5481CD0A031C_5481CCAE029Dget_impl*
 Result := Self;
//#UC END# *5481CD0A031C_5481CCAE029Dget_impl*
end;//TeeCustomSubPanel.pm_GetSubPanel

//#UC START# *4C7F948C03BDimpl*
//#UC END# *4C7F948C03BDimpl*

initialization
{$If not defined(NoScripts)}
// Регистрация TeeCustomSubPanel
 TtfwClassRef.Register(TeeCustomSubPanel);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TeeSubPanel
 TtfwClassRef.Register(TeeSubPanel);
{$IfEnd} //not NoScripts

end.