unit eeSubPanel;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSubPanel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeSubPanel" MUID: (4C7F948C03BD)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeSubPanelExport
 , eeInterfaces
 //#UC START# *4C7F948C03BDintf_uses*
 //#UC END# *4C7F948C03BDintf_uses*
;

type
 TeeCustomSubPanel = class(TeeSubPanelExport)
  protected
   function pm_GetSubPanel: IeeSubPanel;
  public
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
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C7F948C03BDimpl_uses*
 //#UC END# *4C7F948C03BDimpl_uses*
;

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
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCustomSubPanel);
 {* Регистрация TeeCustomSubPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeSubPanel);
 {* Регистрация TeeSubPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
