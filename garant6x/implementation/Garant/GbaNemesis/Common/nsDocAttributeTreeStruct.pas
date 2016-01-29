unit nsDocAttributeTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsDocAttributeTreeStruct.pas"
// Начат: 2003/07/03 17:48:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::DocumentContainers::TnsDocAttributeTreeStruct
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  l3IID,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocAttributeTreeStruct = class(TnsDataResetTreeStruct)
 private
 // private fields
   f_Doc : IDocument;
    {* Документ.}
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   procedure RootChanged(const aOld: Il3SimpleRootNode;
    const aNew: Il3SimpleRootNode); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aDoc: IDocument;
    aShowRoot: Boolean); reintroduce;
   class function Make(const aDoc: IDocument;
    aShowRoot: Boolean = False): Il3SimpleTree; reintroduce;
 end;//TnsDocAttributeTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocAttributeTreeStruct

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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Doc := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsDocAttributeTreeStruct.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.