unit nsUserProperty;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserProperty.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsUserProperty" MUID: (4B5038B80195)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , AdminDomainInterfaces
 , SecurityUnit
 , l3Interfaces
;

type
 _nsUserPropertyImpl_Parent_ = Tl3SimpleObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}
 TnsUserProperty = class(_nsUserPropertyImpl_, InsUserProperty)
  protected
   constructor Create(const aProfile: IUserProfile); reintroduce;
   function DefaultGroupID: Integer; override;
  public
   class function Make(const aProfile: IUserProfile): InsUserProperty; reintroduce;
 end;//TnsUserProperty

implementation

uses
 l3ImplUses
 , DataAdapter
 , nsTypes
 , nsConst
 , IOUnit
 //#UC START# *4B5038B80195impl_uses*
 //#UC END# *4B5038B80195impl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas}

class function TnsUserProperty.Make(const aProfile: IUserProfile): InsUserProperty;
var
 l_Inst : TnsUserProperty;
begin
 l_Inst := Create(aProfile);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsUserProperty.Make

constructor TnsUserProperty.Create(const aProfile: IUserProfile);
//#UC START# *4B503E400115_4B5038B80195_var*
//#UC END# *4B503E400115_4B5038B80195_var*
begin
//#UC START# *4B503E400115_4B5038B80195_impl*
 inherited Create;
 SetProfileData(aProfile, False, False);
//#UC END# *4B503E400115_4B5038B80195_impl*
end;//TnsUserProperty.Create

function TnsUserProperty.DefaultGroupID: Integer;
//#UC START# *4B50439D03B6_4B5038B80195_var*
//#UC END# *4B50439D03B6_4B5038B80195_var*
begin
//#UC START# *4B50439D03B6_4B5038B80195_impl*
 Result := 0;
//#UC END# *4B50439D03B6_4B5038B80195_impl*
end;//TnsUserProperty.DefaultGroupID

end.
