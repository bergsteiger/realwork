unit kwPopQueryCardAttributeSetCollapsed;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , nevBase
 , l3Interfaces
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeSetCollapsed = class(TkwQueryCardFromStackWord)
  {* Управляет свойством Collapsed той ГРУППЫ к которой принадлежит данный атрибут

Пример:
[code]
'AT_TEXT_NAME' true Search:SetAttributeCollapsed
[code] }
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeSetCollapsed
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
