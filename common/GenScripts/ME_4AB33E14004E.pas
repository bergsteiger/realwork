unit NOT_FINISHED_vcmModule;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmModule.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

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
 {$Include l3Unknown.imp.pas}
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
;

{$Include l3Unknown.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
