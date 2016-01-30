unit m3HashHandle;

// Модуль: "w:\common\components\rtl\Garant\m3\m3HashHandle.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3BranchHandleList
;

type
 Tm3HashHandle = class(Tl3CProtoObject)
  private
   f_BranchHandleList: Tm3BranchHandleList;
    {* Поле для свойства BranchHandleList }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
  public
   property BranchHandleList: Tm3BranchHandleList
    read f_BranchHandleList;
 end;//Tm3HashHandle

implementation

uses
 l3ImplUses
 , SysUtils
;

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5459F38200AF_var*
//#UC END# *479731C50290_5459F38200AF_var*
begin
//#UC START# *479731C50290_5459F38200AF_impl*
 FreeAndNil(f_BranchHandleList);
 inherited;
//#UC END# *479731C50290_5459F38200AF_impl*
end;//Tm3HashHandle.Cleanup

end.
