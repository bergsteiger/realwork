unit evLinkedToolPanel;

interface

uses
 l3IntfUses
 , evToolPanel
 , evVisualInterfaces
 , Controls
 , Messages
;

type
 TevCustomLinkedToolPanel = class(TevCustomToolPanel, IevLinkedToolWindow)
  {* базовый класс для инструментальных панелей, привязанных к Control'ам }
  function Control: TWinControl;
   {* управляющий элемент, к которому привязана панель. }
 end;//TevCustomLinkedToolPanel
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
