{ $OmniXML: OmniXML/OmniXML_Types.pas,v 1.1 2008/08/31 15:28:15 mremec Exp $ }
(*******************************************************************************
* The contents of this file are subject to the Mozilla Public License Version
* 1.1 (the "License"); you may not use this file except in compliance with the
* License. You may obtain a copy of the License at http://www.mozilla.org/MPL/
*
* Software distributed under the License is distributed on an "AS IS" basis,
* WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
* the specific language governing rights and limitations under the License.
*
* The Original Code is OmniXML_Types.pas
*
* The Initial Developer of the Original Code is Miha Remec
*   http://omnixml.com/
*******************************************************************************)
{***************************************************************************}
{ "Unit names renamed for integration with Gnostice libraries  - Gnostice"
{***************************************************************************}
unit gtOmniXML_Types;

interface

{$I gtOmniXML.inc}

type
  {$IFDEF OmniXML_Unicode}
  XmlString = string;
  PXmlString = ^string;
  XmlChar = Char;
  PXmlChar = PChar;
  {$ELSE}
  XmlString = WideString;
  PXmlString = PWideString;
  XmlChar = WideChar;
  PXmlChar = PWideChar;
  {$ENDIF}  // OmniXML_Unicode

implementation

end.
