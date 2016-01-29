unit tfwLambdedArrayView;

interface

uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
 , kwCompiledWordWorker
;

type
 TtfwTwoLambdas = class(TkwCompiledWordWorker)
  procedure Create(aLambda: TtfwWord;
   aItemsCountInSlice: Integer;
   aWord: TtfwWord;
   const aCtx: TtfwContext);
 end;//TtfwTwoLambdas
 
 RtfwTwoLambdas = class of TtfwTwoLambdas;
 
 TtfwLambdedArrayView = class(TtfwArrayView)
  procedure Create(const anOther: ItfwValueList;
   aLambda: TtfwWord);
  function Make(const anOther: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
  function TwoLabdasClass: RtfwTwoLambdas;
 end;//TtfwLambdedArrayView
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
