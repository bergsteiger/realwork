unit nsToMSWordOp;
 {* Экспорт в ворд }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\nsToMSWordOp.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
;

type
 TnsToMSWordExportKind = (
  {* Куда экспортировать }
  mswekNewFile
   {* В новый файл }
  , mswekActiveWindow
   {* В активное окно }
 );//TnsToMSWordExportKind

 TnsToMSWordOp = class
  {* Экспорт в ворд }
  public
   class procedure Test(const aParams: IvcmTestParamsPrim);
   class function Execute(const aFilePath: Il3CString;
    aKind: TnsToMSWordExportKind): Boolean; overload;
   class function Execute(const aFilePath: Il3CString;
    const aParams: IvcmExecuteParamsPrim): Boolean; overload;
 end;//TnsToMSWordOp
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsExternalObjectPrim
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
