unit k2NonOptimizeContext;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2NonOptimizeContext.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::K2::Operations::Tk2NonOptimizeContext
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Context
  ;

type
 Tk2NonOptimizeContext = class(Tk2Context)
 protected
 // overridden protected methods
   function GetSaveUndo: Boolean; override;
   function GetNeedOptimize: Boolean; override;
 public
 // public methods
   constructor Create; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tk2NonOptimizeContext;
    {- возвращает экземпляр синглетона. }
 end;//Tk2NonOptimizeContext

implementation

uses
  l3Base {a}
  ;


// start class Tk2NonOptimizeContext

var g_Tk2NonOptimizeContext : Tk2NonOptimizeContext = nil;

procedure Tk2NonOptimizeContextFree;
begin
 l3Free(g_Tk2NonOptimizeContext);
end;

class function Tk2NonOptimizeContext.Instance: Tk2NonOptimizeContext;
begin
 if (g_Tk2NonOptimizeContext = nil) then
 begin
  l3System.AddExitProc(Tk2NonOptimizeContextFree);
  g_Tk2NonOptimizeContext := Create;
 end;
 Result := g_Tk2NonOptimizeContext;
end;


constructor Tk2NonOptimizeContext.Create;
//#UC START# *5310790D00D9_531075C102DD_var*
//#UC END# *5310790D00D9_531075C102DD_var*
begin
//#UC START# *5310790D00D9_531075C102DD_impl*
 inherited Create(nil);
//#UC END# *5310790D00D9_531075C102DD_impl*
end;//Tk2NonOptimizeContext.Create

class function Tk2NonOptimizeContext.Exists: Boolean;
 {-}
begin
 Result := g_Tk2NonOptimizeContext <> nil;
end;//Tk2NonOptimizeContext.Exists

function Tk2NonOptimizeContext.GetSaveUndo: Boolean;
//#UC START# *4E7AF07603D9_531075C102DD_var*
//#UC END# *4E7AF07603D9_531075C102DD_var*
begin
//#UC START# *4E7AF07603D9_531075C102DD_impl*
 Result := false;
//#UC END# *4E7AF07603D9_531075C102DD_impl*
end;//Tk2NonOptimizeContext.GetSaveUndo

function Tk2NonOptimizeContext.GetNeedOptimize: Boolean;
//#UC START# *531075A60396_531075C102DD_var*
//#UC END# *531075A60396_531075C102DD_var*
begin
//#UC START# *531075A60396_531075C102DD_impl*
 Result := false;
//#UC END# *531075A60396_531075C102DD_impl*
end;//Tk2NonOptimizeContext.GetNeedOptimize

end.