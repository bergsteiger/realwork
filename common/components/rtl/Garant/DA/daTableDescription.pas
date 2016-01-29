unit daTableDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daTableDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DA::DataScheme::daTableDescription
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3ProtoObject,
  daTypes,
  daInterfaces,
  daFieldDescriptionList
  ;

type
 TdaTableDescription = class(Tl3ProtoObject, IdaTableDescription)
 private
 // private fields
   f_Description : AnsiString;
   f_IsDublicate : Boolean;
   f_IsFake : Boolean;
   f_FieldList : TdaFieldDescriptionList;
   f_Code : AnsiString;
   f_Name : AnsiString;
   f_Kind : TdaTables;
    {* Поле для свойства Kind}
 protected
 // realized methods
   function Get_Description: AnsiString;
   function Get_IsDublicate: Boolean;
   function Get_IsFake: Boolean;
   function Get_Kind: TdaTables;
   function Get_Field(const FIeldName: AnsiString): IdaFieldDescription;
   function Get_Code: AnsiString;
   function Get_Name: AnsiString;
 public
 // realized methods
   {iterator} procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   constructor Create(aKind: TdaTables;
     const aCode: AnsiString;
     const aName: AnsiString;
     const aDescription: AnsiString;
     aDublicate: Boolean = False;
     aFake: Boolean = False); reintroduce;
   procedure AddField(const aField: IdaFieldDescription);
 public
 // public properties
   property Kind: TdaTables
     read f_Kind;
 end;//TdaTableDescription

implementation

uses
  l3Types,
  SysUtils,
  Classes,
  l3Base
  ;

// unit methods

function CompareFields(Item1: Pointer;
  Item2: Pointer): Integer;
//#UC START# *55CB2045030F_55CB200E0058_var*
//#UC END# *55CB2045030F_55CB200E0058_var*
begin
//#UC START# *55CB2045030F_55CB200E0058_impl*
 Result := IdaFieldDescription(Item1).Index - IdaFieldDescription(Item2).Index;
//#UC END# *55CB2045030F_55CB200E0058_impl*
end;//CompareFields
// start class TdaTableDescription

constructor TdaTableDescription.Create(aKind: TdaTables;
  const aCode: AnsiString;
  const aName: AnsiString;
  const aDescription: AnsiString;
  aDublicate: Boolean = False;
  aFake: Boolean = False);
//#UC START# *55360BAB0116_55360B420250_var*
//#UC END# *55360BAB0116_55360B420250_var*
begin
//#UC START# *55360BAB0116_55360B420250_impl*
 inherited Create;
 f_Kind := aKind;
 f_Code := aCode;
 f_Description := aDescription;
 f_IsDublicate := aDublicate;
 f_IsFake := aFake;
 f_Name := aName;
//#UC END# *55360BAB0116_55360B420250_impl*
end;//TdaTableDescription.Create

procedure TdaTableDescription.AddField(const aField: IdaFieldDescription);
//#UC START# *5538EA4402F6_55360B420250_var*
//#UC END# *5538EA4402F6_55360B420250_var*
begin
//#UC START# *5538EA4402F6_55360B420250_impl*
 f_FieldList.Add(aField);
 aField.BindToTable(Self, f_FieldList.Count);
//#UC END# *5538EA4402F6_55360B420250_impl*
end;//TdaTableDescription.AddField

function TdaTableDescription.Get_Description: AnsiString;
//#UC START# *55360A96000F_55360B420250get_var*
//#UC END# *55360A96000F_55360B420250get_var*
begin
//#UC START# *55360A96000F_55360B420250get_impl*
 Result := f_Description;
//#UC END# *55360A96000F_55360B420250get_impl*
end;//TdaTableDescription.Get_Description

function TdaTableDescription.Get_IsDublicate: Boolean;
//#UC START# *55360AB100E0_55360B420250get_var*
//#UC END# *55360AB100E0_55360B420250get_var*
begin
//#UC START# *55360AB100E0_55360B420250get_impl*
 Result := f_IsDublicate;
