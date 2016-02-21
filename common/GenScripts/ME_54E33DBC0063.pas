unit ncsSynchroCompatibilityClientTransporter;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsSynchroCompatibilityClientTransporter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsSynchroClientTransporter
 , CsQueryTypes
 , ncsMessageInterfaces
;

type
 TncsSynchroCompatibilityClientTransporter = class(TncsSynchroClientTransporter)
  private
   f_QueryID: TCsQueryId;
  protected
   procedure BeforeHandshake; override;
  public
   constructor Create(aQueryID: TCsQueryId); reintroduce;
   class function Make(aQueryID: TCsQueryId): IncsClientTransporter; reintroduce;
 end;//TncsSynchroCompatibilityClientTransporter
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsConst
;

constructor TncsSynchroCompatibilityClientTransporter.Create(aQueryID: TCsQueryId);
//#UC START# *54E33E1A00B4_54E33DBC0063_var*
//#UC END# *54E33E1A00B4_54E33DBC0063_var*
begin
//#UC START# *54E33E1A00B4_54E33DBC0063_impl*
 inherited Create;
 f_QueryID := aQueryID;
//#UC END# *54E33E1A00B4_54E33DBC0063_impl*
end;//TncsSynchroCompatibilityClientTransporter.Create

class function TncsSynchroCompatibilityClientTransporter.Make(aQueryID: TCsQueryId): IncsClientTransporter;
var
 l_Inst : TncsSynchroCompatibilityClientTransporter;
begin
 l_Inst := Create(aQueryID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsSynchroCompatibilityClientTransporter.Make

procedure TncsSynchroCompatibilityClientTransporter.BeforeHandshake;
//#UC START# *54E33EA40163_54E33DBC0063_var*
//#UC END# *54E33EA40163_54E33DBC0063_var*
begin
//#UC START# *54E33EA40163_54E33DBC0063_impl*
 IOHandler.WriteInteger(c_CsVersion);
 IOHandler.WriteInteger(Integer(Get_ClientID));
 IOHandler.WriteInteger(Ord(f_QueryID));
 IOHandler.WriteBufferFlush;
//#UC END# *54E33EA40163_54E33DBC0063_impl*
end;//TncsSynchroCompatibilityClientTransporter.BeforeHandshake
{$IfEnd} // NOT Defined(Nemesis)

end.
