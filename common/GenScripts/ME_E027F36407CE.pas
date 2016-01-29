unit CustomizeToolsKeywordsPack;

interface

uses
 l3IntfUses
 , PrimToolbarMenu_Module
 , tfwControlString
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , TtfwClassRef_Proxy
;

type
 Tkw_Form_CustomizeTools = class(TtfwControlString)
  {* Слово словаря для идентификатора формы CustomizeTools
----
*Пример использования*:
[code]
'aControl' форма::CustomizeTools TryFocus ASSERT
[code] }
 end;//Tkw_Form_CustomizeTools
 
end.
