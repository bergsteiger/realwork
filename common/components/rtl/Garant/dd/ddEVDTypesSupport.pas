unit ddEVDTypesSupport;

interface

uses
 k2Interfaces;

 procedure StartBitmapPara(const Generator: Ik2TagGenerator);

 procedure StartFormulaPara(const Generator: Ik2TagGenerator);

 procedure StartTablePara(const Generator: Ik2TagGenerator);

 procedure StartTableRow(const Generator: Ik2TagGenerator);

 procedure StartObjectSegment(const Generator: Ik2TagGenerator);

 procedure StartTextSegment(const Generator: Ik2TagGenerator);

 procedure StartHyperlink(const Generator: Ik2TagGenerator);

 procedure StartAddress(const Generator: Ik2TagGenerator);

 procedure StartSub(const Generator: Ik2TagGenerator);

 procedure StartTab(const Generator: Ik2TagGenerator);

implementation

uses
 Sub_Const,
 Table_Const,
 BitmapPara_Const,
 Formula_Const,
 TextSegment_Const,
 ObjectSegment_Const,
 HyperLink_Const,
 Address_Const,
 TabStop_Const,
 TableRow_Const;

procedure StartBitmapPara(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typBitmapPara);
end;

procedure StartFormulaPara(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typFormula);
end;

procedure StartTablePara(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typTable);
end;

procedure StartTableRow(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typTableRow);
end;

procedure StartObjectSegment(const Generator: Ik2TagGenerator);
//#UC START# *54D88E10002A_521B05D60264_var*
//#UC END# *54D88E10002A_521B05D60264_var*
begin
//#UC START# *54D88E10002A_521B05D60264_impl*
 Generator.StartChild(k2_typObjectSegment);
//#UC END# *54D88E10002A_521B05D60264_impl*
end;//StartObjectSegment

procedure StartTextSegment(const Generator: Ik2TagGenerator);
//#UC START# *54D88E3D0139_521B05D60264_var*
//#UC END# *54D88E3D0139_521B05D60264_var*
begin
//#UC START# *54D88E3D0139_521B05D60264_impl*
 Generator.StartChild(k2_typTextSegment);
//#UC END# *54D88E3D0139_521B05D60264_impl*
end;//StartTextSegment

procedure StartHyperlink(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typHyperlink);
end;

procedure StartAddress(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typAddress);
end;

procedure StartSub(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typSub);
end;

procedure StartTab(const Generator: Ik2TagGenerator);
begin
 Generator.StartChild(k2_typTabStop);
end;

end.
