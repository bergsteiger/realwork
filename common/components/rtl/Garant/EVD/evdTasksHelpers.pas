unit evdTasksHelpers;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTasksHelpers.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3LongintList
 , l3Interfaces
 , Classes
 , l3ProtoObject
 , l3Variant
 , k2SizedMemoryPool
;

 (*
 MIntegerListTransformator = interface
  procedure ToList(aDest: Tl3LongintList);
  procedure FromList(aSource: Tl3LongintList); overload;
  procedure FromList(const aSource: Il3IntegerList); overload;
  function AsIntegerList: Il3IntegerList;
 end;//MIntegerListTransformator
 *)

type
 DocumentIDListHelper = interface
  ['{0ACFDC6E-9BDD-4EE0-AA18-98EE006B7348}']
  function Get_Count: Integer;
  function Get_Items(anIndex: Integer): Integer;
  procedure Save(aStream: TStream);
  procedure Load(aStream: TStream);
  procedure Clear;
  procedure Add(anItem: Integer);
  procedure Remove(anItem: Integer);
  procedure ToList(aDest: Tl3LongintList);
  procedure FromList(aSource: Tl3LongintList); overload;
  procedure FromList(const aSource: Il3IntegerList); overload;
  function AsIntegerList: Il3IntegerList;
  property Count: Integer
   read Get_Count;
  property Items[anIndex: Integer]: Integer
   read Get_Items;
 end;//DocumentIDListHelper

 StringListHelper = interface
  ['{F19CA673-59AD-46E7-8D1F-58BD23E54A95}']
  function Get_Count: Integer;
  function Get_Strings(anIndex: Integer): AnsiString;
  procedure Add(const anItem: AnsiString);
  procedure CopyTo(aDest: TStrings);
  procedure CopyFrom(aSource: TStrings);
  property Count: Integer
   read Get_Count;
  property Strings[anIndex: Integer]: AnsiString
   read Get_Strings;
   default;
 end;//StringListHelper

 TevdTagHelper = class(Tl3ProtoObject)
  private
   f_Value: Tl3Tag;
    {* Поле для свойства Value }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aValue: Tl3Tag); reintroduce;
  protected
   property Value: Tl3Tag
    read f_Value;
 end;//TevdTagHelper

 SABStreamHelper = interface(DocumentIDListHelper)
  ['{92B4DB96-8C8E-45B8-975A-CC383649BD96}']
  function Get_Size: Int64;
  procedure CopyFrom(Source: TStream;
   Count: Int64);
  procedure CopyTo(Dest: TStream;
   Count: Int64);
  property Size: Int64
   read Get_Size;
 end;//SABStreamHelper

 TAbstractStringListHelper = class(TevdTagHelper, StringListHelper)
  protected
   procedure DoAdd(const anItem: AnsiString); virtual; abstract;
   function DoGetStrings(anIndex: Integer): AnsiString; virtual; abstract;
   function Get_Count: Integer;
   function Get_Strings(anIndex: Integer): AnsiString;
   procedure Add(const anItem: AnsiString);
   procedure CopyTo(aDest: TStrings);
   procedure CopyFrom(aSource: TStrings);
 end;//TAbstractStringListHelper

 RegionIDListHelper = DocumentIDListHelper;

 TasksIDListHelper = interface(StringListHelper)
  ['{252940D3-C632-4B3D-97A5-04EB9A3533A9}']
 end;//TasksIDListHelper

 TDocumentIDListHelper = class(TevdTagHelper, DocumentIDListHelper)
  protected
   procedure Save(aStream: TStream);
   procedure Load(aStream: TStream);
   procedure Clear;
   procedure Add(anItem: Integer);
   procedure Remove(anItem: Integer);
   function Get_Count: Integer;
   function Get_Items(anIndex: Integer): Integer;
  public
   class function Make(aValue: Tl3Tag): DocumentIDListHelper; reintroduce;
   procedure ToList(aDest: Tl3LongintList);
   procedure FromList(aSource: Tl3LongintList); overload;
   procedure FromList(const aSource: Il3IntegerList); overload;
   function AsIntegerList: Il3IntegerList;
 end;//TDocumentIDListHelper

 AccGroupsIDListHelper = DocumentIDListHelper;

 TAccGroupsIDListHelper = TDocumentIDListHelper;

 TImportedDocListHelper = TDocumentIDListHelper;

 ImportedDocListHelper = DocumentIDListHelper;

 TSourceIDListHelper = TDocumentIDListHelper;

 SourceIDListHelper = DocumentIDListHelper;

 TDossierSourceIDListHelper = TDocumentIDListHelper;

 DossierSourceIDListHelper = DocumentIDListHelper;

 TDocTypesIDListHelper = TDocumentIDListHelper;

 DocTypesIDListHelper = DocumentIDListHelper;

 TFASSourceIDListHelper = TDocumentIDListHelper;

 FASSourceIDListHelper = DocumentIDListHelper;

 TRegionIDListHelper = TDocumentIDListHelper;

 TBelongsIDListHelper = TDocumentIDListHelper;

 BelongsIDListHelper = DocumentIDListHelper;

 ExcludeAccGroupsIDListHelper = DocumentIDListHelper;

 TExcludeAccGroupsIDListHelper = TDocumentIDListHelper;

 CommentsIDListHelper = DocumentIDListHelper;

 TCommentsIDListHelper = TDocumentIDListHelper;

 ExcludeDocTypesIDListHelper = DocumentIDListHelper;

 TExcludeDocTypesIDListHelper = TDocumentIDListHelper;

 ExcludeDocBasesIDListHelper = DocumentIDListHelper;

 TExcludeDocBasesIDListHelper = TDocumentIDListHelper;

 BasesIDListHelper = DocumentIDListHelper;

 TBasesIDListHelper = TDocumentIDListHelper;

 TInfoIDListHelper = TDocumentIDListHelper;

 InfoIDListHelper = DocumentIDListHelper;

 TSABStreamHelper = class(TDocumentIDListHelper, SABStreamHelper)
  protected
   function Get_Size: Int64;
  public
   class function Make(aValue: Tl3Tag): SABStreamHelper; reintroduce;
   procedure CopyFrom(Source: TStream;
    Count: Int64);
   procedure CopyTo(Dest: TStream;
    Count: Int64);
 end;//TSABStreamHelper

 TTasksIDListHelper = class(TAbstractStringListHelper, TasksIDListHelper)
  protected
   procedure DoAdd(const anItem: AnsiString); override;
   function DoGetStrings(anIndex: Integer): AnsiString; override;
  public
   class function Make(aValue: Tl3Tag): TasksIDListHelper; reintroduce;
 end;//TTasksIDListHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , Address_Const
 , k2Tags
 , l3InterfacedIntegerList
 , TaskID_Const
