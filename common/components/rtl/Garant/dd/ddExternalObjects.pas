unit ddExternalObjects;
{ Поддержка различных типов внешних объектов  }


{ $Id: ddExternalObjects.pas,v 1.14 2016/02/29 07:07:03 lukyanets Exp $ }

// $Log: ddExternalObjects.pas,v $
// Revision 1.14  2016/02/29 07:07:03  lukyanets
// Не собиралось
//
// Revision 1.13  2016/02/26 16:16:10  voba
// - лингвомодули можно подключать в инишнике
//
// Revision 1.12  2015/11/25 14:01:46  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.11  2014/02/13 12:14:54  lulin
// - рефакторим безликие списки.
//
// Revision 1.10  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.9  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.8  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.7  2008/02/05 09:57:59  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.6  2007/04/25 09:30:55  fireton
// - Рефакторинг DT. Все типы переехали в DT_Types, а константы - в DT_Const
//
// Revision 1.5  2007/02/12 16:01:06  voba
// - buf fix (Шура чото наменял)
//
// Revision 1.4  2005/03/23 09:43:11  narry
// - bug fix
//
// Revision 1.3  2005/03/21 12:47:32  narry
// - bug fix: один тип для всех блоков документа, очистка списка
//
// Revision 1.2  2005/03/16 14:45:30  narry
// - update
//
// Revision 1.1  2005/03/15 14:32:27  narry
// - Объект для управления списком типов внешних объектов
//

interface

Uses
 l3Base, l3Types,
 Classes,
 l3ProtoObjectRefList,
 l3ProtoObject
 ;

type
 TddExternalObject = class(Tl3ProtoObject)
 private
   FDescription: Shortstring;
   FHandle: Tl3Handle;
   FSeeAlsoText: Shortstring;
   FTypeExtension: Shortstring;
   function GetFullSeeAlsoText: AnsiString;
 protected
   function pm_GetHandle: Tl3Handle; //override;
   procedure pm_SetHandle(Value: Tl3Handle); //override;
 public
   property Description: Shortstring
    read FDescription
    write FDescription;
   property FullSeeAlsoText: AnsiString read GetFullSeeAlsoText;
   property Handle: Tl3Handle
    read pm_GetHandle
    write pm_SetHandle;
   property SeeAlsoText: Shortstring
    read FSeeAlsoText
    write FSeeAlsoText;
   property TypeExtension: Shortstring
    read FTypeExtension
    write FTypeExtension;
 end;

 TddExternalObjectsManager = class(Tl3ProtoObject)
 private
  FMaxHandle: Tl3Handle;
  FStrings: TStrings;
  f_List: Tl3ProtoObjectRefList;
 private
  function GetObjects(Handle: Integer): TddExternalObject;
  function GetStrings: TStrings;
  function IniFileName: AnsiString;
 protected
  procedure Cleanup; override;
  procedure LoadFromFile;
  procedure SaveToFile;
 public
  constructor Create{(anOwner: TObject = nil)}; //override;
  function AddObject(aTypeExtension, aDescription, aSeeAlsoText: ShortString): Integer;
  procedure DeleteObject(theHandle: Tl3Handle);
  procedure Revert;
  procedure Save;
  property Objects[Handle: Integer]: TddExternalObject
   read GetObjects;
  property Strings: TStrings read GetStrings;
 end;

function ExtObjManager: TddExternalObjectsManager;

var
 _ExternalObjManager : TddExternalObjectsManager = nil;

const
 eoDefaultHandle      =  0;
 eoDefaultExt         = 'RTF';
 eoDefaultDescription = 'Документ Microsoft Word';
 eoDefaultSeeAlsoText = 'редакторе Microsoft Word';
 eoSeeAlsoPrefix      = 'См. данную форму в ';

implementation
Uses
 l3String, l3FileUtils, l3IniFile,
 daSchemeConsts,
 dt_Serv, dt_Const,
 Math,
 SysUtils
 ;

function ExtObjManager: TddExternalObjectsManager;
begin
 if _ExternalObjManager = nil then
  _ExternalObjManager := TddExternalObjectsManager.Create{(nil)};
 Result := _ExternalObjManager;
end;

const
 recExternalObject = 'SDSS';
Type
 _Rec = packed record
   Descript: ShortString;
   Handle  : Integer;
   TypeExt : Shortstring;
   SeeAlso : ShortString;
 end;


function TddExternalObject.GetFullSeeAlsoText: AnsiString;
begin
  Result := eoSeeAlsoPrefix + SeeAlsoText;
end;

function TddExternalObject.pm_GetHandle: Tl3Handle;
  {virtual;}
begin
 Result := FHandle;
end;

procedure TddExternalObject.pm_SetHandle(Value: Tl3Handle);
  {virtual;}
  {-}
begin
 if FHandle <> Value then
  FHandle := Value;
end;

constructor TddExternalObjectsManager.Create{(anOwner: TObject = nil)};
begin
  inherited;
  f_List:= Tl3ProtoObjectRefList.Make;
  FStrings := TStringList.Create;
  FMaxHandle := 0;
  LoadFromFile;
  if f_List.Count = 0 then
   AddObject(eoDefaultExt, eoDefaultDescription, eoDefaultSeeAlsoText);
  SaveToFile;
