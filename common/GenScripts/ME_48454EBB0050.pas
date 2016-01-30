unit evMemo;
 {* Мемо-поле. (С published свойствами) }

// Модуль: "w:\common\components\gui\Garant\Everest\evMemo.pas"
// Стереотип: "GuiControl"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemo
;

type
 //#UC START# *48454EBB0050ci*
 //#UC END# *48454EBB0050ci*
 //#UC START# *48454EBB0050cit*
 //#UC END# *48454EBB0050cit*
 TevMemo = class(TevCustomMemo)
  {* Мемо-поле. (С published свойствами) }
 //#UC START# *48454EBB0050publ*
    published
      property AutoSelect;
        {-}
      property Canvas;
        {-}
      property TextSource;
        {-}
      property Align;
        {-}
      property Anchors;
        {-}
      property Controller;
        {-}
      property Constraints;
        {-}
      property LMargin
        default def_MemoLMargin;
        {-}
      property RMargin;
        {-}
      property HScrollBar;
        {-горизонтальный скроллбар}
      property VSubPanel;
        {-вертикальная панель Sub'ов}
      property ScrollStyle
        default def_MemoScrollStyle;
        {-}
      property HRuler;
        {-}
      property VRuler;
        {-}
      property ReadOnly;
        {-}
      property Color;
        {-цвет бумаги}
      property Font;
        {-шрифт Memo-поля}
      property PlainText;
        {-}
      property Wrap;
        {-}
      property Text;
        {-текст}
      property NeedDefaultPopupMenu;
        {-}
    {events}
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
      property OnReplaceConfirm;
        {-}
      property OnJumpTo;
        {-}
      property OnCursorInSelectionChange;
        {-изменение свойства - курсор в блоке или нет}
    {inherited properties}
      property Ctl3D{ default DefCtl3D};
      property DragCursor;
      property DragMode;
      property Enabled;
      property ParentColor{ default DefParentColor};
      property ParentFont;
      property ParentCtl3D{ default DefParentCtl3D};
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop{ default DefTabStop};
      property Visible;
      property BorderStyle;
        {-стиль рамки}

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
 //#UC END# *48454EBB0050publ*
 end;//TevMemo

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *48454EBB0050impl*
//#UC END# *48454EBB0050impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevMemo);
 {* Регистрация TevMemo }
{$IfEnd} // NOT Defined(NoScripts)

end.
