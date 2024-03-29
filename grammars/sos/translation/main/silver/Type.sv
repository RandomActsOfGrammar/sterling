grammar sos:translation:main:silver;

attribute
   silverType
occurs on Type;

synthesized attribute silverType::String;

aspect production nameType
top::Type ::= name::QName
{
  top.silverType = "Term";
}


aspect production varType
top::Type ::= name::String
{
  top.silverType = "var_" ++ name;
}


aspect production intType
top::Type ::=
{
  top.silverType = "Integer";
}


aspect production stringType
top::Type ::=
{
  top.silverType = "String";
}


aspect production errorType
top::Type ::=
{
  top.silverType = error("Should not translate with errors");
}


aspect production boolType
top::Type ::=
{
  top.silverType = "Boolean";
}


aspect production unitType
top::Type ::=
{
  top.silverType = "Unit";
}


aspect production tupleType
top::Type ::= tys::TypeList
{
  top.silverType = "(" ++ tys.silverType ++ ")";
}


aspect production listType
top::Type ::= ty::Type
{
  top.silverType = "[" ++ ty.silverType ++ "]";
}





attribute
   silverType
occurs on TypeList;

aspect production nilTypeList
top::TypeList ::=
{
  top.silverType = "";
}


aspect production consTypeList
top::TypeList ::= t::Type rest::TypeList
{
  top.silverType = t.silverType ++
                   if rest.silverType == ""
                   then "" else ", " ++ rest.silverType;
}
