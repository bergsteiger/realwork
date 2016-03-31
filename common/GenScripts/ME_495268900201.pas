unit eeEditor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeEditor.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TeeEditor" MUID: (495268900201)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeEditorExport
 , eeInterfaces
 , Classes
 //#UC START# *495268900201intf_uses*
 //#UC END# *495268900201intf_uses*
;

type
 //#UC START# *4952687202A0ci*
 //#UC END# *4952687202A0ci*
 //#UC START# *4952687202A0cit*
 //#UC END# *4952687202A0cit*
 TeeCustomEditor = class(TeeEditorExport)
  protected
   function pm_GetEditor: IeeEditor;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property Editor: IeeEditor
    read pm_GetEditor;
 //#UC START# *4952687202A0publ*
    public
    // public events
      property OnBlockChange;
        {* - событие для реакции на изменение текущего блока. }
      property OnBlockScroll;
        {* - событие для реакции на изменение текущего видимого блока. }
      property OnCanSplitPara;
        {-}
      property OnUserCommentsHidden;
        {-}
 //#UC END# *4952687202A0publ*
 end;//TeeCustomEditor

 //#UC START# *495268900201ci*
 //#UC END# *495268900201ci*
 //#UC START# *495268900201cit*
 //#UC END# *495268900201cit*
 TeeEditor = class(TeeCustomEditor)
 //#UC START# *495268900201publ*
   {* Компонент для импорта редактора. Для конечного использования. }
    published
    // published properties
      property Align;
        {-}
      property TabOrder;
        {-}
      property Controller;
        {-}
      property TextSource;
        {-}
      property PopupMenu;
        {-}
      property IsStaticText;
        {-}
      property ScrollStyle;
        {-}
      property HScrollBar;
        {-}
      property VScrollBar;
        {-}
      property WebStyle
        default true;
        {-}
      property AutoHideSelection
        default false;
        {-}
      property VSubPanel;
        {-}
    published
    // published events
      property OnBlockChange;
        {-}
      property OnBlockScroll;
        {-}
      property OnMouseAction;
        {-}
      property OnCursorInSelectionChange;
        {-}
      property OnSelectionChange;
        {-}
      property OnGetHotSpotInfo;
        {* - событие для получения информации о HotSpot'е. }
      property OnCanSplitPara;
        {-}
      property OnUserCommentsHidden;
        {-}
      property OnTextSourceChanged;
        {-}
      property OnCheckFocusedInPaint;
        {-}
      property OnAfterFirstPaint;
        {-}
      property OnJumpTo;
        {-}
      property OnCommentsVisibleChanged;
        {-}
      property OnShowDocumentPartsChanged;
        {-}
      property OnDrawSpecialChange;
        {-}
      property OnMakeMacroReplacer;
        {-}
 //#UC END# *495268900201publ*
 end;//TeeEditor

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *495268900201impl_uses*
 //#UC END# *495268900201impl_uses*
;

function TeeCustomEditor.pm_GetEditor: IeeEditor;
//#UC START# *54C231250045_4952687202A0get_var*
//#UC END# *54C231250045_4952687202A0get_var*
begin
//#UC START# *54C231250045_4952687202A0get_impl*
 Result := Self;
//#UC END# *54C231250045_4952687202A0get_impl*
end;//TeeCustomEditor.pm_GetEditor

constructor TeeCustomEditor.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4952687202A0_var*
//#UC END# *47D1602000C6_4952687202A0_var*
begin
//#UC START# *47D1602000C6_4952687202A0_impl*
 inherited;
 WebStyle := true;
 AutoHideSelection := false;
//#UC END# *47D1602000C6_4952687202A0_impl*
end;//TeeCustomEditor.Create

//#UC START# *4952687202A0impl*
//#UC END# *4952687202A0impl*

//#UC START# *495268900201impl*
//#UC END# *495268900201impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeCustomEditor);
 {* Регистрация TeeCustomEditor }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeEditor);
 {* Регистрация TeeEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
