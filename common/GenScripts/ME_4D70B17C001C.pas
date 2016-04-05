unit tstNSRCGenerator;
 {* Обертка над TddGenerator для чтения данных о внешних файлах и запоминания их в тесте для последующей проверки. }

// Модуль: "w:\common\components\rtl\Garant\Daily\tstNSRCGenerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtstNSRCGenerator" MUID: (4D70B17C001C)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ddNSRCGenerator
;

type
 TtstNSRCGenerator = class;

 ItstNSRCListener = interface
  ['{A89ABBCC-F4DD-4B5B-8AA4-50EA93C9907A}']
  procedure ExtractFileEvent(const aFileName: AnsiString);
   {* Событие выливки внешнего файла. }
 end;//ItstNSRCListener

 TtstNSRCGenerator = class(TddNSRCGenerator)
  {* Обертка над TddGenerator для чтения данных о внешних файлах и запоминания их в тесте для последующей проверки. }
  private
   f_Listener: ItstNSRCListener;
  protected
   procedure SaveObjFileName(const aFileName: AnsiString); override;
  public
   procedure LinkNSRCListener(const aListener: ItstNSRCListener);
   procedure UnlinkNSRCListener(const aListener: ItstNSRCListener);
 end;//TtstNSRCGenerator
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TtstNSRCGenerator.LinkNSRCListener(const aListener: ItstNSRCListener);
//#UC START# *4D70B25B0190_4D70B17C001C_var*
//#UC END# *4D70B25B0190_4D70B17C001C_var*
begin
//#UC START# *4D70B25B0190_4D70B17C001C_impl*
 Assert(f_Listener = nil);
 f_Listener := aListener;
//#UC END# *4D70B25B0190_4D70B17C001C_impl*
end;//TtstNSRCGenerator.LinkNSRCListener

procedure TtstNSRCGenerator.UnlinkNSRCListener(const aListener: ItstNSRCListener);
//#UC START# *4D70B2A203B9_4D70B17C001C_var*
//#UC END# *4D70B2A203B9_4D70B17C001C_var*
begin
//#UC START# *4D70B2A203B9_4D70B17C001C_impl*
 Assert(f_Listener = aListener);
 f_Listener := nil;
//#UC END# *4D70B2A203B9_4D70B17C001C_impl*
end;//TtstNSRCGenerator.UnlinkNSRCListener

procedure TtstNSRCGenerator.SaveObjFileName(const aFileName: AnsiString);
//#UC START# *4D70C8250128_4D70B17C001C_var*
//#UC END# *4D70C8250128_4D70B17C001C_var*
begin
//#UC START# *4D70C8250128_4D70B17C001C_impl*
  f_Listener.ExtractFileEvent(aFileName);
//#UC END# *4D70C8250128_4D70B17C001C_impl*
end;//TtstNSRCGenerator.SaveObjFileName
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