;

constructor TevdTagHelper.Create(aValue: Tl3Tag);
//#UC START# *53BD1BCF010B_53BFD54A01CC_var*
//#UC END# *53BD1BCF010B_53BFD54A01CC_var*
begin
//#UC START# *53BD1BCF010B_53BFD54A01CC_impl*
 inherited Create;
 f_Value := aValue;
 // - пока БЕЗ счётчика ссылок, пока НЕ НАЖРЁМСЯ
//#UC END# *53BD1BCF010B_53BFD54A01CC_impl*
end;//TevdTagHelper.Create

procedure TevdTagHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53BFD54A01CC_var*
//#UC END# *479731C50290_53BFD54A01CC_var*
begin
//#UC START# *479731C50290_53BFD54A01CC_impl*
 inherited;
//#UC END# *479731C50290_53BFD54A01CC_impl*
end;//TevdTagHelper.Cleanup

function TAbstractStringListHelper.Get_Count: Integer;
//#UC START# *53BFCD4C03BF_53EDDCC203B4get_var*
//#UC END# *53BFCD4C03BF_53EDDCC203B4get_var*
begin
//#UC START# *53BFCD4C03BF_53EDDCC203B4get_impl*
 Result := f_Value.ChildrenCount;
//#UC END# *53BFCD4C03BF_53EDDCC203B4get_impl*
end;//TAbstractStringListHelper.Get_Count

function TAbstractStringListHelper.Get_Strings(anIndex: Integer): AnsiString;
//#UC START# *53BFCD5501FC_53EDDCC203B4get_var*
//#UC END# *53BFCD5501FC_53EDDCC203B4get_var*
begin
//#UC START# *53BFCD5501FC_53EDDCC203B4get_impl*
 Result := DoGetStrings(anIndex);
