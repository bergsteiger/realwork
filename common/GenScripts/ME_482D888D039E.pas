unit evCustomMemoContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomMemoContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomMemoContainer" MUID: (482D888D039E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , Classes
 , nevTools
 , k2DocumentGenerator
 , k2Base
 , evOpProc
 , nevBase
 , k2TagGen
;

type
 TevCustomMemoContainer = class(TnevPrintableDocumentContainer)
  private
   procedure UpdateParaParam(const Atom: Tk2StackAtom);
  protected
   function pm_GetMemo: TComponent;
   function DoBeforeFinishAtom1(aGenerator: Tk2DocumentGenerator;
    var anAtom: Tk2StackAtom): Boolean; override;
   function DoBeforeFinishAtom(G: Tk2DocumentGenerator;
    var Atom: Tk2StackAtom): Boolean; override;
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   procedure DoGetWriter(aFormat: TnevFormat;
    anInternal: Boolean;
    var theWriter: Tk2TagGenerator;
    aCodePage: Integer); override;
   function NeedsProgressOnSave: Boolean; override;
   function GetDocumentType: Tk2Type; override;
  public
   constructor Create; reintroduce;
   class function Make: InevDocumentContainer; reintroduce;
  protected
   property Memo: TComponent
    read pm_GetMemo;
 end;//TevCustomMemoContainer

implementation

uses
 l3ImplUses
 , k2Tags
 , evTagsListFilter
 , evCustomMemo
 , k2Facade
 , evdTypes
 , evMemoProcessor
 , TextPara_Const
 , SimpleDocument_Const
 , l3Types
 , l3Base
 , evDef
 , Font_Const
;

function TevCustomMemoContainer.pm_GetMemo: TComponent;
//#UC START# *483FA3BF01F2_482D888D039Eget_var*
var
 l_Control: INevControl;
//#UC END# *483FA3BF01F2_482D888D039Eget_var*
begin
//#UC START# *483FA3BF01F2_482D888D039Eget_impl*
 TextSource.CastAnyEditorTo(INevControl, l_Control);
 if Assigned(l_Control) then
 begin
  Result := l_Control.GetDelphiControl;
  if Assigned(Result) and not Result.InheritsFrom(TevCustomMemo) then
   Result := nil;
 end
 else
  Result := nil;
 //Assert(Assigned(Result));
 //^ без комментирования этого не чинится http://mdp.garant.ru/pages/viewpage.action?pageId=121145106
//#UC END# *483FA3BF01F2_482D888D039Eget_impl*
end;//TevCustomMemoContainer.pm_GetMemo

procedure TevCustomMemoContainer.UpdateParaParam(const Atom: Tk2StackAtom);
//#UC START# *483FA33B0045_482D888D039E_var*
var
 l_Layer : Integer;
 l_DefaultStyle : Integer;
//#UC END# *483FA33B0045_482D888D039E_var*
begin
//#UC START# *483FA33B0045_482D888D039E_impl*
 if Atom.IsKindOf(k2_typTextPara) then
 begin
  if (Memo <> nil) then
  begin
   with TevCustomMemo(Memo) do
   begin
    with Atom.Box, Tk2Type(TagType) do
    begin
     if not KeepParaFormattingTag(k2_tiLeftIndent) then
      if not Prop[k2_tiLeftIndent].ReadOnly then
       IntA[k2_tiLeftIndent] := 0;
     if not KeepParaFormattingTag(k2_tiRightIndent) then
      if not Prop[k2_tiRightIndent].ReadOnly then
       IntA[k2_tiRightIndent] := 0;
     if not KeepParaFormattingTag(k2_tiStyle) then
      if not Prop[k2_tiStyle].ReadOnly then
      begin
       l_DefaultStyle := Processor.DefaultStyle;
       if (l_DefaultStyle <> def_DefaultStyle) then
        IntA[k2_tiStyle] := l_DefaultStyle
       else
        AttrW[k2_tiStyle, nil] := nil;
      end;//not Prop[k2_tiStyle].ReadOnly
     if not KeepParaFormattingTag(k2_tiSpaceBefore) then
      if not Prop[k2_tiSpaceBefore].ReadOnly then
       AttrW[k2_tiSpaceBefore, nil] := nil;
     if not KeepParaFormattingTag(k2_tiSpaceAfter) then
      if not Prop[k2_tiSpaceAfter].ReadOnly then
       AttrW[k2_tiSpaceAfter, nil] := nil;
     if not KeepParaFormattingTag(k2_tiJustification) then
      if not Prop[k2_tiJustification].ReadOnly then
       IntA[k2_tiJustification] := Ord(ev_itLeft);
     if not KeepParaFormattingTag(k2_tiFirstIndent) then
      if not Prop[k2_tiFirstIndent].ReadOnly then
       IntA[k2_tiFirstIndent] := 0;
     if not KeepParaFormattingTag(k2_tiFont) then
      if not Prop[k2_tiFont].ReadOnly then
       AttrW[k2_tiFont, nil] := nil;
     if not KeepParaFormattingTag(k2_tiSegments) then
      with Attr[k2_tiSegments] do
      begin
       if IsValid then
       begin
        if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_slView)], @l_Layer).IsValid then
         DeleteChild(l_Layer);
        if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_slHyperlinks)], @l_Layer).IsValid then
         DeleteChild(l_Layer);
       end;//IsValid
      end;//with Attr[k2_tiSegments]
    end;//with Atom.Box
    if UseMemoFontForParagraphs then
    begin
    // - это можно убрать - когда будет честная прозрачность компонент шрифта
     l_DefaultStyle := Processor.DefaultStyle;
     if (l_DefaultStyle = def_DefaultStyle) then
      Atom.Box.AttrW[k2_tiFont, nil] := k2_typFont.ObjToTag(Font).AsObject;
    end;//UseMemoFontForParagraphs
   end;//with Memo
  end;//Memo <> nil
 end;//Atom.IsKindOf(k2_typTextPara)
