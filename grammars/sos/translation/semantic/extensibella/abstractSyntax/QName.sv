grammar sos:translation:semantic:extensibella:abstractSyntax;

synthesized attribute eb_base::String occurs on QName;

synthesized attribute ebTypeName::String occurs on QName;
synthesized attribute ebConstructorName::String occurs on QName;
synthesized attribute ebJudgmentName::String occurs on QName;
synthesized attribute ebProjectionName::String occurs on QName;

synthesized attribute ebUnknownNameI::String occurs on QName;
synthesized attribute ebIsName::String occurs on QName;
synthesized attribute ebIsQName::QName occurs on QName;

aspect production baseName
top::QName ::= name::String
{
  top.eb_base = name;

  top.ebTypeName =
      error("Must have full type name for translation (" ++
            top.pp ++ ") (" ++ top.location.filename ++ ":" ++
            toString(top.location.line) ++ ":" ++
            toString(top.location.column) ++ ")");
  top.ebConstructorName =
      if startsWith("$unknownI__", name) ||
         startsWith("$unknownK__", name)
      then name
      else error("Must have full constructor name for translation" ++
                 " (" ++ top.pp ++ ")");
  top.ebJudgmentName = top.fullJudgment.eb;
  top.ebProjectionName =
      error("Must have full type name for translation of " ++
            "projection (" ++ top.pp ++ ") (" ++
            top.location.filename ++ ":" ++
            toString(top.location.line) ++ ":" ++
            toString(top.location.column) ++ ")");

  top.ebUnknownNameI =
      error("Must have full type for unknown name (" ++ top.pp ++ ")");
  top.ebIsName = error("Must have full type for is name");
  top.ebIsQName = baseName("is_" ++ name, location=top.location);
}


aspect production moduleLayerName
top::QName ::= name::String rest::QName
{
  top.eb_base = name ++ name_sep ++ rest.eb_base;

  top.ebJudgmentName = top.fullJudgment.eb;

  --Assume this is fully qualified, so no need to look things up
  top.ebTypeName = "$ty__" ++ top.eb_base;
  top.ebConstructorName = top.eb_base;
  top.ebProjectionName = "$proj__" ++ top.eb_base;

  top.ebUnknownNameI = "$unknownI__" ++ top.eb_base;

  --mo:du:le:is_name
  top.ebIsName = "$ext__0__" ++
      substitute(":", name_sep, top.baselessName) ++
      name_sep ++ "is_" ++ top.base;
  top.ebIsQName =
      moduleLayerName(name, rest.ebIsQName, location=top.location);
}





attribute
   eb<String>, --full relation name
   ebUnknownNameK --name for unknownK relative to this relation
occurs on JudgmentEnvItem;

synthesized attribute ebUnknownNameK::String;

aspect production extJudgmentEnvItem
top::JudgmentEnvItem ::= name::QName args::TypeList pcIndex::Integer
{
  top.eb = "$ext__" ++ toString(pcIndex) ++ "__" ++ name.eb_base;

  top.ebUnknownNameK = "$unknownK__" ++ name.eb_base;
}


aspect production fixedJudgmentEnvItem
top::JudgmentEnvItem ::= name::QName args::TypeList
{
  top.eb = "$fix__" ++ name.eb_base;

  top.ebUnknownNameK =
      error("Should not access fixedJudgmentEnvItem.ebUnknownNameK");
}


aspect production errorJudgmentEnvItem
top::JudgmentEnvItem ::= name::QName args::TypeList
{
  top.eb = error("Should not translate in the presence of errors");

  top.ebUnknownNameK =
      error("Should not access errorJudgmentEnvIetm.ebUnknownNameK");
}



global name_sep::String = "-$-";
