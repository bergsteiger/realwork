unit evEdit;
 {* Строка ввода. (C published свойствами). }

// Модуль: "w:\common\components\gui\Garant\Everest\evEdit.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TevEdit" MUID: (484658060127)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEdit
;

type
 //#UC START# *484658060127ci*
 //#UC END# *484658060127ci*
 //#UC START# *484658060127cit*
 //#UC END# *484658060127cit*
 TevEdit = class(TevCustomEdit)
  {* Строка ввода. (C published свойствами). }
 //#UC START# *484658060127publ*
    published
      property Canvas;
        {-}
      property TextSource;
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
      property HScrollBar;
        {-горизонтальный скроллбар}
      property VSubPanel;
        {-вертикальная панель Sub'ов}
      property ScrollStyle
        default def_EditScrollStyle;
        {-}
      property HRuler;
        {-}
      property VRuler;
        {-}
      property ReadOnly;
        {-}
      property Font;
        {-шрифт Memo-поля}
      property Text;
        {-текст}
      property Wrap
        default false;
        {-}
      property NeedDefaultPopupMenu;
        {-}
      property UpperCase;
        {- текст переводится в верхний регистр в процессе набора}
      property NeedReplaceQuotes
        default false;   
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
      property Color;
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
 //#UC END# *484658060127publ*
 end;//TevEdit

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *484658060127impl*
//#UC END# *484658060127impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevEdit);
 {* Регистрация TevEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
