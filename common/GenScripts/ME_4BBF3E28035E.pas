unit evUsialParagraph;
 {* Реализация IedParagraph для обычного параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\evUsialParagraph.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , k2ProcessorTagTool
 , evEditorInterfaces
 , l3Variant
 , k2Interfaces
;

type
 TevUsialParagraph = class(Tk2ProcessorTagTool, IedParagraph)
  {* Реализация IedParagraph для обычного параграфа }
  protected
   function Get_Frame: IedFrame;
  public
   class function Make(aTag: Tl3Variant;
    const aProcessor: Ik2Processor): IedParagraph; reintroduce;
 end;//TevUsialParagraph
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , evParaFrame
;

class function TevUsialParagraph.Make(aTag: Tl3Variant;
 const aProcessor: Ik2Processor): IedParagraph;
var
 l_Inst : TevUsialParagraph;
begin
 l_Inst := Create(aTag, aProcessor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevUsialParagraph.Make

function TevUsialParagraph.Get_Frame: IedFrame;
//#UC START# *4BBC89F8009C_4BBF3E28035Eget_var*
//#UC END# *4BBC89F8009C_4BBF3E28035Eget_var*
begin
//#UC START# *4BBC89F8009C_4BBF3E28035Eget_impl*
 Pointer(Result) := Pointer(IedFrame(TevUsialParaFrame.Create(TagInst, Processor)));
//#UC END# *4BBC89F8009C_4BBF3E28035Eget_impl*
end;//TevUsialParagraph.Get_Frame
{$IfEnd} // Defined(k2ForEditor)

end.
