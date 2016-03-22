unit evCustomStyleManager;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomStyleManager.pas"
// Стереотип: "Service"
// Элемент модели: "TevCustomStyleManager" MUID: (53AABE1F0383)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Variant
 , nevTools
;

 (*
 MevCustomStyleManager = interface
  {* Контракт сервиса TevCustomStyleManager }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//MevCustomStyleManager
 *)

type
 IevCustomStyleManager = interface
  {* Интерфейс сервиса TevCustomStyleManager }
  ['{3E2B89CD-5B2D-400C-9EC9-FDA3B57A0C23}']
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//IevCustomStyleManager

 TevCustomStyleManager = {final} class(Tl3ProtoObject)
  private
   f_Alien: IevCustomStyleManager;
    {* Поле для свойства Alien }
  protected
   procedure pm_SetAlien(const aValue: IevCustomStyleManager);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   function IsAbolishedDocumentLink(aSeg: Tl3Variant;
    const aPara: InevPara): Boolean;
   function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
   class function Instance: TevCustomStyleManager;
    {* Метод получения экземпляра синглетона TevCustomStyleManager }
  public
   property Alien: IevCustomStyleManager
    write pm_SetAlien;
    {* Внешняя реализация сервиса IevCustomStyleManager }
 end;//TevCustomStyleManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TevCustomStyleManager: TevCustomStyleManager = nil;
 {* Экземпляр синглетона TevCustomStyleManager }

procedure TevCustomStyleManagerFree;
 {* Метод освобождения экземпляра синглетона TevCustomStyleManager }
begin
 l3Free(g_TevCustomStyleManager);
end;//TevCustomStyleManagerFree

procedure TevCustomStyleManager.pm_SetAlien(const aValue: IevCustomStyleManager);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TevCustomStyleManager.pm_SetAlien

class function TevCustomStyleManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevCustomStyleManager <> nil;
end;//TevCustomStyleManager.Exists

function TevCustomStyleManager.IsAbolishedDocumentLink(aSeg: Tl3Variant;
 const aPara: InevPara): Boolean;
//#UC START# *391A810FF759_53AABE1F0383_var*
//#UC END# *391A810FF759_53AABE1F0383_var*
begin
//#UC START# *391A810FF759_53AABE1F0383_impl*
 Result := Assigned(f_Alien) and f_Alien.IsAbolishedDocumentLink(aSeg, aPara);
//#UC END# *391A810FF759_53AABE1F0383_impl*
end;//TevCustomStyleManager.IsAbolishedDocumentLink

function TevCustomStyleManager.IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
//#UC START# *DC1A5D24B383_53AABE1F0383_var*
//#UC END# *DC1A5D24B383_53AABE1F0383_var*
begin
//#UC START# *DC1A5D24B383_53AABE1F0383_impl*
 Result := Assigned(f_Alien) and f_Alien.IsVisitedDocumentLink(aSeg);
//#UC END# *DC1A5D24B383_53AABE1F0383_impl*
end;//TevCustomStyleManager.IsVisitedDocumentLink

class function TevCustomStyleManager.Instance: TevCustomStyleManager;
 {* Метод получения экземпляра синглетона TevCustomStyleManager }
begin
 if (g_TevCustomStyleManager = nil) then
 begin
  l3System.AddExitProc(TevCustomStyleManagerFree);
  g_TevCustomStyleManager := Create;
 end;
 Result := g_TevCustomStyleManager;
end;//TevCustomStyleManager.Instance

procedure TevCustomStyleManager.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TevCustomStyleManager.ClearFields

end.
