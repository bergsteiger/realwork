unit nsContentsListForFiltering;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsContentsListForFiltering.pas"
// Начат: 26.01.2011 15:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Работа с документом и списком документов::Document::View::Contents::TnsContentsListForFiltering
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
  DynamicTreeUnit,
  DocumentAndListInterfaces,
  l3ProtoObjectForTie,
  IOUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsContentsListForFiltering = class(Tl3ProtoObjectForTie, IListForFiltering)
 private
 // private fields
   f_Contents : IdsBaseContents;
   f_Type : TnsContentsListType;
 protected
 // realized methods
   procedure Item(aIndex: Cardinal; out aRet {: IString}); stdcall;
   function GetCount: Cardinal; stdcall;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aType: TnsContentsListType;
     const aContents: IdsBaseContents); reintroduce;
   class function Make(aType: TnsContentsListType;
     const aContents: IdsBaseContents): IListForFiltering; reintroduce;
     {* Сигнатура фабрики TnsContentsListForFiltering.Make }
 end;//TnsContentsListForFiltering
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  DocumentUnit,
  l3Interfaces,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsContentsListForFiltering

constructor TnsContentsListForFiltering.Create(aType: TnsContentsListType;
  const aContents: IdsBaseContents);
//#UC START# *4D4011EF02C2_4D4011460346_var*
//#UC END# *4D4011EF02C2_4D4011460346_var*
begin
//#UC START# *4D4011EF02C2_4D4011460346_impl*
 inherited Create;
 f_Contents := aContents;
 f_Type := aType;
//#UC END# *4D4011EF02C2_4D4011460346_impl*
end;//TnsContentsListForFiltering.Create

class function TnsContentsListForFiltering.Make(aType: TnsContentsListType;
  const aContents: IdsBaseContents): IListForFiltering;
var
 l_Inst : TnsContentsListForFiltering;
begin
 l_Inst := Create(aType, aContents);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsContentsListForFiltering.Item(aIndex: Cardinal; out aRet {: IString});
//#UC START# *4D3D26DC0123_4D4011460346_var*

 function DoGet: IString;
 begin
  Result := nsIStr(f_Contents.ContentsListItem[TnsContentsListIndex_C(f_Type, aIndex)]);
 end;

var
 l_I : Integer;
//#UC END# *4D3D26DC0123_4D4011460346_var*
begin
//#UC START# *4D3D26DC0123_4D4011460346_impl*
 if (f_Contents = nil) then
  IString(aRet) := nil
 else
 begin
  IString(aRet) := DoGet;
  //l_I := IString(aRet)._AddRef;
 end;//f_Contents = nil
//#UC END# *4D3D26DC0123_4D4011460346_impl*
end;//TnsContentsListForFiltering.Item

function TnsContentsListForFiltering.GetCount: Cardinal;
//#UC START# *4D3D272402AE_4D4011460346get_var*
//#UC END# *4D3D272402AE_4D4011460346get_var*
begin
//#UC START# *4D3D272402AE_4D4011460346get_impl*
 if (f_Contents = nil) then
  Result := 0
 else
  Result := f_Contents.ContentsListCount[f_Type];
//#UC END# *4D3D272402AE_4D4011460346get_impl*
end;//TnsContentsListForFiltering.GetCount

{$If not defined(DesignTimeLibrary)}
class function TnsContentsListForFiltering.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4D4011460346_var*
//#UC END# *47A6FEE600FC_4D4011460346_var*
begin
//#UC START# *47A6FEE600FC_4D4011460346_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4D4011460346_impl*
end;//TnsContentsListForFiltering.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure TnsContentsListForFiltering.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Contents := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsContentsListForFiltering.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.