grammar sos:core:semanticDefs:abstractSyntax;


nonterminal File with
   pp,
   tyDecls, constructorDecls, judgmentDecls, translationDecls,
   ruleDecls, buildsOnDecls,
   tyEnv, constructorEnv, judgmentEnv, translationEnv, ruleEnv,
   moduleName,
   transRuleConstructors, transRuleConstructors_down,
   errors,
   location;
propagate errors on File;

abstract production file
top::File ::= moduleName::QName decls::Decls
{
  top.pp = "Module " ++ moduleName.pp ++ "\n\n" ++ decls.pp;

  decls.moduleName = top.moduleName;

  top.errors <-
      if moduleName.pp == top.moduleName.pp
      then []
      else [errorMessage("Module declaration is incorrect:  " ++
                         moduleName.pp, location=top.location)];

  top.tyDecls = decls.tyDecls;
  top.constructorDecls = decls.constructorDecls;
  top.judgmentDecls = decls.judgmentDecls;
  top.translationDecls = decls.translationDecls;
  top.ruleDecls = decls.ruleDecls;
  top.buildsOnDecls = decls.buildsOnDecls;
  top.transRuleConstructors = decls.transRuleConstructors;

  decls.tyEnv = top.tyEnv;
  decls.constructorEnv = top.constructorEnv;
  decls.judgmentEnv = top.judgmentEnv;
  decls.translationEnv = top.translationEnv;
  decls.ruleEnv = top.ruleEnv;
  decls.transRuleConstructors_down = top.transRuleConstructors_down;
}





nonterminal Decls with
   pp,
   moduleName,
   tyDecls, constructorDecls, judgmentDecls, translationDecls,
   ruleDecls,
   tyEnv, constructorEnv, judgmentEnv, translationEnv, ruleEnv,
   transRuleConstructors, transRuleConstructors_down,
   errors,
   location,
   buildsOnDecls;
propagate errors on Decls;

abstract production nilDecls
top::Decls ::=
{
  top.pp = "";

  top.tyDecls = [];
  top.constructorDecls = [];
  top.judgmentDecls = [];
  top.translationDecls = [];
  top.ruleDecls = [];
  top.buildsOnDecls = [];
  top.transRuleConstructors = [];
}


abstract production buildsOnDecls
top::Decls ::= importName::QName
{
  top.pp = "Builds on " ++ importName.pp ++ "\n";

  top.tyDecls = [];
  top.constructorDecls = [];
  top.judgmentDecls = [];
  top.translationDecls = [];
  top.ruleDecls = [];
  top.buildsOnDecls = [importName];
  top.transRuleConstructors = [];
}


abstract production ruleDecls
top::Decls ::= r::Rule
{
  top.pp = r.pp;

  r.moduleName = top.moduleName;

  top.tyDecls = r.tyDecls;
  top.constructorDecls = r.constructorDecls;
  top.judgmentDecls = r.judgmentDecls;
  top.translationDecls = r.translationDecls;
  top.ruleDecls = r.ruleDecls;
  top.buildsOnDecls = [];
  top.transRuleConstructors = r.transRuleConstructors;

  r.tyEnv = top.tyEnv;
  r.constructorEnv = top.constructorEnv;
  r.judgmentEnv = top.judgmentEnv;
  r.translationEnv = top.translationEnv;
  r.ruleEnv = top.ruleEnv;
}


abstract production absSyntaxDecls
top::Decls ::= a::AbsSyntaxDecl
{
  top.pp = a.pp;

  a.moduleName = top.moduleName;

  top.tyDecls = a.tyDecls;
  top.constructorDecls = a.constructorDecls;
  top.judgmentDecls = a.judgmentDecls;
  top.translationDecls = a.translationDecls;
  top.ruleDecls = [];
  top.buildsOnDecls = [];
  top.transRuleConstructors = [];

  a.tyEnv = top.tyEnv;
  a.constructorEnv = top.constructorEnv;
  a.judgmentEnv = top.judgmentEnv;
  a.translationEnv = top.translationEnv;
  a.transRuleConstructors_down = top.transRuleConstructors_down;
}


abstract production judgmentDecls
top::Decls ::= j::JudgmentDecl
{
  top.pp = j.pp;

  j.moduleName = top.moduleName;

  top.tyDecls = j.tyDecls;
  top.constructorDecls = j.constructorDecls;
  top.judgmentDecls = j.judgmentDecls;
  top.translationDecls = j.translationDecls;
  top.ruleDecls = [];
  top.buildsOnDecls = [];
  top.transRuleConstructors = [];

  j.tyEnv = top.tyEnv;
  j.constructorEnv = top.constructorEnv;
  j.judgmentEnv = top.judgmentEnv;
  j.translationEnv = top.translationEnv;
  j.ruleEnv = top.ruleEnv;
}


abstract production branchDecls
top::Decls ::= d1::Decls d2::Decls
{
  top.pp = d1.pp ++ "\n" ++ d2.pp;

  d1.moduleName = top.moduleName;
  d2.moduleName = top.moduleName;

  top.tyDecls = d1.tyDecls ++ d2.tyDecls;
  top.constructorDecls = d1.constructorDecls ++ d2.constructorDecls;
  top.judgmentDecls = d1.judgmentDecls ++ d2.judgmentDecls;
  top.translationDecls = d1.translationDecls ++ d2.translationDecls;
  top.ruleDecls = d1.ruleDecls ++ d2.ruleDecls;
  top.buildsOnDecls = d1.buildsOnDecls ++ d2.buildsOnDecls;
  top.transRuleConstructors =
      d1.transRuleConstructors ++ d2.transRuleConstructors;

  d1.tyEnv = top.tyEnv;
  d1.constructorEnv = top.constructorEnv;
  d1.judgmentEnv = top.judgmentEnv;
  d1.translationEnv = top.translationEnv;
  d1.ruleEnv = top.ruleEnv;
  d1.transRuleConstructors_down = top.transRuleConstructors_down;
  d2.tyEnv = top.tyEnv;
  d2.constructorEnv = top.constructorEnv;
  d2.judgmentEnv = top.judgmentEnv;
  d2.translationEnv = top.translationEnv;
  d2.ruleEnv = top.ruleEnv;
  d2.transRuleConstructors_down = top.transRuleConstructors_down;
}

