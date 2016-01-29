unit vcmRepositoryEx;
{* Средства для регистрации объектов. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepositoryEx - }
{ Начат: 21.03.2003 12:20 }
{ $Id: vcmRepositoryEx.pas,v 1.16 2014/08/22 09:45:10 kostitsin Exp $ }

// $Log: vcmRepositoryEx.pas,v $
// Revision 1.16  2014/08/22 09:45:10  kostitsin
// чиню библиотеки компонент
//
// Revision 1.15  2014/04/22 14:20:13  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.14  2012/11/01 09:42:19  lulin
// - забыл точку с запятой.
//
// Revision 1.13  2012/11/01 07:44:02  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.12  2011/05/06 14:28:06  lulin
// - правим IfDef'ы.
//
// Revision 1.11  2010/11/12 15:51:19  lulin
// {RequestLink:238944679}.
// - вторая итерация.
//
// Revision 1.10  2010/09/15 15:11:05  lulin
// {RequestLink:235047275}.
//
// Revision 1.9  2009/12/22 16:46:48  lulin
// - удалось запустить тест создающий форму.
//
// Revision 1.8  2009/02/20 10:08:34  lulin
// - чистка комментариев.
//
// Revision 1.7  2006/12/10 16:35:34  lulin
// - cleanup.
//
// Revision 1.6  2005/07/14 17:00:14  lulin
// - cleanup: удалена информация, ненужная для design-time.
//
// Revision 1.5  2005/07/14 16:39:42  lulin
// - new behavior: в run-time получаем ID сущности и модуля по их имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.4  2005/07/14 16:02:46  lulin
// - new behavior: в run-time получаем ID операции по ее имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.3  2004/09/22 05:41:29  lulin
// - оптимизация - убраны код и данные, не используемые в Run-Time.
//
// Revision 1.2  2004/08/11 16:14:23  law
// - более просто из ContextID вычисляем KeyWord.
//
// Revision 1.1  2003/04/01 12:54:42  law
// - переименовываем MVC в VCM.
//
// Revision 1.3  2003/03/21 11:32:10  law
// - change: добавлены редакторы свойства Caption.
//
// Revision 1.2  2003/03/21 10:13:34  law
// - cleanup: удалены модули vcm*Repository.
//
// Revision 1.1  2003/03/21 09:39:28  law
// - new _module: vcmRepositoryEx.
//

{$Include vcmDefine.inc }

interface

type
  TvcmRep = (vcm_repEntity,
             {$IfDef DesignTimeLibrary}
             vcm_repEntityCategory,
             {$EndIf DesignTimeLibrary}
             vcm_repOperation,
             vcm_repModule
             {$IfDef DesignTimeLibrary}
             ,
             vcm_repEntityCaption,
             vcm_repOperationCaption
             {$EndIf DesignTimeLibrary}
             );

function vcmGetID(aRep        : TvcmRep;
                  const aName : String;
                  aParentID   : Integer = 0): Integer;
  {* - возвращает идентификатор объекта по ее имени. }
{$IfDef DesignTimeLibrary}
function vcmGetCount(aRep: TvcmRep): Integer;
  {* - возвращает количество объектов. }
function vcmGetName(aRep: TvcmRep; anIndex: Integer): String;
  {* - возвращает имя объекта по его индексу. }
{$EndIf DesignTimeLibrary}  
function vcmGetNameByID(aRep      : TvcmRep;
                        anIndex   : Integer;
                        aParentID : Integer = 0): String;
  {* - возвращает имя объекта по его ID. }

implementation

uses
  {$IfDef DesignTimeLibrary}
  vcmRepository
  {$Else  DesignTimeLibrary}
  SysUtils,
  
  vcmBaseCollectionItem,
  vcmBaseMenuManager
  {$EndIf  DesignTimeLibrary}
  ;

{$IfDef DesignTimeLibrary}
var
 g_Index : array [Low(TvcmRep) .. High(TvcmRep)] of TvcmIndex =
  (vcmIndexEmpty,
   {$IfDef DesignTimeLibrary}
   vcmIndexEmpty,
   {$EndIf DesignTimeLibrary}
   vcmIndexEmpty,
   vcmIndexEmpty
   {$IfDef DesignTimeLibrary}
   ,
   vcmIndexEmpty,
   vcmIndexEmpty
   {$EndIf DesignTimeLibrary}
   );
{$EndIf DesignTimeLibrary}   

