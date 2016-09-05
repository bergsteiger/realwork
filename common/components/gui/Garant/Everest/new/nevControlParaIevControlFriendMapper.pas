unit nevControlParaIevControlFriendMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevControlParaIevControlFriendMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevControlParaIevControlFriendMapper" MUID: (53D64CA801F6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TnevControlParaIevControlFriendMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlParaIevControlFriendMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , evQueryCardInt
 , SysUtils
 //#UC START# *53D64CA801F6impl_uses*
 //#UC END# *53D64CA801F6impl_uses*
;

class function TnevControlParaIevControlFriendMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D64CA801F6_var*
var
 l_CP: IevControlFriend;
//#UC END# *53D639B601D7_53D64CA801F6_var*
begin
//#UC START# *53D639B601D7_53D64CA801F6_impl*
 if not aTag.QT(IevControlFriend, l_CP, aProcessor) OR
    not l_CP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D64CA801F6_impl*
end;//TnevControlParaIevControlFriendMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
