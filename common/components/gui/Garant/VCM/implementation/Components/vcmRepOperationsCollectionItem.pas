unit vcmRepOperationsCollectionItem;
{* Элемент коллекции операций. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepOperationsCollectionItem - }
{ Начат: 19.11.2003 13:44 }
{ $Id: vcmRepOperationsCollectionItem.pas,v 1.53 2015/09/24 14:29:20 kostitsin Exp $ }

// $Log: vcmRepOperationsCollectionItem.pas,v $
// Revision 1.53  2015/09/24 14:29:20  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.52  2015/03/16 16:53:07  lulin
// - делаем стереотипы Service и ServiceImplementation.
//
// Revision 1.51  2014/08/22 09:45:24  kostitsin
// чиню библиотеки компонент
//
// Revision 1.50  2014/02/17 08:40:35  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.49  2014/02/04 09:33:09  morozov
// {RequestLink: 515841696}
//
// Revision 1.48  2013/08/28 16:38:01  lulin
// - чистка кода.
//
// Revision 1.47  2013/08/28 14:29:35  lulin
// - чистка кода.
//
// Revision 1.46  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.45  2012/08/07 14:37:42  lulin
// {RequestLink:358352265}
//
// Revision 1.44  2012/07/10 12:27:05  lulin
// {RequestLink:237994598}
//
// Revision 1.43  2012/03/22 06:40:09  lulin
// - чистим код от мусора.
//
// Revision 1.42  2011/12/08 16:30:03  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.41  2011/05/19 12:21:15  lulin
// {RequestLink:266409354}.
//
// Revision 1.40  2010/09/15 18:15:01  lulin
// {RequestLink:235047275}.
//
// Revision 1.39  2010/09/10 16:12:44  lulin
// {RequestLink:197496539}.
//
// Revision 1.38  2009/09/28 17:12:48  lulin
// {RequestLink:159360578}. №31.
//
// Revision 1.37  2009/09/25 12:09:14  lulin
// - выкидываем ненужное.
//
// Revision 1.36  2009/08/11 14:24:03  lulin
// {RequestLink:129240934}. №16.
//
// Revision 1.35  2009/08/07 13:47:32  lulin
// - делаем возможность централизованно запретить показ операций в контекстном меню.
//
// Revision 1.34  2009/08/06 13:27:16  lulin
// {RequestLink:129240934}. №26.
//
// Revision 1.33  2009/02/12 17:09:15  lulin
// - <K>: 135604584. Выделен модуль с внутренними константами.
//
// Revision 1.32  2008/03/20 09:48:19  lulin
// - cleanup.
//
// Revision 1.31  2007/05/31 13:53:18  oman
// - fix: Вкладка с галкой на повторную активацию теперь закрывается,
//  а не просто переключает навигатор на предыдущую активную
//  - переименовано свойство в соответствии со смыслом (cq25230)
//
// Revision 1.30  2007/01/18 11:47:36  oman
// - new: Локализация библиотек - vcm (cq24078)
//
// Revision 1.29  2006/03/15 11:09:48  lulin
// - new behavior: выливаем не заголовки категорий, а их идентификаторы.
//
// Revision 1.28  2006/03/13 12:33:31  lulin
// - теперь если возможно получаем категорию из пункта меню.
//
// Revision 1.26  2005/09/22 11:06:03  mmorozov
// - работа с историей в контексте сборок;
//
// Revision 1.25  2005/07/14 16:02:48  lulin
// - new behavior: в run-time получаем ID операции по ее имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.24  2005/02/02 14:47:35  mmorozov
// change: название метода;
//
// Revision 1.23  2005/02/02 14:44:37  mmorozov
// new: в _Handled используем IsFormActivateDefine;
//
// Revision 1.22  2005/02/02 14:42:38  mmorozov
// new: property TvcmRepOperationsCollectionItem.IsFormActivateDefine;
//
// Revision 1.21  2005/02/02 14:36:23  lulin
// - добавлен комментарий.
//
// Revision 1.20  2005/02/02 14:23:17  lulin
// - bug fix: было неправильное условие - вылезали ненужные операции.
//
// Revision 1.19  2005/02/02 12:53:56  am
// change: правки, связанные с переделками TvcmBaseOperationCollectionItem._Handled()
//
// Revision 1.18  2005/01/20 13:25:19  lulin
// - new consts: _vcm_otModuleInternal, _vcm_otFormConstructor.
//
// Revision 1.17  2005/01/14 14:03:25  lulin
// - вызываем "правильный" Free.
//
// Revision 1.16  2005/01/14 10:48:03  mmorozov
// change: _TvcmFormActivate наследник от _TvcmBase;
// change: _FormActivate в TvcmRepOperationsCollectionItem создаётся по требованию;
//
// Revision 1.15  2005/01/14 10:42:30  lulin
// - методы Get*ParentForm переехали в библиотеку AFW.
//
// Revision 1.14  2004/12/07 14:56:50  mmorozov
// - не компилировалась библиотека;
//
// Revision 1.13  2004/12/07 11:54:19  lulin
// - new method: _Tl3LongintList.IndexOf.
//
// Revision 1.12  2004/09/11 11:55:47  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.11  2004/07/30 13:07:18  law
// - cleanup.
//
// Revision 1.10  2004/07/30 10:00:05  nikitin75
// корректно мержим предустановленные (disigntime) шорткаты и прочитанные из настроек, bugfix
//
// Revision 1.9  2004/06/01 14:56:35  law
// - удалены конструкторы Tl3VList.MakeLongint, MakeLongintSorted - пользуйтесь _Tl3LongintList.
//
// Revision 1.8  2004/03/20 15:26:51  mmorozov
// new: type TvcmFormActivateType;
// new: array vcmFormActivateTypeName;
// new: property _TvcmFormActivate.TypeActivate;
//
// Revision 1.7  2004/03/20 09:49:10  mmorozov
// - переименовано свойство _TvcmFormActivate._FormName -> Name;
// new: properties _TvcmFormActivate.__DoExecuteIfExists;
// new: property _TvcmFormActivate.Caption;
//
// Revision 1.6  2004/03/19 15:03:19  mmorozov
// new: в метод _HasForm добавлен параметр (UserType : Integer = vcm_utAny);
//
// Revision 1.5  2004/03/19 13:23:22  mmorozov
// new: класс _TvcmFormActivate;
// new: property TvcmRepOperationsCollectionItem._FormActivate;
//
// Revision 1.4  2003/11/24 17:23:48  law
// - new behavior: не регестрируем операцию больше одного раза.
//
// Revision 1.3  2003/11/19 17:24:13  law
// - new prop: TvcmRepOperationsCollectionItem.RealizedIn - показывает в каких формах реализована (или по крайней мере описана) данная операция.
//
// Revision 1.2  2003/11/19 12:56:52  law
// - new behavior: отобразил свойства операций на формах на централизованное хранилище (Caption, ImageIndex, _GroupID, _Category, OperationType).
//
// Revision 1.1  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  ActnList,

  l3Base,
  l3ProtoPersistent,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmUserControls,
  vcmBase,
  vcmBaseOperationsCollectionItem,
  vcmMenuItemsCollectionItem,
  vcmOperationsCollectionItem,
  vcmOperationsCollectionItemList
  ;

