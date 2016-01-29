unit evCustomPDFWriter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomPDFWriter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevCustomPDFWriter
//
// Писатель PDF-файлов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  k2DocumentBuffer,
  k2CustomFileGenerator,
  l3Variant
  ;

type
 TevCustomPDFWriter = class(Tk2CustomFileGenerator)
  {* Писатель PDF-файлов. }
 private
 // private fields
   f_Document : Tk2DocumentBuffer;
 protected
 // overridden protected methods
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
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure ExportPDF; virtual; abstract;
   function GetDocument: InevPara;
 end;//TevCustomPDFWriter

implementation

uses
  SysUtils
  ;

// start class TevCustomPDFWriter

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