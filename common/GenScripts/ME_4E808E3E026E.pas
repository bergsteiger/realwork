unit kwPopQueryCardSetAttribute;

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
 TkwPopQueryCardSetAttribute = class(TkwQueryCardFromStackWord)
  {* Добавляет атрибут к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
[code] }
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardSetAttribute
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
