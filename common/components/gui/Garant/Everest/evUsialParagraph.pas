unit evUsialParagraph;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evUsialParagraph.pas"
// Начат: 09.04.2010 18:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaUtils::TevUsialParagraph
//
// Реализация IedParagraph для обычного параграфа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  k2Interfaces,
  evEditorInterfaces,
  k2ProcessorTagTool,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevUsialParagraph = class(Tk2ProcessorTagTool, IedParagraph)
  {* Реализация IedParagraph для обычного параграфа }
 protected
 // realized methods
   function Get_Frame: IedFrame;
 public
 // public methods
   class function Make(aTag: Tl3Variant;
     const aProcessor: Ik2Processor): IedParagraph; reintroduce;
     {* Сигнатура фабрики TevUsialParagraph.Make }
 end;//TevUsialParagraph
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  evParaFrame
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevUsialParagraph

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
end;

function TevUsialParagraph.Get_Frame: IedFrame;
//#UC START# *4BBC89F8009C_4BBF3E28035Eget_var*
//#UC END# *4BBC89F8009C_4BBF3E28035Eget_var*
begin
//#UC START# *4BBC89F8009C_4BBF3E28035Eget_impl*
 Pointer(Result) := Pointer(IedFrame(TevUsialParaFrame.Create(TagInst, Processor)));
//#UC END# *4BBC89F8009C_4BBF3E28035Eget_impl*
end;//TevUsialParagraph.Get_Frame

{$IfEnd} //k2ForEditor

end.