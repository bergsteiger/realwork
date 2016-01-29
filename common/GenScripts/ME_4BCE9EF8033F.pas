unit FormProducer.imp;

interface

uses
 l3IntfUses
 , Types
;

type
 // _FormClass_
 
 FormClassRef = class of _FormClass_;
 
 _FormProducer_ = class
  function MakeForm: _FormClass_;
  function MakeFormClass: FormClassRef;
  function FormExtent: TPoint;
   {* Размеры формы }
  procedure FormMade(const aForm: _FormClass_);
  function UseFormExtentAsClientSize: Boolean;
   {* Использовать заданные размеры формы как размеры клиентской области - размеры формы пересчитываются относительно этих ограничений. }
 end;//_FormProducer_
 
implementation

uses
 l3ImplUses
 , vcmBase
 , SysUtils
 , Forms
 , l3Base
;

end.