type
  TvcmRepeatedActivationBehaviour = (vcm_rabNone, vcm_rabClose, vcm_rabInactivate,
   vcm_rabJustExecuteIfActive);

type
  TvcmRepOperationsCollectionItem = class;

  TvcmFormActivate = class(Tl3ProtoPersistent)
  {* Класс описывающий форму, которой необходимо управлять. }
  private
    f_Name              : AnsiString;
    f_Caption           : AnsiString;
    f_UserType          : Integer;
    f_DoExecuteIfExists : Boolean;
    f_ZoneType          : TvcmZoneType;
    f_RepeatedActivationBehaviour: TvcmRepeatedActivationBehaviour;
    f_Operation         : TvcmRepOperationsCollectionItem;
  protected
  //property methods
    procedure SetName(const Value: AnsiString);
      {-}
    procedure SetUserType(const Value: Integer);
      {-}
    procedure SetZoneType(const Value: TvcmZoneType);
      {-}
    procedure SetCaption(const Value: AnsiString);
      {-}
    procedure SetDoExecuteIfExists(const Value: Boolean);
      {-}
  //interanl methods
    procedure SetDefault;
      {-}
  public
    constructor Create(aOperation : TvcmRepOperationsCollectionItem);
      reintroduce;
      {-}
    procedure Assign(Source : TPersistent);
      override;
      {* - копируем из потока объект. }
    property Operation : TvcmRepOperationsCollectionItem
      read f_Operation;
      {-}
  published
    property Name : AnsiString
      read f_Name
      write SetName;
      {* - имя формы с которой связана операция. }
    property UserType : Integer
      read f_UserType
      write SetUserType
      default vcm_utAny;
      {* - идентификатор пользовательского типа на форме. }
    property ZoneType : TvcmZoneType
      read f_ZoneType
      write SetZoneType
      default vcm_ztAny;
      {* - тип зоны в которой находится форма. }
    property Caption : AnsiString
      read f_Caption
      write SetCaption;
    property DoExecuteIfExists : Boolean
      read f_DoExecuteIfExists
      write SetDoExecuteIfExists
      default False;
      {* - вызывать обработчик операции. }
    property RepeatedActivationBehaviour: TvcmRepeatedActivationBehaviour
      read f_RepeatedActivationBehaviour
      write f_RepeatedActivationBehaviour
      default vcm_rabClose;
      {* - тип активации. }
  end;//TvcmFormActivate

  TvcmRepOperationsCollectionItem = class(TvcmBaseOperationsCollectionItem)
   {* Элемент коллекции операций. }
    private
    // internal fields
      f_Holders      : TvcmOperationsCollectionItemList;
      f_FormActivate : TvcmFormActivate;
      f_MenuItem     : TvcmMenuItemsCollectionItem;
      f_RestrictOptions : TvcmOperationOptions;
    protected
    // property methods
      function  GetDefaultOptions: TvcmOperationOptions;
        override;
        {-}
      {$IfNDef DesignTimeLibrary}
      function  pm_GetCategory: AnsiString;
        override;
        {-}
      {$EndIf  DesignTimeLibrary}  
      function  pm_GetCategoryID: Integer;
      procedure pm_SetCategoryID(const aValue: Integer);
        {-}
      function  pm_GetIsFormActivateDefined : Boolean;
        {-}
      function  pm_GetOperationType: TvcmOperationType;
        override;
      procedure pm_SetOperationType(aValue: TvcmOperationType);
        override;
        {-}
      procedure pm_SetShortCut(aValue: TShortCut);
        override;
        {-}
      procedure pm_SetSecondaryShortCuts(aValue: TShortCutList);
        override;
        {-}
      function pm_GetFormActivate: TvcmFormActivate;
        {-}
      procedure pm_SetFormActivate(const Value: TvcmFormActivate);
        {-}
      procedure SetShortCuts(aShortCut: TShortCut; aSecondaryShortCuts: TShortCutList);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
      procedure AddHolder(aHolder: TvcmOperationsCollectionItem);
        {-}
      procedure RemoveHolder(aHolder: TvcmOperationsCollectionItem);
        {-}
      procedure RemoveShortCut(aShortCut: TShortCut);
        override;
        {-}
      function  Handled(aTypes: TvcmHandleTypes): Boolean;
        override;
        {-}
      {$IfNDef DesignTimeLibrary}
      function  MakeID(const aName: AnsiString): Integer;
        override;
        {-}
      {$EndIf  DesignTimeLibrary}  
    published
    // published properties
      property OperationType;
        {-}
      property GroupID;
        {-}
      property Options
        default [];
        {-}
      property IsDefault;
        {-}
      property FormActivate : TvcmFormActivate
        read pm_GetFormActivate
        write pm_SetFormActivate;
        {* - идентификатор формы, состояниями активации (деактивации) которой
             необходимо управлять. }
      property IsFormActivateDefined : Boolean
        read pm_GetIsFormActivateDefined;
        {* - определяет определена ли у операции форма, которой нужно управлять. }
      property CategoryID: Integer
        read pm_GetCategoryID
        write pm_SetCategoryID
        default 0;
        {-}
      property RestrictOptions: TvcmOperationOptions
        read f_RestrictOptions
        write f_RestrictOptions
        default [];
        {-}    
  end;{ Описатель операции }

