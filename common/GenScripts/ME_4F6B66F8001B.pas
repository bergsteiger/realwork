unit F1Like_FormDefinitions_Controls;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , tfwString
;

type
 ChildFormDef = interface
 end;//ChildFormDef
 
 ParentFormDef = interface
 end;//ParentFormDef
 
implementation

uses
 l3ImplUses
;

type
 Tkw_Form_Child_ID = class(TtfwString)
  {* Слово словаря для идентификатора формы Child
----
*Пример использования*:
[code]
'aControl' форма::Child TryFocus ASSERT
[code] }
 end;//Tkw_Form_Child_ID
 
 Tkw_Form_Parent_ID = class(TtfwString)
  {* Слово словаря для идентификатора формы Parent
----
*Пример использования*:
[code]
'aControl' форма::Parent TryFocus ASSERT
[code] }
 end;//Tkw_Form_Parent_ID
 
end.
