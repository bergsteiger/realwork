unit caResultSet;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caResultSet.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaResultSet" MUID: (56DFD1470338)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daFieldList
 , daSelectFieldList
;

type
 TcaResultSet = class(Tl3ProtoObject, IdaResultSet, IdaResultBuffer)
  private
   f_HTResultSet: IdaResultSet;
   f_PGResultSet: IdaResultSet;
   f_Fields: TdaFieldList;
   f_FieldsDescription: TdaSelectFieldList;
  protected
   procedure Next;
   function EOF: Boolean;
   function IsEmpty: Boolean;
   function Get_Field(const anAlias: AnsiString): IdaField;
   procedure RegisterField(const aField: IdaField);
   procedure UnregisterField(const aField: IdaField);
   function FieldBufferPtr(FieldIndex: Integer): Pointer;
   function CalcRecordCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFieldsDescription: TdaSelectFieldList;
    const aHTResultSet: IdaResultSet;
    const aPGResultSet: IdaResultSet); reintroduce;
   class function Make(aFieldsDescription: TdaSelectFieldList;
    const aHTResultSet: IdaResultSet;
    const aPGResultSet: IdaResultSet): IdaResultSet; reintroduce;
 end;//TcaResultSet
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , caField
 //#UC START# *56DFD1470338impl_uses*
 //#UC END# *56DFD1470338impl_uses*
;

constructor TcaResultSet.Create(aFieldsDescription: TdaSelectFieldList;
 const aHTResultSet: IdaResultSet;
 const aPGResultSet: IdaResultSet);
//#UC START# *56DFDC4B0032_56DFD1470338_var*
//#UC END# *56DFDC4B0032_56DFD1470338_var*
begin
//#UC START# *56DFDC4B0032_56DFD1470338_impl*
 inherited Create;
 f_HTResultSet := aHTResultSet;
 f_PGResultSet := aPGResultSet;
 f_Fields := TdaFieldList.Make;
 aFieldsDescription.SetRefTo(f_FieldsDescription);
//#UC END# *56DFDC4B0032_56DFD1470338_impl*
end;//TcaResultSet.Create

class function TcaResultSet.Make(aFieldsDescription: TdaSelectFieldList;
 const aHTResultSet: IdaResultSet;
 const aPGResultSet: IdaResultSet): IdaResultSet;
var
 l_Inst : TcaResultSet;
begin
 l_Inst := Create(aFieldsDescription, aHTResultSet, aPGResultSet);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaResultSet.Make

procedure TcaResultSet.Next;
//#UC START# *5549C44C037A_56DFD1470338_var*
//#UC END# *5549C44C037A_56DFD1470338_var*
begin
//#UC START# *5549C44C037A_56DFD1470338_impl*
 f_HTResultSet.Next;
 f_PGResultSet.Next;
//#UC END# *5549C44C037A_56DFD1470338_impl*
end;//TcaResultSet.Next

function TcaResultSet.EOF: Boolean;
//#UC START# *5549C45A025C_56DFD1470338_var*
//#UC END# *5549C45A025C_56DFD1470338_var*
begin
//#UC START# *5549C45A025C_56DFD1470338_impl*
 Result := f_HTResultSet.EOF;
 Assert(Result = f_PGResultSet.EOF);
//#UC END# *5549C45A025C_56DFD1470338_impl*
end;//TcaResultSet.EOF

function TcaResultSet.IsEmpty: Boolean;
//#UC START# *558BF63203D7_56DFD1470338_var*
//#UC END# *558BF63203D7_56DFD1470338_var*
begin
//#UC START# *558BF63203D7_56DFD1470338_impl*
 Result := f_HTResultSet.IsEmpty;
 Assert(Result = f_PGResultSet.IsEmpty);
//#UC END# *558BF63203D7_56DFD1470338_impl*
end;//TcaResultSet.IsEmpty

function TcaResultSet.Get_Field(const anAlias: AnsiString): IdaField;
//#UC START# *5590FD57027D_56DFD1470338get_var*
var
 l_IDX: Integer;
//#UC END# *5590FD57027D_56DFD1470338get_var*
begin
//#UC START# *5590FD57027D_56DFD1470338get_impl*
 if f_Fields.FindData(anAlias, l_IDX, l3_siUnsorted) then
  Result := f_Fields[l_IDX]
 else
  if f_FieldsDescription.FindData(anAlias, l_IDX) then
   Result := TcaField.Make(Self, f_HTResultSet.Field[anAlias], f_PGResultSet.Field[anAlias])
  else
   Result := nil;
//#UC END# *5590FD57027D_56DFD1470338get_impl*
end;//TcaResultSet.Get_Field

procedure TcaResultSet.RegisterField(const aField: IdaField);
//#UC START# *55A63E22019B_56DFD1470338_var*
var
 l_Dummy: Integer;
//#UC END# *55A63E22019B_56DFD1470338_var*
begin
//#UC START# *55A63E22019B_56DFD1470338_impl*
 Assert(f_Fields.FindData(aField, l_Dummy) = False);
 f_Fields.Add(aField);
//#UC END# *55A63E22019B_56DFD1470338_impl*
end;//TcaResultSet.RegisterField

procedure TcaResultSet.UnregisterField(const aField: IdaField);
//#UC START# *55A63E3D0122_56DFD1470338_var*
//#UC END# *55A63E3D0122_56DFD1470338_var*
begin
//#UC START# *55A63E3D0122_56DFD1470338_impl*
 f_Fields.Remove(aField);
//#UC END# *55A63E3D0122_56DFD1470338_impl*
end;//TcaResultSet.UnregisterField

function TcaResultSet.FieldBufferPtr(FieldIndex: Integer): Pointer;
//#UC START# *55C8996702B1_56DFD1470338_var*
//#UC END# *55C8996702B1_56DFD1470338_var*
begin
//#UC START# *55C8996702B1_56DFD1470338_impl*
 Result := nil;
 Assert(False, 'Никогда не должны попасть сюда');
//#UC END# *55C8996702B1_56DFD1470338_impl*
end;//TcaResultSet.FieldBufferPtr

function TcaResultSet.CalcRecordCount: Integer;
//#UC START# *576278A800EA_56DFD1470338_var*
//#UC END# *576278A800EA_56DFD1470338_var*
begin
//#UC START# *576278A800EA_56DFD1470338_impl*
 Result := f_HTResultSet.CalcRecordCount;
 Assert(Result = f_PGResultSet.CalcRecordCount);
//#UC END# *576278A800EA_56DFD1470338_impl*
end;//TcaResultSet.CalcRecordCount

procedure TcaResultSet.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56DFD1470338_var*
//#UC END# *479731C50290_56DFD1470338_var*
begin
//#UC START# *479731C50290_56DFD1470338_impl*
 f_HTResultSet := nil;
 f_PGResultSet := nil;
 FreeAndNil(f_Fields);
 FreeAndNil(f_FieldsDescription);
 inherited;
//#UC END# *479731C50290_56DFD1470338_impl*
end;//TcaResultSet.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
