unit NOT_FINISHED_vgBitmap;

// Модуль: "w:\common\components\rtl\external\VGScene\NOT_FINISHED_vgBitmap.pas"
// Стереотип: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomBitmap
 , vgObject
;

type
 TvgBitmapObject = class(TvgObject)
 end;//TvgBitmapObject

 TvgBitmap = class(TvgCustomBitmap)
 end;//TvgBitmap
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgBitmapObject);
 {* Регистрация TvgBitmapObject }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
