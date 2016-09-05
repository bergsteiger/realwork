unit evCustomPDFWriter;
 {* Писатель PDF-файлов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomPDFWriter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomPDFWriter" MUID: (53FED6EF027B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
 , k2DocumentBuffer
 , nevTools
 , l3Variant
;

type
 TevCustomPDFWriter = class(Tk2CustomFileGenerator)
  {* Писатель PDF-файлов. }
  private
   f_Document: Tk2DocumentBuffer;
  protected
   procedure ExportPDF; virtual; abstract;
   function GetDocument: InevPara;
   procedure StartChild(TypeID: Tl3Type); override;
   procedure StartTag(TagID: Integer); override;
   procedure OpenStream; override;
    {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure CloseStream(NeedUndo: Boolean); override;
    {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
   procedure CloseStructure(NeedUndo: Boolean); override;
    {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure ClearFields; override;
 end;//TevCustomPDFWriter

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *53FED6EF027Bimpl_uses*
 //#UC END# *53FED6EF027Bimpl_uses*
;

function TevCustomPDFWriter.GetDocument: InevPara;
//#UC START# *53FEE8EB02B9_53FED6EF027B_var*
//#UC END# *53FEE8EB02B9_53FED6EF027B_var*
begin
//#UC START# *53FEE8EB02B9_53FED6EF027B_impl*
 Result := nil;
 if not f_Document.Root.QT(InevPara, Result) then
  Assert(false);
//#UC END# *53FEE8EB02B9_53FED6EF027B_impl*
end;//TevCustomPDFWriter.GetDocument

procedure TevCustomPDFWriter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_53FED6EF027B_var*
//#UC END# *4836D4650177_53FED6EF027B_var*
begin
//#UC START# *4836D4650177_53FED6EF027B_impl*
 f_Document.StartChild(TypeID);
 inherited;
//#UC END# *4836D4650177_53FED6EF027B_impl*
end;//TevCustomPDFWriter.StartChild

procedure TevCustomPDFWriter.StartTag(TagID: Integer);
//#UC START# *4836D477022A_53FED6EF027B_var*
//#UC END# *4836D477022A_53FED6EF027B_var*
begin
//#UC START# *4836D477022A_53FED6EF027B_impl*
 f_Document.StartTag(TagID);
 inherited; 
//#UC END# *4836D477022A_53FED6EF027B_impl*
end;//TevCustomPDFWriter.StartTag

procedure TevCustomPDFWriter.OpenStream;
 {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
//#UC START# *4836D49800CA_53FED6EF027B_var*
//#UC END# *4836D49800CA_53FED6EF027B_var*
begin
//#UC START# *4836D49800CA_53FED6EF027B_impl*
 inherited;
 f_Document := Tk2DocumentBuffer.Create;
 f_Document.Start;
//#UC END# *4836D49800CA_53FED6EF027B_impl*
end;//TevCustomPDFWriter.OpenStream

procedure TevCustomPDFWriter.CloseStream(NeedUndo: Boolean);
 {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
//#UC START# *4836D4B003DC_53FED6EF027B_var*
//#UC END# *4836D4B003DC_53FED6EF027B_var*
begin
//#UC START# *4836D4B003DC_53FED6EF027B_impl*
 f_Document.Finish;
 ExportPDF;
 inherited;
//#UC END# *4836D4B003DC_53FED6EF027B_impl*
end;//TevCustomPDFWriter.CloseStream

procedure TevCustomPDFWriter.CloseStructure(NeedUndo: Boolean);
 {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
//#UC START# *4836D4C20059_53FED6EF027B_var*
//#UC END# *4836D4C20059_53FED6EF027B_var*
begin
//#UC START# *4836D4C20059_53FED6EF027B_impl*
 inherited;
 f_Document.Finish(NeedUndo);
//#UC END# *4836D4C20059_53FED6EF027B_impl*
end;//TevCustomPDFWriter.CloseStructure

procedure TevCustomPDFWriter.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_53FED6EF027B_var*
//#UC END# *4836D52400D9_53FED6EF027B_var*
begin
//#UC START# *4836D52400D9_53FED6EF027B_impl*
 inherited;
 f_Document.AddAtomEx(AtomIndex, Value);
//#UC END# *4836D52400D9_53FED6EF027B_impl*
end;//TevCustomPDFWriter.AddAtomEx

procedure TevCustomPDFWriter.ClearFields;
//#UC START# *5000565C019C_53FED6EF027B_var*
//#UC END# *5000565C019C_53FED6EF027B_var*
begin
//#UC START# *5000565C019C_53FED6EF027B_impl*
 FreeAndNil(f_Document);
 inherited;
//#UC END# *5000565C019C_53FED6EF027B_impl*
end;//TevCustomPDFWriter.ClearFields

end.