//#UC END# *53BFCD5501FC_53EDDCC203B4get_impl*
end;//TAbstractStringListHelper.Get_Strings

procedure TAbstractStringListHelper.Add(const anItem: AnsiString);
//#UC START# *53BFCD800222_53EDDCC203B4_var*
//#UC END# *53BFCD800222_53EDDCC203B4_var*
begin
//#UC START# *53BFCD800222_53EDDCC203B4_impl*
 DoAdd(anItem);
//#UC END# *53BFCD800222_53EDDCC203B4_impl*
end;//TAbstractStringListHelper.Add

procedure TAbstractStringListHelper.CopyTo(aDest: TStrings);
//#UC START# *53BFCDAA0388_53EDDCC203B4_var*
var
 l_Index : Integer;
//#UC END# *53BFCDAA0388_53EDDCC203B4_var*
begin
//#UC START# *53BFCDAA0388_53EDDCC203B4_impl*
 aDest.Clear;
 for l_Index := 0 to Pred(f_Value.ChildrenCount) do
  aDest.Add(Self.Get_Strings(l_Index)); 
//#UC END# *53BFCDAA0388_53EDDCC203B4_impl*
end;//TAbstractStringListHelper.CopyTo

procedure TAbstractStringListHelper.CopyFrom(aSource: TStrings);
//#UC START# *53BFCE310249_53EDDCC203B4_var*
var
 l_Index : Integer;
//#UC END# *53BFCE310249_53EDDCC203B4_var*
begin
//#UC START# *53BFCE310249_53EDDCC203B4_impl*
 f_Value.DeleteChildren;
 for l_Index := 0 to Pred(aSource.Count) do
  Self.Add(aSource[l_Index]);
//#UC END# *53BFCE310249_53EDDCC203B4_impl*
end;//TAbstractStringListHelper.CopyFrom

class function TDocumentIDListHelper.Make(aValue: Tl3Tag): DocumentIDListHelper;
var
 l_Inst : TDocumentIDListHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocumentIDListHelper.Make

procedure TDocumentIDListHelper.Save(aStream: TStream);
//#UC START# *53BD20D702C0_53BD13DC0048_var*
var
 l_List : Tl3LongintList;
//#UC END# *53BD20D702C0_53BD13DC0048_var*
begin
//#UC START# *53BD20D702C0_53BD13DC0048_impl*
 l_List := Tl3LongintList.Create;
 try
  Self.ToList(l_List);
  l_List.Save(aStream);
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *53BD20D702C0_53BD13DC0048_impl*
end;//TDocumentIDListHelper.Save

procedure TDocumentIDListHelper.Load(aStream: TStream);
//#UC START# *53BD20ED0368_53BD13DC0048_var*
var
 l_List : Tl3LongintList;
//#UC END# *53BD20ED0368_53BD13DC0048_var*
begin
//#UC START# *53BD20ED0368_53BD13DC0048_impl*
 Clear;
 l_List := Tl3LongintList.Create;
 try
  l_List.Load(aStream);
  Self.FromList(l_List);
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *53BD20ED0368_53BD13DC0048_impl*
end;//TDocumentIDListHelper.Load

procedure TDocumentIDListHelper.Clear;
//#UC START# *53BD214603DA_53BD13DC0048_var*
//#UC END# *53BD214603DA_53BD13DC0048_var*
begin
//#UC START# *53BD214603DA_53BD13DC0048_impl*
 f_Value.DeleteChildren;
//#UC END# *53BD214603DA_53BD13DC0048_impl*
end;//TDocumentIDListHelper.Clear

procedure TDocumentIDListHelper.Add(anItem: Integer);
//#UC START# *53BD216B039D_53BD13DC0048_var*
var
 l_Addr : Tl3Tag;
//#UC END# *53BD216B039D_53BD13DC0048_var*
begin
//#UC START# *53BD216B039D_53BD13DC0048_impl*
 l_Addr := k2_typAddress.MakeTag.AsObject;
 l_Addr.IntA[k2_tiDocID] := anItem;
 f_Value.AddChild(l_Addr);
