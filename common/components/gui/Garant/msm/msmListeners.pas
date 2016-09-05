unit msmListeners;

// Модуль: "w:\common\components\gui\Garant\msm\msmListeners.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmListeners" MUID: (57ADAF81029D)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmModelElementsControllers
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmModelSubscriber;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TmsmListeners = class(_l3InterfaceRefList_, ImsmListeners)
  protected
   procedure AddListener(const aListener: ImsmModelSubscriber);
  public
   class function Make: ImsmListeners; reintroduce;
 end;//TmsmListeners

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57ADAF81029Dimpl_uses*
 //#UC END# *57ADAF81029Dimpl_uses*
;

type _Instance_R_ = TmsmListeners;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

class function TmsmListeners.Make: ImsmListeners;
var
 l_Inst : TmsmListeners;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmListeners.Make

procedure TmsmListeners.AddListener(const aListener: ImsmModelSubscriber);
//#UC START# *57ADAF2103C5_57ADAF81029D_var*
//#UC END# *57ADAF2103C5_57ADAF81029D_var*
begin
//#UC START# *57ADAF2103C5_57ADAF81029D_impl*
 Add(aListener);
//#UC END# *57ADAF2103C5_57ADAF81029D_impl*
end;//TmsmListeners.AddListener

end.
