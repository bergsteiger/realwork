unit NOT_FINISHED_vcmPopupMenuPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\NOT_FINISHED_vcmPopupMenuPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = TPopupMenu;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmPopupMenuPrim = class(_l3Unknown_)
 end;//TvcmPopupMenuPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
