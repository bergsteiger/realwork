unit evTextParaMultiSelectionBlock;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evTextParaMultiSelectionBlock.pas"
// Начат: 16.03.2004 18:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevTextParaMultiSelectionBlock
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
  evLeafParaMultiSelectionBlock,
  nevBase,
  evdInterfaces
  ;

type
 TevTextParaMultiSelectionBlock = class(TevLeafParaMultiSelectionBlock, IevSelectionPairs)
 protected
 // realized methods
   function pm_GetPairsCount: Integer;
   function pm_GetPair(anIndex: Integer): TevPair;
 protected
 // overridden protected methods
   procedure DoStore(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* сохраняет выделение в G }
 end;//TevTextParaMultiSelectionBlock

implementation

uses
  evdSegmentsLayerJoiner,
  k2Tags,
  evTextParaPartFilter,
  l3Chars,
  l3String,
  l3CustomString,
  l3Types,
  l3_String,
  k2BaseTypes,
  l3Base
  ;

// start class TevTextParaMultiSelectionBlock

function TevTextParaMultiSelectionBlock.pm_GetPairsCount: Integer;
//#UC START# *48EDB3B60265_48ECD68E0010get_var*
//#UC END# *48EDB3B60265_48ECD68E0010get_var*
begin
//#UC START# *48EDB3B60265_48ECD68E0010get_impl*
 if (Blocks = nil) then
  Result := 0
 else
  Result := Blocks.Count;
//#UC END# *48EDB3B60265_48ECD68E0010get_impl*
end;//TevTextParaMultiSelectionBlock.pm_GetPairsCount

function TevTextParaMultiSelectionBlock.pm_GetPair(anIndex: Integer): TevPair;
//#UC START# *48EDB3C60280_48ECD68E0010get_var*
//#UC END# *48EDB3C60280_48ECD68E0010get_var*
begin
//#UC START# *48EDB3C60280_48ECD68E0010get_impl*
 Result := Blocks.Items[anIndex].Borders;
//#UC END# *48EDB3C60280_48ECD68E0010get_impl*
end;//TevTextParaMultiSelectionBlock.pm_GetPair

procedure TevTextParaMultiSelectionBlock.DoStore(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
//#UC START# *48ECE4420180_48ECD68E0010_var*

const
 c_All = [k2_tiText, k2_tiSegments, k2_tiSubs];
 c_Segs = [Low(Byte)..High(Byte)] - [k2_tiSegments];

var
 l_Atom  : Tl3Variant;
 l_NText : Tl3_String;
 l_Text  : Tl3CustomString;
 l_Gen   : TevdSegmentsLayerJoiner;

  function l_StoreSel(aSel: PIUnknown; anIndex: Integer): Boolean;
  var
   l_B : TevPair;
  begin//l_StoreSel
   Result := true;
   l_B := InevRange(aSel^).Borders;
   if (l_B.Len > 0) then
   begin
    TevTextParaPartFilter.WriteAtom(l_Gen, l_Atom, l_B, l3_spfAll, c_Segs, l_NText.Len);
    with l_NText do
    begin
     if (Len > 0) AND (Ch[Pred(Len)] <> cc_HardSpace) then
      Append(cc_HardSpace);
     Append(l3PCharLen(l_Text.St + l_B.rStart, l_B.Len, l_Text.CodePage));
    end;//with l_NText
   end;//l_BS < l_BF
  end;//l_StoreSel

//#UC END# *48ECE4420180_48ECD68E0010_var*
begin
//#UC START# *48ECE4420180_48ECD68E0010_impl*
 if not (evd_sfChildrenOnly in aFlags) then
 begin
  if (Blocks <> nil) AND (Blocks.Count = 1) then
   inherited
  else
  begin
   l_Atom := GetRedirect;
   l_Gen := TevdSegmentsLayerJoiner.Create;
   try
    l_Gen.Start;
    try
     l_Gen.StartChild(l_Atom.TagType);
     try
      with l_Atom.Attr[k2_tiText] do
       if IsValid then
        l_Text := AsObject As Tl3CustomString
       else
        l_Text := nil;
      l_NText := Tl3_String.Create;
      try
       if l_Text.Empty then
        Assert(false, 'По идее не может быть мультивыделения на пустом параграфе')
       else
        Blocks.IterateAllF(l3L2IA(@l_StoreSel));
       l_Atom.AsObject.WriteTag(l_Gen, l3_spfAll, c_All);
       if not l_NText.Empty then
        l_Gen.AddStringAtom(k2_tiText, l_NText.AsWStr);
      finally
       l3Free(l_NText);
      end;//try..finally
     finally
      l_Gen.Finish;
     end;{try..finally}
    finally
     l_Gen.Finish;
    end;//try..finally
    G.StartChild(l_Atom.TagType);
    try
     l_Gen.Root.WriteTag(G);
    finally
     G.Finish;
    end;//try..finally
   finally
    l3Free(l_Gen);
   end;//try..finally
  end;//f_Blocks <> nil
 end;//not ChildrenOnly
//#UC END# *48ECE4420180_48ECD68E0010_impl*
end;//TevTextParaMultiSelectionBlock.DoStore

end.