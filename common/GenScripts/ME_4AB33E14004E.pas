unit NOT_FINISHED_vcmModule;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmModule.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmModule" MUID: (4AB33E14004E)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , l3PureMixIns
;

type
 RvcmModule = class of TvcmModule;

 _l3Unknown_Parent_ = TComponent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmModule = class(_l3Unknown_)
 end;//TvcmModule
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmModule);
 {* Регистрация TvcmModule }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
