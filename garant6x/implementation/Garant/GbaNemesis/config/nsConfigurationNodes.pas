unit nsConfigurationNodes;

{-----------------------------------------------------------------------------
 Unit Name: nsConfigurationNodes
 Author:    Морозов Михаил
 Purpose:   Описать классы используемые для отображения списка конфигураций в
            дереве TeeTreeView;
 History:
-----------------------------------------------------------------------------}

{$Include nsDefine.inc}

interface

// <no_string>

uses
  l3Interfaces,
  l3Types,
  l3Base,
  l3VirtualNode,

  afwInterfaces,
  
  eeInterfaces,

  nsNodes,
  bsInterfaces,

  ConfigInterfaces
  ;

type
  _afwSettingsReplace_Parent_ = TnsCacheableNode;
  {$Include afwSettingsReplace.imp.pas}
  TnsConfigNode = class(_afwSettingsReplace_,
                        InsConfigNode,
                        InsConfigNotifyRecipient)
  private
   f_ActiveSuffix : Il3CString;
   f_Config       : InsConfigSettingsInfo;
  private
   procedure UpdateName;
  private
   function  pm_GetActiveSuffix: Il3CString;
   procedure pm_SetActiveSuffix(const aValue: Il3CString);
     {-}
   function  pm_GetConfig: InsConfigSettingsInfo;
     {-}
   procedure InfoChanged;
     {-}
  protected
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
     override;
     {-}
   procedure Cleanup;
    override;
     {-}
  protected
  // IafwSettingsReplaceListener
   procedure SettingsReplaceFinish;
     override;
     {* - после замены настроек. }
  public
   procedure UpdateActivity;
    {-}
  public
   constructor Create(const aConfig        : InsConfigSettingsInfo;
                      const anActiveSuffix : Il3CString);
     reintroduce;
     {-}
   class function Make(const aConfig        : InsConfigSettingsInfo;
                       const anActiveSuffix : Il3CString): InsConfigNode;
     reintroduce;
     {-}
  public
   property Config: InsConfigSettingsInfo
       read pm_GetConfig;
     {-}
   property ActiveSuffix: Il3CString
       read pm_GetActiveSuffix
      write pm_SetActiveSuffix;
    {-}
  end;//TnsConfigNode

 TnsRootConfigNode = class(TnsCacheableNode)
 protected
  function ChildNodeClass : Rl3CustomVirtualNode;
    override;
    {-}
 end;//TnsConfigNode

implementation

uses
  SysUtils,

  l3String,

  afwFacade,

  nsTypes,

  afwSettingsChangePublisher
  ;

{$Include afwSettingsReplace.imp.pas}

{ TnsRootConfigNode }

function TnsRootConfigNode.ChildNodeClass: Rl3CustomVirtualNode;
begin
 Result := TnsConfigNode; 
end;

{ TnsConfigNode }

procedure TnsConfigNode.Cleanup;
var
 l_Subsriber: InsConfigNotificationSource;
begin
 if Supports(f_Config, InsConfigNotificationSource, l_Subsriber) then
  l_Subsriber.Unsubscribe(InsConfigNotifyRecipient(Self));
 f_Config := nil;
 f_ActiveSuffix := nil;
 inherited;
end;

constructor TnsConfigNode.Create(const aConfig        : InsConfigSettingsInfo;
                                 const anActiveSuffix : Il3CString);
var
 l_Subsriber: InsConfigNotificationSource;
begin
 inherited Create(nil, -1, -1);
 f_Config := aConfig;
 f_ActiveSuffix := anActiveSuffix;
 UpdateName;
 if Supports(f_Config, InsConfigNotificationSource, l_Subsriber) then
  l_Subsriber.Subscribe(InsConfigNotifyRecipient(Self));
end;

class function TnsConfigNode.Make(const aConfig        : InsConfigSettingsInfo;
                                  const anActiveSuffix : Il3CString): InsConfigNode;
var
 l_Node: TnsConfigNode;
begin
 if (aConfig = nil) then
  Result := nil
 else
 begin
  l_Node := Create(aConfig, anActiveSuffix);
  try
   Result := l_Node;
  finally
   l3Free(l_Node);
  end;
 end;//aDocument = nil
end;

procedure TnsConfigNode.InfoChanged;
begin
 UpdateName;
end;

function TnsConfigNode.pm_GetActiveSuffix: Il3CString;
begin
 Result := f_ActiveSuffix;
end;

procedure TnsConfigNode.pm_SetActiveSuffix(const aValue: Il3CString);
begin
 if (not l3Same(f_ActiveSuffix, aValue)) then
 begin
  f_ActiveSuffix := aValue;
  UpdateName;
 end;//not l3Same(f_ActiveSuffix, aValue)
end;

function TnsConfigNode.pm_GetConfig: InsConfigSettingsInfo;
begin
 Result := f_COnfig;
end;

procedure TnsConfigNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 l3Set(f_Caption, Value);
end;

procedure TnsConfigNode.UpdateActivity;
begin
 if Assigned(f_Config) then
  f_Config.UpdateActivity;
 UpdateName;
end;

procedure TnsConfigNode.UpdateName;
var
 l_Name: Il3CString;
begin
 l_Name := Config.ConfigName;
 if Config.IsActive and (not l3IsNil(f_ActiveSuffix)) then
  l_Name := l3Fmt('%s %s', [l_Name, f_ActiveSuffix]);
 AsWStr := l3PCharLen(l_Name);
end;

procedure TnsConfigNode.SettingsReplaceFinish;
  {* - после замены настроек. }
begin
 inherited;
 UpdateActivity;
end;

end.
