unit kwObjectCreate;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwObjectCreate = class(TtfwRegisterableWord)
  {* Поддержка автоматического создания формы-обвязки для тестов.
*Формат:* aClass .Create
aClass - класс формы.

ПОКА создаёт только VCM-формы но предполагается научить создавать и ДРУГИЕ объекты. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwObjectCreate
 
implementation

uses
 l3ImplUses
 , vcmEntityForm
 , Forms
 , vcmBase
 , vcmForm
 , Controls
 , StdRes
 , afwAnswer
;

end.
