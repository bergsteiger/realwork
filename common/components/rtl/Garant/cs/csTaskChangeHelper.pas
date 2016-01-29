unit csTaskChangeHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csTaskChangeHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> Shared Delphi For Archi::cs::Tasks::TcsTaskChangeHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
(*
 McsTaskChangeHelper = PureMixIn
  {* Контракт сервиса TcsTaskChangeHelper }
   procedure TaskGotErrorStatus;
 end;//McsTaskChangeHelper
*)

type
 IcsTaskChangeHelper = interface(IUnknown)
  {* Интерфейс сервиса TcsTaskChangeHelper }
   ['{9337EC2E-743E-421E-994C-15DEC812DC61}']
  // McsTaskChangeHelper
   procedure TaskGotErrorStatus;
 end;//IcsTaskChangeHelper

 TcsTaskChangeHelper = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : IcsTaskChangeHelper;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: IcsTaskChangeHelper);
 public
 // realized methods
   procedure TaskGotErrorStatus;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Alien: IcsTaskChangeHelper
     write pm_SetAlien;
     {* Внешняя реализация сервиса IcsTaskChangeHelper }
 public
 // singleton factory method
   class function Instance: TcsTaskChangeHelper;
    {- возвращает экземпляр синглетона. }
 end;//TcsTaskChangeHelper
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TcsTaskChangeHelper

var g_TcsTaskChangeHelper : TcsTaskChangeHelper = nil;

procedure TcsTaskChangeHelperFree;
begin
 l3Free(g_TcsTaskChangeHelper);
end;

class function TcsTaskChangeHelper.Instance: TcsTaskChangeHelper;
begin
 if (g_TcsTaskChangeHelper = nil) then
 begin
  l3System.AddExitProc(TcsTaskChangeHelperFree);
  g_TcsTaskChangeHelper := Create;
 end;
 Result := g_TcsTaskChangeHelper;
end;


procedure TcsTaskChangeHelper.pm_SetAlien(const aValue: IcsTaskChangeHelper);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TcsTaskChangeHelper.pm_SetAlien

class function TcsTaskChangeHelper.Exists: Boolean;
 {-}
begin
 Result := g_TcsTaskChangeHelper <> nil;
end;//TcsTaskChangeHelper.Exists

procedure TcsTaskChangeHelper.TaskGotErrorStatus;
//#UC START# *F75B4443B80B_5583BE960064_var*
//#UC END# *F75B4443B80B_5583BE960064_var*
begin
//#UC START# *F75B4443B80B_5583BE960064_impl*
 if Assigned(f_Alien) then
  f_Alien.TaskGotErrorStatus;
//#UC END# *F75B4443B80B_5583BE960064_impl*
end;//TcsTaskChangeHelper.TaskGotErrorStatus

procedure TcsTaskChangeHelper.ClearFields;
 {-}
begin
 {$If not defined(Nemesis)}
 Alien := nil;
 {$IfEnd} //not Nemesis
 inherited;
end;//TcsTaskChangeHelper.ClearFields

{$IfEnd} //not Nemesis

end.