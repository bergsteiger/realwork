unit deCommonDiction;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\deCommonDiction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeCommonDiction" MUID: (4B1E70D20312)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deDocInfo
 , CommonDictionInterfaces
 , l3Interfaces
 , DocumentInterfaces
 , DocumentUnit
;

type
 TdeCommonDiction = class(TdeDocInfo, IdeCommonDiction)
  protected
   f_Context: Il3CString;
  protected
   function pm_GetContext: Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DefaultDocType: TDocumentType; override;
   procedure AssignFromClone(const aData: IdeDocInfo); override;
   procedure ClearFields; override;
  public
   class function Convert(const aDocInfo: IdeDocInfo): IdeCommonDiction;
   class function Make(const aDocument: IDocument;
    const aContext: Il3CString = nil): IdeDocInfo;
 end;//TdeCommonDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , BaseTypesUnit
 , bsTypesNew
 , bsDataContainer
 //#UC START# *4B1E70D20312impl_uses*
 //#UC END# *4B1E70D20312impl_uses*
;

class function TdeCommonDiction.Convert(const aDocInfo: IdeDocInfo): IdeCommonDiction;
//#UC START# *4B1E7EC0026F_4B1E70D20312_var*
var
 l_Data: TdeCommonDiction;
//#UC END# *4B1E7EC0026F_4B1E70D20312_var*
begin
//#UC START# *4B1E7EC0026F_4B1E70D20312_impl*
 if Assigned(aDocInfo) then
  l_Data := CreateCloned(aDocInfo)
 else
  l_Data := Create(TbsDocumentContainer.Make(nil));
 try
  Result := l_Data;
 finally
  FreeAndNil(l_Data);
 end;
//#UC END# *4B1E7EC0026F_4B1E70D20312_impl*
end;//TdeCommonDiction.Convert

class function TdeCommonDiction.Make(const aDocument: IDocument;
 const aContext: Il3CString = nil): IdeDocInfo;
//#UC START# *4B1E7EF1015B_4B1E70D20312_var*
var
 lClass: TdeCommonDiction;
//#UC END# *4B1E7EF1015B_4B1E70D20312_var*
begin
//#UC START# *4B1E7EF1015B_4B1E70D20312_impl*
 lClass := Create(TbsDocumentContainer.Make(aDocument));
 try
  lClass.f_Context := aContext;
  Result := lClass;
 finally
  FreeAndNil(lClass);
 end;
//#UC END# *4B1E7EF1015B_4B1E70D20312_impl*
end;//TdeCommonDiction.Make

function TdeCommonDiction.pm_GetContext: Il3CString;
//#UC START# *4B1D15350358_4B1E70D20312get_var*
//#UC END# *4B1D15350358_4B1E70D20312get_var*
begin
//#UC START# *4B1D15350358_4B1E70D20312get_impl*
 Result := f_Context;
//#UC END# *4B1D15350358_4B1E70D20312get_impl*
end;//TdeCommonDiction.pm_GetContext

procedure TdeCommonDiction.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B1E70D20312_var*
//#UC END# *479731C50290_4B1E70D20312_var*
begin
//#UC START# *479731C50290_4B1E70D20312_impl*
 f_Context := nil;
 inherited;
//#UC END# *479731C50290_4B1E70D20312_impl*
end;//TdeCommonDiction.Cleanup

function TdeCommonDiction.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_4B1E70D20312_var*
//#UC END# *4B1E714A0125_4B1E70D20312_var*
begin
//#UC START# *4B1E714A0125_4B1E70D20312_impl*
 Result := inherited DefaultDocType;
 Assert(False);
//#UC END# *4B1E714A0125_4B1E70D20312_impl*
end;//TdeCommonDiction.DefaultDocType

procedure TdeCommonDiction.AssignFromClone(const aData: IdeDocInfo);
//#UC START# *4B1E749D033C_4B1E70D20312_var*
var
 l_Data: IdeCommonDiction;
//#UC END# *4B1E749D033C_4B1E70D20312_var*
begin
//#UC START# *4B1E749D033C_4B1E70D20312_impl*
 inherited;
 if Supports(aData, IdeCommonDiction, l_Data) then
  f_Context := l_Data.Context;
//#UC END# *4B1E749D033C_4B1E70D20312_impl*
end;//TdeCommonDiction.AssignFromClone

procedure TdeCommonDiction.ClearFields;
begin
 f_Context := nil;
 inherited;
end;//TdeCommonDiction.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
