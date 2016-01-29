unit vcmItems;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmItems -      }
{ Начат: 15.01.2007 17:15 }
{ $Id: vcmItems.pas,v 1.14 2010/02/24 17:39:51 lulin Exp $ }

// $Log: vcmItems.pas,v $
// Revision 1.14  2010/02/24 17:39:51  lulin
// - удаляем излишнюю виртуальность.
//
// Revision 1.13  2008/02/12 19:32:28  lulin
// - избавляемся от универсальности списков.
//
// Revision 1.12  2007/08/14 19:31:38  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.11  2007/07/24 19:43:39  lulin
// - bug fix: не компилировались библиотеки.
//
// Revision 1.10  2007/07/24 19:21:09  lulin
// - скомпилировался F1 с модулем l3Interfaces, сгенерированным с модели.
//
// Revision 1.9  2007/04/03 13:34:24  mmorozov
// - bugfix: проверям типы класса элементов списка перед использованием;
//
// Revision 1.8  2007/03/01 08:39:50  lulin
// - не копируем данные строки, если их держит интерфейс строки.
//
// Revision 1.7  2007/02/28 13:15:32  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.6  2007/01/26 13:11:12  lulin
// - не требуем обязательного указания заголовка операции.
//
// Revision 1.5  2007/01/15 17:34:20  lulin
// - расширяем интерфейс списка нод.
//
// Revision 1.4  2007/01/15 14:56:48  lulin
// - при построении меню используем операции модуля из списка строк.
//
// Revision 1.3  2007/01/15 14:17:51  lulin
// - добавлен еще один метод назначения кода операции.
//
// Revision 1.2  2007/01/15 14:03:03  lulin
// - добавлена возможность добавлять коды операций к строкам.
//
// Revision 1.1  2007/01/15 13:26:26  lulin
// - расширен интерфейс элементов операции.
//

{$Include vcmDefine.inc }

interface

// <no_string>

uses
  {$IfDef vcmNeedL3}
  l3Base,
  {$EndIf vcmNeedL3}

  vcmExternalInterfaces,
  
  vcmStringList
  ;

type
  TvcmItems = class(TvcmStringList, IvcmItems)
    protected
    // interface methods
      // IvcmItems
      {$IfNDef vcmNeedL3}
      function IvcmItems.Get_Count = GetCount;
        {-}
      function  IvcmItems.Get_Item = Get;
      procedure IvcmItems.Set_Item = Put;
        {-}
      function  IvcmItems.Get_Objects = GetObject;
      procedure IvcmItems.Set_Objects = PutObject;
        {-}
      {$EndIf  vcmNeedL3}
      function pm_GetOp(anIndex: Integer): TvcmOpSelector;
        {-}
      function  AddOp(const anOp : TvcmOpSelector;
                      const aCap : IvcmCString = nil;
                      anObj      : TObject = nil): Integer;
        overload;
        {-}
      function  AddOp(const anOp : TvcmOPID;
                      const aCap : IvcmCString = nil;
                      anObj      : TObject = nil): Integer;
        overload;
        {-}
      function  AddOp(const anOp : TvcmMOPID;
                      const aCap : IvcmCString = nil;
                      anObj      : TObject = nil): Integer;
        overload;
        {-}
    protected
    // internal methods
      {$IfDef vcmNeedL3}
      function  CStrToItem(const aStr: IvcmCString): Tl3CustomString;
        override;
        {-}
      function  StringItemClass: Rl3String;
        override;
        {-}
      {$EndIf vcmNeedL3}
    public
    // public methods
      class function Make: IvcmItems;
        reintroduce;
        {-}
  end;//TvcmItems

implementation

uses
  {$IfDef vcmNeedL3}
  l3VCLStrings,
  {$EndIf vcmNeedL3}
  
  vcmBase
  ;

{$IfDef vcmNeedL3}
type
  TvcmItemsString = class(Tl3ObjPtrString)
    private
    // internal fields
      f_Op : TvcmOpSelector;
    public
    // public methods
      procedure InitFields;
        override;
        {-}
  end;//TvcmItemsString

