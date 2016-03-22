unit ddSCCollectFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddSCCollectFilter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::SubCompare::TddSCCollectFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  evdBufferedFilter,
  ddSCSubList,
  l3Variant
  ;

type
 TddSCCollectFilter = class(TevdBufferedFilter)
 private
 // private fields
   f_SubStack : TddSCSubList;
   f_SubList : TddSCSubList;
    {* Поле для свойства SubList}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure StartChild(TypeID: Tl3Type); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   procedure DoFlushBuffer(aLeaf: Tl3Variant;
     aTagId: Integer;
     aNeedCloseBracket: Boolean); override;
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
 public
 // public properties
   property SubList: TddSCSubList
     read f_SubList;
 end;//TddSCCollectFilter

implementation

uses
  SysUtils,
  Block_Const
  ;

// start class TddSCCollectFilter

constructor TddSCCollectFilter.Create;
//#UC START# *565C38A103C9_5656FD810153_var*
//#UC END# *565C38A103C9_5656FD810153_var*
begin
//#UC START# *565C38A103C9_5656FD810153_impl*
 inherited Create;
 f_SubList := TddSCSubList.Make;
 f_SubStack := TddSCSubList.Make;
//#UC END# *565C38A103C9_5656FD810153_impl*
end;//TddSCCollectFilter.Create

procedure TddSCCollectFilter.Cleanup;
//#UC START# *479731C50290_5656FD810153_var*
//#UC END# *479731C50290_5656FD810153_var*
begin
//#UC START# *479731C50290_5656FD810153_impl*
 FreeAndNil(f_SubList);
 FreeAndNil(f_SubStack);
 inherited;
//#UC END# *479731C50290_5656FD810153_impl*
end;//TddSCCollectFilter.Cleanup

procedure TddSCCollectFilter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_5656FD810153_var*
//#UC END# *4836D4650177_5656FD810153_var*
begin
//#UC START# *4836D4650177_5656FD810153_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4650177_5656FD810153_impl*
end;//TddSCCollectFilter.StartChild

function TddSCCollectFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_5656FD810153_var*
//#UC END# *4C56D54B002A_5656FD810153_var*
begin
//#UC START# *4C56D54B002A_5656FD810153_impl*
 if (aID =  
//#UC END# *4C56D54B002A_5656FD810153_impl*
end;//TddSCCollectFilter.NeedStartBuffering

procedure TddSCCollectFilter.DoFlushBuffer(aLeaf: Tl3Variant;
  aTagId: Integer;
  aNeedCloseBracket: Boolean);
//#UC START# *4D53D8BF00D5_5656FD810153_var*
//#UC END# *4D53D8BF00D5_5656FD810153_var*
begin
//#UC START# *4D53D8BF00D5_5656FD810153_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D53D8BF00D5_5656FD810153_impl*
end;//TddSCCollectFilter.DoFlushBuffer

end.