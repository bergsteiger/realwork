unit imeStampObjectManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/imeStampObjectManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::TimeStampObjectManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
//#UC START# *4614E03B02EEci*
//#UC END# *4614E03B02EEci*
//#UC START# *4614E03B02EEcit*
//#UC END# *4614E03B02EEcit*
 TimeStampObjectManager = class
//#UC START# *4614E03B02EEpubl*
//#UC END# *4614E03B02EEpubl*
 public
 // singleton factory method
   class function Instance: TimeStampObjectManager;
    {- возвращает экземпляр синглетона. }
 end;//TimeStampObjectManager

implementation

uses
  l3Base {a}
  ;


// start class TimeStampObjectManager

var g_TimeStampObjectManager : TimeStampObjectManager = nil;

procedure TimeStampObjectManagerFree;
begin
 l3Free(g_TimeStampObjectManager);
end;

class function TimeStampObjectManager.Instance: TimeStampObjectManager;
begin
 if (g_TimeStampObjectManager = nil) then
 begin
  l3System.AddExitProc(TimeStampObjectManagerFree);
  g_TimeStampObjectManager := Create;
 end;
 Result := g_TimeStampObjectManager;
end;


//#UC START# *4614E03B02EEimpl*
//#UC END# *4614E03B02EEimpl*

end.