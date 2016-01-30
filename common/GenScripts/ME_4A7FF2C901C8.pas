unit nsRedactionCurrentPara;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsRedactionCurrentPara.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , EditionsInterfaces
 , eeInterfaces
;

type
 TnsRedactionCurrentPara = class(Tl3ProtoObject)
  private
   f_Para: IeeLeafPara;
    {* Параграф для синхронизации }
  protected
   function Get_RedactionCurrentPara: IeeLeafPara;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: IeeLeafPara); reintroduce;
 end;//TnsRedactionCurrentPara
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsRedactionCurrentPara.Create(const aPara: IeeLeafPara);
//#UC START# *4B5853E10268_4A7FF2C901C8_var*
//#UC END# *4B5853E10268_4A7FF2C901C8_var*
begin
//#UC START# *4B5853E10268_4A7FF2C901C8_impl*
 inherited Create;
 f_Para := aPara;
//#UC END# *4B5853E10268_4A7FF2C901C8_impl*
end;//TnsRedactionCurrentPara.Create

function TnsRedactionCurrentPara.Get_RedactionCurrentPara: IeeLeafPara;
//#UC START# *4A7FF1AC035C_4A7FF2C901C8get_var*
//#UC END# *4A7FF1AC035C_4A7FF2C901C8get_var*
begin
//#UC START# *4A7FF1AC035C_4A7FF2C901C8get_impl*
 Result := f_Para;
//#UC END# *4A7FF1AC035C_4A7FF2C901C8get_impl*
end;//TnsRedactionCurrentPara.Get_RedactionCurrentPara

procedure TnsRedactionCurrentPara.ClearFields;
begin
 f_Para := nil;
 inherited;
end;//TnsRedactionCurrentPara.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
