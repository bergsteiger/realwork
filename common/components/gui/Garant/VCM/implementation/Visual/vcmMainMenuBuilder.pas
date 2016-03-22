unit vcmMainMenuBuilder;

// —ервис, предназначенный дл€ регистрации модулей и сущностей
// и построени€ главного меню в любой нужный момент времени.

// Ѕиблиотека "vcm"
// Ќачат: 16.11.2015

// $Id: vcmMainMenuBuilder.pas,v 1.1 2015/11/17 11:58:11 morozov Exp $

// $Log: vcmMainMenuBuilder.pas,v $
// Revision 1.1  2015/11/17 11:58:11  morozov
// {RequestLink: 611211969}
//

interface

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

{$If not defined(NoVCM)}
uses
  l3ProtoObject,
  Menus,
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmModuleDefList,
  vcmEntityDefList,
  vcmEntityForm
  ;

type
  TvcmMainMenuBuilder = class(Tl3ProtoObject)
  // —ервис, предназначенный дл€ регистрации модулей и сущностей
  // и построени€ главного меню в любой нужный момент времени. }
  private
   f_ModuleDefList: TvcmModuleDefList;
   f_EntityDefList: TvcmEntityDefList;
   constructor Create;
   procedure RegisterModuleDef(const AModuleDef: IvcmModuleDef);
   procedure RegisterEntityDef(const AEntityDef: IvcmEntityDef);
  protected
   procedure CleanUp; override;
  public
   procedure RegisterModule(const AModuleDef: IvcmModuleDef);
   procedure RegisterForm(const AForm: TvcmEntityForm);
   procedure RegisterMainForm(const AForm: TvcmEntityForm);
   procedure BuildMainMenu(const AMenuItem: TMenuItem);
   class function Instance: TvcmMainMenuBuilder;
  end;

{$IfEnd} //not NoVCM

implementation
{$If not defined(NoVCM)}
uses
  SysUtils,
  l3Base,
  vcmMenus,
  vcmUserControls,
  vcmMenuItemsCollectionItem,
  vcmMainMenuAction,
  vcmBaseMenuManager,
  vcmMenuManager;

constructor TvcmMainMenuBuilder.Create;
begin
 inherited;
 f_ModuleDefList := TvcmModuleDefList.Create;
 f_EntityDefList := TvcmEntityDefList.Create;
end;

procedure TvcmMainMenuBuilder.RegisterModuleDef(const AModuleDef: IvcmModuleDef);

 function lp_FindModuleDef: Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  for l_Index := 0 to Pred(f_ModuleDefList.Count) do
   if (f_ModuleDefList[l_Index].ID = AModuleDef.ID) then
    Result := True;
 end;

begin
 if not lp_FindModuleDef then
  f_ModuleDefList.Add(AModuleDef);
end;

procedure TvcmMainMenuBuilder.RegisterEntityDef(const AEntityDef: IvcmEntityDef);

 function lp_FindEntityDef: Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  for l_Index := 0 to Pred(f_EntityDefList.Count) do
   if (f_EntityDefList[l_Index].ID = AEntityDef.ID) then
    Result := True;
 end;//lp_FindEntityDef

begin
 if not lp_FindEntityDef then
  f_EntityDefList.Add(AEntityDef);
end;

procedure TvcmMainMenuBuilder.CleanUp;
begin
 FreeAndNil(f_ModuleDefList);
 FreeAndNil(f_EntityDefList);
 inherited;
end;

procedure TvcmMainMenuBuilder.RegisterModule(const AModuleDef: IvcmModuleDef);
begin
 RegisterModuleDef(AModuleDef);
end;

procedure TvcmMainMenuBuilder.RegisterForm(const AForm: TvcmEntityForm);
var
 l_Iter: IvcmEntitiesDefIterator;
 l_EntityDef: IvcmEntityDef;
begin
 l_Iter := AForm.GetEntitiesDefIterator;
 l_EntityDef := l_Iter.Next;
 while (l_EntityDef <> nil) do
 begin
  RegisterEntityDef(l_EntityDef);
  l_EntityDef := l_Iter.Next;
 end;
end;

procedure TvcmMainMenuBuilder.RegisterMainForm(const AForm: TvcmEntityForm);
begin
 RegisterForm(AForm);
