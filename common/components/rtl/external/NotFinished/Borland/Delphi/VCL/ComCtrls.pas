unit ComCtrls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Vcl"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/ComCtrls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::ComCtrls
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
uses
  Classes
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  TreeNodeWordsPack
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  TreeViewWordsPack
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация TCustomUpDown
 TtfwClassRef.Register(TCustomUpDown);
{$IfEnd} //not NoScripts AND not NoVCL

end.