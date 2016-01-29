unit K216531291;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K216531291.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K216531291
//
// [$216531291]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

uses
  ScrollTest
  ;

type
 TK216531291 = class(TScrollTest)
  {* [$216531291] }
 protected
  function ScrollByPage: Boolean; override;
 end;//TK216531291

implementation

uses
  TestFrameWork
  ;


{ TK216531291 }

{ TK216531291 }

function TK216531291.ScrollByPage: Boolean;
begin
 Result := False;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\Daily\K216531291.pas initialization enter'); {$EndIf}
 TestFramework.RegisterTest(TK216531291.Suite);
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\Daily\K216531291.pas initialization leave'); {$EndIf}
end.
