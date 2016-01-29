unit vcmFormsCollectionItem;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmFormsCollectionItem - }
{ Начат: 27.11.2003 21:14 }
{ $Id: vcmFormsCollectionItem.pas,v 1.26 2015/08/16 16:03:24 kostitsin Exp $ }

// $Log: vcmFormsCollectionItem.pas,v $
// Revision 1.26  2015/08/16 16:03:24  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.25  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.24  2012/04/05 19:44:26  lulin
// {RequestLink:237994598}
//
// Revision 1.23  2011/08/01 14:51:33  lulin
// {RequestLink:274825697}.
//
// Revision 1.22  2011/03/16 13:26:12  lulin
// - вычищаем мусорок.
//
// Revision 1.21  2011/03/11 18:05:10  lulin
// {RequestLink:228688510}.
// - впихиваем БП в специально подготовленный контейнер.
//
// Revision 1.20  2010/06/01 18:51:49  lulin
// {RequestLink:215549303}.
// - вычищаем ненужные данные.
//
// Revision 1.19  2010/06/01 18:42:26  lulin
// {RequestLink:215549303}.
// - вычищаем ненужные данные.
//
// Revision 1.18  2010/06/01 17:49:12  lulin
// {RequestLink:215549303}.
// - теперь локализуем параметры пользовательских типов форм через стандартный механизм локализации строк.
//
// Revision 1.17  2010/04/27 18:02:24  lulin
// {RequestLink:159352361}.
// - признак возможности закрытия формы переносим на модель.
//
// Revision 1.16  2010/04/23 16:37:49  lulin
// {RequestLink:159352361}.
//
// Revision 1.15  2009/12/22 16:46:50  lulin
// - удалось запустить тест создающий форму.
//
// Revision 1.14  2009/10/19 13:07:56  lulin
// {RequestLink:159360578}. №7.
//
// Revision 1.13  2006/12/10 17:05:15  lulin
// - cleanup.
//
// Revision 1.12  2006/11/03 11:00:32  lulin
// - объединил с веткой 6.4.
//
// Revision 1.11.6.1  2006/10/17 07:37:05  lulin
// - ресурсы компонент загружаем в специально предназначенную для этого коллекцию.
//
// Revision 1.11  2006/03/24 12:31:49  lulin
// - cleanup: не пишем пустые коллекции.
//
// Revision 1.10  2006/03/14 14:38:24  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.9  2006/03/14 13:04:52  lulin
// - разделяем UserType'ы в репозитарии и в формах.
//
// Revision 1.8  2006/01/16 18:14:22  lulin
// - cleanup.
//
// Revision 1.7  2005/07/25 12:13:33  mmorozov
// new: public property FormClass;
//
// Revision 1.6  2004/09/22 14:32:43  lulin
// - доделан DblClick в коллекции форм (открывает форму). Для этого пришлось завести свойство TvcmFormsCollectionItem.FormFile, т.к. я не нашел как средствами ToolsAPI найти файл от формы проекта.
//
// Revision 1.5  2004/09/22 06:36:18  lulin
// - оптимизация - TvcmFormsCollection теперь тоже ищет элементы по индексу (в роли которого выступает класс формы).
//
// Revision 1.4  2003/12/01 11:01:38  law
// - bug fix: поправлена генерация UserType'ов.
// - bug fix: свойство Weigth переименовано в _Weight.
//
// Revision 1.3  2003/11/30 12:38:16  law
// - bug fix: при убивании формы удаляем ссылку на нее из MenuManager'а.
//
// Revision 1.2  2003/11/30 11:39:41  law
// - new behavior: автогенерируем типы пользовательских объектов.
//
// Revision 1.1  2003/11/27 18:55:57  law
// - new prop: TvcmBaseMenuManager._AppForms - список всех форм приложения.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,
  
  vcmInterfaces,

  vcmBaseCollectionItem,
  vcmBaseUserTypesCollection,
  vcmComponentResCollection,

  vcmEntityForm
  ;

