unit vcmCustomHelpers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmCustomHelpers.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmCustomHelpers
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3ProtoObject
  {$If not defined(NoVCL)}
  ,
  l3FormatActionInfoHelper
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  
  ;

type
 TvcmFormatActionInfoHelper = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3FormatActionInfoHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
    {$If not defined(NoVCL)}
   function Format(anAction: TCustomAction): AnsiString;
    {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmFormatActionInfoHelper;
    {- возвращает экземпляр синглетона. }
 end;//TvcmFormatActionInfoHelper
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  vcmModuleAction,
  vcmOperationAction,
  vcmEntityAction
  ;


// start class TvcmFormatActionInfoHelper

var g_TvcmFormatActionInfoHelper : TvcmFormatActionInfoHelper = nil;

procedure TvcmFormatActionInfoHelperFree;
begin
 l3Free(g_TvcmFormatActionInfoHelper);
end;

class function TvcmFormatActionInfoHelper.Instance: TvcmFormatActionInfoHelper;
begin
 if (g_TvcmFormatActionInfoHelper = nil) then
 begin
  l3System.AddExitProc(TvcmFormatActionInfoHelperFree);
  g_TvcmFormatActionInfoHelper := Create;
 end;
 Result := g_TvcmFormatActionInfoHelper;
end;


class function TvcmFormatActionInfoHelper.Exists: Boolean;
 {-}
begin
 Result := g_TvcmFormatActionInfoHelper <> nil;
end;//TvcmFormatActionInfoHelper.Exists

{$If not defined(NoVCL)}
function TvcmFormatActionInfoHelper.Format(anAction: TCustomAction): AnsiString;
//#UC START# *781F06EEA149_551442CF02AD_var*
 procedure AddInfo(var theInfo: AnsiString;
   const aCaption: AnsiString;
   const aValue: AnsiString;
   aNewLine: Boolean = False);
 begin
  if Length(aValue) > 0 then
  begin
   if Length(theInfo) > 0 then
    if aNewLine
     then theInfo := theInfo + #13#10
     else theInfo := theInfo + ', ';
   theInfo := theInfo + aCaption + ':' + aValue;
  end;
 end;//AddInfo
//#UC END# *781F06EEA149_551442CF02AD_var*
begin
//#UC START# *781F06EEA149_551442CF02AD_impl*
 Result := '';
 if anAction is TvcmOperationAction then
 begin
  AddInfo(Result, 'OpDef', TvcmOperationAction(anAction).OpDef.Name);
  if anAction is TvcmEntityAction then
   AddInfo(Result, 'EntityDef', TvcmEntityAction(anAction).EntityDef.Name);
  if anAction is TvcmActiveEntityActionEx then
   AddInfo(Result, 'EntityDef', TvcmActiveEntityActionEx(anAction).EntityDef.Name);
  if anAction is TvcmModuleAction then
   AddInfo(Result, 'ModuleDef', TvcmModuleAction(anAction).ModuleDef.Name);
 end;
//#UC END# *781F06EEA149_551442CF02AD_impl*
end;//TvcmFormatActionInfoHelper.Format
{$IfEnd} //not NoVCL
{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Регистрация TvcmFormatActionInfoHelper
 {$If not defined(NoVCL)}
 Tl3FormatActionInfoHelper.Instance.Alien := TvcmFormatActionInfoHelper.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVCM

end.