{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24.0}
    {$LEGACYIFEND ON}
  {$IFEND}
  {$IF CompilerVersion >= 17.0}
    {$DEFINE DIAMONDBACK_UP}
  {$IFEND}
  {$IF CompilerVersion >= 18.0}
    {$DEFINE DIAMONDBACK_UP}
    {$DEFINE DEXTER_UP}
  {$IFEND}
  {$IF CompilerVersion >= 18.5}
    {$DEFINE SPACELY_UP}
  {$IFEND}
  {$IF CompilerVersion >= 19.0}
    {$DEFINE DIAMONDBACK_UP}
    {$DEFINE DEXTER_UP}
    {$DEFINE HIGHLANDER_UP}
  {$IFEND}
  {$IF CompilerVersion >= 20.0}
    {$DEFINE DIAMONDBACK_UP}
    {$DEFINE DEXTER_UP}
    {$DEFINE HIGHLANDER_UP}
    {$DEFINE TIBURON_UP}
  {$IFEND}
  {$IF CompilerVersion >= 21.0}
    {$DEFINE DIAMONDBACK_UP}
    {$DEFINE DEXTER_UP}
    {$DEFINE HIGHLANDER_UP}
    {$DEFINE TIBURON_UP}
    {$DEFINE WEAVER_UP}
  {$IFEND}
  {$IF CompilerVersion >= 22.0}
    {$DEFINE DIAMONDBACK_UP}
    {$DEFINE DEXTER_UP}
    {$DEFINE HIGHLANDER_UP}
    {$DEFINE TIBURON_UP}
    {$DEFINE WEAVER_UP}
    {$DEFINE FULCRUM_UP}
  {$IFEND}
{$ENDIF}