//#UC END# *53BD216B039D_53BD13DC0048_impl*
end;//TDocumentIDListHelper.Add

procedure TDocumentIDListHelper.Remove(anItem: Integer);
//#UC START# *53BD267000B9_53BD13DC0048_var*
var
 l_Child : Tl3Tag;
//#UC END# *53BD267000B9_53BD13DC0048_var*
begin
//#UC START# *53BD267000B9_53BD13DC0048_impl*
 l_Child := f_Value.rAtomEx([k2_tiChildren, k2_tiDocID, anItem]);
 //Assert(l_Child.IsValid);
 if l_Child.IsValid then
  f_Value.DeleteChild(l_Child);
//#UC END# *53BD267000B9_53BD13DC0048_impl*
end;//TDocumentIDListHelper.Remove

function TDocumentIDListHelper.Get_Count: Integer;
//#UC START# *53BD303603B8_53BD13DC0048get_var*
//#UC END# *53BD303603B8_53BD13DC0048get_var*
begin
//#UC START# *53BD303603B8_53BD13DC0048get_impl*
 Result := f_Value.ChildrenCount;
//#UC END# *53BD303603B8_53BD13DC0048get_impl*
end;//TDocumentIDListHelper.Get_Count

function TDocumentIDListHelper.Get_Items(anIndex: Integer): Integer;
//#UC START# *53BD303C009F_53BD13DC0048get_var*
//#UC END# *53BD303C009F_53BD13DC0048get_var*
begin
//#UC START# *53BD303C009F_53BD13DC0048get_impl*
 Result := f_Value.Child[anIndex].IntA[k2_tiDocID];
//#UC END# *53BD303C009F_53BD13DC0048get_impl*
end;//TDocumentIDListHelper.Get_Items

procedure TDocumentIDListHelper.ToList(aDest: Tl3LongintList);
//#UC START# *53DA2FCA03C8_53BD13DC0048_var*
var
 l_Index : Integer;
//#UC END# *53DA2FCA03C8_53BD13DC0048_var*
begin
//#UC START# *53DA2FCA03C8_53BD13DC0048_impl*
 aDest.Clear;
 for l_Index := 0 to Pred(f_Value.ChildrenCount) do
  aDest.Add(f_Value.Child[l_Index].IntA[k2_tiDocID]);
//#UC END# *53DA2FCA03C8_53BD13DC0048_impl*
end;//TDocumentIDListHelper.ToList

procedure TDocumentIDListHelper.FromList(aSource: Tl3LongintList);
//#UC START# *53DA307D03A7_53BD13DC0048_var*
var
 l_Index : Integer;
//#UC END# *53DA307D03A7_53BD13DC0048_var*
begin
//#UC START# *53DA307D03A7_53BD13DC0048_impl*
 Self.Clear;
 if Assigned(aSource) then
  for l_Index := 0 to Pred(aSource.Count) do
   Self.Add(aSource.Items[l_Index]);
//#UC END# *53DA307D03A7_53BD13DC0048_impl*
end;//TDocumentIDListHelper.FromList

procedure TDocumentIDListHelper.FromList(const aSource: Il3IntegerList);
//#UC START# *53DA30A10113_53BD13DC0048_var*
var
 l_Index : Integer;
//#UC END# *53DA30A10113_53BD13DC0048_var*
begin
//#UC START# *53DA30A10113_53BD13DC0048_impl*
 Self.Clear;
 if Assigned(aSource) then
  for l_Index := 0 to Pred(aSource.Count) do
   Self.Add(aSource.Items[l_Index]);
//#UC END# *53DA30A10113_53BD13DC0048_impl*
end;//TDocumentIDListHelper.FromList

function TDocumentIDListHelper.AsIntegerList: Il3IntegerList;
//#UC START# *53DA30C501BC_53BD13DC0048_var*
var
 l_List : Tl3InterfacedIntegerList;
 l_Index : Integer; 
//#UC END# *53DA30C501BC_53BD13DC0048_var*
begin
//#UC START# *53DA30C501BC_53BD13DC0048_impl*
 l_List := Tl3InterfacedIntegerList.Create;
 try
  Result := l_List;
  for l_Index := 0 to Pred(f_Value.ChildrenCount) do
   l_List.Add(f_Value.Child[l_Index].IntA[k2_tiDocID]);
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *53DA30C501BC_53BD13DC0048_impl*
end;//TDocumentIDListHelper.AsIntegerList

