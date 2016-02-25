unit NOT_FINISHED_tb97GraphicControl;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_tb97GraphicControl.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = TGraphicControl;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Ttb97CustomGraphicControl = class(_l3Unknown_)
 end;//Ttb97CustomGraphicControl

 Ttb97GraphicTextControl = class(Ttb97GraphicControl)
 end;//Ttb97GraphicTextControl

 Ttb97GraphicControl = class(Ttb97CustomGraphicControl)
 end;//Ttb97GraphicControl
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ttb97CustomGraphicControl);
 {* Регистрация Ttb97CustomGraphicControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ttb97GraphicTextControl);
 {* Регистрация Ttb97GraphicTextControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ttb97GraphicControl);
 {* Регистрация Ttb97GraphicControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoTB97)

end.
