unit evEditor;
 {* Полноценный компонент-редактор. Для конечного пользователя (программиста). }

// Модуль: "w:\common\components\gui\Garant\Everest\evEditor.pas"
// Стереотип: "GuiControl"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evTunedEditor
;

type
 //#UC START# *484544370206ci*
 //#UC END# *484544370206ci*
 //#UC START# *484544370206cit*
 //#UC END# *484544370206cit*
 TevEditor = class(TevTunedEditor)
  {* Полноценный компонент-редактор. Для конечного пользователя (программиста). }
 //#UC START# *484544370206publ*
    published
      property Canvas;
        {-}
      property AutoSelect;
        {-}  
      property Align;
        {-}
      property Anchors;
        {-}
      property Controller;
        {-}
      property Constraints;
        {-}
      property LMargin;
        {-}
      property RMargin;
        {-}
      property LeftIndentDelta;
        {-}
      property HScrollBar;
        {* - горизонтальный скроллбар. }
      property WebStyle;
        {-}
      property VSubPanel;
        {* - вертикальная панель Sub'ов. }
      property ScrollStyle;
        {-}
      property HRuler;
        {-}
      property VRuler;
        {-}
      property ReadOnly;
        {-}
      property TextSource;
        {-}
      property PrintDialog;
        {-}
      property PlainText;
        {-}  
    // published events
      property OnContextPopup;
        {-}
      property OnParaChange;
        {-}
      property OnCursorChange;
        {-}
      property OnFontChange;
        {-}
      property OnSetCursor;
        {-}
      property OnStyleChange;
        {-}
      property OnJumpTo;
        {-}
      property OnGetMonikerSink;
        {-}
      property OnMouseAction;
        {-}    
      property OnGetHotSpotInfo;
        {-}    
      property OnCursorInSelectionChange;
        {* - изменение свойства - курсор в блоке или нет? }
      property OnReplaceConfirm;
        {* - запрос при замене. }
      property OnMakeTextSource;
        {-}
      property OnAfterFirstPaint;
        {-}

    {inherited properties}
      property Color;
      property Ctl3D{ default DefCtl3D};
      property DragCursor;
      property DragMode;
      property Enabled;
      property ParentColor{ default DefParentColor};
      property ParentCtl3D{ default DefParentCtl3D};
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop{ default DefTabStop};
      property Visible;
      property BorderStyle;
        {* - стиль рамки. }

    {inherited events}
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
 //#UC END# *484544370206publ*
 end;//TevEditor

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *484544370206impl*
//#UC END# *484544370206impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevEditor);
 {* Регистрация TevEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
