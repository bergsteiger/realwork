unit nsToMSWordOp;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/nsToMSWordOp.pas"
// Начат: 2009/01/14 09:35:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::View::Common::TnsToMSWordOp
//
// Экспорт в ворд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsToMSWordExportKind = (
  {* Куда экспортировать }
   mswekNewFile // В новый файл
 , mswekActiveWindow // В активное окно
 );//TnsToMSWordExportKind

 TnsToMSWordOp = class
  {* Экспорт в ворд }
 public
 // public methods
   class procedure Test(const aParams: IvcmTestParamsPrim);
   class function Execute(const aFilePath: Il3CString;
    aKind: TnsToMSWordExportKind): Boolean; overload; 
   class function Execute(const aFilePath: Il3CString;
    const aParams: IvcmExecuteParamsPrim): Boolean; overload; 
 end;//TnsToMSWordOp
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsExternalObjectPrim
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsToMSWordOp

class procedure TnsToMSWordOp.Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4975FB3102A5_496DA60C03CA_var*
//#UC END# *4975FB3102A5_496DA60C03CA_var*
begin
//#UC START# *4975FB3102A5_496DA60C03CA_impl*
 with aParams.Op.SubItems do
  if Count = 0 then
  begin
   Add(vcmCStr(str_MSWordNewFile));
   Add(vcmCStr(str_MSWordActiveWindow));
  end;
//#UC END# *4975FB3102A5_496DA60C03CA_impl*
end;//TnsToMSWordOp.Test

class function TnsToMSWordOp.Execute(const aFilePath: Il3CString;
  aKind: TnsToMSWordExportKind): Boolean;
//#UC START# *4975FB460262_496DA60C03CA_var*
//#UC END# *4975FB460262_496DA60C03CA_var*
begin
//#UC START# *4975FB460262_496DA60C03CA_impl*
 case aKind of
  mswekNewFile :
   Result := nsDoShellExecute(aFilePath, True);
  mswekActiveWindow:
  begin
   Result := nsInsertFileIntoWord(aFilePath);
   if not Result then
    Result := nsDoShellExecute(aFilePath, True);
  end;
  else
  begin
   Result := False;
   Assert(False);
  end;
 end;//case aKind 
//#UC END# *4975FB460262_496DA60C03CA_impl*
end;//TnsToMSWordOp.Execute

class function TnsToMSWordOp.Execute(const aFilePath: Il3CString;
  const aParams: IvcmExecuteParamsPrim): Boolean;
//#UC START# *4975FB5B0162_496DA60C03CA_var*
//#UC END# *4975FB5B0162_496DA60C03CA_var*
begin
//#UC START# *4975FB5B0162_496DA60C03CA_impl*
 Case aParams.ItemIndex of
  0,1:
   Result := Execute(aFilePath, mswekNewFile);
  2:
   Result := Execute(aFilePath, mswekActiveWindow);
  else
  begin
   Result := False;
   Assert(False);
  end;
 end;//Case aParams.ItemIndex
//#UC END# *4975FB5B0162_496DA60C03CA_impl*
end;//TnsToMSWordOp.Execute

{$IfEnd} //not Admin AND not Monitorings

end.