//#UC END# *483FA33B0045_482D888D039E_impl*
end;//TevCustomMemoContainer.UpdateParaParam

constructor TevCustomMemoContainer.Create;
//#UC START# *483FA3A301E0_482D888D039E_var*
//#UC END# *483FA3A301E0_482D888D039E_var*
begin
//#UC START# *483FA3A301E0_482D888D039E_impl*
 inherited Create;
//#UC END# *483FA3A301E0_482D888D039E_impl*
end;//TevCustomMemoContainer.Create

class function TevCustomMemoContainer.Make: InevDocumentContainer;
var
 l_Inst : TevCustomMemoContainer;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevCustomMemoContainer.Make

function TevCustomMemoContainer.DoBeforeFinishAtom1(aGenerator: Tk2DocumentGenerator;
 var anAtom: Tk2StackAtom): Boolean;
//#UC START# *47F226170180_482D888D039E_var*
//#UC END# *47F226170180_482D888D039E_var*
begin
//#UC START# *47F226170180_482D888D039E_impl*
 Result := inherited DoBeforeFinishAtom1(aGenerator, anAtom);
 if Result then
  UpdateParaParam(anAtom);
//#UC END# *47F226170180_482D888D039E_impl*
end;//TevCustomMemoContainer.DoBeforeFinishAtom1

function TevCustomMemoContainer.DoBeforeFinishAtom(G: Tk2DocumentGenerator;
 var Atom: Tk2StackAtom): Boolean;
//#UC START# *47F2262B0094_482D888D039E_var*
//#UC END# *47F2262B0094_482D888D039E_var*
begin
//#UC START# *47F2262B0094_482D888D039E_impl*
 Result := inherited DoBeforeFinishAtom(G, Atom);
 if Result then
  UpdateParaParam(Atom);
//#UC END# *47F2262B0094_482D888D039E_impl*
end;//TevCustomMemoContainer.DoBeforeFinishAtom

procedure TevCustomMemoContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_482D888D039E_var*
//#UC END# *47F35245009A_482D888D039E_var*
begin
//#UC START# *47F35245009A_482D888D039E_impl*
 theProcessor := TevMemoProcessor.Create;
//#UC END# *47F35245009A_482D888D039E_impl*
end;//TevCustomMemoContainer.MakeProcessor

procedure TevCustomMemoContainer.DoGetWriter(aFormat: TnevFormat;
 anInternal: Boolean;
 var theWriter: Tk2TagGenerator;
 aCodePage: Integer);
//#UC START# *483E6C150277_482D888D039E_var*
const
 cExcludeAttr : array [0..7] of Integer =
                 (
                  k2_tiLeftIndent,
                  k2_tiRightIndent,
                  k2_tiFirstIndent,
                  k2_tiJustification,
                  k2_tiStyle,
                  k2_tiSpaceBefore,
                  k2_tiSpaceAfter,
                  k2_tiFont
                 );
var
 l_ExcludeAttr : TLongArray;
 l_Index       : Integer;
//#UC END# *483E6C150277_482D888D039E_var*
begin
//#UC START# *483E6C150277_482D888D039E_impl*
 inherited;
 if (theWriter <> nil) then
  if (Memo <> nil) then
  begin
  // - ставим фильтр на те теги, которые сами добавили или изменили
  for l_Index := Low(cExcludeAttr) to High(cExcludeAttr) do
   if not TevCustomMemo(Memo).KeepParaFormattingTag(cExcludeAttr[l_Index]) then
    l_ExcludeAttr := l3CatLongArray(l_ExcludeAttr, [cExcludeAttr[l_Index]]);
  if (Length(l_ExcludeAttr) > 0) then  
   with TevTagsListFilter do
    SetTo(theWriter, MakeAttrList(k2_typTextPara, l_ExcludeAttr));
  end;//Memo <> nil
//#UC END# *483E6C150277_482D888D039E_impl*
end;//TevCustomMemoContainer.DoGetWriter

function TevCustomMemoContainer.NeedsProgressOnSave: Boolean;
//#UC START# *483FA1320271_482D888D039E_var*
//#UC END# *483FA1320271_482D888D039E_var*
begin
//#UC START# *483FA1320271_482D888D039E_impl*
 Result := false;
//#UC END# *483FA1320271_482D888D039E_impl*
end;//TevCustomMemoContainer.NeedsProgressOnSave

function TevCustomMemoContainer.GetDocumentType: Tk2Type;
//#UC START# *4A8D226F0164_482D888D039E_var*
//#UC END# *4A8D226F0164_482D888D039E_var*
begin
//#UC START# *4A8D226F0164_482D888D039E_impl*
 Result := k2_typSimpleDocument;
//#UC END# *4A8D226F0164_482D888D039E_impl*
end;//TevCustomMemoContainer.GetDocumentType

end.
