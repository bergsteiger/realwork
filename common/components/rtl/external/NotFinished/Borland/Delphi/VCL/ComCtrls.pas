unit ComCtrls;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\ComCtrls.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
;

type
 TProgressBar = class
 end;//TProgressBar

 TCustomStatusBar = class
 end;//TCustomStatusBar

 TToolbar = class
 end;//TToolbar

 TTreeNode = class
 end;//TTreeNode

 TTreeView = class
 end;//TTreeView

 TTreeNodes = class
 end;//TTreeNodes

 TUpDown = class
 end;//TUpDown

 TCustomUpDown = class
 end;//TCustomUpDown
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TreeNodeWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TreeViewWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomUpDown);
 {* Регистрация TCustomUpDown }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