end;

function TddExternalObjectsManager.AddObject(aTypeExtension, aDescription,
    aSeeAlsoText: ShortString): Integer;
var
 l_Item: TddExternalObject;
begin
 l_Item:= TddExternalObject.Create{(nil)};
 try
  l_Item.Handle := FMaxHandle;
  l_Item.Description := aDescription;
  l_Item.TypeExtension := aTypeExtension;
  l_Item.SeeAlsoText := aSeeAlsoText;
  f_List.Add(l_Item);
  Result:= l_Item.Handle;
 finally
  FreeAndNil(l_Item);
 end;
 Inc(FMaxHandle);
end;

procedure TddExternalObjectsManager.Cleanup;
begin
  l3Free(f_List);
  l3Free(FStrings);
  inherited;
end;

procedure TddExternalObjectsManager.DeleteObject(theHandle: Tl3Handle);
var
 l_Item: TddExternalObject;
begin
 if theHandle > 0 then
 begin
  l_Item := Objects[theHandle];
  if l_Item <> nil then
   f_List.Remove(l_Item);
 end; // theHandle > 0
end;

function TddExternalObjectsManager.GetObjects(Handle: Integer): TddExternalObject;
var
 i: Integer;
begin
 Result := nil;
 for i:= 0 to f_List.Hi do
  if TddExternalObject(f_List.Items[i]).Handle = Handle then
  begin
   Result := TddExternalObject(f_List.Items[i]);
   break;
  end; // TddExternalObject(f_List.Items[i]).Handle = Handle
 if (Result = nil) and (f_List.Count > 0) then
  Result := TddExternalObject(f_List.First);
end;

function TddExternalObjectsManager.GetStrings: TStrings;
var
 i: Integer;
 l_Obj : TddExternalObject;
begin
 FStrings.Clear;
 for i:= 0 to f_List.Hi do
 begin
  l_Obj := TddExternalObject(f_List.Items[i]);
  FStrings.AddObject(l_Obj.Description, l_Obj);
 end; // for i
 Result := FStrings;
end;

function TddExternalObjectsManager.IniFileName: AnsiString;
begin
 Result := ConcatDirName(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily), 'base.ini');
end;

procedure TddExternalObjectsManager.LoadFromFile;

 procedure OnReadItem(const ItStr: ShortString);
 var
  l_Item: TddExternalObject;
  l_Rec : _Rec;
 begin
  l_Item := TddExternalObject.Create{(nil)};
  try
   l3FormatStringToRec(ItStr, l_Rec, recExternalObject);
   l_Item.Handle := l_Rec.Handle;
   l_Item.Description := l_Rec.Descript;
   l_Item.TypeExtension := l_Rec.TypeExt;
   l_Item.SeeAlsoText := l_Rec.SeeAlso;
   f_List.Add(l_Item);
   FMaxHandle := Max(fMaxHandle, l_Item.Handle);
  finally
   l3Free(l_Item);
  end;
 end;


var
 lIterFunc : TOnSetListItem;

begin
 f_List.Clear;
 with TCfgList.Create(IniFileName) do
 try
  Section:= 'ExternalObjects';
  FMaxHandle := 0;
  lIterFunc := MakeRGLStub(@OnReadItem);
  try
   ReadParamExtList('Item', lIterFunc);
  finally
   FreeRGLStub(lIterFunc);
  end;

  if f_List.Count > 0 then
   Inc(FMaxHandle);
 finally
  Free;
 end;
end;

procedure TddExternalObjectsManager.Revert;
begin
 LoadFromFile;
end;

procedure TddExternalObjectsManager.Save;
begin
 SaveToFile;
end;

procedure TddExternalObjectsManager.SaveToFile;
 var
  lIndex : integer;

 function OnWriteItem(var ItStr: ShortString): Boolean;
 var
  l_Item: TddExternalObject;
  l_rec : _Rec;
 begin
  Result := False; // больше нет элементов
  if lIndex < f_List.Count then
  begin
   l_Item := TddExternalObject(f_List.Items[lIndex]);
   l_Rec.Handle := l_Item.Handle;
   l_Rec.Descript := l_Item.Description;
   l_Rec.TypeExt := l_Item.TypeExtension;
   l_Rec.SeeAlso := l_Item.SeeAlsoText;
   ItStr := l3RecToFormatString(l_Rec, recExternalObject);
   Inc(lIndex);
   Result := True;
  end; // Index < f_List.Count
 end;

var
 lIterFunc : TOnGetListItem;

begin
 lIndex := 0;
 with TCfgList.Create(IniFileName) do
 try
  Section:= 'ExternalObjects';
  lIterFunc := MakeWGLStub(@OnWriteItem);
  try
   WriteParamExtList('Item', lIterFunc);
  finally
   FreeWGLStub(lIterFunc);
  end;
 finally
  Free;
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddExternalObjects.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddExternalObjects.pas initialization leave'); {$EndIf}
finalization
 l3Free(_ExternalObjManager);
end.
