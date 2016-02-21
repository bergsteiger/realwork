unit nsPrimCacheableNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsPrimCacheableNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimAdapterNode
 , IOUnit
 , l3Interfaces
;

type
 TnsPrimCacheableNode = {abstract} class(TnsPrimAdapterNode)
  protected
   f_AdapterCaption: IString;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
 end;//TnsPrimCacheableNode

implementation

uses
 l3ImplUses
 , l3String
 , nsTypes
;

procedure TnsPrimCacheableNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADDF42201A2_var*
//#UC END# *479731C50290_4ADDF42201A2_var*
begin
//#UC START# *479731C50290_4ADDF42201A2_impl*
 f_AdapterCaption := nil;
 inherited;
//#UC END# *479731C50290_4ADDF42201A2_impl*
end;//TnsPrimCacheableNode.Cleanup

function TnsPrimCacheableNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4ADDF42201A2_var*
//#UC END# *47A869BB02DE_4ADDF42201A2_var*
begin
//#UC START# *47A869BB02DE_4ADDF42201A2_impl*
 if (f_AdapterCaption = nil) then
  if (AdapterNode <> nil) then
   AdapterNode.GetCaption(f_AdapterCaption);
 Result := nsWStr(f_AdapterCaption);
//#UC END# *47A869BB02DE_4ADDF42201A2_impl*
end;//TnsPrimCacheableNode.GetAsPCharLen

end.
