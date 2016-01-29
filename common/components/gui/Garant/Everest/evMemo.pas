unit evMemo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evMemo.pas"
// Начат: 23.05.1997 09:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::Everest::Editors::TevMemo
//
// Мемо-поле. (С published свойствами)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomMemo
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
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


//#UC START# *48454EBB0050impl*
//#UC END# *48454EBB0050impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TevMemo
 TtfwClassRef.Register(TevMemo);
{$IfEnd} //not NoScripts

end.