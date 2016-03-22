unit m3HashHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3HashHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3HashHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3CProtoObject,
  m3BranchHandleList
  ;

type
 Tm3HashHandle = class(Tl3CProtoObject)
 private
 // private fields
   f_BranchHandleList : Tm3BranchHandleList;
    {* Поле для свойства BranchHandleList}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create; reintroduce;
 public
 // public properties
   property BranchHandleList: Tm3BranchHandleList
     read f_BranchHandleList;
 end;//Tm3HashHandle

implementation

uses
  SysUtils
  ;

// start class Tm3HashHandle

constructor Tm3HashHandle.Create;
//#UC START# *5459F3C30067_5459F38200AF_var*
//#UC END# *5459F3C30067_5459F38200AF_var*
begin
//#UC START# *5459F3C30067_5459F38200AF_impl*
 inherited;
 f_BranchHandleList := Tm3BranchHandleList.Create;
//#UC END# *5459F3C30067_5459F38200AF_impl*
end;//Tm3HashHandle.Create

procedure Tm3HashHandle.Cleanup;
//#UC START# *479731C50290_5459F38200AF_var*
//#UC END# *479731C50290_5459F38200AF_var*
begin
//#UC START# *479731C50290_5459F38200AF_impl*
 FreeAndNil(f_BranchHandleList);
 inherited;
//#UC END# *479731C50290_5459F38200AF_impl*
end;//Tm3HashHandle.Cleanup

end.