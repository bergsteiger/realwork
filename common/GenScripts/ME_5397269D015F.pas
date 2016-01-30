unit atComparableList;

// Модуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atComparableList.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , l3_Base
 , DynamicDocListUnit
 , DynamicTreeUnit
 , BaseTypesUnit
 , DocumentUnit
 , SysUtils
 , Contnrs
;

type
 EInvalidStringFormat = class(Exception)
 end;//EInvalidStringFormat

 TatListElement = class(Tl3_Base)
  private
   f_DocId: Longword;
   f_Position: Longword;
   f_NodeType: TListNodeType;
   f_PositionType: TPositionType;
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   function IsEqual(const anOtherElement: TatListElement): Boolean; virtual;
   constructor Create(const aString: AnsiString); reintroduce; overload;
   constructor Create(const aNode: INodeBase); reintroduce; overload;
   function ToString: AnsiString; virtual;
 end;//TatListElement

 _ObjectListElement_ = TatListElement;
 _atTypedObjectList_Parent_ = TObjectList;
 {$Include atTypedObjectList.imp.pas}
 TatElementsList = class(_atTypedObjectList_)
 end;//TatElementsList

 TatComparableList = class(Tl3_Base)
  private
   f_Elements: TatElementsList;
  private
   procedure OnListNode(const aNode: INodeBase); virtual;
  protected
   constructor Create; reintroduce; overload;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aList: IDynList); reintroduce; overload;
   constructor Create(const aFileName: AnsiString); reintroduce; overload;
   function IsEqual(const anOtherList: TatComparableList): Boolean; virtual;
   procedure SaveToFile(const aFileName: AnsiString); virtual;
 end;//TatComparableList

implementation

uses
 l3ImplUses
 , atNodeHelper
 , atListHelper
 , atListEntryInfo
 , atPositionTypeConverter
 , atListNodeTypeConverter
 , Classes
;

const
 FIELD_DELIMITER: AnsiChar = ';';

function TatListElement.IsEqual(const anOtherElement: TatListElement): Boolean;
//#UC START# *539728B401BF_539726B801C6_var*
//#UC END# *539728B401BF_539726B801C6_var*
begin
//#UC START# *539728B401BF_539726B801C6_impl*
  Result := (Self.f_NodeType = anOtherElement.f_NodeType)
      AND (Self.f_DocId = anOtherElement.f_DocId)
      AND (Self.f_Position = anOtherElement.f_Position)
      AND (Self.f_PositionType = anOtherElement.f_PositionType);
//#UC END# *539728B401BF_539726B801C6_impl*
end;//TatListElement.IsEqual

constructor TatListElement.Create(const aString: AnsiString);
//#UC START# *5397290302AC_539726B801C6_var*
//#UC END# *5397290302AC_539726B801C6_var*
begin
//#UC START# *5397290302AC_539726B801C6_impl*
  inherited Create;
  //
  with TStringList.Create do
  try
    Delimiter := FIELD_DELIMITER;
    DelimitedText := aString;
    //
    if Count <> 4 then
      Raise EInvalidStringFormat.Create('Должно быть ровно 4 поля');

    f_NodeType := TatListNodeTypeConverter.Instance.ToValue(Strings[0]);
    f_DocId := StrToInt64(Strings[1]);
    f_PositionType := TatPositionTypeConverter.Instance.ToValue(Strings[2]);
    f_Position := StrToInt64(Strings[3]);
  finally
    Free;
  end;
//#UC END# *5397290302AC_539726B801C6_impl*
end;//TatListElement.Create

constructor TatListElement.Create(const aNode: INodeBase);
//#UC START# *5397291A00C7_539726B801C6_var*
//#UC END# *5397291A00C7_539726B801C6_var*
begin
//#UC START# *5397291A00C7_539726B801C6_impl*
  inherited Create;
  //
  f_NodeType := TListNodeType(aNode.GetType);

  if f_NodeType <> LNT_EDITIONS_GROUP then
    with TatListEntryInfo.Create(aNode) do
    try
      f_DocId := PID.rObjectId;
      f_PositionType := Entity.GetType;
      f_Position := Entity.GetPosition;
    finally
      Free;
    end;
//#UC END# *5397291A00C7_539726B801C6_impl*
end;//TatListElement.Create

function TatListElement.ToString: AnsiString;
//#UC START# *53972CAF0329_539726B801C6_var*
  const
    FORMAT_STR = '%s;%u;%s;%u';
//#UC END# *53972CAF0329_539726B801C6_var*
begin
//#UC START# *53972CAF0329_539726B801C6_impl*
  Result := Format(FORMAT_STR, [
    TatListNodeTypeConverter.Instance.ToName(f_NodeType),
    f_DocId,
    TatPositionTypeConverter.Instance.ToName(f_PositionType),
    f_Position]);
//#UC END# *53972CAF0329_539726B801C6_impl*
end;//TatListElement.ToString

{$If NOT Defined(DesignTimeLibrary)}
class function TatListElement.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_539726B801C6_var*
//#UC END# *47A6FEE600FC_539726B801C6_var*
begin
//#UC START# *47A6FEE600FC_539726B801C6_impl*
  Result := True;