implementation

uses
  Forms,
  SysUtils,
  Menus,

  afwFacade,

  vcmForm,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmInternalConst
  ;

// start class TvcmRepOperationsCollectionItem

{ TvcmRepOperationsCollectionItem }

constructor TvcmRepOperationsCollectionItem.Create(
  Collection: TCollection);
begin
 inherited Create(Collection);
end;

procedure TvcmRepOperationsCollectionItem.Cleanup;
  //override;
  {-}
var
 l_Index : Integer;
begin
 vcmFree(f_FormActivate);
 if (f_Holders <> nil) then
  with f_Holders do
   for l_Index := 0 to Pred(Count) do
    Items[l_Index].SetRep(nil);
 vcmFree(f_Holders);
 inherited;
end;

{$IfNDef DesignTimeLibrary}
function TvcmRepOperationsCollectionItem.MakeID(const aName: AnsiString): Integer;
  //override;
  {-}
begin
 Result := Succ(Index);
end;
{$EndIf  DesignTimeLibrary}

procedure TvcmRepOperationsCollectionItem.AddHolder(aHolder: TvcmOperationsCollectionItem);
  {-}
begin
 //if (aHolder Is TvcmOperationsCollectionItem) then
 begin
  if (f_Holders = nil) then
   f_Holders := TvcmOperationsCollectionItemList.Create;
  if (f_Holders.IndexOf(aHolder) < 0) then
  begin
   f_Holders.Add(aHolder);
   aHolder.SetRep(Self);
  end;//f_Holders.IndexOf(Pointer(aHolder) < 0
 end;//aHolder Is TvcmOperationsCollectionItem
