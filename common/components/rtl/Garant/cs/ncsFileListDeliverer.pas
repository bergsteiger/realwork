unit ncsFileListDeliverer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsFileListDeliverer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsFileListDeliverer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  SysUtils,
  l3ProtoObject,
  ddProgressObj,
  ncsMessageInterfaces,
  ncsFileDescHelper,
  ncsOneFileDelivererList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 EncsEmptyResults = class(Exception)
 end;//EncsEmptyResults

 TncsFileListDeliverer = class(Tl3ProtoObject)
 private
 // private fields
   f_Data : TncsOneFileDelivererList;
   f_Transporter : IncsTransporter;
   f_LocalPath : AnsiString;
   f_TaskID : AnsiString;
   f_Progressor : TddProgressObject;
 private
 // private methods
   procedure PrepareDescription(const aList: FileDescHelper);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   constructor Create(const aTransporter: IncsTransporter;
     aProgressor: TddProgressObject;
     const aTaskID: AnsiString;
     const aLocalPath: AnsiString); reintroduce;
   function Execute(const aList: FileDescHelper): Boolean;
 end;//TncsFileListDeliverer
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  ncsOneFileDeliverer,
  ncsFileDesc,
  l3Interfaces,
  l3FileUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsFileListDeliverer

procedure TncsFileListDeliverer.PrepareDescription(const aList: FileDescHelper);
//#UC START# *5472D96A03B7_546F398E0203_var*
var
 l_FileDesc: TncsFileDesc;
 l_Deliverer: TncsOneFileDeliverer;
 l_IDX: Integer;
 l_Total: Int64;
//#UC END# *5472D96A03B7_546F398E0203_var*
begin
//#UC START# *5472D96A03B7_546F398E0203_impl*
 if not ForceDirectories(f_LocalPath) then
  raise EInOutError.Create('Path not found');
 if not l3CheckPathWritable(f_LocalPath) then
  raise EInOutError.Create('Path is read only');
 l_Total := 0;
 for l_IDX := 0 to aList.Count - 1 do
 begin
  l_FileDesc := TncsFileDesc.Create;
  try
   l_FileDesc.SetTaggedData(aList.Files[l_IDX]);
   inc(l_Total, l_FileDesc.Size);
   l_Deliverer := TncsOneFileDeliverer.Create(f_Transporter, f_TaskID, f_LocalPath, l_FileDesc);
   try
    f_Data.Add(l_Deliverer)
   finally
    FreeAndNil(l_Deliverer);
   end;
   // Проверяем 1 файл.
  finally
   FreeAndNil(l_FileDesc);
  end;
 end;
 if Assigned(f_Progressor) then
  f_Progressor.Start(l_Total, 'Проверка файлов');
//#UC END# *5472D96A03B7_546F398E0203_impl*
end;//TncsFileListDeliverer.PrepareDescription

constructor TncsFileListDeliverer.Create(const aTransporter: IncsTransporter;
  aProgressor: TddProgressObject;
  const aTaskID: AnsiString;
  const aLocalPath: AnsiString);
//#UC START# *5472DC690380_546F398E0203_var*
//#UC END# *5472DC690380_546F398E0203_var*
begin
//#UC START# *5472DC690380_546F398E0203_impl*
 inherited Create;
 f_Transporter := aTransporter;
 aProgressor.SetRefTo(f_Progressor);
 f_TaskID := aTaskID;
 f_LocalPath := aLocalPath;
//#UC END# *5472DC690380_546F398E0203_impl*
end;//TncsFileListDeliverer.Create

function TncsFileListDeliverer.Execute(const aList: FileDescHelper): Boolean;
//#UC START# *546F3BE702A4_546F398E0203_var*
var
 l_IDX: Integer;
//#UC END# *546F3BE702A4_546F398E0203_var*
begin
//#UC START# *546F3BE702A4_546F398E0203_impl*
 f_Data.Clear;
 try
  Result := False;
  PrepareDescription(aList);
  if aList.Count = 0 then
   raise EncsEmptyResults.Create('Empty delivery list');
  if Assigned(f_Progressor) then
   f_Progressor.ProcessUpdate(piCurrent, 0, 'Передача файлов');
  if not f_Transporter.Processing then
   Exit;
  for l_IDX := 0 to f_Data.Count - 1 do
  begin
   if not f_Transporter.Processing then
    Exit;
   if not f_Data[l_IDX].DoProcess(f_Progressor) then
    Exit;
  end;
  Result := aList.Count > 0;
  if Result then
   for l_IDX := 0 to f_Data.Count - 1 do
    f_Data[l_IDX].CommitDelivery;
 finally
  f_Data.Clear;
  if Assigned(f_Progressor) then
   f_Progressor.Stop;
 end;
//#UC END# *546F3BE702A4_546F398E0203_impl*
end;//TncsFileListDeliverer.Execute

procedure TncsFileListDeliverer.Cleanup;
//#UC START# *479731C50290_546F398E0203_var*
//#UC END# *479731C50290_546F398E0203_var*
begin
//#UC START# *479731C50290_546F398E0203_impl*
 FreeAndNil(f_Progressor);
 FreeAndNil(f_Data);
 f_Transporter := nil;
 inherited;
//#UC END# *479731C50290_546F398E0203_impl*
end;//TncsFileListDeliverer.Cleanup

procedure TncsFileListDeliverer.InitFields;
//#UC START# *47A042E100E2_546F398E0203_var*
//#UC END# *47A042E100E2_546F398E0203_var*
begin
//#UC START# *47A042E100E2_546F398E0203_impl*
 inherited;
 f_Data := TncsOneFileDelivererList.Create;
//#UC END# *47A042E100E2_546F398E0203_impl*
end;//TncsFileListDeliverer.InitFields

{$IfEnd} //not Nemesis

end.