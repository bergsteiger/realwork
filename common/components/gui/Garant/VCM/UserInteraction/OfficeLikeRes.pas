unit OfficeLikeRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLikeRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> Shared Delphi Operations::OfficeLike::UserInteraction::OfficeLike
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  OfficeLike_Usual_Controls,
  vcmMainForm,
  vcmApplication,
  OfficeLikeMain_Form,
  Classes {a},
  vcmInterfaces {a},
  vcmUserControls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vcmToolbarsInterfaces,
  l3ProtoDataContainer,
  vcmBaseMenuManager,
  PrimToolbarMenu_Module
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
TOfficeLikeRes = {abstract} class(TvcmApplication)
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;

 public
 // operations codes
   class function mod_opcode_ToolbarMenu_Customize : TvcmMOpID;
     {  -> ���������... }
   class function mod_opcode_ToolbarMenu_AvailableOperations : TvcmMOpID;
     {  -> ��������� ��������... }
   class function mod_opcode_ToolbarMenu_IconsSize : TvcmMOpID;
     {  -> ������ ������ }
   class function mod_opcode_ToolbarMenu_Fasten : TvcmMOpID;
     {  -> ��������� ������ ������������ }
end;//TOfficeLikeRes
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Windows,
  vcmBaseOperationsCollectionItem
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  moToolbarMenu
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TOfficeLikeRes

procedure TOfficeLikeRes.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TOfficeLikeRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_ToolbarMenu);
end;

var
 g_module_opcode_ToolbarMenu_Customize : TvcmMOpID;
 g_module_opcode_ToolbarMenu_AvailableOperations : TvcmMOpID;
 g_module_opcode_ToolbarMenu_IconsSize : TvcmMOpID;
 g_module_opcode_ToolbarMenu_Fasten : TvcmMOpID;

procedure TOfficeLikeRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_ToolbarMenu, '��������� �������');
 PublishOperation(en_Common,
                    op_Exit,
                    en_capCommon,
                    op_capExit);
 PublishOperation(en_History,
                    op_Back,
                    en_capHistory,
                    op_capBack);
 PublishOperation(en_History,
                    op_Forward,
                    en_capHistory,
                    op_capForward);
 g_module_opcode_ToolbarMenu_Customize := 
  PublishModuleOperation(Tmo_ToolbarMenu, 'Customize', '���������...');
 g_module_opcode_ToolbarMenu_AvailableOperations := 
  PublishModuleOperation(Tmo_ToolbarMenu, 'AvailableOperations', '��������� ��������...');
 g_module_opcode_ToolbarMenu_IconsSize := 
  PublishModuleOperation(Tmo_ToolbarMenu, 'IconsSize', '������ ������');
 g_module_opcode_ToolbarMenu_Fasten := 
  PublishModuleOperation(Tmo_ToolbarMenu, 'Fasten', '��������� ������ ������������');
end;

// operations codes

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_Customize : TvcmMOpID;
begin
 Result := g_module_opcode_ToolbarMenu_Customize;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_AvailableOperations : TvcmMOpID;
begin
 Result := g_module_opcode_ToolbarMenu_AvailableOperations;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_IconsSize : TvcmMOpID;
begin
 Result := g_module_opcode_ToolbarMenu_IconsSize;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TOfficeLikeRes.mod_opcode_ToolbarMenu_Fasten : TvcmMOpID;
begin
 Result := g_module_opcode_ToolbarMenu_Fasten;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //not NoVCM

end.