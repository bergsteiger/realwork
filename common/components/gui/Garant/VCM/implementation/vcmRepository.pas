unit vcmRepository;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRepository - }
{ Начат: 14.03.2003 11:23 }
{ $Id: vcmRepository.pas,v 1.13 2012/03/23 13:03:43 lulin Exp $ }

// $Log: vcmRepository.pas,v $
// Revision 1.13  2012/03/23 13:03:43  lulin
// - отпиливаем настройки.
//
// Revision 1.12  2011/05/18 10:42:08  lulin
// {RequestLink:266412246}.
//
// Revision 1.11  2010/03/01 14:03:01  lulin
// {RequestLink:193823544}.
// - первый шаг.
//
// Revision 1.10  2009/02/20 10:08:34  lulin
// - чистка комментариев.
//
// Revision 1.9  2008/03/19 17:09:12  lulin
// - <K>: 87589523.
//
// Revision 1.8  2004/09/28 17:22:00  lulin
// - в первом приближении сделал кеш документов. Пока без вымещения покументов на диск.
//
// Revision 1.7  2004/09/15 16:20:45  lulin
// - bug fix: AllEverestComponents7 не собирался из-за Str_Man'а.
// - bug fix: AllEverestComponents7 не загружался из-за шаблонов.
//
// Revision 1.6  2004/08/16 09:20:45  demon
// - cleanup: uses l3Dict
//
// Revision 1.5  2004/08/11 16:16:15  law
// - bug fix.
//
// Revision 1.4  2004/08/11 16:14:23  law
// - более просто из ContextID вычисляем KeyWord.
//
// Revision 1.3  2004/04/09 11:27:45  law
// - new class: _TvcmStringList.
//
// Revision 1.2  2003/06/03 14:08:12  law
// - bug fix: не собиралось с опцией _vcmNeedL3.
// - bug fix: при закрытии приложения не освобождались модули.
//
// Revision 1.1  2003/04/01 12:54:42  law
// - переименовываем MVC в VCM.
//
// Revision 1.6  2003/03/25 11:28:07  law
// - bug fix: не учитывался пустой идентификатор.
//
// Revision 1.5  2003/03/21 09:39:28  law
// - new _module: vcmRepositoryEx.
//
// Revision 1.4  2003/03/18 16:14:32  law
// - change: добавлены редакторы свойств имен сущности, операции и категории сущности.
//
// Revision 1.3  2003/03/14 12:44:13  law
// - change: отвязываем vcm от l3.
//
// Revision 1.2  2003/03/14 12:20:52  law
// - change: отвязываем vcm от l3.
//
// Revision 1.1  2003/03/14 09:22:35  law
// - change: отвязываем vcm от l3.
//

{$Include vcmDefine.inc }

interface

uses
  l3StringMap
  ;
  
type
  TvcmIndex = Tl3StringMap;

const
  vcmIndexEmpty = nil;

function vcmGetObjectID(const aName  : String;
                        var theIndex : TvcmIndex): Integer;
  {* - возвращает идентификатор объекта по его имени. }
function vcmGetObjectCount(theIndex : TvcmIndex): Integer;
  {* - количество объектов в репозитарии. }
function vcmGetObjectName(anIndex: Integer; theIndex : TvcmIndex): String;
  {* - возвращает имя объекта по его номеру. }
function vcmGetObjectNameByID(anIndex: Integer; theIndex : TvcmIndex): String;
  {* - возвращает имя объекта по его ID. }
procedure vcmFreeIndex(var theIndex : TvcmIndex);
  {-}
  
implementation

uses
  SysUtils,
  
  l3Base,
  l3KeyWrd,

  vcmBase
  ;

function vcmGetObjectID(const aName  : String;
                        var theIndex : TvcmIndex): Integer;
  {* - возвращает идентификатор объекта по его имени. }
begin
 if (aName = '') then
  Result := 0
 else
 begin
  if (theIndex = nil) then
   theIndex := Tl3StringMap.Create;
  Result := Succ(theIndex.ResolveString(aName));
 end;//aName = ''
end;

function vcmGetObjectCount(theIndex : TvcmIndex): Integer;
  {* - количество объектов в репозитарии. }
begin
 if (theIndex = vcmIndexEmpty) then
  Result := 0
 else
  Result := theIndex.Count;
end;

function vcmGetObjectName(anIndex: Integer; theIndex : TvcmIndex): String;
  {* - возвращает имя объекта по его номеру. }
begin
 if (theIndex = vcmIndexEmpty) then
  Result := ''
 else
  Result := Tl3KeyWord(theIndex.Items[anIndex]).AsString;
end;

function vcmGetObjectNameByID(anIndex: Integer; theIndex : TvcmIndex): String;
  {* - возвращает имя объекта по его ID. }
begin
 if (theIndex = vcmIndexEmpty) then
  Result := ''
 else
  Result := theIndex.DRByID[Pred(anIndex)].AsString;
end;

procedure vcmFreeIndex(var theIndex : TvcmIndex);
  {-}
begin
 FreeAndNil(theIndex);
end;

end.

