unit nsDocAttributeTreeStruct;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsDocAttributeTreeStruct.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DocumentUnit
 , l3TreeInterfaces
 , DynamicTreeUnit
 , l3IID
;

type
 TnsDocAttributeTreeStruct = class(TnsDataResetTreeStruct)
  private
   f_Doc: IDocument;
    {* Документ. }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   procedure RootChanged(const aOld: Il3SimpleRootNode;
    const aNew: Il3SimpleRootNode); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   constructor Create(const aDoc: IDocument;
    aShowRoot: Boolean); reintroduce;
   class function Make(const aDoc: IDocument;
    aShowRoot: Boolean = False): Il3SimpleTree; reintroduce;
 end;//TnsDocAttributeTreeStruct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTypesUnit
;

constructor TnsDocAttributeTreeStruct.Create(const aDoc: IDocument;
 aShowRoot: Boolean);
//#UC START# *49085633031D_4683614C02F2_var*
//#UC END# *49085633031D_4683614C02F2_var*
begin
//#UC START# *49085633031D_4683614C02F2_impl*
 f_Doc := aDoc;
 inherited Create(ReAqurieUnfilteredRoot, aShowRoot);
//#UC END# *49085633031D_4683614C02F2_impl*
end;//TnsDocAttributeTreeStruct.Create

class function TnsDocAttributeTreeStruct.Make(const aDoc: IDocument;
 aShowRoot: Boolean = False): Il3SimpleTree;
var
 l_Inst : TnsDocAttributeTreeStruct;
begin
 l_Inst := Create(aDoc, aShowRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocAttributeTreeStruct.Make

function TnsDocAttributeTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4683614C02F2_var*
//#UC END# *48FF64F60078_4683614C02F2_var*
begin
//#UC START# *48FF64F60078_4683614C02F2_impl*
 Assert(f_Doc <> nil);
 try
  f_Doc.GetAttributesRoot(Result);
 except
  on ECanNotFindData do
   Result := nil;
 end;
//#UC END# *48FF64F60078_4683614C02F2_impl*
end;//TnsDocAttributeTreeStruct.ReAqurieUnfilteredRoot

procedure TnsDocAttributeTreeStruct.RootChanged(const aOld: Il3SimpleRootNode;
 const aNew: Il3SimpleRootNode);
//#UC START# *48FDDE4B01F5_4683614C02F2_var*
//#UC END# *48FDDE4B01F5_4683614C02F2_var*
begin
//#UC START# *48FDDE4B01F5_4683614C02F2_impl*
 inherited;
 ExpandSubDir(nil, true, 1);
//#UC END# *48FDDE4B01F5_4683614C02F2_impl*
end;//TnsDocAttributeTreeStruct.RootChanged

function TnsDocAttributeTreeStruct.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4683614C02F2_var*
//#UC END# *4A60B23E00C3_4683614C02F2_var*
begin
//#UC START# *4A60B23E00C3_4683614C02F2_impl*
 Result.SetOK;
 if IID.EQ(IDocument) then
  IDocument(Obj) := f_Doc
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4683614C02F2_impl*
end;//TnsDocAttributeTreeStruct.COMQueryInterface

procedure TnsDocAttributeTreeStruct.ClearFields;
begin
 f_Doc := nil;
 inherited;
end;//TnsDocAttributeTreeStruct.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