end;

procedure TvcmRepOperationsCollectionItem.RemoveHolder(aHolder: TvcmOperationsCollectionItem);
  {-}
begin
 //if (aHolder Is TvcmOperationsCollectionItem) then
 begin
  if (f_Holders <> nil) then
   f_Holders.Remove(aHolder);
  aHolder.SetRep(nil);
 end;//aHolder Is TvcmOperationsCollectionItem
end;

procedure TvcmRepOperationsCollectionItem.RemoveShortCut(aShortCut: TShortCut);
  {-}
  //override;

var
 l_ShortCut  : TShortCut;

 procedure l_RemoveSecondaryShortcut(aIndex: Integer);
 var
  l_ShortCuts : TShortCutList;
 begin//l_RemoveSecondaryShortcut
  l_ShortCuts := TShortCutList.Create;
  try
   l_ShortCuts.Assign(SecondaryShortCuts);
   l_ShortCuts.Delete(aIndex);
   SecondaryShortCuts := l_ShortCuts;
  finally
   FreeAndNil(l_ShortCuts);
  end;//try..finally
 end;//l_RemoveSecondaryShortcut

var
 i : Integer;
begin
 if (aShortCut = 0) then
  Exit;
 SecondaryShortCuts.OnChange := nil;
 try
  if ShortCut = aShortCut then
  begin
   if SecondaryShortCuts.Count > 0 then
   begin
    l_ShortCut := SecondaryShortCuts.ShortCuts[0];
    l_RemoveSecondaryShortcut(0);
    ShortCut := l_ShortCut;
   end
   else
    ShortCut := 0;
  end
  else
  begin
   for i := 0 to SecondaryShortCuts.Count - 1 do
    if SecondaryShortCuts.ShortCuts[i] = aShortCut then
    begin
     l_RemoveSecondaryShortcut(i);
     break;
    end;
  end;
 finally
  SecondaryShortCuts.OnChange := OnSecondaryShortCutsChange;
 end;//try..finally
end;