//#UC END# *47A6FEE600FC_539726B801C6_impl*
end;//TatListElement.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TatListElement.ClearFields;
//#UC START# *5000565C019C_539726B801C6_var*
//#UC END# *5000565C019C_539726B801C6_var*
begin
//#UC START# *5000565C019C_539726B801C6_impl*
  f_NodeType := LNT_EDITIONS_GROUP;
  f_DocId := 0;
  f_PositionType := PT_BOOKMARK;
  f_Position := 0;
  //
  inherited;
//#UC END# *5000565C019C_539726B801C6_impl*
end;//TatListElement.ClearFields

{$Include atTypedObjectList.imp.pas}

constructor TatComparableList.Create(const aList: IDynList);
//#UC START# *53972BC4005B_5397269D015F_var*
//#UC END# *53972BC4005B_5397269D015F_var*
begin
//#UC START# *53972BC4005B_5397269D015F_impl*
  Create;
  //
  if aList <> nil then
    with TatList.Create(aList) do
    try
      TatNodeHelper.LoadNodes(FirstElement,
        65535,
        MaxInt,
        OnListNode);
    finally
      Free;
    end;
//#UC END# *53972BC4005B_5397269D015F_impl*
end;//TatComparableList.Create

constructor TatComparableList.Create(const aFileName: AnsiString);
//#UC START# *53972BE1000D_5397269D015F_var*
  var
    l_File : Text;
    l_Line : String;
//#UC END# *53972BE1000D_5397269D015F_var*
begin
//#UC START# *53972BE1000D_5397269D015F_impl*
  Create;
  //
  AssignFile(l_File, aFileName);
  try
    Reset(l_File);

    if Eof(l_File) then
      Exit;

    ReadLn(l_File, l_Line); //header

    while not Eof(l_File) do
    begin
      ReadLn(l_File, l_Line);
      f_Elements.Add(TatListElement.Create(l_Line));
    end;
  finally
    CloseFile(l_File);
  end;
//#UC END# *53972BE1000D_5397269D015F_impl*
end;//TatComparableList.Create

constructor TatComparableList.Create;
//#UC START# *53972BFF0358_5397269D015F_var*
//#UC END# *53972BFF0358_5397269D015F_var*
begin
//#UC START# *53972BFF0358_5397269D015F_impl*
  inherited;
  //
  f_Elements := TatElementsList.Create;
  f_Elements.OwnsObjects := True;
//#UC END# *53972BFF0358_5397269D015F_impl*
end;//TatComparableList.Create

function TatComparableList.IsEqual(const anOtherList: TatComparableList): Boolean;
//#UC START# *53972C140349_5397269D015F_var*
  var
    i : Integer;
//#UC END# *53972C140349_5397269D015F_var*
begin
//#UC START# *53972C140349_5397269D015F_impl*
  Result := Self.f_Elements.Count = anOtherList.f_Elements.Count;

  if Result then
    for i := 0 to f_Elements.Count-1 do
      if NOT Self.f_Elements.Items[i].IsEqual(anOtherList.f_Elements.Items[i]) then
      begin
        Result := False;
        Exit;
      end;
//#UC END# *53972C140349_5397269D015F_impl*
end;//TatComparableList.IsEqual

procedure TatComparableList.SaveToFile(const aFileName: AnsiString);
//#UC START# *53972CD501F1_5397269D015F_var*
  const
    CSV_HEADER : String = 'NodeType;Document ID;Position Type;Position';
  var
    l_File : Text;
    i : Integer;
//#UC END# *53972CD501F1_5397269D015F_var*
begin
//#UC START# *53972CD501F1_5397269D015F_impl*
  AssignFile(l_File, aFileName);
  try
    Rewrite(l_File);

    if f_Elements.Count > 0 then
    begin
      WriteLn(l_File, CSV_HEADER);
      for i := 0 to f_Elements.Count-1 do
        WriteLn(l_File, f_Elements.Items[i].ToString);
    end;
  finally
    CloseFile(l_File);
  end;
//#UC END# *53972CD501F1_5397269D015F_impl*
end;//TatComparableList.SaveToFile

procedure TatComparableList.OnListNode(const aNode: INodeBase);
//#UC START# *5397339A0021_5397269D015F_var*
//#UC END# *5397339A0021_5397269D015F_var*
begin
//#UC START# *5397339A0021_5397269D015F_impl*
  f_Elements.Add(TatListElement.Create(aNode));
//#UC END# *5397339A0021_5397269D015F_impl*
end;//TatComparableList.OnListNode

{$If NOT Defined(DesignTimeLibrary)}
class function TatComparableList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_5397269D015F_var*
//#UC END# *47A6FEE600FC_5397269D015F_var*
begin
//#UC START# *47A6FEE600FC_5397269D015F_impl*
  Result := True;
//#UC END# *47A6FEE600FC_5397269D015F_impl*
end;//TatComparableList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TatComparableList.ClearFields;
//#UC START# *5000565C019C_5397269D015F_var*
//#UC END# *5000565C019C_5397269D015F_var*
begin
//#UC START# *5000565C019C_5397269D015F_impl*
  FreeAndNil(f_Elements);
  //
  inherited;
//#UC END# *5000565C019C_5397269D015F_impl*
end;//TatComparableList.ClearFields

end.
