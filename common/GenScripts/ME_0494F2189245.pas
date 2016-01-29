unit elCustomEditKeywordsPack;

interface

uses
 l3IntfUses
 , elCustomEdit_Form
 , elCustomEdit
 , tfwControlString
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_elCustomEdit = class(TtfwControlString)
  {* Слово словаря для идентификатора формы elCustomEdit
----
*Пример использования*:
[code]
'aControl' форма::elCustomEdit TryFocus ASSERT
[code] }
 end;//Tkw_Form_elCustomEdit
 
 Tkw_elCustomEdit_Component_Edit = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Edit
----
*Пример использования*:
[code]
компонент::Edit TryFocus ASSERT
[code] }
 end;//Tkw_elCustomEdit_Component_Edit
 
 TkwElCustomEditFormEdit = class(TtfwPropertyLike)
  {* Слово скрипта .TelCustomEditForm.Edit
[panel]Контрол Edit формы TelCustomEditForm[panel]
*Тип результата:* TelCustomEdit
*Пример:*
[code]
OBJECT VAR l_TelCustomEdit
 aelCustomEditForm .TelCustomEditForm.Edit >>> l_TelCustomEdit
[code]  }
  function Edit(const aCtx: TtfwContext;
   aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
   {* Реализация слова скрипта .TelCustomEditForm.Edit }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwElCustomEditFormEdit
 
end.
