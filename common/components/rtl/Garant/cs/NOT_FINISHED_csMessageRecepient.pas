unit NOT_FINISHED_csMessageRecepient;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csMessageRecepient.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMessageRecepient" MUID: (52FB9F4F029B)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ddClientMessageSortableList
;

type
 TcsMessageRecepient = class(Tl3ProtoObject)
  private
   f_Messages: TddClientMessageSortableList;
    {* Поле для свойства Messages }
  public
   property Messages: TddClientMessageSortableList
    read f_Messages;
 end;//TcsMessageRecepient
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
