unit K578892941;
 {* [RequestLink:578892941] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\Processing\K578892941.pas"
// Стереотип: "TestCase"
// Элемент модели: "K578892941" MUID: (54785B8603B8)
// Имя типа: "TK578892941"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TK578892941 = class({$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 )
  {* [RequestLink:578892941] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
  published
   procedure DoIt;
 end;//TK578892941
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ncsGetReadyToDeliveryTasksReply
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , evdNcsTypes
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 //#UC START# *54785B8603B8impl_uses*
 //#UC END# *54785B8603B8impl_uses*
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
procedure TK578892941.DoIt;
//#UC START# *54785B9A00C8_54785B8603B8_var*
var
 l_Message : TncsMessage;
 l_Reply: TncsGetReadyToDeliveryTasksReply;
//#UC END# *54785B9A00C8_54785B8603B8_var*
begin
//#UC START# *54785B9A00C8_54785B8603B8_impl*
 l_Message := TncsMessage.Create;
 try
  l_Message.Kind := ncs_mkMessage;
  l_Reply := TncsGetReadyToDeliveryTasksReply.Create(l_Message);
  try
   l_Reply.TasksIDList.Add('104');
  finally
   FreeAndNil(l_Reply);
  end;//try..finally
 finally
  FreeAndNil(l_Message);
 end;//try..finally
//#UC END# *54785B9A00C8_54785B8603B8_impl*
end;//TK578892941.DoIt

function TK578892941.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksProcessing';
end;//TK578892941.GetFolder

function TK578892941.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54785B8603B8';
end;//TK578892941.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK578892941.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
