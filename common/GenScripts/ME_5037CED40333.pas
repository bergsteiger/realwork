unit atStringProvider;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atStringProvider.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
;

type
 TatStringProvider = {abstract} class(TObject)
  private
   f_Random: Boolean;
    {* Поле для свойства Random }
   f_Looped: Boolean;
    {* Поле для свойства Looped }
  public
   function AcquireNext(out theString: AnsiString): Boolean; virtual; abstract;
   procedure Reset; virtual; abstract;
  public
   property Random: Boolean
    read f_Random
    write f_Random;
   property Looped: Boolean
    read f_Looped
    write f_Looped;
 end;//TatStringProvider

implementation

uses
 l3ImplUses
;

end.