function TvcmRepOperationsCollectionItem.GetDefaultOptions: TvcmOperationOptions;
  //override;
  {-}
begin
 Result := [];
end;

{$IfNDef DesignTimeLibrary}
function TvcmRepOperationsCollectionItem.pm_GetCategory: AnsiString;
  //override;
  {-}
begin
 if (f_MenuItem = nil) then
  Result := inherited pm_GetCategory
 else
  Result := f_MenuItem.Caption;
end;
{$EndIf DesignTimeLibrary}

function TvcmRepOperationsCollectionItem.pm_GetCategoryID: Integer;
  {-}
begin
 if (f_MenuItem = nil) then
  Result := 0
 else
  Result := f_MenuItem.LinkID;
end;

procedure TvcmRepOperationsCollectionItem.pm_SetCategoryID(const aValue: Integer);
  {-}
begin
 if (g_MenuManager <> nil) AND (g_MenuManager Is TvcmCustomMenuManager) then
 begin
  if (aValue = 0) then
   f_MenuItem := nil
  else
   f_MenuItem := TvcmCustomMenuManager(g_MenuManager).MainMenuItems.FindItemByID(aValue) As TvcmMenuItemsCollectionItem;
 end;//g_MenuManager <> nil
end;

function TvcmRepOperationsCollectionItem.pm_GetIsFormActivateDefined : Boolean;
begin
 Result := Assigned(f_FormActivate) and (f_FormActivate.Name <> '');
end;

function TvcmRepOperationsCollectionItem.pm_GetOperationType: TvcmOperationType;
  //override;
  {-}
begin
 Result := inherited pm_GetOperationType;
 if (Result = vcm_otInternal) then
 begin
  if IsLinkedToModule then
  begin
   {$IfNDef DesignTimeLibrary}
   Assert(false);
   {$EndIf  DesignTimeLibrary}
//   Result := vcm_otModuleInternal;
//   f_OperationType := Result;
  end;//IsLinkedToModule
 end;//Result = vcm_otInternal
end;

procedure TvcmRepOperationsCollectionItem.pm_SetOperationType(aValue: TvcmOperationType);
  //override;
  {-}
begin
 if (aValue = vcm_otInternal) AND IsLinkedToModule then
 begin
  {$IfNDef DesignTimeLibrary}
  Assert(false);
  {$EndIf  DesignTimeLibrary}
  Exit;
 end;//aValue in vcm_otInternal
 inherited;
end;

procedure TvcmRepOperationsCollectionItem.pm_SetShortCut(aValue: TShortCut);
  //virtual;
  {-}
begin
 SetShortCuts(aValue, SecondaryShortCuts);
end;

procedure TvcmRepOperationsCollectionItem.pm_SetSecondaryShortCuts(aValue: TShortCutList);
  //override;
  {-}
begin
 SetShortCuts(ShortCut, aValue);
end;

procedure TvcmRepOperationsCollectionItem.pm_SetFormActivate(const Value: TvcmFormActivate);
  {-}
begin
 f_FormActivate.Assign(Value);
end;

procedure TvcmRepOperationsCollectionItem.SetShortCuts(aShortCut: TShortCut; aSecondaryShortCuts: TShortCutList);
  //override;
  {-}
var
 i,
 j             : Integer;
 l_ShortCut    : TShortCut;
 l_ShortCuts   : TShortCutList;
 l_IsExistFlag : Boolean;

 procedure l_ClearShortCuts;
 var
  i          : Integer;
  l_ShortCut : TShortCut;
 begin
  if SecondaryShortCuts.Count > 0 then
  begin
   for i := 0 to SecondaryShortCuts.Count - 1 do
   begin
    l_ShortCut := SecondaryShortCuts.ShortCuts[i];
    ResetShortCutHandler(l_ShortCut);
   end;
   inherited pm_SetSecondaryShortCuts(nil);
  end;
  if ShortCut <> 0 then
  begin
   l_ShortCut := ShortCut;
   ResetShortCutHandler(l_ShortCut);
   inherited pm_SetShortCut(0);
  end;
 end;
