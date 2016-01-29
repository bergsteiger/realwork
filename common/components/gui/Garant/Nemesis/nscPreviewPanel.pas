unit nscPreviewPanel;

{ Библиотека "Nemesis Controls" }
{ Начал: Люлин А.В.             }
{ Модуль: nscPreviewPanel -     }
{ Начат: 21.12.2004 20:10       }
{ $Id: nscPreviewPanel.pas,v 1.1 2004/12/21 17:33:26 lulin Exp $ }

// $Log: nscPreviewPanel.pas,v $
// Revision 1.1  2004/12/21 17:33:26  lulin
// - new class: TnscPreviewPanel.
//

{$I nscDefine.inc }

interface

uses
  eePreviewPanel
  ;

type
  TnscCustomPreviewPanel = class(TeeCustomPreviewPanel)
  end;//TnscCustomPreviewPanel

  TnscPreviewPanel = class(TnscCustomPreviewPanel)
   {* Компонент для Preview. С published свойствами. }
    published
      property Align;
  //    property Alignment;
      property Anchors;
      property AutoSize;
      property BevelInner;
      property BevelOuter;
      property BevelWidth;
      property BiDiMode;
      property BorderWidth;
      property BorderStyle;
      property Caption;
      property Color;
      property Constraints;
      property Ctl3D;
      property UseDockManager default True;
      property DockSite;
      property DragCursor;
      property DragKind;
      property DragMode;
      property Enabled;
  //    property FullRepaint;
      property Font;
  //    property Locked;
      property ParentBiDiMode;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property OnCanResize;
      property OnClick;
      property OnConstrainedResize;
      property OnContextPopup;
      property OnDockDrop;
      property OnDockOver;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDock;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnGetSiteInfo;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnResize;
      property OnStartDock;
      property OnStartDrag;
      property OnUnDock;

      property OnCurrentPageChanged;
       {-}
  end;//TnscPreviewPanel

implementation

end.

