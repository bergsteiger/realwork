unit evDocumentCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentCursorPair.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
 , k2Interfaces
 , nevBase
;

type
 TevDocumentCursorPair = class(TevParaListCursorPair)
  protected
   procedure DoStore(const aView: InevView;
    const G: Ik2TagGenerator;
    aFlags: TevStoreFlags); override;
   {$If Defined(evNeedEditableCursors)}
   function DoDelete(const aView: InevView;
    const anOpPack: InevOp = nil;
    aMode: TevClearMode = ev_cmAll;
    const aPara: InevPara = nil): Boolean; override;
   {$IfEnd} // Defined(evNeedEditableCursors)
 end;//TevDocumentCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evdInterfaces
 , l3UnitsTools
 , evSectionPara
 , evdDOM
 , k2Tags
 , Para_Const
;

procedure TevDocumentCursorPair.DoStore(const aView: InevView;
 const G: Ik2TagGenerator;
 aFlags: TevStoreFlags);
//#UC START# *5108D5CB0048_4A2D2DA90232_var*
var
 l_NeedCloseDocument : Boolean;
 
 procedure CheckSectionBreak;
 var
  l_Child  : InevObject;
  l_Holder : InevObjectHolder;
  l_SB     : InevSectionBreaks;
  l_Break  : InevObject;
  l_Range  : InevRange;
 begin//CheckSectionBreak
  if (f_Start <> nil) then
  begin
   l_Holder := ParaX.DocumentContainer;
   if (l_Holder <> nil) then
   begin
    l_SB := l_Holder.SectionBreaks;
    if (l_SB <> nil) then
    begin
     l_Child := f_Start.MostInner.Obj^;
     if l_SB.GetSectionBreak(l_Child, l_Break) then
     begin
      if not (evd_sfChildrenOnly in aFlags) then
      begin
       G.StartChild(pm_GetTagType);
       aFlags := aFlags + [evd_sfChildrenOnly];
       l_NeedCloseDocument := true;
      end;//not (evd_sfChildrenOnly in aFlags)
      if not l_Break.AsObject.IsSame(l_Child.AsObject) then
      begin
       if (Abs(evPixel2Cm(evSectionExtent(l_Break.AsObject).X) - evPageSizes[evd_psA4].X) > 10) then
       begin
        l_Range := l_Break.Range;
        l_Range.AsStorable.Store(aView, G, []);
       end;//evSectionExtent(l_Break).X <> evPageSizes[evd_psA4].X)
      end;//not l_Break.IsSame(l_Child)
     end;//l_SB.GetSectionBreak(f_Start.MostInner.Obj^, l_Break)
    end;//l_SB <> nil
   end;//l_Holder <> nil
  end;//f_Start <> nil
 end;//CheckSectionBreak
