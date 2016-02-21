unit vcmApplicationRef;
 {* Хак для подключения сгенерированных модулей }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Design\vcmApplicationRef.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmApplication
;

type
 TvcmApplicationRef = class(TvcmApplication)
  {* Хак для подключения сгенерированных модулей }
 end;//TvcmApplicationRef
{$IfEnd} // Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

implementation

{$If Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(DesignTimeLibrary) AND NOT Defined(NoVCM)

end.
