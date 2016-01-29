unit evDecorStyleEliminator;

{$Include ..\Everest\evDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant,
  k2Interfaces
  ;

type
 TevDecorStyleEliminator = class(TevdLeafParaFilter)
 public
  DocID : Integer;
  NeedCorrect : Boolean;
 protected 
   procedure LogDocID(aStyle : Integer);
   procedure DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant); override;
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevDecorStyleEliminator

implementation

uses
  TextPara_Const,
  k2Tags,
  Formula_Const,
  evdTypes,
  l3_String
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  l3Base,
  Segment_Const,
  StrUtils,
  SysUtils,
  l3String,
  evdStyles,
  Document_Const,
  ObjectSegment_Const,
  Hyperlink_Const,
  vtDebug
  ;

// start class TevDecorStyleEliminator

procedure TevDecorStyleEliminator.LogDocID(aStyle : Integer);
begin
 dbgAppendToLogLn(ChangeFileExt(ParamStr(0), '.num'), ClassName + ' ' + IntToStr(DocID) + ' : ' + IntToStr(aStyle));
 NeedCorrect := true;
end;

procedure TevDecorStyleEliminator.DoAddAtomEx(AtomIndex: Integer; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  case AtomIndex of
   k2_tiInternalHandle:
    if (Value.AsInteger > 0) then
     DocID := Value.AsInteger;
  end;//case AtomIndex
 end;//CurrentType.IsKindOf(k2_typDocument)
 inherited;
end;

function TevDecorStyleEliminator.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTextPara;
end;//TevDecorStyleEliminator.ParaTypeForFiltering

procedure TevDecorStyleEliminator.DoWritePara(aLeaf: Tl3Variant);
var
 l_Objects : Tl3Variant;
 l_Index : Integer;
 l_O : Tl3Variant;
 l_Style : Integer;
begin
 ///if evHasText(aLeaf) then
 begin
  l_Objects := aLeaf.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)]);
  if l_Objects.IsValid AND (l_Objects.ChildrenCount > 0) then
  begin
   l_Index := 0;
   while (l_Index < l_Objects.ChildrenCount) do
   begin
    l_O := l_Objects.Child[l_Index];
    if not l_O.IsKindOf(k2_typObjectSegment) then
     if not l_O.IsKindOf(k2_typHyperlink) then
      if l_O.HasSubAtom(k2_tiStyle) then
    begin
     l_Style := l_O.IntA[k2_tiStyle];
     if (l_Style > 0)
        OR (l_Style = ev_saNormalTable)
        OR (l_Style = ev_saNormalSBSLeft)
        OR (l_Style = ev_saNormalSBSRight)
        OR (l_Style = ev_saCenteredTable)

        OR (l_Style = ev_saNormalTableList)
       
        OR (l_Style = ev_saUserComment)
       
        OR (l_Style = ev_saContents)
        OR (l_Style = ev_saToLeft)

        OR (l_Style = ev_saAddedText)
        OR (l_Style = ev_saDeletedText)
       
        OR (l_Style = ev_saChatHeaderSender)
        OR (l_Style = ev_saChatHeaderRecipient)
       
        OR (l_Style = ev_saColorSelectionForBaseSearch)

        OR (l_Style = ev_saTechComment)

        OR (l_Style = ev_saTxtNormalANSI)
        OR (l_Style = ev_saTxtNormalOEM)
        OR (l_Style = ev_saANSIDOS)
        OR (l_Style = ev_saNormalNote)
        OR (l_Style = ev_saNormalAnno)
        
        OR (l_Style = ev_saChangesInfo)

        OR (l_Style = ev_saTxtHeader1)
        OR (l_Style = ev_saTxtHeader2)
        OR (l_Style = ev_saTxtHeader3)
        OR (l_Style = ev_saTxtHeader4)
        OR (l_Style = ev_saArticleHeader)

        OR (l_Style = ev_saInterface)
        OR (l_Style = ev_saDialogs)
       
        OR (l_Style = ev_saActiveHyperlink)
       
        OR (l_Style = ev_saSnippet)
        OR (l_Style = ev_saAbolishedDocumentLink)
        OR (l_Style = ev_saVisitedDocumentInList)
        OR (l_Style = ev_saVisitedSnippetInList)
       
        OR (l_Style = ev_saExpandedText)
        OR (l_Style = ev_saObject)
        OR (l_Style = ev_saMistake)
       
        OR (l_Style = ev_saMainMenuConstPath)
        OR (l_Style = ev_saMainMenuChangePath)
        OR (l_Style = ev_saMainMenuHeader)
        OR (l_Style = ev_saMainMenuInteractiveHeader)
        OR (l_Style = ev_saMainMenu)
        then
     begin
      LogDocID(l_Style);
      l_O.AttrW[k2_tiStyle, nil] := nil;
     end;
    end;//l_O.HasSubAtom(k2_tiStyle) 
    Inc(l_Index);
   end;//while l_Index
  end;//l_Objects.IsValid
 end;//evHasText(aLeaf)
 inherited;
end;//TevDecorStyleEliminator.DoWritePara

end.