procedure TvcmItemsString.InitFields;
  //override;
  {-}
begin
 inherited;
 l3FillChar(f_Op, SizeOf(f_Op), 0);
end;

type
  TvcmItemsIntfString = class(Tl3ObjPtrIntfString)
    private
    // internal fields
      f_Op : TvcmOpSelector;
    public
    // public methods
      procedure InitFields;
        override;
        {-}
  end;//TvcmItemsString

procedure TvcmItemsIntfString.InitFields;
  //override;
  {-}
begin
 inherited;
 l3FillChar(f_Op, SizeOf(f_Op), 0);
end;

{$EndIf vcmNeedL3}

// start class TvcmItems

class function TvcmItems.Make: IvcmItems;
  //reintroduce;
  {-}
var
 l_Items : TvcmItems;
begin
 l_Items := Create;
 try
  Result := l_Items;
 finally
  vcmFree(l_Items);
 end;//try..finally
end;

function TvcmItems.pm_GetOp(anIndex: Integer): TvcmOpSelector;
  {-}
{$IfDef vcmNeedL3}
var
 l_Item : Tl3PrimString;
{$EndIf vcmNeedL3}
begin
 {$IfDef vcmNeedL3}
 l_Item := Items[anIndex];
 if (l_Item Is TvcmItemsIntfString) then
  Result := TvcmItemsIntfString(l_Item).f_Op
 else
  if (l_Item Is TvcmItemsString) then
   Result := TvcmItemsString(l_Item).f_Op
  else
   l3FillChar(Result, SizeOf(TvcmOpSelector), 0);
 {$Else  vcmNeedL3}
 FillChar(Result, SizeOf(Result), 0);
 {$EndIf vcmNeedL3}
end;

function TvcmItems.AddOp(const anOp : TvcmOpSelector;
                         const aCap : IvcmCString = nil;
                         anObj      : TObject = nil): Integer;
  //overload;
  {-}
{$IfDef vcmNeedL3}
var
 l_Item : Tl3PrimString;
{$EndIf vcmNeedL3}
begin
 Result := Add(aCap);
 if (anObj <> nil) then
 {$IfDef vcmNeedL3}
  Set_Objects(Result, anObj);
 {$Else  vcmNeedL3}
  PutObject(Result, anObj);
 {$EndIf vcmNeedL3}
 {$IfDef vcmNeedL3}
 l_Item := Items[Result];
 if (l_Item Is TvcmItemsIntfString) then
  TvcmItemsIntfString(l_Item).f_Op := anOp
 else
  if (l_Item Is TvcmItemsString) then
   TvcmItemsString(l_Item).f_Op := anOp
  else
   Assert(False);
 {$EndIf vcmNeedL3}
end;

function TvcmItems.AddOp(const anOp : TvcmOPID;
                         const aCap : IvcmCString = nil;
                         anObj      : TObject = nil): Integer;
  //overload;
  {-}
var
 l_Op : TvcmOpSelector;
begin
 l_Op.rKind := vcm_okEntity;
 l_Op.rID := anOp;
 Result := AddOp(l_Op, aCap, anObj);
end;

function TvcmItems.AddOp(const anOp : TvcmMOPID;
                         const aCap : IvcmCString = nil;
                         anObj      : TObject = nil): Integer;
  //overload;
  {-}
var
 l_Op : TvcmOpSelector;
begin
 l_Op.rKind := vcm_okModule;
 l_Op.rMID := anOp;
 Result := AddOp(l_Op, aCap, anObj);
end;

{$IfDef vcmNeedL3}
function TvcmItems.CStrToItem(const aStr: IvcmCString): Tl3CustomString;
  //override;
  {-}
begin
 Result := TvcmItemsIntfString.Make(aStr);
end;

function TvcmItems.StringItemClass: Rl3String;
  //override;
  {-}
begin
 Result := TvcmItemsString;
end;
{$EndIf vcmNeedL3}

end.

