unit daFieldDescription;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaFieldDescription" MUID: (5538D0A902AF)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TdaFieldDescription = class(Tl3ProtoObject, IdaFieldDescription)
  private
   f_Table: Pointer;
   f_SQLName: AnsiString;
   f_Description: AnsiString;
   f_Required: Boolean;
   f_DataType: TdaDataType;
   f_Index: Integer;
   f_Size: Integer;
  protected
   function Get_SQLName: AnsiString;
   function Get_Description: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Required: Boolean;
   function Get_Table: IdaTableDescription;
   function Get_Index: Integer;
   procedure BindToTable(const aTable: IdaTableDescription = nil;
    anIndex: Integer = -1);
   function Get_Size: Integer;
  public
   constructor Create(const aSQLName: AnsiString;
    const aDesc: AnsiString;
    aRequired: Boolean;
    aType: TdaDataType;
    aSize: Integer = 0); reintroduce;
   class function Make(const aSQLName: AnsiString;
    const aDesc: AnsiString;
    aRequired: Boolean;
    aType: TdaDataType;
    aSize: Integer = 0): IdaFieldDescription; reintroduce;
 end;//TdaFieldDescription

implementation

uses
 l3ImplUses
;

constructor TdaFieldDescription.Create(const aSQLName: AnsiString;
 const aDesc: AnsiString;
 aRequired: Boolean;
 aType: TdaDataType;
 aSize: Integer = 0);
//#UC START# *5538D15A03E5_5538D0A902AF_var*
//#UC END# *5538D15A03E5_5538D0A902AF_var*
begin
//#UC START# *5538D15A03E5_5538D0A902AF_impl*
 inherited Create;
 f_SQLName := aSQLName;
 f_Description := aDesc;
 f_Required := aRequired;
 f_DataType := aType;
 f_Size := aSize;
//#UC END# *5538D15A03E5_5538D0A902AF_impl*
end;//TdaFieldDescription.Create

class function TdaFieldDescription.Make(const aSQLName: AnsiString;
 const aDesc: AnsiString;
 aRequired: Boolean;
 aType: TdaDataType;
 aSize: Integer = 0): IdaFieldDescription;
var
 l_Inst : TdaFieldDescription;
begin
 l_Inst := Create(aSQLName, aDesc, aRequired, aType, aSize);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdaFieldDescription.Make

function TdaFieldDescription.Get_SQLName: AnsiString;
//#UC START# *5538AA34030F_5538D0A902AFget_var*
//#UC END# *5538AA34030F_5538D0A902AFget_var*
begin
//#UC START# *5538AA34030F_5538D0A902AFget_impl*
 Result := f_SQLName;
//#UC END# *5538AA34030F_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_SQLName

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

function TdaFieldDescription.Get_Size: Integer;
//#UC START# *553A064A03B1_5538D0A902AFget_var*
//#UC END# *553A064A03B1_5538D0A902AFget_var*
begin
//#UC START# *553A064A03B1_5538D0A902AFget_impl*
 Result := f_Size;
//#UC END# *553A064A03B1_5538D0A902AFget_impl*
end;//TdaFieldDescription.Get_Size

end.