type
  TvcmFormsCollectionItem = class(TvcmBaseCollectionItem)
    private
    // property fields
      {$IfDef DesignTimeLibrary}
      f_Form       : Pointer;
      {$EndIf DesignTimeLibrary}
      f_FormClass  : RvcmEntityForm;
//      f_UserTypes  : TvcmRepUserTypesCollection;
(*      {$IfDef DesignTimeLibrary}
      f_FormFile   : AnsiString;
      {$EndIf DesignTimeLibrary}*)
      f_Components : TvcmComponentResCollection;
    protected
    // property methods
(*      {$IfNDef DesignTimeLibrary}
      function  pm_GetFormFile: AnsiString;
      procedure pm_SetFormFile(const aValue: AnsiString);
        {-}
      {$EndIf  DesignTimeLibrary}*)
      {$IfDef DesignTimeLibrary}
      function  pm_GetForm: TvcmEntityForm;
      procedure pm_SetForm(const aValue: TvcmEntityForm);
        {-}
      {$EndIf DesignTimeLibrary}  
(*      function  pm_GetUserTypes: TvcmBaseUserTypesCollection;
      procedure pm_SetUserTypes(const aValue: TvcmBaseUserTypesCollection);
      function  UserTypesStored: Boolean;*)
        {-}
      function  pm_GetCaption: AnsiString;
        override;
        {-}
      procedure SetCaptionFromName(const aName: AnsiString);
        override;
        {-}
    procedure pm_SetCaption(const aName: AnsiString);
      override;
      {-}
      function GetCaptionStored: Boolean;
        override;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
      function GetID: Integer;
        override;
        {-}
    public
    // public properties
      {$IfDef DesignTimeLibrary}
      property Form: TvcmEntityForm
        read pm_GetForm
        write pm_SetForm;
        {-}
      {$EndIf DesignTimeLibrary}
      property FormClass : RvcmEntityForm
        read f_FormClass
        {$IfNDef DesignTimeLibrary}
        write f_FormClass
        {$EndIf DesignTimeLibrary}
        ;
        {-}
      property Components: TvcmComponentResCollection
        read f_Components;
        {-}
    published
    // public published
(*      property FormFile: AnsiString
        {$IfDef DesignTimeLibrary}
        read f_FormFile
        write f_FormFile
        {$Else  DesignTimeLibrary}
        read pm_GetFormFile
        write pm_SetFormFile
        {$EndIf DesignTimeLibrary}
        stored false;
        {-}*)
(*    private
      property UserTypes: TvcmBaseUserTypesCollection
        read pm_GetUserTypes
        write pm_SetUserTypes
        stored false{UserTypesStored};
        {-}*)
  end;//TvcmFormsCollectionItem

implementation

uses
  TypInfo,
  {$IfDef DesignTimeLibrary}
  ToolsAPI,
  {$EndIf DesignTimeLibrary}
  
  SysUtils,
  StrUtils,

  vcmBase,
  vcmBaseMenuManager
  ;

// start class TvcmFormsCollectionItem

constructor TvcmFormsCollectionItem.Create(Collection: TCollection);
  //override;
  {-}
begin
 inherited;
// f_UserTypes := TvcmRepUserTypesCollection.Create(Self);
 f_Components := TvcmComponentResCollection.Create(Self);
end;

procedure TvcmFormsCollectionItem.Cleanup;
  //override;
  {-}
begin
 {$IfNDef DesignTimeLibrary}
 FormClass := nil;
 {$Else  DesignTimeLibrary}
 Form := nil;
 {$EndIf DesignTimeLibrary}
 //FreeAndNil(f_UserTypes);
 // - это надо ПОСЛЕ присваивания Form
 FreeAndNil(f_Components);
 inherited;
end;

function TvcmFormsCollectionItem.GetID: Integer;
  //override;
  {-}
begin
 Result := Integer(f_FormClass);
end;

