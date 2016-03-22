unit ncsPushFilePart;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsPushFilePart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsPushFilePart" MUID: (548940970391)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2SizedMemoryPool
 , k2Base
;

type
 TncsPushFilePart = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
   function pm_GetOffset: Int64;
   procedure pm_SetOffset(aValue: Int64);
   function pm_GetPartSize: Int64;
   procedure pm_SetPartSize(aValue: Int64);
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
   property Offset: Int64
    read pm_GetOffset
    write pm_SetOffset;
   property PartSize: Int64
    read pm_GetPartSize
    write pm_SetPartSize;
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
 end;//TncsPushFilePart
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csPushFilePart_Const
;

function TncsPushFilePart.pm_GetTaskID: AnsiString;
//#UC START# *2C782D1D596C_548940970391get_var*
//#UC END# *2C782D1D596C_548940970391get_var*
begin
//#UC START# *2C782D1D596C_548940970391get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C782D1D596C_548940970391get_impl*
end;//TncsPushFilePart.pm_GetTaskID

procedure TncsPushFilePart.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *2C782D1D596C_548940970391set_var*
//#UC END# *2C782D1D596C_548940970391set_var*
begin
//#UC START# *2C782D1D596C_548940970391set_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C782D1D596C_548940970391set_impl*
end;//TncsPushFilePart.pm_SetTaskID

function TncsPushFilePart.pm_GetFileName: AnsiString;
//#UC START# *BA14D05FE9CC_548940970391get_var*
//#UC END# *BA14D05FE9CC_548940970391get_var*
begin
//#UC START# *BA14D05FE9CC_548940970391get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA14D05FE9CC_548940970391get_impl*
end;//TncsPushFilePart.pm_GetFileName

procedure TncsPushFilePart.pm_SetFileName(const aValue: AnsiString);
//#UC START# *BA14D05FE9CC_548940970391set_var*
//#UC END# *BA14D05FE9CC_548940970391set_var*
begin
//#UC START# *BA14D05FE9CC_548940970391set_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA14D05FE9CC_548940970391set_impl*
end;//TncsPushFilePart.pm_SetFileName

function TncsPushFilePart.pm_GetOffset: Int64;
//#UC START# *173DEF59C04D_548940970391get_var*
//#UC END# *173DEF59C04D_548940970391get_var*
begin
//#UC START# *173DEF59C04D_548940970391get_impl*
 !!! Needs to be implemented !!!
//#UC END# *173DEF59C04D_548940970391get_impl*
end;//TncsPushFilePart.pm_GetOffset

procedure TncsPushFilePart.pm_SetOffset(aValue: Int64);
//#UC START# *173DEF59C04D_548940970391set_var*
//#UC END# *173DEF59C04D_548940970391set_var*
begin
//#UC START# *173DEF59C04D_548940970391set_impl*
 !!! Needs to be implemented !!!
//#UC END# *173DEF59C04D_548940970391set_impl*
end;//TncsPushFilePart.pm_SetOffset

function TncsPushFilePart.pm_GetPartSize: Int64;
//#UC START# *62BDC02A2DB8_548940970391get_var*
//#UC END# *62BDC02A2DB8_548940970391get_var*
begin
//#UC START# *62BDC02A2DB8_548940970391get_impl*
 !!! Needs to be implemented !!!
//#UC END# *62BDC02A2DB8_548940970391get_impl*
end;//TncsPushFilePart.pm_GetPartSize

procedure TncsPushFilePart.pm_SetPartSize(aValue: Int64);
//#UC START# *62BDC02A2DB8_548940970391set_var*
//#UC END# *62BDC02A2DB8_548940970391set_var*
begin
//#UC START# *62BDC02A2DB8_548940970391set_impl*
 !!! Needs to be implemented !!!
//#UC END# *62BDC02A2DB8_548940970391set_impl*
end;//TncsPushFilePart.pm_SetPartSize

function TncsPushFilePart.pm_GetData: Tk2RawData;
//#UC START# *0F7173AD8CC8_548940970391get_var*
//#UC END# *0F7173AD8CC8_548940970391get_var*
begin
//#UC START# *0F7173AD8CC8_548940970391get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F7173AD8CC8_548940970391get_impl*
end;//TncsPushFilePart.pm_GetData

procedure TncsPushFilePart.pm_SetData(aValue: Tk2RawData);
//#UC START# *0F7173AD8CC8_548940970391set_var*
//#UC END# *0F7173AD8CC8_548940970391set_var*
begin
//#UC START# *0F7173AD8CC8_548940970391set_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F7173AD8CC8_548940970391set_impl*
end;//TncsPushFilePart.pm_SetData

class function TncsPushFilePart.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_548940970391_var*
//#UC END# *53AC03EE01FD_548940970391_var*
begin
//#UC START# *53AC03EE01FD_548940970391_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_548940970391_impl*
end;//TncsPushFilePart.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