class function TSABStreamHelper.Make(aValue: Tl3Tag): SABStreamHelper;
var
 l_Inst : TSABStreamHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSABStreamHelper.Make

procedure TSABStreamHelper.CopyFrom(Source: TStream;
 Count: Int64);
//#UC START# *53B55ED6016D_53BD48A2009C_var*
var
 l_Pos : Int64;
 l_Count : Integer;
 l_CountToRead : Integer;
 l_Index : Integer;
 l_Item : Integer;
//#UC END# *53B55ED6016D_53BD48A2009C_var*
begin
//#UC START# *53B55ED6016D_53BD48A2009C_impl*
 Clear;
 if (Count > 0) then
 begin
  l_Pos := Source.Position;
  try
   Source.ReadBuffer(l_Count, SizeOf(l_Count));
  finally
   Source.Position := l_Pos;
  end;//try..finally
  if (l_Count = Count) then
   // - НОВЫЙ ФОРМАТ, читаем как список целых
   Load(Source)
  else
  begin
   // - СТАРЫЙ ФОРМАТ, читаем как "сырой поток" целых
   Assert(Count mod 4 = 0, 'Размер списка целыех не кратен размеру целого');
   Assert(Source.Size - l_Pos > Count, 'Размер списка целых меньше оставшегося размера потока');
   l_CountToRead := Count div 4;
   for l_Index := 0 to Pred(l_CountToRead) do
   begin
    Source.ReadBuffer(l_Item, SizeOf(l_Item));
    Self.Add(l_Item);
   end;//for l_Index
  end;//l_Count = Count
 end;//Count > 0
//#UC END# *53B55ED6016D_53BD48A2009C_impl*
end;//TSABStreamHelper.CopyFrom

procedure TSABStreamHelper.CopyTo(Dest: TStream;
 Count: Int64);
//#UC START# *53B55EF0025D_53BD48A2009C_var*
//#UC END# *53B55EF0025D_53BD48A2009C_var*
begin
//#UC START# *53B55EF0025D_53BD48A2009C_impl*
 if (Count > 0) then
  Save(Dest);
//#UC END# *53B55EF0025D_53BD48A2009C_impl*
end;//TSABStreamHelper.CopyTo

function TSABStreamHelper.Get_Size: Int64;
//#UC START# *53BD52D902BE_53BD48A2009Cget_var*
//#UC END# *53BD52D902BE_53BD48A2009Cget_var*
begin
//#UC START# *53BD52D902BE_53BD48A2009Cget_impl*
 Result := Get_Count;
//#UC END# *53BD52D902BE_53BD48A2009Cget_impl*
end;//TSABStreamHelper.Get_Size

class function TTasksIDListHelper.Make(aValue: Tl3Tag): TasksIDListHelper;
var
 l_Inst : TTasksIDListHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TTasksIDListHelper.Make

procedure TTasksIDListHelper.DoAdd(const anItem: AnsiString);
//#UC START# *53EDDCE10317_54646EB103D5_var*
var
 l_ID : Tl3Tag;
//#UC END# *53EDDCE10317_54646EB103D5_var*
begin
//#UC START# *53EDDCE10317_54646EB103D5_impl*
 l_ID := k2_typTaskID.MakeTag.AsObject;
 l_ID.StrA[k2_tiName] := anItem;
 f_Value.AddChild(l_ID);
//#UC END# *53EDDCE10317_54646EB103D5_impl*
end;//TTasksIDListHelper.DoAdd

function TTasksIDListHelper.DoGetStrings(anIndex: Integer): AnsiString;
//#UC START# *53F1FD130157_54646EB103D5_var*
//#UC END# *53F1FD130157_54646EB103D5_var*
begin
//#UC START# *53F1FD130157_54646EB103D5_impl*
 Result := f_Value.Child[anIndex].StrA[k2_tiName];
//#UC END# *53F1FD130157_54646EB103D5_impl*
end;//TTasksIDListHelper.DoGetStrings

end.
