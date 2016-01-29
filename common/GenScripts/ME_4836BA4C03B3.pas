unit evdDocumentFilter;

interface

uses
 l3IntfUses
 , k2DocumentGenerator
;

type
 TevdDocumentFilter = class(Tk2DocumentGenerator)
  {* Фильтр отдельных частей документа, основанный на частичной обработке тегов, накопленных в памяти.
      Для использования как предка для собственных фильтров-преобразователей. }
 end;//TevdDocumentFilter
 
implementation

uses
 l3ImplUses
;

end.
