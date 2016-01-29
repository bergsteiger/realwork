unit evStyleInterfaceEx;

interface

uses
 l3IntfUses
 , evStyleInterface
 , k2DocumentGenerator
 , nevInternalInterfaces
 , Classes
 , k2TagGen
 , k2Dictionary
;

type
 TevStyleInterfaceEx = class(TevStyleInterface)
  function DoFinishAtom(G: Tk2DocumentGenerator;
   var Atom: Tk2StackAtom): Boolean;
  procedure Load(const Reader: Tk2CustomReader); overload;
  procedure Load(S: TStream); overload;
  procedure Save(G: Tk2TagGenerator); overload;
  procedure Save(S: TStream;
   aBinary: Boolean); overload;
  procedure SaveCurrent(G: Tk2TagGenerator);
 end;//TevStyleInterfaceEx
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Variant
 , Style_Const
 , k2BaseTypes
 , evdStyles
 , Graphics
 , evOpProc
 , k2Context
 , nevBase
 , l3Base
 , l3Filer
 , evdNativeReader
 , StrUtils
 , k2Base
 , k2SimpleTagList
 , evStyleTableFontSizeCorrector
 , l3Types
 , k2NonOptimizeContext
 , evdNativeWriter
;

type
 Tk2DictionaryFriend = class(Tk2Dictionary)
  {* Друг для Tk2Dictionary }
 end;//Tk2DictionaryFriend
 
 TevStyleTableGenerator = class(Tk2DocumentGenerator)
 end;//TevStyleTableGenerator
 
end.