begin
 SecondaryShortCuts.OnChange := nil;
 try
  l_ShortCuts := TShortCutList.Create;
  try
   if aShortCut <> 0 then
    l_ShortCuts.Add(ShortCutToText(aShortCut));
   if Assigned(aSecondaryShortCuts) and (aSecondaryShortCuts.Count > 0) then
    for i := 0 to aSecondaryShortCuts.Count - 1 do
    begin
     l_IsExistFlag := false;
     l_ShortCut := aSecondaryShortCuts.ShortCuts[i];
     if l_ShortCut <> 0 then
     begin
      for j := 0 to l_ShortCuts.Count - 1 do
       if l_ShortCuts.ShortCuts[j] = l_ShortCut then
       begin
        l_IsExistFlag := true;
        break;
       end;
      if not l_IsExistFlag then
       l_ShortCuts.Add(ShortCutToText(l_ShortCut));
     end;
    end;
   l_ClearShortCuts;
   if (l_ShortCuts.Count > 0) then
   begin
    l_ShortCut := l_ShortCuts.ShortCuts[0];
    ResetShortCutHandler(l_ShortCut, ControllerCommand);
    inherited pm_SetShortCut(l_ShortCut);
    l_ShortCuts.Delete(0);
    for i := 0 to l_ShortCuts.Count - 1 do
    begin
     l_ShortCut := l_ShortCuts.ShortCuts[i];
     ResetShortCutHandler(l_ShortCut, ControllerCommand);
    end;//for i
    inherited pm_SetSecondaryShortCuts(l_ShortCuts);
   end;//l_ShortCuts.Count > 0
  finally
   l_ShortCuts.Free;
  end;//try..finally
 finally
  SecondaryShortCuts.OnChange := OnSecondaryShortCutsChange;
 end;//try..finally
end;

function TvcmRepOperationsCollectionItem.pm_GetFormActivate: TvcmFormActivate;
begin
 if not Assigned(f_FormActivate) then
  f_FormActivate := TvcmFormActivate.Create(Self);
 Result := f_FormActivate;
end;

function TvcmRepOperationsCollectionItem.Handled(aTypes: TvcmHandleTypes): Boolean;
begin
 Result := inherited Handled(aTypes);
 if not Result AND (([vcm_htContext, vcm_htGlobal] * aTypes) <> []) then
  Result := IsFormActivateDefined;
end;

{ TvcmFormActivate }

procedure TvcmFormActivate.Assign(Source : TPersistent);
var
 lLink : TvcmFormActivate;
begin

 if not (Source is TvcmFormActivate) then
  Exit;

 lLink := TvcmFormActivate(Source);

 f_ZoneType     := lLink.ZoneType;
 f_Name         := lLink.Name;
 f_UserType     := lLink.UserType;
 f_Caption      := lLink.Caption;
 f_RepeatedActivationBehaviour := lLink.RepeatedActivationBehaviour;
end;

constructor TvcmFormActivate.Create(aOperation : TvcmRepOperationsCollectionItem);
begin
 inherited Create;
 f_Operation := aOperation;
 SetDefault;
end;

procedure TvcmFormActivate.SetDefault;
begin
 f_ZoneType           := vcm_ztAny;
 f_UserType           := vcm_utAny;
 f_DoExecuteIfExists  := False;
 f_RepeatedActivationBehaviour := vcm_rabClose;
 f_Caption            := '';
end;

procedure TvcmFormActivate.SetCaption(const Value: AnsiString);
begin
 f_Caption := Value;
end;

procedure TvcmFormActivate.SetDoExecuteIfExists(const Value: Boolean);
begin
 f_DoExecuteIfExists := Value;
end;

procedure TvcmFormActivate.SetName(const Value: AnsiString);
begin
 f_Name := Value;
 if f_Name = '' then
  SetDefault;
end;

procedure TvcmFormActivate.SetUserType(const Value: Integer);
begin
 f_UserType := Value;
end;

procedure TvcmFormActivate.SetZoneType(const Value: TvcmZoneType);
begin
 f_ZoneType := Value;
end;

end.

