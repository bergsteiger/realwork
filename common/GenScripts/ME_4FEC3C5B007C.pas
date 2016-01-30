unit nscStatusBarDelimiterDef;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscStatusBarDelimiterDef.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscStatusBarItemDef
 , nscNewInterfaces
;

type
 TnscStatusBarDelimiterDef = class(TnscStatusBarItemDef, InscStatusBarDelimiterDef)
  private
   f_SeparatorPos: TsbdSeparatorPos;
   f_SeparatorVisible: Boolean;
   f_Width: integer;
  protected
   function Get_SeparatorPos: TsbdSeparatorPos;
   function Get_IsSeparatorVisible: Boolean;
   function Get_Width: integer;
  public
   constructor Create(aSeparatorVisible: Boolean;
    aSeparatorPos: TsbdSeparatorPos = nscNewInterfaces.spMiddle;
    aWidth: Integer = 0); reintroduce;
   class function Make(aSeparatorVisible: Boolean;
    aSeparatorPos: TsbdSeparatorPos = nscNewInterfaces.spMiddle;
    aWidth: Integer = 0): InscStatusBarDelimiterDef; reintroduce;
 end;//TnscStatusBarDelimiterDef
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

constructor TnscStatusBarDelimiterDef.Create(aSeparatorVisible: Boolean;
 aSeparatorPos: TsbdSeparatorPos = nscNewInterfaces.spMiddle;
 aWidth: Integer = 0);
//#UC START# *4FEC49660337_4FEC3C5B007C_var*
//#UC END# *4FEC49660337_4FEC3C5B007C_var*
begin
//#UC START# *4FEC49660337_4FEC3C5B007C_impl*
 inherited Create(False, nil, False, False, 0, nsc_ttkNone);
 f_SeparatorPos := aSeparatorPos;
 f_SeparatorVisible := aSeparatorVisible;
 f_Width := aWidth;
//#UC END# *4FEC49660337_4FEC3C5B007C_impl*
end;//TnscStatusBarDelimiterDef.Create

class function TnscStatusBarDelimiterDef.Make(aSeparatorVisible: Boolean;
 aSeparatorPos: TsbdSeparatorPos = nscNewInterfaces.spMiddle;
 aWidth: Integer = 0): InscStatusBarDelimiterDef;
var
 l_Inst : TnscStatusBarDelimiterDef;
begin
 l_Inst := Create(aSeparatorVisible, aSeparatorPos, aWidth);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscStatusBarDelimiterDef.Make

function TnscStatusBarDelimiterDef.Get_SeparatorPos: TsbdSeparatorPos;
//#UC START# *4FF315450358_4FEC3C5B007Cget_var*
//#UC END# *4FF315450358_4FEC3C5B007Cget_var*
begin
//#UC START# *4FF315450358_4FEC3C5B007Cget_impl*
 Result := f_SeparatorPos;
//#UC END# *4FF315450358_4FEC3C5B007Cget_impl*
end;//TnscStatusBarDelimiterDef.Get_SeparatorPos

function TnscStatusBarDelimiterDef.Get_IsSeparatorVisible: Boolean;
//#UC START# *4FF3157D0385_4FEC3C5B007Cget_var*
//#UC END# *4FF3157D0385_4FEC3C5B007Cget_var*
begin
//#UC START# *4FF3157D0385_4FEC3C5B007Cget_impl*
 Result := f_SeparatorVisible;
//#UC END# *4FF3157D0385_4FEC3C5B007Cget_impl*
end;//TnscStatusBarDelimiterDef.Get_IsSeparatorVisible

function TnscStatusBarDelimiterDef.Get_Width: integer;
//#UC START# *4FF3159402B4_4FEC3C5B007Cget_var*
//#UC END# *4FF3159402B4_4FEC3C5B007Cget_var*
begin
//#UC START# *4FF3159402B4_4FEC3C5B007Cget_impl*
 Result := f_Width;
//#UC END# *4FF3159402B4_4FEC3C5B007Cget_impl*
end;//TnscStatusBarDelimiterDef.Get_Width
{$IfEnd} // Defined(Nemesis)

end.
