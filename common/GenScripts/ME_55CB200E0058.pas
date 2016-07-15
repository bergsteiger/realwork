unit daTableDescription;

// Модуль: "w:\common\components\rtl\Garant\DA\daTableDescription.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "daTableDescription" MUID: (55CB200E0058)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , daFieldDescriptionList
;

type
 TdaTableDescription = class(Tl3ProtoObject, IdaTableDescription)
  private
   f_Description: AnsiString;
   f_IsDublicate: Boolean;
   f_IsFake: Boolean;
   f_FieldList: TdaFieldDescriptionList;
   f_SQLName: AnsiString;
   f_Scheme: AnsiString;
   f_IsTree: Boolean;
   f_Code: AnsiString;
   f_FamilyID: TdaFamilyID;
   f_Kind: TdaTables;
  protected
   function Get_Description: AnsiString;
   function Get_IsDublicate: Boolean;
   function Get_IsFake: Boolean;
   function Get_Kind: TdaTables;
   function Get_Field(const FIeldName: AnsiString): IdaFieldDescription;
   function Get_SQLName: AnsiString;
   function Get_Scheme: AnsiString;
   function FieldByIndex(anIndex: Integer): IdaFieldDescription;
   function Get_FieldsCount: Integer;
   function Get_FieldsCountWithoutTree: Integer;
   function Get_IsTree: Boolean;
   function Get_Code: AnsiString;
   function Get_FamilyID: TdaFamilyID;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create(aKind: TdaTables;
    const aSQLName: AnsiString;
    const aDescription: AnsiString;
    const aCode: AnsiString;
    aFamilyID: TdaFamilyID;
    const aScheme: AnsiString = '';
    aDublicate: Boolean = False;
    aFake: Boolean = False;
    aIsTree: Boolean = False); reintroduce;
   procedure AddField(const aField: IdaFieldDescription);
   procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
  public
   property Kind: TdaTables
    read f_Kind;
 end;//TdaTableDescription

implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
 , Classes
 , l3Base
;

function CompareFields(Item1: Pointer;
 Item2: Pointer): Integer;
//#UC START# *55CB2045030F_55CB200E0058_var*
//#UC END# *55CB2045030F_55CB200E0058_var*
begin
//#UC START# *55CB2045030F_55CB200E0058_impl*
 Result := IdaFieldDescription(Item1).Index - IdaFieldDescription(Item2).Index;
//#UC END# *55CB2045030F_55CB200E0058_impl*
end;//CompareFields

constructor TdaTableDescription.Create(aKind: TdaTables;
 const aSQLName: AnsiString;
 const aDescription: AnsiString;
 const aCode: AnsiString;
 aFamilyID: TdaFamilyID;
 const aScheme: AnsiString = '';
 aDublicate: Boolean = False;
 aFake: Boolean = False;
 aIsTree: Boolean = False);
//#UC START# *55360BAB0116_55360B420250_var*
//#UC END# *55360BAB0116_55360B420250_var*
begin
//#UC START# *55360BAB0116_55360B420250_impl*
 inherited Create;
 f_Kind := aKind;
 f_Description := aDescription;
 f_IsDublicate := aDublicate;
 f_IsFake := aFake;
 f_SQLName := aSQLName;
 f_Scheme := aScheme;
 f_IsTree := aIsTree;
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
//#UC END# *55379DA40290_55360B420250get_impl*
end;//TdaTableDescription.Get_Field

procedure TdaTableDescription.IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
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

function TdaTableDescription.Get_SQLName: AnsiString;
//#UC START# *5608EE130006_55360B420250get_var*
//#UC END# *5608EE130006_55360B420250get_var*
begin
//#UC START# *5608EE130006_55360B420250get_impl*
 Result := f_SQLName;
//#UC END# *5608EE130006_55360B420250get_impl*
end;//TdaTableDescription.Get_SQLName

function TdaTableDescription.Get_Scheme: AnsiString;
//#UC START# *566572560127_55360B420250get_var*
//#UC END# *566572560127_55360B420250get_var*
begin
//#UC START# *566572560127_55360B420250get_impl*
 Result := f_Scheme;
//#UC END# *566572560127_55360B420250get_impl*
end;//TdaTableDescription.Get_Scheme

function TdaTableDescription.FieldByIndex(anIndex: Integer): IdaFieldDescription;
//#UC START# *569F6ADC0330_55360B420250_var*
var
 l_Result: IdaFieldDescription;

 function lp_Find(aField: IdaFieldDescription): Boolean;
 begin
  Result := aField.Index <> anIndex;
  if not Result then
   l_Result := aField;
 end;

//#UC END# *569F6ADC0330_55360B420250_var*
begin
//#UC START# *569F6ADC0330_55360B420250_impl*
 l_Result := nil;
 IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@lp_Find));
 Result := l_Result;
//#UC END# *569F6ADC0330_55360B420250_impl*
end;//TdaTableDescription.FieldByIndex

function TdaTableDescription.Get_FieldsCount: Integer;
//#UC START# *56A0C27502A5_55360B420250get_var*
//#UC END# *56A0C27502A5_55360B420250get_var*
begin
//#UC START# *56A0C27502A5_55360B420250get_impl*
 Result := f_FieldList.Count;
//#UC END# *56A0C27502A5_55360B420250get_impl*
end;//TdaTableDescription.Get_FieldsCount

function TdaTableDescription.Get_FieldsCountWithoutTree: Integer;
//#UC START# *56A1E93B0132_55360B420250get_var*
//#UC END# *56A1E93B0132_55360B420250get_var*
begin
//#UC START# *56A1E93B0132_55360B420250get_impl*
 Result := Get_FieldsCount;
 if f_IsTree then
  Dec(Result, 2);
//#UC END# *56A1E93B0132_55360B420250get_impl*
end;//TdaTableDescription.Get_FieldsCountWithoutTree

function TdaTableDescription.Get_IsTree: Boolean;
//#UC START# *56A1FDB80282_55360B420250get_var*
//#UC END# *56A1FDB80282_55360B420250get_var*
begin
//#UC START# *56A1FDB80282_55360B420250get_impl*
 Result := f_IsTree;
//#UC END# *56A1FDB80282_55360B420250get_impl*
end;//TdaTableDescription.Get_IsTree

function TdaTableDescription.Get_Code: AnsiString;
//#UC START# *576D062600B3_55360B420250get_var*
//#UC END# *576D062600B3_55360B420250get_var*
begin
//#UC START# *576D062600B3_55360B420250get_impl*
 Result := f_Code;
//#UC END# *576D062600B3_55360B420250get_impl*
end;//TdaTableDescription.Get_Code

function TdaTableDescription.Get_FamilyID: TdaFamilyID;
//#UC START# *577223F80158_55360B420250get_var*
//#UC END# *577223F80158_55360B420250get_var*
begin
//#UC START# *577223F80158_55360B420250get_impl*
 Result := f_FamilyID;
//#UC END# *577223F80158_55360B420250get_impl*
end;//TdaTableDescription.Get_FamilyID

procedure TdaTableDescription.Cleanup;
 {* Функция очистки полей объекта. }
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