function vcmGetID(aRep        : TvcmRep;
                  const aName : String;
                  aParentID   : Integer = 0): Integer;
  {-}
{$IfNDef DesignTimeLibrary}
var
 l_Item : TvcmBaseCollectionItem;
{$EndIf  DesignTimeLibrary}
begin
 {$IfNDef DesignTimeLibrary}
 Assert((aRep <> vcm_repOperation) OR (aParentID <> 0),
        'Не задана сущность, для которой получается ID операции');
 if (aRep = vcm_repOperation) then
 begin
  Assert(g_MenuManager <> nil);
  l_Item := g_MenuManager.GetOperationableObjectByID(aParentID).Operations.FindItemByName(aName);
  if (l_Item = nil) then
  begin
   {$If not Defined(nsTest) OR Defined(InsiderTest)}
   if (aParentID < 0) then
   // - это модуль
   {$IfEnd}
   begin
    l_Item := g_MenuManager.GetOperationableObjectByID(aParentID).Operations.Add As TvcmBaseCollectionItem;
    l_Item.Name := aName;
   end;//aParentID < 0
  end;//l_Item = nil
  Assert(l_Item <> nil, Format('Для объекта %s в StdRes не определена операция %s', [g_MenuManager.GetOperationableObjectByID(aParentID).Name, aName]));
  Result := l_Item.GetID;
 end//aRep = vcm_repOperation
 else
 if (aRep = vcm_repEntity) then
  Result := g_MenuManager.GetOperationableObjectByName(aName, false).GetID
 else
 if (aRep = vcm_repModule) then
  Result := g_MenuManager.GetOperationableObjectByName(aName, true).GetID
 else
 begin
  Result := 0;
  Assert(false); 
 end;//aRep = vcm_repModule
 {$Else   DesignTimeLibrary}
 Result := vcmGetObjectID(aName, g_Index[aRep]);
 {$EndIf  DesignTimeLibrary}
end;

{$IfDef DesignTimeLibrary}
function vcmGetCount(aRep: TvcmRep): Integer;
  {-}
begin
 Result := vcmGetObjectCount(g_Index[aRep]);
end;

function vcmGetName(aRep: TvcmRep; anIndex: Integer): String;
  {-}
begin
 Result := vcmGetObjectName(anIndex, g_Index[aRep]);
end;
{$EndIf DesignTimeLibrary}

function vcmGetNameByID(aRep      : TvcmRep;
                        anIndex   : Integer;
                        aParentID : Integer = 0): String;
  {* - возвращает имя объекта по его ID. }
{$IfNDef DesignTimeLibrary}
var
 l_Item : TvcmBaseCollectionItem;
{$EndIf  DesignTimeLibrary}
begin
 {$IfNDef DesignTimeLibrary}
 Assert((aRep <> vcm_repOperation) OR (aParentID <> 0),
        'Не задана сущность, для которой получается ID операции');
 if (aRep = vcm_repOperation) then
 begin
  Assert(g_MenuManager <> nil);
  l_Item := g_MenuManager.GetOperationableObjectByID(aParentID).Operations.FindItemByID(anIndex);
  Assert(l_Item <> nil, Format('Для объекта %s в StdRes не определена операция %d', [g_MenuManager.GetOperationableObjectByID(aParentID).Name, anIndex]));
  Result := l_Item.Name;
 end//aRep = vcm_repOperation
 else
 if (aRep = vcm_repEntity) then
  Result := g_MenuManager.GetOperationableObjectByID(anIndex).Name
 else
 if (aRep = vcm_repModule) then
  Result := g_MenuManager.GetOperationableObjectByID(-anIndex).Name;
 {$Else   DesignTimeLibrary}
 Result := vcmGetObjectNameByID(anIndex, g_Index[aRep]);
 {$EndIf  DesignTimeLibrary}
end;

{$IfDef DesignTimeLibrary}
procedure __Done;
var
 l_Index : TvcmRep;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  vcmFreeIndex(g_Index[l_Index]);
end;
{$EndIf  DesignTimeLibrary}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\vcmRepositoryEx.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\vcmRepositoryEx.pas initialization leave'); {$EndIf}
finalization
{$IfDef DesignTimeLibrary}
 __Done;
{$EndIf DesignTimeLibrary} 

end.

