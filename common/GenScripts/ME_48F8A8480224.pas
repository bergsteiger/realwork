unit evTreeStorable;

// Модуль: "w:\common\components\gui\Garant\Everest\evTreeStorable.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evStorable
 , nevBase
 , evdInterfaces
 , nevTools
;

type
 TevTreeStorableData = record
  rTree: InevSimpleTree;
  rLevelTag: Integer;
  rFlag: Word;
 end;//TevTreeStorableData

 TevTreeStorable = class(TevStorable)
  private
   f_LevelTag: Integer;
   f_Flag: Word;
   f_LevelIndent: Integer;
    {* Поле для свойства LevelIndent }
   f_Data: InevSimpleTree;
    {* Поле для свойства Data }
   f_SubRoot: InevSimpleNode;
    {* Поле для свойства SubRoot }
  protected
   procedure DoStoreNode(const aNode: InevSimpleNode;
    const G: InevTagGenerator;
    aLevel: Integer);
   procedure DoIterateTree(const G: InevTagGenerator;
    aFlags: TevStoreFlags = evDefaultStoreFlags); virtual;
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aData: TevTreeStorableData;
    const aReader: InevTagReader;
    aLevelIndent: Integer;
    const aSubRoot: InevSimpleNode); reintroduce;
   class function Make(const aData: TevTreeStorableData;
    const aReader: InevTagReader = nil;
    aLevelIndent: Integer = 2;
    const aSubRoot: InevSimpleNode = nil): IevdDataObject; reintroduce;
   class function MakeStorable(const aData: TevTreeStorableData;
    const aReader: InevTagReader = nil;
    aLevelIndent: Integer = 2;
    const aSubRoot: InevSimpleNode = nil): InevStorable; reintroduce;
  protected
   property Data: InevSimpleTree
    read f_Data;
   property SubRoot: InevSimpleNode
    read f_SubRoot;
  public
   property LevelIndent: Integer
    read f_LevelIndent
    write f_LevelIndent;
 end;//TevTreeStorable

function TevTreeStorableData_C: TevTreeStorableData;

implementation

uses
 l3ImplUses
 , l3Defaults
 , l3Base
 , nevPersistentDocumentContainer
 , k2Tags
 , SysUtils
 , l3TreeInterfaces
 , l3Nodes
 , TextPara_Const
 , Document_Const
;

function TevTreeStorableData_C: TevTreeStorableData;
//#UC START# *48FC65A403CF_48FC655F025C_var*
//#UC END# *48FC65A403CF_48FC655F025C_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *48FC65A403CF_48FC655F025C_impl*
 Result.rTree := aTree;
 Result.rLevelTag := aLevelTag;
 Result.rFlag := aFlag;
//#UC END# *48FC65A403CF_48FC655F025C_impl*
end;//TevTreeStorableData_C

procedure TevTreeStorable.DoStoreNode(const aNode: InevSimpleNode;
 const G: InevTagGenerator;
 aLevel: Integer);
//#UC START# *48F8A8CD00D9_48F8A8480224_var*
const
 cIndentUnit = def_FirstIndent div 2;
var
 l_LevelValueMultiplier : Integer;
 l_DataObj              : IevTreeDataObject;
//#UC END# *48F8A8CD00D9_48F8A8480224_var*
begin
//#UC START# *48F8A8CD00D9_48F8A8480224_impl*
 if aLevel > 0 then
 begin
  if (f_LevelTag in [k2_tiFirstIndent, k2_tiLeftIndent]) then
   l_LevelValueMultiplier := cIndentUnit * f_LevelIndent
  else
   l_LevelValueMultiplier := 1;
  if Supports(aNode, IevTreeDataObject, l_DataObj) then
  begin
   try
    l_DataObj.Store(G, f_LevelTag,  (aLevel-1) * l_LevelValueMultiplier);
   finally
    l_DataObj := nil;
   end; {try..finally}
  end
  else
  begin
   G.StartChild(k2_typTextPara);
   try
    G.AddStringAtom(k2_tiText, aNode.Text);
    G.AddIntegerAtom(f_LevelTag, (aLevel-1) * l_LevelValueMultiplier);
    if f_LevelTag = k2_tiLeftIndent then
     G.AddIntegerAtom(k2_tiFirstIndent, (aLevel-1) * l_LevelValueMultiplier);
   finally
    G.Finish;
   end;//try..finally
  end; {if..}
 end;//aLevel > 0
