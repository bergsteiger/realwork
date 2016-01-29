unit FTAM_Filter;

interface
uses
 l3Base,
 l3Types,
 k2Types,
 k2Prim,
 l3Variant,
 evInfoFilter;

type
 TFTAMFilter = class(TevInfoFilterEx)
 private
  f_ParaSize: Integer;
  f_ParaStyle: Integer;
 protected
  procedure StartChild(TypeID: Tl3VariantDef); override;
  procedure CloseStructure(NeedUndo: Bool); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 end;

implementation
uses
 SysUtils,

 k2Interfaces,
 k2Tags,
 k2Base,

 evdStyles,
 evTextStyle_Const,

 LeafPara_Const,
 Table_Const,
 SBS_Const;

 
procedure TFTAMFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 CT : Tk2Type;
 S  : Tl3CustomString;
begin
 inherited;
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typLeafPara) then
  begin
   case AtomIndex of
    k2_tiStyle: f_ParaStyle := VariantAsInteger(k2_tiStyle, Value);
    k2_tiText : begin
                 S := VariantAsString(Value);
                 try
                  if not S.Empty then
                   f_ParaSize := S.Len;
                 finally
                   FreeAndNil(S);
                 end;
                end;
   end;
  end;
 end;
end;

procedure TFTAMFilter.CloseStructure(NeedUndo: Bool);
var
 CT : Tk2Type;
begin
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typLeafPara) and
     ((f_ParaStyle = ev_saTxtNormalOEM) or (f_ParaStyle = ev_saANSIDOS)) and
     (f_ParaSize > 73) then
   ReportDocID;
 end;
 inherited;
end;

procedure TFTAMFilter.StartChild(TypeID: Tl3VariantDef);
var
 CT : Tk2Type;
begin
 inherited;
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typTable) AND not CT.IsKindOf(k2_typSBS) then
   ReportDocID;
  if (not f_WasOut) and CT.IsKindOf(k2_typLeafPara) then
  begin
   f_ParaStyle := ev_saEmpty;
   f_ParaSize  := 0;
  end;
 end;
end;

end.
