unit SubPanelWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\SubPanelWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SubPanelWordsPack" MUID: (52D643FE004B)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwIterateSubDescriptors
 , kwSubdescriptorGetDrawType
 , kwSubdescriptorGetBitmapIndex
 , kwSubdescriptorGetBlockBitmapIndex
 , kwSubdescriptorGetDocumentBitmapIndex
 , kwSubdescriptorGetVisible
 , kwSubdescriptorGetColumn
 , kwIterateSubDecriptorsOnSubPanel
 , kwIterateSubDecriptorsOnSubPanelEX
 , kwSubPanelGetPopupMenuForSub
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