//#UC END# *5108D5CB0048_4A2D2DA90232_var*
begin
//#UC START# *5108D5CB0048_4A2D2DA90232_impl*
 if (Solid(aView) OR not GetRedirect.Owner.IsKindOf(k2_typPara)) then
 begin
 // - если выделен целиком или не вложенный документ
  {$IfDef Nemesis}
  if (f_Start = nil) OR f_Start.AtStart then
  begin
   with ParaX do
   begin
    l_NeedCloseDocument := true;
    if (evd_sfChildrenOnly in aFlags) then
     l_NeedCloseDocument := false
    else
     G.StartChild(TagType);
    try
     if HasSubAtom(k2_tiInContents) then
      G.AddBoolAtom(k2_tiInContents, BoolA[k2_tiInContents]);
     if ((f_Start <> nil) AND not f_Start.AtStart)
        // OR not (evd_sfChildrenOnly in aFlags)
        // Хочется это раскомментировать - иначе в документ не попадает имя
        // НО НЕЛЬЗЯ, т.к. иначе в Preview попадает паразитный параграф при добавлении
        // заголовков документа/блоков.
        // Придётся пожертвовать именем и тестовыми данными
        // Если сильно припрёт, то можно попробовать поиграться с записью тега k2_tiInContents
        then
     begin
      if HasSubAtom(k2_tiName) then
       G.AddStringAtom(k2_tiName, PCharLenA[k2_tiName]);
      if HasSubAtom(k2_tiShortName) then
       G.AddStringAtom(k2_tiShortName, PCharLenA[k2_tiShortName]);
     end;//(f_Start <> nil) AND not f_Start.AtStart
     if HasSubAtom(k2_tiLineSpacing) then
      G.AddIntegerAtom(k2_tiLineSpacing, IntA[k2_tiLineSpacing]);
     if HasSubAtom(k2_tiStyle) then
      G.AddIntegerAtom(k2_tiStyle, IntA[k2_tiStyle]);
     if HasSubAtom(k2_tiExternalHandle) then
      G.AddIntegerAtom(k2_tiExternalHandle, IntA[k2_tiExternalHandle]);
     inherited DoStore(aView, G, aFlags + [evd_sfChildrenOnly]);
    finally
     if l_NeedCloseDocument then
      G.Finish;
    end;//try..finally
   end;//with ParaX
  end//f_Start = nil
  else
  {$EndIf  Nemesis}
  begin
   {$IfDef Nemesis}
   if (evd_sfChildrenOnly in aFlags) then
    with ParaX do
    begin
     if HasSubAtom(k2_tiInContents) then
      G.AddBoolAtom(k2_tiInContents, BoolA[k2_tiInContents]);
     if HasSubAtom(k2_tiName) then
      G.AddStringAtom(k2_tiName, PCharLenA[k2_tiName]);
     if HasSubAtom(k2_tiShortName) then
      G.AddStringAtom(k2_tiShortName, PCharLenA[k2_tiShortName]);
     if HasSubAtom(k2_tiExternalHandle) then
      G.AddIntegerAtom(k2_tiExternalHandle, IntA[k2_tiExternalHandle]);
    end;//with ParaX
   {$EndIf Nemesis}
   l_NeedCloseDocument := false;
   {$IfDef Nemesis}
   CheckSectionBreak;
   {$EndIf Nemesis}
   try
    inherited DoStore(aView, G, aFlags{ - [evd_sfStoreParaEnd]});
   finally
    if l_NeedCloseDocument then
     G.Finish;
   end;//try..finally
  end;//f_Start = nil
 end//(Solid(aView) OR not GetRedirect.Owner.IsKindOf(k2_typPara))
 else
  inherited DoStore(aView, G, aFlags + [evd_sfChildrenOnly]);
//#UC END# *5108D5CB0048_4A2D2DA90232_impl*
end;//TevDocumentCursorPair.DoStore

{$If Defined(evNeedEditableCursors)}
function TevDocumentCursorPair.DoDelete(const aView: InevView;
 const anOpPack: InevOp = nil;
 aMode: TevClearMode = ev_cmAll;
 const aPara: InevPara = nil): Boolean;
//#UC START# *5108D66900C9_4A2D2DA90232_var*
//#UC END# *5108D66900C9_4A2D2DA90232_var*
begin
//#UC START# *5108D66900C9_4A2D2DA90232_impl*
 if Solid(aView) then
 begin
  if (aMode = ev_cmAll) then
   aMode := ev_cmKeepOne;
 end//Solid
 else
 begin
  if (aMode = ev_cmKeepOne) then
   aMode := ev_cmAll
  else
  if (aMode = ev_cmForceKeepOne) then
   aMode := ev_cmKeepOne;
 end;//Solid
 Result := inherited DoDelete(aView, anOpPack, aMode, aPara);
//#UC END# *5108D66900C9_4A2D2DA90232_impl*
end;//TevDocumentCursorPair.DoDelete
{$IfEnd} // Defined(evNeedEditableCursors)

{$IfEnd} // Defined(evUseVisibleCursors)
end.
