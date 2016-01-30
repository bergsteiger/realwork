unit htResultSet;

// Модуль: "w:\common\components\rtl\Garant\HT\htResultSet.pas"
// Стереотип: "SimpleClass"

{$Include htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 {$If NOT Defined(Nemesis)}
 , HT_Const
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_List
 {$IfEnd} // NOT Defined(Nemesis)
 , daFieldList
 , htInterfaces
 , daSelectFieldList
;

type
 ThtResultSet = class(Tl3ProtoObject, IdaResultSet, IdaResultBuffer)
  private
   f_SAB: SAB;
   f_CurrentPos: LongInt;
   f_Data: TAbstractList;
   f_Fields: TdaFieldList;
   f_DataConverter: IhtDataConverter;
   f_SabDescription: ThtSubItemDescriptionArray;
   f_FieldsDescription: TdaSelectFieldList;
   f_EOF: Boolean;
  protected
   procedure Next;
   function EOF: Boolean;
   function IsEmpty: Boolean;
   function Get_Field(const anAlias: AnsiString): IdaField;
   procedure RegisterField(const aField: IdaField);
   procedure UnregisterField(const aField: IdaField);
   function FieldBufferPtr(FieldIndex: Integer): Pointer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDataConverter: IhtDataConverter;
    const aSAB: SAB;
    aSelectFields: TdaSelectFieldList;
    Unidirectional: Boolean); reintroduce;
   class function Make(const aDataConverter: IhtDataConverter;
    const aSAB: SAB;
    aSelectFields: TdaSelectFieldList;
    Unidirectional: Boolean): IdaResultSet; reintroduce;
 end;//ThtResultSet

implementation

uses
 l3ImplUses
 , l3Base
 {$If NOT Defined(Nemesis)}
 , HT_DLL
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Err
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , dt_Types
 , htField
 , l3Types
;

constructor ThtResultSet.Create(const aDataConverter: IhtDataConverter;
 const aSAB: SAB;
 aSelectFields: TdaSelectFieldList;
 Unidirectional: Boolean);
//#UC START# *5591222303A9_559121CE0393_var*
var
 l_Mode: TOpenMode;
 l_Description : ThtSubItemDescriptionArray;
 l_IDX: Integer;
//#UC END# *5591222303A9_559121CE0393_var*
begin
//#UC START# *5591222303A9_559121CE0393_impl*
 inherited Create;
 f_DataConverter := aDataConverter;
 f_Fields := TdaFieldList.Make;

 if (htResultsType(aSab) <> Res_NProc) then
  Ht(htCopyResults(f_Sab, aSab));
 htOpenResults(f_Sab, ROPEN_BODY, nil, 0);
 SetLength(l_Description, htResultsItemCnt(f_Sab));
 htResultsItemParm(f_Sab, @l_Description[0]);
 SetLength(f_SabDescription, Length(l_Description));
 for l_IDX := Low(l_Description) to High(l_Description) do
  f_SabDescription[l_Description[l_IDX].nNum - 1] := l_Description[l_IDX];
 aSelectFields.SetRefTo(f_FieldsDescription);
 if not IsEmpty then
 begin
  f_CurrentPos := 1;
  l_Mode.OpenMode := ROPEN_BODY;
  l_Mode.Count := 0;
  l_Mode.FldArr := nil;
  f_Data := TAbstractList.Create(@f_Sab, l_Mode);
  f_Data.ReadForvard := Unidirectional;
  f_EOF := False;
 end
 else
 begin
  f_CurrentPos := 0;
  f_Data := nil;
  f_EOF := True;
 end;
//#UC END# *5591222303A9_559121CE0393_impl*
end;//ThtResultSet.Create

class function ThtResultSet.Make(const aDataConverter: IhtDataConverter;
 const aSAB: SAB;
 aSelectFields: TdaSelectFieldList;
 Unidirectional: Boolean): IdaResultSet;
var
 l_Inst : ThtResultSet;
begin
 l_Inst := Create(aDataConverter, aSAB, aSelectFields, Unidirectional);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtResultSet.Make

