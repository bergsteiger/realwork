unit ImageEnViewRegistrator;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ImageEnViewRegistrator.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3IntfUses
 , imageenview
;

type
 TImageEnViewRegistrator = {abstract} class(TImageEnView)
 end;//TImageEnViewRegistrator
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

initialization
 TtfwClassRef.Register(TImageEnViewRegistrator);
 {* ����������� TImageEnViewRegistrator }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
