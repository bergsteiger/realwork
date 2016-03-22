unit evEdit;
 {* ������ �����. (C published ����������). }

// ������: "w:\common\components\gui\Garant\Everest\evEdit.pas"
// ���������: "GuiControl"
// ������� ������: "TevEdit" MUID: (484658060127)

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
  {* ������ �����. (C published ����������). }
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
        {-�������������� ���������}
      property VSubPanel;
        {-������������ ������ Sub'��}
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
        {-����� Memo-����}
      property Text;
        {-�����}
      property Wrap
        default false;
        {-}
      property NeedDefaultPopupMenu;
        {-}
      property UpperCase;
        {- ����� ����������� � ������� ������� � �������� ������}
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
        {-��������� �������� - ������ � ����� ��� ���}
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
        {-����� �����}

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
 {* ����������� TevEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