procedure ThtResultSet.Next;
//#UC START# *5549C44C037A_559121CE0393_var*
//#UC END# *5549C44C037A_559121CE0393_var*
begin
//#UC START# *5549C44C037A_559121CE0393_impl*
 Inc(f_CurrentPos);
 if f_CurrentPos > f_SAB.GFoundCnt then
 begin
  f_CurrentPos := f_SAB.GFoundCnt;
  f_EOF := True;
 end
 else
  f_EOF := False;
//#UC END# *5549C44C037A_559121CE0393_impl*
end;//ThtResultSet.Next

function ThtResultSet.EOF: Boolean;
//#UC START# *5549C45A025C_559121CE0393_var*
//#UC END# *5549C45A025C_559121CE0393_var*
begin
//#UC START# *5549C45A025C_559121CE0393_impl*
 Result := f_EOF;
//#UC END# *5549C45A025C_559121CE0393_impl*
end;//ThtResultSet.EOF

function ThtResultSet.IsEmpty: Boolean;
//#UC START# *558BF63203D7_559121CE0393_var*
//#UC END# *558BF63203D7_559121CE0393_var*
begin
//#UC START# *558BF63203D7_559121CE0393_impl*
 Result := f_SAB.GFoundCnt = 0;
//#UC END# *558BF63203D7_559121CE0393_impl*
end;//ThtResultSet.IsEmpty

function ThtResultSet.Get_Field(const anAlias: AnsiString): IdaField;
//#UC START# *5590FD57027D_559121CE0393get_var*
var
 l_IDX: Integer;
//#UC END# *5590FD57027D_559121CE0393get_var*
begin
//#UC START# *5590FD57027D_559121CE0393get_impl*
 if f_Fields.FindData(anAlias, l_IDX, l3_siUnsorted) then
  Result := f_Fields[l_IDX]
 else
  if f_FieldsDescription.FindData(anAlias, l_IDX) then
   Result := ThtField.Make(Self, f_DataConverter, f_FieldsDescription[l_IDX], f_SabDescription[l_IDX])
  else
   Result := nil;
//#UC END# *5590FD57027D_559121CE0393get_impl*
end;//ThtResultSet.Get_Field

procedure ThtResultSet.RegisterField(const aField: IdaField);
//#UC START# *55A63E22019B_559121CE0393_var*
var
 l_Dummy: Integer;
//#UC END# *55A63E22019B_559121CE0393_var*
begin
//#UC START# *55A63E22019B_559121CE0393_impl*
 Assert(f_Fields.FindData(aField, l_Dummy) = False);
 f_Fields.Add(aField);
//#UC END# *55A63E22019B_559121CE0393_impl*
end;//ThtResultSet.RegisterField

procedure ThtResultSet.UnregisterField(const aField: IdaField);
//#UC START# *55A63E3D0122_559121CE0393_var*
//#UC END# *55A63E3D0122_559121CE0393_var*
begin
//#UC START# *55A63E3D0122_559121CE0393_impl*
 f_Fields.Remove(aField);
//#UC END# *55A63E3D0122_559121CE0393_impl*
end;//ThtResultSet.UnregisterField

function ThtResultSet.FieldBufferPtr(FieldIndex: Integer): Pointer;
//#UC START# *55C8996702B1_559121CE0393_var*
//#UC END# *55C8996702B1_559121CE0393_var*
begin
//#UC START# *55C8996702B1_559121CE0393_impl*
 Result := Pointer(PAnsiChar(f_Data.GetItem(f_CurrentPos - 1)) + f_SabDescription[FieldIndex].wOff);
//#UC END# *55C8996702B1_559121CE0393_impl*
end;//ThtResultSet.FieldBufferPtr

procedure ThtResultSet.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_559121CE0393_var*
//#UC END# *479731C50290_559121CE0393_var*
begin
//#UC START# *479731C50290_559121CE0393_impl*
 FreeAndNil(f_Fields);
 htClearResults(f_SAB);
 l3ZeroMemory(@f_SAB, SizeOf(f_SAB));
 FreeAndNil(f_Data);
 f_DataConverter := nil;
 SetLength(f_SabDescription, 0);
 FreeAndNil(f_FieldsDescription);
 inherited;
//#UC END# *479731C50290_559121CE0393_impl*
end;//ThtResultSet.Cleanup

end.
