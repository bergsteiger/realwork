unit f1MultilinkResolver;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\f1MultilinkResolver.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tf1MultilinkResolver" MUID: (4DCD5932009E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evdLeafParaFilter
 , DocumentUnit
 , l3Variant
 , k2Base
;

type
 Tf1MultilinkResolver = class(TevdLeafParaFilter)
  private
   f_Doc: IDocument;
   f_ParaID: Integer;
  protected
   procedure StartChild(TypeID: Tl3Type); override;
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
   procedure ClearFields; override;
  public
   class function SetTo(var theGenerator: Ik2TagGenerator;
    const aDoc: IDocument): Ik2TagGenerator;
   constructor Create(const aDoc: IDocument); reintroduce;
 end;//Tf1MultilinkResolver
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , HyperLink_Const
 , evdTypes
 , k2Tags
 , LeafPara_Const
 , SysUtils
 , BaseTypesUnit
;

class function Tf1MultilinkResolver.SetTo(var theGenerator: Ik2TagGenerator;
 const aDoc: IDocument): Ik2TagGenerator;
//#UC START# *4DCD5A9F022F_4DCD5932009E_var*
var
 l_G : Tf1MultilinkResolver;
//#UC END# *4DCD5A9F022F_4DCD5932009E_var*
begin
//#UC START# *4DCD5A9F022F_4DCD5932009E_impl*
 l_G := Create(aDoc);
 try
  l_G.Generator := theGenerator;
  theGenerator := l_G;
 finally
  FreeAndNil(l_G);
 end;//try..finally
 Result := theGenerator;
//#UC END# *4DCD5A9F022F_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.SetTo

constructor Tf1MultilinkResolver.Create(const aDoc: IDocument);
//#UC START# *4DCD5AE3022C_4DCD5932009E_var*
//#UC END# *4DCD5AE3022C_4DCD5932009E_var*
begin
//#UC START# *4DCD5AE3022C_4DCD5932009E_impl*
 inherited Create;
 f_Doc := aDoc;
//#UC END# *4DCD5AE3022C_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.Create

procedure Tf1MultilinkResolver.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4DCD5932009E_var*
//#UC END# *4836D4650177_4DCD5932009E_var*
begin
//#UC START# *4836D4650177_4DCD5932009E_impl*
 inherited;
 if CurrentType.IsKindOf(k2_typLeafPara) then
  f_ParaID := -1;
//#UC END# *4836D4650177_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.StartChild

procedure Tf1MultilinkResolver.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_4DCD5932009E_var*
//#UC END# *4836D52400D9_4DCD5932009E_var*
begin
//#UC START# *4836D52400D9_4DCD5932009E_impl*
 inherited;
 if CurrentType.IsKindOf(k2_typLeafPara) then
  if (AtomIndex = k2_tiHandle) then
   f_ParaID := Value.AsInteger;
//#UC END# *4836D52400D9_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.AddAtomEx

function Tf1MultilinkResolver.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4DCD5932009E_var*
//#UC END# *49E488070386_4DCD5932009E_var*
begin
//#UC START# *49E488070386_4DCD5932009E_impl*
 Result := k2_typHyperlink;
//#UC END# *49E488070386_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.ParaTypeForFiltering

procedure Tf1MultilinkResolver.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_4DCD5932009E_var*
var
 l_T : TTopic;
 l_TID : Integer;
 l_A   : Tl3Variant;
 l_L   : IDocPointList;
 l_I   : Integer;
 l_P   : TDocPoint;
//#UC END# *49E4883E0176_4DCD5932009E_var*
begin
//#UC START# *49E4883E0176_4DCD5932009E_impl*
 if (aLeaf.ChildrenCount > 0) then
 begin
  l_A := aLeaf.Child[0];
  if l_A.IsValid then
  begin
   l_TID := l_A.IntA[k2_tiType];
   if (l_TID = CI_MULT) OR
      (l_TID = CI_PHARM_MULTI) then
   begin
    with l_T do
    begin
     rPid.rObjectId := TObjectId(f_ParaID);
     rPid.rClassId := TClassId(l_TID);
     rPosition.rPoint := Cardinal(l_A.IntA[k2_tiSubID]);
     rPosition.rType := PT_SUB;
    end;//with l_T
    f_Doc.GetMultiLinkInfo(f_Doc.GetInternalID{!!!}, l_T, l_L);
    if (l_L = nil) then
     Exit;
    aLeaf.AsObject.DeleteChildren;
    for l_I := 0 to Pred(l_L.Count) do
    begin
     l_L.pm_GetItem(l_I, l_P);
     l_A := Tk2Type(aLeaf.TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
     try
      l_A.IntA[k2_tiType] := CI_TOPIC;
      l_A.IntA[k2_tiDocID] := Integer(l_P.rDocID);
      l_A.IntA[k2_tiSubID] := Integer(l_P.rSubID);
      aLeaf.AddChild(l_A);
     finally
      l_A := nil;
     end;//try..finally
    end;//for l_I
   end;//l_TID = CI_MULT
  end;//l_A.IsValid
 end;//aLeaf.ChilrenCount > 0
 inherited;
//#UC END# *49E4883E0176_4DCD5932009E_impl*
end;//Tf1MultilinkResolver.DoWritePara

procedure Tf1MultilinkResolver.ClearFields;
begin
 f_Doc := nil;
 inherited;
end;//Tf1MultilinkResolver.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
