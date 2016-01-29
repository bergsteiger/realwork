unit daFieldDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daFieldDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::DataScheme::TdaFieldDescription
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
  daInterfaces
  ;

type
 TdaFieldDescription = class(Tl3ProtoObject, IdaFieldDescription)
 private
 // private fields
   f_Table : Pointer;
   f_Name : AnsiString;
   f_Description : AnsiString;
   f_Required : Boolean;
   f_DataType : TdaDataType;
   f_Index : Integer;
   f_Size : Integer;
 protected
 // realized methods
   function Get_Name: AnsiString;
   function Get_Description: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Required: Boolean;
   function Get_Table: IdaTableDescription;
   function Get_Index: Integer;
   procedure BindToTable(const aTable: IdaTableDescription = nil;
    anIndex: Integer = -1);
   function Get_SIze: Integer;
 public
 // public methods
   constructor Create(const aName: AnsiString;
     const aDesc: AnsiString;
     aRequired: Boolean;
     aType: TdaDataType;
     aSize: Integer = 0); reintroduce;
   class function Make(const aName: AnsiString;
     const aDesc: AnsiString;
     aRequired: Boolean;
     aType: TdaDataType;
     aSize: Integer = 0): IdaFieldDescription; reintroduce;
     {* Сигнатура фабрики TdaFieldDescription.Make }
 end;//TdaFieldDescription

implementation

// start class TdaFieldDescription

constructor TdaFieldDescription.Create(const aName: AnsiString;
  const aDesc: AnsiString;
  aRequired: Boolean;
  aType: TdaDataType;
  aSize: Integer = 0);
//#UC START# *5538D15A03E5_5538D0A902AF_var*
//#UC END# *5538D15A03E5_5538D0A902AF_var*
begin
//#UC START# *5538D15A03E5_5538D0A902AF_impl*
 inherited Create;
 f_Name := aName;
 f_Description := aDesc;
 f_Required := aRequired;
 f_DataType := aType;
 f_Size := aSize;
//#UC END# *5538D15A03E5_5538D0A902AF_impl*
end;//TdaFieldDescription.Create

class function TdaFieldDescription.Make(const aName: AnsiString;
  const aDesc: AnsiString;
  aRequired: Boolean;
  aType: TdaDataType;
  aSize: Integer = 0): IdaFieldDescription;
var
 l_Inst : TdaFieldDescription;
begin
 l_Inst := Create(aName, aDesc, aRequired, aType, aSize);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdaFieldDescription.Get_Name: AnsiString;
//#UC START# *5538AA34030F_5538D0A902AFget_var*
//#UC END# *5538AA34030F_5538D0A902AFget_var*
begin
//#UC START# *5538AA34030F_5538D0A902AFget_impl*
 Result := f_Name;
//#UC END# *5538AA34030F_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Name

function TdaFieldDescription.Get_Description: AnsiString;
//#UC START# *5538AA4302F7_5538D0A902AFget_var*
//#UC END# *5538AA4302F7_5538D0A902AFget_var*
begin
//#UC START# *5538AA4302F7_5538D0A902AFget_impl*
 Result := f_Description;
//#UC END# *5538AA4302F7_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Description

function TdaFieldDescription.Get_DataType: TdaDataType;
//#UC START# *5538AA86026D_5538D0A902AFget_var*
//#UC END# *5538AA86026D_5538D0A902AFget_var*
begin
//#UC START# *5538AA86026D_5538D0A902AFget_impl*
 Result := f_DataType;
//#UC END# *5538AA86026D_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_DataType

function TdaFieldDescription.Get_Required: Boolean;
//#UC START# *5538AAA000DD_5538D0A902AFget_var*
//#UC END# *5538AAA000DD_5538D0A902AFget_var*
begin
//#UC START# *5538AAA000DD_5538D0A902AFget_impl*
 Result := f_Required;
//#UC END# *5538AAA000DD_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Required

function TdaFieldDescription.Get_Table: IdaTableDescription;
//#UC START# *5538AAB4012A_5538D0A902AFget_var*
//#UC END# *5538AAB4012A_5538D0A902AFget_var*
begin
//#UC START# *5538AAB4012A_5538D0A902AFget_impl*
 Result := IdaTableDescription(f_Table);
//#UC END# *5538AAB4012A_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Table

function TdaFieldDescription.Get_Index: Integer;
//#UC START# *5538AADD0314_5538D0A902AFget_var*
//#UC END# *5538AADD0314_5538D0A902AFget_var*
begin
//#UC START# *5538AADD0314_5538D0A902AFget_impl*
 Result := f_Index;
//#UC END# *5538AADD0314_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Index

procedure TdaFieldDescription.BindToTable(const aTable: IdaTableDescription = nil;
  anIndex: Integer = -1);
//#UC START# *5538AB95021E_5538D0A902AF_var*
//#UC END# *5538AB95021E_5538D0A902AF_var*
begin
//#UC START# *5538AB95021E_5538D0A902AF_impl*
 f_Table := Pointer(aTable);
 f_Index := anIndex;
//#UC END# *5538AB95021E_5538D0A902AF_impl*
end;//TdaFieldDescription.BindToTable

function TdaFieldDescription.Get_SIze: Integer;
//#UC START# *553A064A03B1_5538D0A902AFget_var*
//#UC END# *553A064A03B1_5538D0A902AFget_var*
begin
//#UC START# *553A064A03B1_5538D0A902AFget_impl*
 Result := f_Size;
//#UC END# *553A064A03B1_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_SIze

end.