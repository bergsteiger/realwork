unit deCommonDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/deCommonDiction.pas"
// Начат: 08.12.2009 18:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::CommonDiction::CommonDiction::TdeCommonDiction
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
  DocumentUnit,
  l3Interfaces,
  deDocInfo,
  CommonDictionInterfaces,
  DocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeCommonDiction = class(TdeDocInfo, IdeCommonDiction)
 protected
 // realized methods
   function pm_GetContext: Il3CString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DefaultDocType: TDocumentType; override;
   procedure AssignFromClone(const aData: IdeDocInfo); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Context : Il3CString;
 public
 // public methods
   class function Convert(const aDocInfo: IdeDocInfo): IdeCommonDiction;
   class function Make(const aDocument: IDocument;
     const aContext: Il3CString = nil): IdeDocInfo;
 end;//TdeCommonDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  BaseTypesUnit,
  bsTypesNew,
  bsDataContainer
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeCommonDiction

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Context := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdeCommonDiction.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.