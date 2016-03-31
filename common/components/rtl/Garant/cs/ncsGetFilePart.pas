unit ncsGetFilePart;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetFilePart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetFilePart" MUID: (547583330291)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetFilePart = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
   function pm_GetOffset: Int64;
   procedure pm_SetOffset(aValue: Int64);
   function pm_GetPartSize: Int64;
   procedure pm_SetPartSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
    {* С относительным путем (полный вычисляется от задачи) }
   property Offset: Int64
    read pm_GetOffset
    write pm_SetOffset;
   property PartSize: Int64
    read pm_GetPartSize
    write pm_SetPartSize;
 end;//TncsGetFilePart
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetFilePart_Const
;

function TncsGetFilePart.pm_GetTaskID: AnsiString;
//#UC START# *78F323F06BE5_547583330291get_var*
//#UC END# *78F323F06BE5_547583330291get_var*
begin
//#UC START# *78F323F06BE5_547583330291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *78F323F06BE5_547583330291get_impl*
end;//TncsGetFilePart.pm_GetTaskID

procedure TncsGetFilePart.pm_SetTaskID(const aValue: AnsiString);
//#UC START# *78F323F06BE5_547583330291set_var*
//#UC END# *78F323F06BE5_547583330291set_var*
begin
//#UC START# *78F323F06BE5_547583330291set_impl*
 !!! Needs to be implemented !!!
//#UC END# *78F323F06BE5_547583330291set_impl*
end;//TncsGetFilePart.pm_SetTaskID

function TncsGetFilePart.pm_GetFileName: AnsiString;
//#UC START# *FC273BB02538_547583330291get_var*
//#UC END# *FC273BB02538_547583330291get_var*
begin
//#UC START# *FC273BB02538_547583330291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC273BB02538_547583330291get_impl*
end;//TncsGetFilePart.pm_GetFileName

procedure TncsGetFilePart.pm_SetFileName(const aValue: AnsiString);
//#UC START# *FC273BB02538_547583330291set_var*
//#UC END# *FC273BB02538_547583330291set_var*
begin
//#UC START# *FC273BB02538_547583330291set_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC273BB02538_547583330291set_impl*
end;//TncsGetFilePart.pm_SetFileName

function TncsGetFilePart.pm_GetOffset: Int64;
//#UC START# *6A2208B1BA37_547583330291get_var*
//#UC END# *6A2208B1BA37_547583330291get_var*
begin
//#UC START# *6A2208B1BA37_547583330291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A2208B1BA37_547583330291get_impl*
end;//TncsGetFilePart.pm_GetOffset

procedure TncsGetFilePart.pm_SetOffset(aValue: Int64);
//#UC START# *6A2208B1BA37_547583330291set_var*
//#UC END# *6A2208B1BA37_547583330291set_var*
begin
//#UC START# *6A2208B1BA37_547583330291set_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A2208B1BA37_547583330291set_impl*
end;//TncsGetFilePart.pm_SetOffset

function TncsGetFilePart.pm_GetPartSize: Int64;
//#UC START# *12BF94706D13_547583330291get_var*
//#UC END# *12BF94706D13_547583330291get_var*
begin
//#UC START# *12BF94706D13_547583330291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *12BF94706D13_547583330291get_impl*
end;//TncsGetFilePart.pm_GetPartSize

procedure TncsGetFilePart.pm_SetPartSize(aValue: Int64);
//#UC START# *12BF94706D13_547583330291set_var*
//#UC END# *12BF94706D13_547583330291set_var*
begin
//#UC START# *12BF94706D13_547583330291set_impl*
 !!! Needs to be implemented !!!
//#UC END# *12BF94706D13_547583330291set_impl*
end;//TncsGetFilePart.pm_SetPartSize

class function TncsGetFilePart.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_547583330291_var*
//#UC END# *53AC03EE01FD_547583330291_var*
begin
//#UC START# *53AC03EE01FD_547583330291_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_547583330291_impl*
end;//TncsGetFilePart.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
