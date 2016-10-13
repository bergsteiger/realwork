unit csDeliveryProfileTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csDeliveryProfileTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsDeliveryProfileTask" MUID: (57F4DAED0254)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsDeliveryProfileTask = class(TddProcessTask)
  protected
   function pm_GetTargetFolder: AnsiString;
   procedure pm_SetTargetFolder(const aValue: AnsiString);
   function pm_GetSourceFolder: AnsiString;
   procedure pm_SetSourceFolder(const aValue: AnsiString);
   function RequireDelivery: Boolean; override;
  public
   function DeliverySourceFolder: AnsiString; override;
   function DeliveryTargetFolder: AnsiString; override;
   function GetDescription: AnsiString; override;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TargetFolder: AnsiString
    read pm_GetTargetFolder
    write pm_SetTargetFolder;
   property SourceFolder: AnsiString
    read pm_GetSourceFolder
    write pm_SetSourceFolder;
 end;//TcsDeliveryProfileTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , DeliveryProfile_Const
 //#UC START# *57F4DAED0254impl_uses*
 //#UC END# *57F4DAED0254impl_uses*
;

function TcsDeliveryProfileTask.pm_GetTargetFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTargetFolder]);
end;//TcsDeliveryProfileTask.pm_GetTargetFolder

procedure TcsDeliveryProfileTask.pm_SetTargetFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTargetFolder, nil] := (aValue);
end;//TcsDeliveryProfileTask.pm_SetTargetFolder

function TcsDeliveryProfileTask.pm_GetSourceFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceFolder]);
end;//TcsDeliveryProfileTask.pm_GetSourceFolder

procedure TcsDeliveryProfileTask.pm_SetSourceFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSourceFolder, nil] := (aValue);
end;//TcsDeliveryProfileTask.pm_SetSourceFolder

function TcsDeliveryProfileTask.RequireDelivery: Boolean;
//#UC START# *57F603C6018A_57F4DAED0254_var*
//#UC END# *57F603C6018A_57F4DAED0254_var*
begin
//#UC START# *57F603C6018A_57F4DAED0254_impl*
 Result := True;
//#UC END# *57F603C6018A_57F4DAED0254_impl*
end;//TcsDeliveryProfileTask.RequireDelivery

function TcsDeliveryProfileTask.DeliverySourceFolder: AnsiString;
//#UC START# *57F603E20074_57F4DAED0254_var*
//#UC END# *57F603E20074_57F4DAED0254_var*
begin
//#UC START# *57F603E20074_57F4DAED0254_impl*
 Result := SourceFolder;
//#UC END# *57F603E20074_57F4DAED0254_impl*
end;//TcsDeliveryProfileTask.DeliverySourceFolder

function TcsDeliveryProfileTask.DeliveryTargetFolder: AnsiString;
//#UC START# *57F6040302FE_57F4DAED0254_var*
//#UC END# *57F6040302FE_57F4DAED0254_var*
begin
//#UC START# *57F6040302FE_57F4DAED0254_impl*
 Result := TargetFolder;
//#UC END# *57F6040302FE_57F4DAED0254_impl*
end;//TcsDeliveryProfileTask.DeliveryTargetFolder

function TcsDeliveryProfileTask.GetDescription: AnsiString;
//#UC START# *57F639C2025B_57F4DAED0254_var*
//#UC END# *57F639C2025B_57F4DAED0254_var*
begin
//#UC START# *57F639C2025B_57F4DAED0254_impl*
 Result := 'Проверка достваки папка: ' + TargetFolder;
//#UC END# *57F639C2025B_57F4DAED0254_impl*
end;//TcsDeliveryProfileTask.GetDescription

class function TcsDeliveryProfileTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typDeliveryProfile;
end;//TcsDeliveryProfileTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
