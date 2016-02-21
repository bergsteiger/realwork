unit dd_lcHiddenTextExtractor;

// Модуль: "w:\common\components\rtl\Garant\dd\dd_lcHiddenTextExtractor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
 , k2TagGen
;

type
 Tdd_lcHiddenTextExtractor = class(TevdLeafParaFilter)
  private
   f_ClearFont: Boolean;
    {* Поле для свойства ClearFont }
  private
   procedure WriteToLog(const aText: AnsiString;
    IsSeg: Boolean);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
  public
   constructor Create(anOwner: Tk2TagGeneratorOwner); override;
  public
   property ClearFont: Boolean
    read f_ClearFont
    write f_ClearFont;
 end;//Tdd_lcHiddenTextExtractor

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , evdTypes
 , PageBreak_Const
;

procedure Tdd_lcHiddenTextExtractor.WriteToLog(const aText: AnsiString;
 IsSeg: Boolean);
//#UC START# *538C220C033A_538C1D82017A_var*
//#UC END# *538C220C033A_538C1D82017A_var*
begin
//#UC START# *538C220C033A_538C1D82017A_impl*
 if (aText <> '') and (aText <> ' ') then
  l3System.Msg2Log('Скрытый текст: %s', [aText]);
//#UC END# *538C220C033A_538C1D82017A_impl*
end;//Tdd_lcHiddenTextExtractor.WriteToLog

procedure Tdd_lcHiddenTextExtractor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_538C1D82017A_var*
//#UC END# *479731C50290_538C1D82017A_var*
begin
//#UC START# *479731C50290_538C1D82017A_impl*
 f_ClearFont := True;
 inherited;
//#UC END# *479731C50290_538C1D82017A_impl*
end;//Tdd_lcHiddenTextExtractor.Cleanup

function Tdd_lcHiddenTextExtractor.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_538C1D82017A_var*
var
 l_Len   : Integer;
 l_Start : Integer;
 l_Finish: Integer;

  function lp_CheckLayer(aLayer: Tl3Variant; anIndex: Integer): Boolean;

   function lp_CheckSegment(aSegment: Tl3Variant; anIndex: Integer): Boolean;
   begin//CheckSegment
    Result := True;
    with aSegment do
    begin
     if HasSubAtom(k2_tiStart) then
      if (IntA[k2_tiStart] >= l_Start) then
       IntW[k2_tiStart, nil] := IntA[k2_tiStart] - l_Len;
     if HasSubAtom(k2_tiFinish) then
      if (IntA[k2_tiFinish] >= l_Finish) then
       IntW[k2_tiFinish, nil] := IntA[k2_tiFinish] - l_Len;
    end; // with aSegment do
   end;//CheckSegment

 begin//CheckLayer
  Result := True;
  l_Len := l_Finish - l_Start + 1;
  aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckSegment));
 end;//CheckLayer

var
 i       : Integer;
 l_S     : AnsiString;
 l_Seg   : Tl3Variant;
 l_Layer : Tl3Variant;
//#UC END# *49E48829016F_538C1D82017A_var*
begin
//#UC START# *49E48829016F_538C1D82017A_impl*
 {
  Нужно проверить два случая:
   * абзац имеет признак "невидим"
   * сегмент имеет признак "невидим"
 }
 if aLeaf.IsKindOf(k2_typPageBreak) then
  Result := inherited NeedWritePara(aLeaf)
 else
  if not aLeaf.BoolA[k2_tiVisible] then
  begin
   Result:= False;
   WriteToLog(aLeaf.StrA[k2_tiText], False);
   // Конечно, еще может быть невидимый абзац и видимый сегмент, но мы на это плюем (пока)
  end
  else
  begin
   if f_ClearFont then
    aLeaf.AttrW[k2_tiFont, nil] := nil;
   l_Layer := aLeaf.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)], nil);
   if l_Layer.IsValid then
   begin
    i := 0;
    while i < l_Layer.ChildrenCount do
    begin
     l_Seg := l_Layer.Child[i];
     if not l_Seg.BoolA[k2_tiVisible] then
     begin
      if l_Seg.Attr[k2_tiStart].IsValid then
       l_Start := l_Seg.IntA[k2_tiStart]
      else
       l_Start := 1;
      if l_Seg.Attr[k2_tiFinish].IsValid then
       l_Finish := l_Seg.IntA[k2_tiFinish]
      else
       l_Finish := aLeaf.PCharLenA[k2_tiText].SLen;
      l_Finish := l_Seg.IntA[k2_tiFinish];
      if (l_Start < aLeaf.PCharLenA[k2_tiText].SLen) and
         (l_Start <> l_Finish) then
      begin
       l_Len := l_Finish - l_Start + 1;
       WriteToLog(Copy(aLeaf.StrA[k2_tiText], l_Start, l_Len), True);
       l_Layer.DeleteChild(i);                
       // Удаляем текст
       l_S := aLeaf.StrA[k2_tiText];
       Delete(l_S, l_Start, l_Len);
       aLeaf.StrW[k2_tiText, nil] := l_S;
       // Чистим сегменты...
       aLeaf.Attr[k2_tiSegments].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckLayer));
      end
      else
       Inc(i);
     end
     else
      Inc(i);
    end;
   end;
   Result := inherited NeedWritePara(aLeaf);
  end;
//#UC END# *49E48829016F_538C1D82017A_impl*
end;//Tdd_lcHiddenTextExtractor.NeedWritePara

constructor Tdd_lcHiddenTextExtractor.Create(anOwner: Tk2TagGeneratorOwner);
//#UC START# *538C1F9A00C7_538C1D82017A_var*
//#UC END# *538C1F9A00C7_538C1D82017A_var*
begin
//#UC START# *538C1F9A00C7_538C1D82017A_impl*
 inherited;
 f_ClearFont := True;
//#UC END# *538C1F9A00C7_538C1D82017A_impl*
end;//Tdd_lcHiddenTextExtractor.Create

end.
