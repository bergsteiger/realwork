unit nevPrintableDocumentContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevPrintableDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevPersistentDocumentContainer
 , nevTools
 , afwInterfaces
 , nevBase
 , evOpProc
 , evDocumentPreview
 , evHAFPainterEx
;

type
 RevDocumentPreview = class of TevDocumentPreview;

 RevHAFPainter = class of TevHAFPainterEx;

 TnevPrintableDocumentContainer = class(TnevPersistentDocumentContainer)
  protected
   function DocumentForPreview: InevDocumentProvider;
   function MakeHAFPainter(const aMacroReplacer: IafwHAFMacroReplacer): IafwHAFPainter;
   function HAFPainterClass: RevHAFPainter; virtual;
   function DocumentPreviewClass: RevDocumentPreview; virtual;
   function Info: InevStorable; virtual;
   function MakeDocumentPreview(const aKey: TevPreviewCacheKey;
    const aMacroReplacer: IafwHAFMacroReplacer;
    const aRange: InevRange = nil): IafwDocumentPreview; override;
   function MakeInfoPreview(const aKey: TevPreviewCacheKey;
    const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview; override;
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
 end;//TnevPrintableDocumentContainer

implementation

uses
 l3ImplUses
 , evEditorWindowProcessor
 , evDefaultContext
 , nevInterfaces
 , l3String
 , l3Chars
 , evFormatHAFMacroReplacer
 , l3Base
 , evFixedHAFMacroReplacer
 , k2Tags
 , nevDocumentProviderEx
 , nevDocumentProvider
 , l3Variant
 , l3StringIDEx
;

function TnevPrintableDocumentContainer.DocumentForPreview: InevDocumentProvider;
//#UC START# *47F34F7E03A8_47F34F00021C_var*
var
 l_D : Tl3Tag;
 l_S : InevStorable;
//#UC END# *47F34F7E03A8_47F34F00021C_var*
begin
//#UC START# *47F34F7E03A8_47F34F00021C_impl*
 l_D := Document;
 Assert(l_D <> nil);
 if not l_D.QT(InevStorable, l_S, Processor) then
  Assert(false)
 else
  try
   Result := TnevDocumentProviderEx.Make(l_S, l_D);
  finally
   l_S := nil;
  end;//try..finally
//#UC END# *47F34F7E03A8_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.DocumentForPreview

function TnevPrintableDocumentContainer.MakeHAFPainter(const aMacroReplacer: IafwHAFMacroReplacer): IafwHAFPainter;
//#UC START# *47F35C8503C4_47F34F00021C_var*
//#UC END# *47F35C8503C4_47F34F00021C_var*
begin
//#UC START# *47F35C8503C4_47F34F00021C_impl*
 Result := HAFPainterClass.Make(aMacroReplacer);
//#UC END# *47F35C8503C4_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.MakeHAFPainter

function TnevPrintableDocumentContainer.HAFPainterClass: RevHAFPainter;
//#UC START# *47F35CAC00E4_47F34F00021C_var*
//#UC END# *47F35CAC00E4_47F34F00021C_var*
begin
//#UC START# *47F35CAC00E4_47F34F00021C_impl*
 Result := TevHAFPainterEx;
//#UC END# *47F35CAC00E4_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.HAFPainterClass

function TnevPrintableDocumentContainer.DocumentPreviewClass: RevDocumentPreview;
//#UC START# *47F35CBA00C1_47F34F00021C_var*
//#UC END# *47F35CBA00C1_47F34F00021C_var*
begin
//#UC START# *47F35CBA00C1_47F34F00021C_impl*
 Result := TevDocumentPreview;
//#UC END# *47F35CBA00C1_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.DocumentPreviewClass

function TnevPrintableDocumentContainer.Info: InevStorable;
//#UC START# *47F35CD9002F_47F34F00021C_var*
//#UC END# *47F35CD9002F_47F34F00021C_var*
begin
//#UC START# *47F35CD9002F_47F34F00021C_impl*
 Result := nil;
//#UC END# *47F35CD9002F_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.Info

function TnevPrintableDocumentContainer.MakeDocumentPreview(const aKey: TevPreviewCacheKey;
 const aMacroReplacer: IafwHAFMacroReplacer;
 const aRange: InevRange = nil): IafwDocumentPreview;
//#UC START# *47F1112A0183_47F34F00021C_var*

 function lp_CheckAreaReplacer(const aReplacer: IafwHAFMacroReplacer): IafwHAFMacroReplacer;
  const c_Map: array [TafwPreviewCaleeArea] of Pl3StringIDEx = (
   @str_nevmmFragment, // afw_pcaMain //
   @str_nevmmReference, // afw_pcaReference //
   @str_nevmmAnnotation, // afw_pcaAnnotation //
   @str_nevmmTranslation, // afw_pcaTranslation //
   @str_nevmmChronology // afw_pcaChronology //
   );
 begin
  if (aKey.CaleeArea <> afw_pcaMain) then
   Result := TevFormatHAFMacroReplacer.Make(aReplacer, c_Map[aKey.CaleeArea].AsCStr)
  else 
  if (aReplacer = nil) then
   Result := TevFixedHAFMacroReplacer.Make(aReplacer,
                                           l3CStr(Document.PCharLenA[k2_tiShortName]),
                                           l3CStr(Document.PCharLenA[k2_tiName]))
  else
   Result := aReplacer;
 end;
 
var
 l_Document: InevDocumentProvider;
 l_HAF: IafwHAFPainter;
//#UC END# *47F1112A0183_47F34F00021C_var*
begin
//#UC START# *47F1112A0183_47F34F00021C_impl*
 if Assigned(aRange) then
  l_HAF := MakeHAFPainter(lp_CheckAreaReplacer(TevFormatHAFMacroReplacer.Make(aMacroReplacer, str_nevmmFragment.AsCStr)))
 else
  l_HAF := MakeHAFPainter(lp_CheckAreaReplacer(aMacroReplacer));
 if Assigned(aRange) then
  l_Document := TnevDocumentProvider.Make(aRange.AsStorable)
 else
  l_Document := DocumentForPreview;
 Result := DocumentPreviewClass.Make(l_Document, aKey, l_HAF);
//#UC END# *47F1112A0183_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.MakeDocumentPreview

function TnevPrintableDocumentContainer.MakeInfoPreview(const aKey: TevPreviewCacheKey;
 const aMacroReplacer: IafwHAFMacroReplacer): IafwDocumentPreview;
//#UC START# *47F111500241_47F34F00021C_var*
var
 l_Info: InevStorable;
 l_HAF: IafwHAFPainter;
//#UC END# *47F111500241_47F34F00021C_var*
begin
//#UC START# *47F111500241_47F34F00021C_impl*
 l_Info := Info;
 if (l_Info = nil) then
  Result := nil
 else
 begin
  l_HAF := MakeHAFPainter(TevFormatHAFMacroReplacer.Make(aMacroReplacer, str_nevmmReference.AsCStr));
  Result := DocumentPreviewClass.Make(l_Info, aKey, l_HAF);
 end;//l_Info = nil
//#UC END# *47F111500241_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.MakeInfoPreview

procedure TnevPrintableDocumentContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_47F34F00021C_var*
//#UC END# *47F35245009A_47F34F00021C_var*
begin
//#UC START# *47F35245009A_47F34F00021C_impl*
 theProcessor := TevEditorWindowProcessor.Create(TevDefaultContext);
//#UC END# *47F35245009A_47F34F00021C_impl*
end;//TnevPrintableDocumentContainer.MakeProcessor

end.
