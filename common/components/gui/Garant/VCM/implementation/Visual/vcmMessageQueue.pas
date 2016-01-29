unit vcmMessageQueue;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMessageQueue.pas"
// Начат: 27.06.2011 19:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmMessageQueue
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmMessageQueuePrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmMessageQueue = class(TvcmMessageQueuePrim)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: TvcmMessageQueue;
    {- возвращает экземпляр синглетона. }
 end;//TvcmMessageQueue
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmMessageQueue

var g_TvcmMessageQueue : TvcmMessageQueue = nil;

procedure TvcmMessageQueueFree;
begin
 l3Free(g_TvcmMessageQueue);
end;

class function TvcmMessageQueue.Instance: TvcmMessageQueue;
begin
 if (g_TvcmMessageQueue = nil) then
 begin
  l3System.AddExitProc(TvcmMessageQueueFree);
  g_TvcmMessageQueue := Create;
 end;
 Result := g_TvcmMessageQueue;
end;


class function TvcmMessageQueue.Exists: Boolean;
//#UC START# *4E089B4302D8_4E089AEB01DA_var*
//#UC END# *4E089B4302D8_4E089AEB01DA_var*
begin
//#UC START# *4E089B4302D8_4E089AEB01DA_impl*
 Result := (g_TvcmMessageQueue <> nil);
//#UC END# *4E089B4302D8_4E089AEB01DA_impl*
end;//TvcmMessageQueue.Exists

{$IfEnd} //not NoVCM

end.