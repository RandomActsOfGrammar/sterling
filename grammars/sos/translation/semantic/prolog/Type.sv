grammar sos:translation:semantic:prolog;


attribute prolog<String> occurs on Type;

aspect production nameType
top::Type ::= name::QName
{
  top.prolog = name.prolog;
}


aspect production varType
top::Type ::= name::String
{
  top.prolog = error("Should not access prolog on varType");
}


aspect production intType
top::Type ::=
{
  top.prolog = error("Should not access prolog on intType");
}


aspect production stringType
top::Type ::=
{
  top.prolog = error("Should not access prolog on stringType");
}


aspect production listType
top::Type ::= ty::Type
{
  top.prolog = error("Should not access prolog on listType");
}


aspect production tupleType
top::Type ::= tys::TypeList
{
  top.prolog = error("Should not access prolog on tupleType");
}


aspect production errorType
top::Type ::=
{
  top.prolog = error("Should not access prolog on errorType");
}

