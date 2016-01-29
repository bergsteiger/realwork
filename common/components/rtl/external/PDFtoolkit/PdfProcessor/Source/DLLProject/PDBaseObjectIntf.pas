{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }


unit PDBaseObjectIntf;

interface

uses
  gtObjectIntf;

//    constants representing TgtPDObjTypes
  const

    otBoolean = $00000000;
    otInteger = $00000001;
    otReal = $00000002;
    otString = $00000003;
    otName = $00000004;
    otCommand = $00000005;

    otNull = $00000006;
    otEOF = $00000007;
    otError = $00000008;

    otArray = $00000009;
    otDict = $0000000A;
    otIndirectRef = $0000000B;
    otStream = $0000000C;

    otNone = $0000000D;

type
  IgtPDBaseObject = Interface(IgtObject)

   //Type Checking for simple objects
    function IsBoolean: WordBool;
    function IsInteger: WordBool;
    function IsReal: WordBool;
    function IsNumber: WordBool;
    function IsString: WordBool;
    function IsName: WordBool; overload;
    function IsNull: WordBool;

   //Type checking for complex functions
    function IsArray: WordBool;
    function IsDict: WordBool; overload;
    function IsStream: WordBool;
    function IsIndirectRef: WordBool;

    function IsCommand: WordBool; overload;
    function IsError: WordBool;
    function IsEOF: WordBool;

   //Special type checking
    function IsName(const AName: WideString): WordBool; overload ;
    function IsCommand(const ACommand: WideString): WordBool; overload;
    function IsDict(const ADictType: WideString): WordBool; overload;

   //Returns a Copy of the object
    function Clone: IgtPDBaseObject;

    //Returns a Copy of the object
    procedure Assign(ASourceObj: IgtPDBaseObject);

    function GetType: Integer;
    function GetTypeName: WideString;

//    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
//      XRef: TgtObject): Cardinal;  abstract;

  end;



implementation

end.
