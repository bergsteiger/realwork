unit evdDocumentBufferedFilter;
 {* Фильтр для фильтрации документа целиком. По умолчанию просто заглатывает документ в буфер и прокидывает его потом дальше. }

// Модуль: "w:\common\components\gui\Garant\Everest\evdDocumentBufferedFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , k2TagGen
;

type
 TevdDocumentBufferedFilter = class(TevdChildBufferedFilter)
  {* Фильтр для фильтрации документа целиком. По умолчанию просто заглатывает документ в буфер и прокидывает его потом дальше. }
  public
   constructor Create; reintroduce;
   class function SetTo(var theGenerator: Tk2TagGenerator): Pointer; overload;
 end;//TevdDocumentBufferedFilter

implementation

uses
 l3ImplUses
 , Document_Const
 , l3Base
;

constructor TevdDocumentBufferedFilter.Create;
//#UC START# *5638731901C2_56387286026A_var*
//#UC END# *5638731901C2_56387286026A_var*
begin
//#UC START# *5638731901C2_56387286026A_impl*
 inherited Create(k2_idDocument);
//#UC END# *5638731901C2_56387286026A_impl*
end;//TevdDocumentBufferedFilter.Create

class function TevdDocumentBufferedFilter.SetTo(var theGenerator: Tk2TagGenerator): Pointer;
//#UC START# *563874A00314_56387286026A_var*
var
 l_Filter : TevdDocumentBufferedFilter;
//#UC END# *563874A00314_56387286026A_var*
begin
//#UC START# *563874A00314_56387286026A_impl*
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
//#UC END# *563874A00314_56387286026A_impl*
end;//TevdDocumentBufferedFilter.SetTo

end.
