unit k2NonOptimizeContext;

// Модуль: "w:\common\components\rtl\Garant\K2\k2NonOptimizeContext.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2NonOptimizeContext" MUID: (531075C102DD)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Context
;

type
 Tk2NonOptimizeContext = class(Tk2Context)
  protected
   function GetSaveUndo: Boolean; override;
   function GetNeedOptimize: Boolean; override;
  public
   constructor Create; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tk2NonOptimizeContext;
    {* Метод получения экземпляра синглетона Tk2NonOptimizeContext }
 end;//Tk2NonOptimizeContext

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tk2NonOptimizeContext: Tk2NonOptimizeContext = nil;
 {* Экземпляр синглетона Tk2NonOptimizeContext }

procedure Tk2NonOptimizeContextFree;
 {* Метод освобождения экземпляра синглетона Tk2NonOptimizeContext }
begin
 l3Free(g_Tk2NonOptimizeContext);
end;//Tk2NonOptimizeContextFree

constructor Tk2NonOptimizeContext.Create;
//#UC START# *5310790D00D9_531075C102DD_var*
//#UC END# *5310790D00D9_531075C102DD_var*
begin
//#UC START# *5310790D00D9_531075C102DD_impl*
 inherited Create(nil);
//#UC END# *5310790D00D9_531075C102DD_impl*
end;//Tk2NonOptimizeContext.Create

class function Tk2NonOptimizeContext.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tk2NonOptimizeContext <> nil;
end;//Tk2NonOptimizeContext.Exists

class function Tk2NonOptimizeContext.Instance: Tk2NonOptimizeContext;
 {* Метод получения экземпляра синглетона Tk2NonOptimizeContext }
begin
 if (g_Tk2NonOptimizeContext = nil) then
 begin
  l3System.AddExitProc(Tk2NonOptimizeContextFree);
  g_Tk2NonOptimizeContext := Create;
 end;
 Result := g_Tk2NonOptimizeContext;
end;//Tk2NonOptimizeContext.Instance

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