end;

type
  TvcmEntityDefIterator = class(Tl3ProtoObject, IvcmEntitiesDefIterator)
  private
   f_List: TvcmEntityDefList;
   f_CurrentIndex: Integer;
  protected
   function Get_Next: IvcmEntityDef;
   procedure CleanUp; override;
  public
   constructor Create(AList: TvcmEntityDefList);
   class function Make(AList: TvcmEntityDefList): IvcmEntitiesDefIterator;
  end;

function TvcmEntityDefIterator.Get_Next: IvcmEntityDef;
begin
 Inc(f_CurrentIndex);
 
 if (f_CurrentIndex <= Pred(f_List.Count)) then
  Result := f_List[f_CurrentIndex]
 else
  Result := nil;
  
end;

procedure TvcmEntityDefIterator.CleanUp;
begin
 f_List := nil;
 inherited;
end;

constructor TvcmEntityDefIterator.Create(AList: TvcmEntityDefList);
begin
 inherited Create;
 f_List := AList;
 f_CurrentIndex := -1;
end;

class function TvcmEntityDefIterator.Make(AList: TvcmEntityDefList): IvcmEntitiesDefIterator;
var
 l_Inst: TvcmEntityDefIterator;
begin
 l_Inst := Create(AList);
 try
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
end;

procedure TvcmMainMenuBuilder.BuildMainMenu(const AMenuItem: TMenuItem);

 procedure lp_BuildMenu;
 var
  l_Manager: TvcmMenuManager;
  l_Index: Integer;
  l_MMI: TvcmMenuItemsCollectionItem;
 begin
  l_Manager := TvcmMenuManager(g_MenuManager);

  for l_Index := 0 to Pred(l_Manager.MainMenuItems.Count) do
  begin
   l_MMI := TvcmMenuItemsCollectionItem(l_Manager.MainMenuItems.Items[l_Index]);

   TvcmMainMenuAction.MakeForMenu(vcmAddCategoryItem(AMenuItem,
                                                     l_MMI.Caption),
                                  l_MMI.OnTest);
  end;//for l_Index
 end;//lp_BuildMenu

 procedure lp_MakeModuleMenuItems;
 var
  l_ModuleItem: TMenuItem;
  l_Index: Integer;
  l_ModuleDef: IvcmModuleDef;
 begin
  for l_Index := 0 to Pred(f_ModuleDefList.Count) do
  begin
   l_ModuleItem := vcmMakeModuleMenu(AMenuItem,
                                     f_ModuleDefList[l_Index],
                                     [vcm_ooShowInMainMenu],
                                     true);
   vcmMakeEntitiesMenus(AMenuItem,
                        f_ModuleDefList[l_Index].EntitiesDefIterator,
                        [vcm_ooShowInMainMenu]);
  end;
 end;//lp_MakeModuleMenu

 procedure lp_MakeEntitiesMenuItems;
 var
  l_Iter: IvcmEntitiesDefIterator;
  l_Index: Integer;
  l_ChildItem: TMenuItem;
 begin
  l_Iter := TvcmEntityDefIterator.Make(f_EntityDefList);

  vcmMakeEntitiesMenus(AMenuItem,
                       l_Iter,
                       [vcm_ooShowInMainMenu]);

  l_Index := 0;

  while (l_Index < AMenuItem.Count) do
  begin
   l_ChildItem := AMenuItem.Items[l_Index];

   if (l_ChildItem.Count <= 0) then
    AMenuItem.Remove(l_ChildItem)
   else
    Inc(l_Index);
  end;//while (l_Index < l_Item.Count)
 end;//lp_MakeEntitiesMenu

begin
 lp_BuildMenu;
 lp_MakeModuleMenuItems;
 lp_MakeEntitiesMenuItems;
end;

var
  g_Instance: TvcmMainMenuBuilder = nil;

procedure TvcmMainMenuBuilder_Free;
begin
 FreeAndNil(g_Instance);
end;   

class function TvcmMainMenuBuilder.Instance: TvcmMainMenuBuilder;
begin
 if (g_Instance = nil) then
 begin
  g_Instance := Create;
  l3System.AddExitProc(TvcmMainMenuBuilder_Free);
 end;
 Result := g_Instance;
end;

{$IfEnd} //not NoVCM

end.