(*{$IfNDef DesignTimeLibrary}
function TvcmFormsCollectionItem.pm_GetFormFile: AnsiString;
  {-}
begin
 Result := '';
end;

procedure TvcmFormsCollectionItem.pm_SetFormFile(const aValue: AnsiString);
  {-}
begin
end;
{$EndIf  DesignTimeLibrary}*)

{$IfDef DesignTimeLibrary}
function TvcmFormsCollectionItem.pm_GetForm: TvcmEntityForm;
  {-}
begin
 Result := TvcmEntityForm(f_Form);
end;
{$EndIf DesignTimeLibrary}

{$IfDef DesignTimeLibrary}
procedure TvcmFormsCollectionItem.pm_SetForm(const aValue: TvcmEntityForm);
  {-}
{$IfDef DesignTimeLibrary}
var
 l_S    : IOTAModuleServices;
 l_M    : IOTAModule;
 l_Name : AnsiString;
 l_Path : AnsiString;
 l_TI   : PTypeData;
{$EndIf DesignTimeLibrary}
begin
 {$IfNDef DesignTimeLibrary}
 if (f_Form <> aValue) then
 {$EndIf  DesignTimeLibrary}
 begin
  f_Form := Pointer(aValue);
  if (aValue <> nil) then
  begin
   f_FormClass := RvcmEntityForm(aValue.ClassType);
   {$IfDef DesignTimeLibrary}
(*   if (FormFile = '') then
   begin
    l_S := vcmGetTAModules;
    if (l_S <> nil) then
    begin
     l_TI := GetTypeData(f_FormClass.ClassInfo);
     l_M := vcmGetTAModule(ChangeFileExt(ExtractFileName(l_TI.UnitName), ''));
     if (l_M = nil) then
      l_M := l_S.FindFormModule(Name);
     if (l_M <> nil) then
     begin
      l_Name := l_M.FileName;
      if (g_MenuManager <> nil) then
      begin
       l_Path := g_MenuManager.UnitPath;
       if ANSIStartsText(l_Path, l_Name) then
        System.Delete(l_Name, 1, Length(l_Path));
      end;//g_MenuManager <> nil
      FormFile := l_Name;
     end;//l_M <> nil
    end;//l_S <> nil
   end;//FormFile = ''*)
   //UserTypes := aValue.UserTypes;
   {$EndIf DesignTimeLibrary}
  end;//aValue <> nil
 end;//f_Form <> aValue
end;
{$EndIf DesignTimeLibrary}

function TvcmFormsCollectionItem.pm_GetCaption: AnsiString;
  //override;
  {-}
begin
 Result := inherited pm_GetCaption;
 {$IfNDef DesignTimeLibrary}
 //Assert(false);
 // - это можно включить когда заголовки форм переведём на локализованные константы
 {$EndIf DesignTimeLibrary}
end;

procedure TvcmFormsCollectionItem.pm_SetCaption(const aName: AnsiString);
  //override;
  {-}
begin
 //{$IfDef DesignTimeLibrary}
 inherited;
 // - это можно выключить когда заголовки форм переведём на локализованные константы
 //{$EndIf DesignTimeLibrary}
end;

procedure TvcmFormsCollectionItem.SetCaptionFromName(const aName: AnsiString);
  //override;
  {-}
begin
 {$IfDef DesignTimeLibrary}
 inherited;
 {$EndIf DesignTimeLibrary}
end;

function TvcmFormsCollectionItem.GetCaptionStored: Boolean;
  //override;
  {-}
begin
 Result := false;
end;

(*function TvcmFormsCollectionItem.pm_GetUserTypes: TvcmBaseUserTypesCollection;
  {-}
begin
 Result := f_UserTypes;
end;

procedure TvcmFormsCollectionItem.pm_SetUserTypes(const aValue: TvcmBaseUserTypesCollection);
  {-}
begin
 if (aValue = nil) then
  f_UserTypes.Clear
 else
  f_UserTypes.Assign(aValue);
end;*)

(*function TvcmFormsCollectionItem.UserTypesStored: Boolean;
  {-}
begin
 Result := (f_UserTypes <> nil) AND (f_UserTypes.Count > 0);
end;*)
  
end.

