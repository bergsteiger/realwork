unit deDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/deDiction.pas"
// Начат: 08.12.2009
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction::TdeDiction
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
  bsTypes,
  DictionInterfaces,
  deCommonDiction,
  DocumentInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeDiction = class(TdeCommonDiction, IdeDiction)
 private
 // private fields
   f_DictLanguage : TbsLanguage;
   f_ContextMap : InsLangToContextMap;
 protected
 // realized methods
   function pm_GetDictLanguage: TbsLanguage;
   procedure pm_SetDictLanguage(aValue: TbsLanguage);
   function pm_GetContextMap: InsLangToContextMap;
   procedure pm_SetContextMap(const aValue: InsLangToContextMap);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DefaultDocType: TDocumentType; override;
   procedure AssignFromClone(const aData: IdeDocInfo); override;
 public
 // public methods
   class function Make(const aDocument: IDocument;
     aDictLanguage: TbsLanguage = LG_RUSSIAN;
     const aContextMap: InsLangToContextMap = nil): IdeDocInfo;
   class function Convert(const aDocInfo: IdeDocInfo;
     aLang: TbsLanguage): IdeDiction;
 end;//TdeDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  bsDataContainer
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeDiction

class function TdeDiction.Make(const aDocument: IDocument;
  aDictLanguage: TbsLanguage = LG_RUSSIAN;
  const aContextMap: InsLangToContextMap = nil): IdeDocInfo;
//#UC START# *4B1E9B7E023E_4925538201C4_var*
var
 lClass: TdeDiction;
//#UC END# *4B1E9B7E023E_4925538201C4_var*
begin
//#UC START# *4B1E9B7E023E_4925538201C4_impl*
 lClass := Create(TbsDocumentContainer.Make(aDocument));
 try
  lClass.f_DictLanguage := aDictLanguage;
  lClass.f_ContextMap := aContextMap;
  Result := lClass;
 finally
  FreeAndNil(lClass);
 end;
//#UC END# *4B1E9B7E023E_4925538201C4_impl*
end;//TdeDiction.Make

class function TdeDiction.Convert(const aDocInfo: IdeDocInfo;
  aLang: TbsLanguage): IdeDiction;
//#UC START# *4B1E9BA80018_4925538201C4_var*
var
 l_Data: TdeDiction;
//#UC END# *4B1E9BA80018_4925538201C4_var*
begin
//#UC START# *4B1E9BA80018_4925538201C4_impl*
 if Assigned(aDocInfo) then
  l_Data := CreateCloned(aDocInfo)
 else
  l_Data := Create(TbsDocumentContainer.Make(nil));
 try
  l_Data.pm_SetDictLanguage(aLang);
  Result := l_Data;
 finally
  FreeAndNil(l_Data);
 end;
//#UC END# *4B1E9BA80018_4925538201C4_impl*
end;//TdeDiction.Convert

function TdeDiction.pm_GetDictLanguage: TbsLanguage;
//#UC START# *4B1D157B01C9_4925538201C4get_var*
//#UC END# *4B1D157B01C9_4925538201C4get_var*
begin
//#UC START# *4B1D157B01C9_4925538201C4get_impl*
 Result := f_DictLanguage;
//#UC END# *4B1D157B01C9_4925538201C4get_impl*
end;//TdeDiction.pm_GetDictLanguage

procedure TdeDiction.pm_SetDictLanguage(aValue: TbsLanguage);
//#UC START# *4B1D157B01C9_4925538201C4set_var*
//#UC END# *4B1D157B01C9_4925538201C4set_var*
begin
//#UC START# *4B1D157B01C9_4925538201C4set_impl*
 f_DictLanguage := aValue;
//#UC END# *4B1D157B01C9_4925538201C4set_impl*
end;//TdeDiction.pm_SetDictLanguage

function TdeDiction.pm_GetContextMap: InsLangToContextMap;
//#UC START# *52D3BE9302D6_4925538201C4get_var*
//#UC END# *52D3BE9302D6_4925538201C4get_var*
begin
//#UC START# *52D3BE9302D6_4925538201C4get_impl*
 Result := InsLangToContextMap(f_ContextMap);
//#UC END# *52D3BE9302D6_4925538201C4get_impl*
end;//TdeDiction.pm_GetContextMap

procedure TdeDiction.pm_SetContextMap(const aValue: InsLangToContextMap);
//#UC START# *52D3BE9302D6_4925538201C4set_var*
//#UC END# *52D3BE9302D6_4925538201C4set_var*
begin
//#UC START# *52D3BE9302D6_4925538201C4set_impl*
 f_ContextMap := aValue;
//#UC END# *52D3BE9302D6_4925538201C4set_impl*
end;//TdeDiction.pm_SetContextMap

procedure TdeDiction.Cleanup;
//#UC START# *479731C50290_4925538201C4_var*
//#UC END# *479731C50290_4925538201C4_var*
begin
//#UC START# *479731C50290_4925538201C4_impl*
 f_ContextMap := nil;
 inherited;
//#UC END# *479731C50290_4925538201C4_impl*
end;//TdeDiction.Cleanup

function TdeDiction.DefaultDocType: TDocumentType;
//#UC START# *4B1E714A0125_4925538201C4_var*
//#UC END# *4B1E714A0125_4925538201C4_var*
begin
//#UC START# *4B1E714A0125_4925538201C4_impl*
 Result := DT_EXPLANATORY;
//#UC END# *4B1E714A0125_4925538201C4_impl*
end;//TdeDiction.DefaultDocType

procedure TdeDiction.AssignFromClone(const aData: IdeDocInfo);
//#UC START# *4B1E749D033C_4925538201C4_var*
var
 l_Data: IdeDiction;
//#UC END# *4B1E749D033C_4925538201C4_var*
begin
//#UC START# *4B1E749D033C_4925538201C4_impl*
 inherited;
 if Supports(aData, IdeDiction, l_Data) then
 begin
  f_DictLanguage := l_Data.DictLanguage;
  f_ContextMap := l_Data.ContextMap;
 end;
//#UC END# *4B1E749D033C_4925538201C4_impl*
end;//TdeDiction.AssignFromClone

{$IfEnd} //not Admin AND not Monitorings

end.