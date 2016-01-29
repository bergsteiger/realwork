unit evEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evEdit.pas"
// Начат: 23.04.2004 19:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevEdit
//
// Строка ввода. (C published свойствами).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomEdit
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
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


//#UC START# *484658060127impl*
//#UC END# *484658060127impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TevEdit
 TtfwClassRef.Register(TevEdit);
{$IfEnd} //not NoScripts

end.