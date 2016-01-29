unit kwPopQueryCardAttributeSetWithLogicOperation;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , l3Interfaces
 , nevBase
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeSetWithLogicOperation = class(TkwQueryCardFromStackWord)
  {* Добавляет атрибут с логическим значением к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 1 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttributeWithLogicOperation
 Ok
[code] }
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeSetWithLogicOperation
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
