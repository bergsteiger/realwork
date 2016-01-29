unit kwVcmHistoryDeleteBackItem;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmHistoryDeleteBackItem = class(TtfwRegisterableWord)
  {* Удаляет один элемент истории из списка Back.
 *Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
 OnTest
 vcm:history:DeleteBackItem
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmHistoryDeleteBackItem
 
implementation

uses
 l3ImplUses
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