//#UC END# *55360AB100E0_55360B420250get_impl*
end;//TdaTableDescription.Get_IsDublicate

function TdaTableDescription.Get_IsFake: Boolean;
//#UC START# *55360AF00014_55360B420250get_var*
//#UC END# *55360AF00014_55360B420250get_var*
begin
//#UC START# *55360AF00014_55360B420250get_impl*
 Result := f_IsFake;
//#UC END# *55360AF00014_55360B420250get_impl*
end;//TdaTableDescription.Get_IsFake

function TdaTableDescription.Get_Kind: TdaTables;
//#UC START# *55378E13022E_55360B420250get_var*
//#UC END# *55378E13022E_55360B420250get_var*
begin
//#UC START# *55378E13022E_55360B420250get_impl*
 Result := f_Kind;
//#UC END# *55378E13022E_55360B420250get_impl*
end;//TdaTableDescription.Get_Kind

function TdaTableDescription.Get_Field(const FIeldName: AnsiString): IdaFieldDescription;
//#UC START# *55379DA40290_55360B420250get_var*
var
 l_Index: Integer;
//#UC END# *55379DA40290_55360B420250get_var*
begin
//#UC START# *55379DA40290_55360B420250get_impl*
 if f_FieldList.FindData(FieldName, l_Index) then
  Result := f_FieldList[l_Index]
 else
  Result := nil;
// !!! Needs to be implemented !!!
//#UC END# *55379DA40290_55360B420250get_impl*
end;//TdaTableDescription.Get_Field

function TdaTableDescription.Get_Code: AnsiString;
//#UC START# *553A19BC0335_55360B420250get_var*
//#UC END# *553A19BC0335_55360B420250get_var*
begin
//#UC START# *553A19BC0335_55360B420250get_impl*
 Result := f_Code;
//#UC END# *553A19BC0335_55360B420250get_impl*
end;//TdaTableDescription.Get_Code

{iterator} procedure TdaTableDescription.IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
//#UC START# *55C860390259_55360B420250_var*

var
 l_List: TList;

 function DoIt(aData : Pointer; anIndex : Integer) : Boolean;
 begin
  l_List.Add(Pointer(aData^));
  Result := True;
 end;

var
 Hack : Pointer absolute anAction;
 l_IDX: Integer;
//#UC END# *55C860390259_55360B420250_var*
begin
//#UC START# *55C860390259_55360B420250_impl*
 l_List := TList.Create;
 try
  try
   f_FieldList.IterateAllF(l3L2IA(@DoIt));
   l_List.Sort(@CompareFields);
   for l_IDX := 0 to l_List.Count - 1 do
    anAction(IdaFieldDescription(l_List[l_IDX]))
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 finally
  FreeAndNil(l_List);
 end;
//#UC END# *55C860390259_55360B420250_impl*
end;//TdaTableDescription.IterateFieldsF

function TdaTableDescription.Get_Name: AnsiString;
//#UC START# *5608EE130006_55360B420250get_var*
//#UC END# *5608EE130006_55360B420250get_var*
begin
//#UC START# *5608EE130006_55360B420250get_impl*
 Result := f_Name;
//#UC END# *5608EE130006_55360B420250get_impl*
end;//TdaTableDescription.Get_Name

procedure TdaTableDescription.Cleanup;
//#UC START# *479731C50290_55360B420250_var*
//#UC END# *479731C50290_55360B420250_var*
begin
//#UC START# *479731C50290_55360B420250_impl*
 FreeAndNil(f_FieldList);
 inherited;
//#UC END# *479731C50290_55360B420250_impl*
end;//TdaTableDescription.Cleanup

procedure TdaTableDescription.InitFields;
//#UC START# *47A042E100E2_55360B420250_var*
//#UC END# *47A042E100E2_55360B420250_var*
begin
//#UC START# *47A042E100E2_55360B420250_impl*
 inherited;
 f_FieldList := TdaFieldDescriptionList.MakeSorted(l3_dupError);
//#UC END# *47A042E100E2_55360B420250_impl*
end;//TdaTableDescription.InitFields

end.