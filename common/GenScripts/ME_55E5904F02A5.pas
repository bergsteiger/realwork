unit tfwSliceView;

interface

uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
 , kwCompiledWordWorker
 , tfwValueList
;

type
 TtfwSliceLambda = class(TkwCompiledWordWorker)
  procedure Create(aCount: Integer;
   aWord: TtfwWord;
   const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwSliceLambda
 
 TtfwSliceView = class(TtfwArrayView)
  procedure Create(const anOther: ItfwValueList;
   aCount: Integer);
  function Make(const anOther: ItfwValueList;
   aCount: Integer): ItfwValueList;
 end;//TtfwSliceView
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
