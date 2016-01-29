unit nsUserDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsUserDataObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::UsersDataObjects::TnsUserDataObject
//
// Объект данных для нод дерева пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  l3Interfaces,
  bsInterfaces,
  evPersistentDataObjectEx,
  l3IID,
  evPersistentDataObject,
  nevBase,
  evdInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TnsUserDataObject = class(TevPersistentDataObjectEx)
  {* Объект данных для нод дерева пользователей }
 private
 // private fields
   f_Inited : Boolean;
    {* Данные зачитаны в поток.}
   f_List : IbsSelectedUsers;
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* метод для реализации QueryInterface (Для перекрытия в потомках) }
   function DataObjectClass: RevDataObject; override;
   function GetIsQuestionNeedBeforeFlush: Boolean; override;
   function DoStore(aFormat: TnevFormat;
    const aPool: IStream;
    const aFilters: InevTagGenerator;
    aFlags: TevdStoreFlags): Boolean; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IbsSelectedUsers); reintroduce;
   class function Make(const aList: IbsSelectedUsers): IDataObject; reintroduce;
 end;//TnsUserDataObject
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  nevTools,
  evTypes,
  l3Base,
  Classes,
  nsUserInterfacedDataObject,
  l3Types,
  k2Tags,
  evdNativeWriter,
  Document_Const,
  TextPara_Const
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TnsUserDataObject

constructor TnsUserDataObject.Create(const aList: IbsSelectedUsers);
//#UC START# *49F56D450147_49F56C06023C_var*
var
 l_OH : InevObjectHolder;
//#UC END# *49F56D450147_49F56C06023C_var*
begin
//#UC START# *49F56D450147_49F56C06023C_impl*
 f_Inited := false;
 f_List := aList;
 l_OH := Holder;
 try
  inherited Create(nil, true, cf_EverestBin,
                   l_OH.TagReader, l_OH.TagWriter,
                   l3FormatArray([cf_EverestBin, cf_RTF, cf_UnicodeText,
                               cf_Text, cf_OEMText]),
                   nil);
 finally
  l_OH := nil;
 end;//try..finally
//#UC END# *49F56D450147_49F56C06023C_impl*
end;//TnsUserDataObject.Create

class function TnsUserDataObject.Make(const aList: IbsSelectedUsers): IDataObject;
var
 l_Inst : TnsUserDataObject;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst As IDataObject;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsUserDataObject.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *48F475350256_49F56C06023C_var*
//#UC END# *48F475350256_49F56C06023C_var*
begin
//#UC START# *48F475350256_49F56C06023C_impl*
 if IID.EQ(IbsSelectedUsers) then
 begin
  Result.SetOk;
  IbsSelectedUsers(Obj) := f_List;
 end//IID.EQ(INodesClipboard)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *48F475350256_49F56C06023C_impl*
end;//TnsUserDataObject.COMQueryInterface

function TnsUserDataObject.DataObjectClass: RevDataObject;
//#UC START# *48F4795901B5_49F56C06023C_var*
//#UC END# *48F4795901B5_49F56C06023C_var*
begin
//#UC START# *48F4795901B5_49F56C06023C_impl*
 Result := TnsUserInterfacedDataObject;
//#UC END# *48F4795901B5_49F56C06023C_impl*
end;//TnsUserDataObject.DataObjectClass

function TnsUserDataObject.GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *48F4818300A5_49F56C06023C_var*
//#UC END# *48F4818300A5_49F56C06023C_var*
begin
//#UC START# *48F4818300A5_49F56C06023C_impl*
 Result := Assigned(f_List) and (f_List.Count > 1000);
//#UC END# *48F4818300A5_49F56C06023C_impl*
end;//TnsUserDataObject.GetIsQuestionNeedBeforeFlush

function TnsUserDataObject.DoStore(aFormat: TnevFormat;
  const aPool: IStream;
  const aFilters: InevTagGenerator;
  aFlags: TevdStoreFlags): Boolean;
//#UC START# *48F481B6035B_49F56C06023C_var*
var
 l_Writer: TevdNativeWriter;
 l_IDX: Integer;
//#UC END# *48F481B6035B_49F56C06023C_var*
begin
//#UC START# *48F481B6035B_49F56C06023C_impl*
 if not f_Inited then
 begin
  l_Writer := TevdNativeWriter.Create;
  try
   l_Writer.Filer.Mode := l3_fmWrite;
   if aFormat = Format then
    l_Writer.Filer.COMStream := aPool As IStream
   else
    l_Writer.Filer.COMStream := Self As IStream;
   Result := True;
   with l_Writer do
   begin
    Start;
    StartChild(k2_typDocument);
    for l_IDX := 0 to f_List.Count - 1 do
    begin
     StartChild(k2_typTextPara);
     AddStringAtom(k2_tiText, f_List.Name[l_IDX].AsWStr);
     Finish;
    end;
    Finish;
    Finish;
   end;
  finally
   l3Free(l_Writer);
  end;
  f_Inited := true;
  if aFormat = Format then
  begin
   Result := True;
   Exit;
  end;
 end;//not f_Inited
 Result := inherited DoStore(aFormat, aPool, aFilters, aFlags);
//#UC END# *48F481B6035B_49F56C06023C_impl*
end;//TnsUserDataObject.DoStore

procedure TnsUserDataObject.ClearFields;
 {-}
begin
 {$If defined(Admin)}
 f_List := nil;
 {$IfEnd} //Admin
 inherited;
end;//TnsUserDataObject.ClearFields

{$IfEnd} //Admin

end.