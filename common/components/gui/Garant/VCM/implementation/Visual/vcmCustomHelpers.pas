unit vcmCustomHelpers;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmCustomHelpers.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmCustomHelpers" MUID: (551442A301CD)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3FormatActionInfoHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmFormatActionInfoHelper = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3FormatActionInfoHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   {$If NOT Defined(NoVCL)}
   function Format(anAction: TCustomAction): AnsiString;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvcmFormatActionInfoHelper;
    {* ����� ��������� ���������� ���������� TvcmFormatActionInfoHelper }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmFormatActionInfoHelper
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmModuleAction
 , vcmOperationAction
 , vcmEntityAction
 , SysUtils
 , l3Base
 //#UC START# *551442A301CDimpl_uses*
 //#UC END# *551442A301CDimpl_uses*
;

var g_TvcmFormatActionInfoHelper: TvcmFormatActionInfoHelper = nil;
 {* ��������� ���������� TvcmFormatActionInfoHelper }

procedure TvcmFormatActionInfoHelperFree;
 {* ����� ������������ ���������� ���������� TvcmFormatActionInfoHelper }
begin
 l3Free(g_TvcmFormatActionInfoHelper);
end;//TvcmFormatActionInfoHelperFree

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

class function TvcmFormatActionInfoHelper.Instance: TvcmFormatActionInfoHelper;
 {* ����� ��������� ���������� ���������� TvcmFormatActionInfoHelper }
begin
 if (g_TvcmFormatActionInfoHelper = nil) then
 begin
  l3System.AddExitProc(TvcmFormatActionInfoHelperFree);
  g_TvcmFormatActionInfoHelper := Create;
 end;
 Result := g_TvcmFormatActionInfoHelper;
end;//TvcmFormatActionInfoHelper.Instance

class function TvcmFormatActionInfoHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmFormatActionInfoHelper <> nil;
end;//TvcmFormatActionInfoHelper.Exists

initialization
{$If NOT Defined(NoVCL)}
 Tl3FormatActionInfoHelper.Instance.Alien := TvcmFormatActionInfoHelper.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* ����������� TvcmFormatActionInfoHelper }
{$IfEnd} // NOT Defined(NoVCM)

end.
