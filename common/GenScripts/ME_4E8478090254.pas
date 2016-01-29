unit evdAllDocumentSubsEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevdAllDocumentSubsEliminator = class(Tk2TagFilter)
  {* Фильтр, выкидывающий ВСЕ сабы документа из обратного индекса }
 end;//TevdAllDocumentSubsEliminator
 
implementation

uses
 l3ImplUses
 , DocSubLayer_Const
 , DocumentSub_Const
;

end.
