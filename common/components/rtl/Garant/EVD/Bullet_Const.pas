unit Bullet_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Bullet_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::EVD::Standard::evdNative::Bullet
//
// Тип маркера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Bullet - "Тип маркера".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typBullet: BulletAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Bullet : BulletAtom = nil;

// start class BulletAtom

function k2_typBullet: BulletAtom;
begin
 if (g_Bullet = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Bullet := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Bullet;
 end;//g_Bullet = nil
 Result := g_Bullet;
end;

end.