//#UC END# *48F8A8CD00D9_48F8A8480224_impl*
end;//TevTreeStorable.DoStoreNode

procedure TevTreeStorable.DoIterateTree(const G: InevTagGenerator;
 aFlags: TevStoreFlags = evDefaultStoreFlags);
//#UC START# *48F8A8F501DD_48F8A8480224_var*

 function lpIterate(const aIntf : InevSimpleNode) : Boolean;
 begin//AddChildren
  Result := True;
  DoStoreNode(aIntf, G, aIntf.GetLevelFor(f_Data.RootNode));
 end;//AddChildren

var
 l_ETree : Il3ExpandedSimpleTree;
//#UC END# *48F8A8F501DD_48F8A8480224_var*
begin
//#UC START# *48F8A8F501DD_48F8A8480224_impl*
 if (f_Flag <> 0) AND
  Supports(f_Data, Il3ExpandedSimpleTree, l_ETree) then
  try
   l_ETree.FlagIterateF(l3L2SNA(@lpIterate), f_Flag, 0, f_SubRoot);
  finally
   l_ETree := nil;
  end//try..finally
 else
  f_Data.SimpleIterateF(L3L2SNA(@lpIterate), 0, f_SubRoot);
//#UC END# *48F8A8F501DD_48F8A8480224_impl*
end;//TevTreeStorable.DoIterateTree

constructor TevTreeStorable.Create(const aData: TevTreeStorableData;
 const aReader: InevTagReader;
 aLevelIndent: Integer;
 const aSubRoot: InevSimpleNode);
//#UC START# *48F8A91F004B_48F8A8480224_var*
var
 l_Reader : InevTagReader;
//#UC END# *48F8A91F004B_48F8A8480224_var*
begin
//#UC START# *48F8A91F004B_48F8A8480224_impl*
 f_Data := aData.rTree;
 f_LevelTag := aData.rLevelTag;
 f_Flag := aData.rFlag;
 if (f_LevelTag = k2_tiVoid) then
  f_LevelTag := k2_tiFirstIndent;
 if (aReader = nil) then
  l_Reader := TnevPersistentDocumentContainer.Make.TagReader
 else
  l_Reader := aReader;
 inherited Create(l_Reader);
 f_LevelIndent := aLevelIndent;
 f_SubRoot := aSubRoot;
//#UC END# *48F8A91F004B_48F8A8480224_impl*
end;//TevTreeStorable.Create

class function TevTreeStorable.Make(const aData: TevTreeStorableData;
 const aReader: InevTagReader = nil;
 aLevelIndent: Integer = 2;
 const aSubRoot: InevSimpleNode = nil): IevdDataObject;
var
 l_Inst : TevTreeStorable;
begin
 l_Inst := Create(aData, aReader, aLevelIndent, aSubRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevTreeStorable.Make

class function TevTreeStorable.MakeStorable(const aData: TevTreeStorableData;
 const aReader: InevTagReader = nil;
 aLevelIndent: Integer = 2;
 const aSubRoot: InevSimpleNode = nil): InevStorable;
var
 l_Inst : TevTreeStorable;
begin
 l_Inst := Create(aData, aReader, aLevelIndent, aSubRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevTreeStorable.MakeStorable

procedure TevTreeStorable.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
//#UC START# *48F48C6E02F4_48F8A8480224_var*
//#UC END# *48F48C6E02F4_48F8A8480224_var*
begin
//#UC START# *48F48C6E02F4_48F8A8480224_impl*
 G.Start;
 try
  G.StartChild(k2_typDocument);
  try
   DoIterateTree(G, aFlags);
  finally
   G.Finish;
  end;//try..finally
 finally
  G.Finish;
 end;//try..finally
//#UC END# *48F48C6E02F4_48F8A8480224_impl*
end;//TevTreeStorable.DoStore

procedure TevTreeStorable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F8A8480224_var*
//#UC END# *479731C50290_48F8A8480224_var*
begin
//#UC START# *479731C50290_48F8A8480224_impl*
 f_Data := nil;
 f_SubRoot := nil;
 inherited;
//#UC END# *479731C50290_48F8A8480224_impl*
end;//TevTreeStorable.Cleanup

procedure TevTreeStorable.ClearFields;
begin
 f_Data := nil;
 f_SubRoot := nil;
 inherited;
end;//TevTreeStorable.ClearFields

end.
